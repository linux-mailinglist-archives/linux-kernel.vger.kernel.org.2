Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7042040B5D8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhINRZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 13:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229720AbhINRY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631640220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MqDXjCZcBn29nal+6qOuwi7JZU8wFISffsSfwR+3L3E=;
        b=SZy8xrWi359oDh9qw537B21NtuGb7iI71OeNnXvfG/LKE1y/lBIEdd5a5eaodaWkdEZn+H
        o61h96Z6g8XLAsW0wF4WecsQDyWN6bv6hDeQgia3wlNgmN0piF5M9UKS3vcmyQ+pV2ocnm
        yh77niGKhL/v7wgjtD820hwW/aQv+/A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-ytcyggfSNwGCoYnvlTzEKw-1; Tue, 14 Sep 2021 13:23:39 -0400
X-MC-Unique: ytcyggfSNwGCoYnvlTzEKw-1
Received: by mail-wr1-f72.google.com with SMTP id x2-20020a5d54c2000000b0015dfd2b4e34so2542543wrv.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 10:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MqDXjCZcBn29nal+6qOuwi7JZU8wFISffsSfwR+3L3E=;
        b=2YHy0PNfKxyWoITpo8EUduz1E1M4TalYpcdv3NVRZHxI7Sm0j+dheaTeQM8EOpMiYi
         TzN/4rQYQLrp7Yp1EcxhApUzSrkQLv1IJ1CuaSv1TuCnd0GUGGoavtdclUePGIRvrrB9
         n/io92dLqQ99Z3H5nmzgjfuxoyIUs7TdY1QFaJJM6W8OSFtT2EuFSqUIhO/JTWYK1tHw
         zye5e4VJox6OjcxPiWB47LcdK4iBlKmJsIAqzgR8yI+wgDnTwGuMz8OgcP47thHF14Cs
         fjD8g/YI7H6yMt9u8mMxepP8qFwerRUCK7/zEd9gO0bogF77AWMM+ZkuraQRo1FlVn2N
         3YLg==
X-Gm-Message-State: AOAM530tUf0a/mI72A/wG8ogS2kmnOlCiNeBHAG3P3za7vy/Wv4YLRy/
        98o9Xa0dnVYHhR4t6A95x6OEForeTbnAmHpbYIFhuOjM+Q7PdFM3BxdglJSBhDoeYpiPn0wK1g/
        iUQq1ZPOoYLYSw1X9uKeLlV+w
X-Received: by 2002:a5d:61c1:: with SMTP id q1mr334686wrv.154.1631640218350;
        Tue, 14 Sep 2021 10:23:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3k1jrCY2l0TCreFxkhzeZFt/sEfOOcGitXD1qc1Q6O8TBKNKTnPnTU/9Pcn8mkICg9BGFjg==
X-Received: by 2002:a5d:61c1:: with SMTP id q1mr334653wrv.154.1631640218126;
        Tue, 14 Sep 2021 10:23:38 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6041.dip0.t-ipconnect.de. [91.12.96.65])
        by smtp.gmail.com with ESMTPSA id 61sm4080214wrl.94.2021.09.14.10.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 10:23:37 -0700 (PDT)
Subject: Re: [PATCH resend RFC 7/9] s390/mm: no need for pte_alloc_map_lock()
 if we know the pmd is present
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
References: <20210909162248.14969-1-david@redhat.com>
 <20210909162248.14969-8-david@redhat.com>
 <20210914185449.42d7d5ca@p-imbrenda>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <5a572489-a6d6-aaf4-098a-a8059f9b12f0@redhat.com>
Date:   Tue, 14 Sep 2021 19:23:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210914185449.42d7d5ca@p-imbrenda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.09.21 18:54, Claudio Imbrenda wrote:
> On Thu,  9 Sep 2021 18:22:46 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> pte_map_lock() is sufficient.
> 
> Can you explain the difference and why it is enough?

I didn't repeat the $subject:

"No need for pte_alloc_map_lock() if we know the pmd is present; 
pte_map_lock() is sufficient, because there isn't anything to allocate."

> 
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   arch/s390/mm/pgtable.c | 15 +++------------
>>   1 file changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
>> index 5fb409ff7842..4e77b8ebdcc5 100644
>> --- a/arch/s390/mm/pgtable.c
>> +++ b/arch/s390/mm/pgtable.c
>> @@ -814,10 +814,7 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
>>   	}
>>   	spin_unlock(ptl);
>>   
>> -	ptep = pte_alloc_map_lock(mm, pmdp, addr, &ptl);
>> -	if (unlikely(!ptep))
>> -		return -EFAULT;
>> -
>> +	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
>>   	new = old = pgste_get_lock(ptep);
>>   	pgste_val(new) &= ~(PGSTE_GR_BIT | PGSTE_GC_BIT |
>>   			    PGSTE_ACC_BITS | PGSTE_FP_BIT);
>> @@ -912,10 +909,7 @@ int reset_guest_reference_bit(struct mm_struct *mm, unsigned long addr)
>>   	}
>>   	spin_unlock(ptl);
>>   
>> -	ptep = pte_alloc_map_lock(mm, pmdp, addr, &ptl);
>> -	if (unlikely(!ptep))
>> -		return -EFAULT;
>> -
>> +	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
>>   	new = old = pgste_get_lock(ptep);
>>   	/* Reset guest reference bit only */
>>   	pgste_val(new) &= ~PGSTE_GR_BIT;
>> @@ -977,10 +971,7 @@ int get_guest_storage_key(struct mm_struct *mm, unsigned long addr,
>>   	}
>>   	spin_unlock(ptl);
>>   
>> -	ptep = pte_alloc_map_lock(mm, pmdp, addr, &ptl);
>> -	if (unlikely(!ptep))
>> -		return -EFAULT;
>> -
>> +	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
>>   	pgste = pgste_get_lock(ptep);
>>   	*key = (pgste_val(pgste) & (PGSTE_ACC_BITS | PGSTE_FP_BIT)) >> 56;
>>   	paddr = pte_val(*ptep) & PAGE_MASK;
> 


-- 
Thanks,

David / dhildenb

