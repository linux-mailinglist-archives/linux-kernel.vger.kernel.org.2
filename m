Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A72C383699
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 17:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343749AbhEQPey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 11:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244250AbhEQPTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 11:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621264714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBnQo/J9oz8gnM35x+7tBsgRWTaGkCDWee+DmJ5pKGg=;
        b=N8Y5eBgPTAIroqeRUsNbC1DBfQjo20AjmjUZMdw9It/E1+icZZo+9BSttLP7/56S1ERCEf
        1yvuJyQ9p1uBPOuTK7vJL3D8Xza6R1MyQgtlNmgQ2Sb2oCeZxNDewf3VmZHWtVywCln/rn
        CrpuVldox98ATxXIZOM3wHq6HaGTJv4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-LejBWe3INtqdvyDvIWjR1g-1; Mon, 17 May 2021 11:18:33 -0400
X-MC-Unique: LejBWe3INtqdvyDvIWjR1g-1
Received: by mail-wr1-f70.google.com with SMTP id v5-20020adf9e450000b029010e708f05b3so3969814wre.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JBnQo/J9oz8gnM35x+7tBsgRWTaGkCDWee+DmJ5pKGg=;
        b=qwblMDxE5sfVZmhcTnv1qrNMxX7EFnfv04O5XzKHqEBPp5FuBxGj6X1XKwoxFeKGO/
         k2+J59+ckf3ouXYv6OvY+7I2qO+EFfcqUYgoRN4QOLYGA0kN4WdYcJN1+qXkY3suwuSE
         LNgqblDd2b6Fyp5dxvoQryfGBskbPqCsqO4O8agb6Z27bpfU16CniJIDdd/Rbm1ggHLa
         ILatUC/QW40ZckO5FiYxtA8YjaPIa3MT+jcd2ddLyRlJphc2ri3LW6rRWyfomtznE4r7
         g/g/eHR228PRAv/Cyyh4eVMYRjDzaCrGJgaJIKaL+oqft1rl+eGTdtnhGiehFDZXuM/Q
         gykA==
X-Gm-Message-State: AOAM5312PDfq69n6040reR/ken5Di0ak0vg6HPy5Fv9OnL2gHbAM06SV
        UZFHfK3ZdP9Uq8VHMvpjG3LTnEsvQpY/+uEG0GhGHnW7w8JcUpA1EgogWJtb236nf7Lm7FXwpvn
        mYmDHtst45QjclME2FxRUz2R3
X-Received: by 2002:a5d:5306:: with SMTP id e6mr231548wrv.324.1621264711826;
        Mon, 17 May 2021 08:18:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9pgHxSB1CvA6bP+5A102Vw3q+wpKkw7H+TASfr6okGY07XFAE7cdx9Tfb7WlCOrjNYsTg6Q==
X-Received: by 2002:a5d:5306:: with SMTP id e6mr231511wrv.324.1621264711624;
        Mon, 17 May 2021 08:18:31 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6833.dip0.t-ipconnect.de. [91.12.104.51])
        by smtp.gmail.com with ESMTPSA id g206sm5661736wme.16.2021.05.17.08.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 08:18:31 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] mm: introduce page_offline_(begin|end|freeze|thaw)
 to synchronize setting PageOffline()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Price <steven.price@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Aili Yao <yaoaili@kingsoft.com>, Jiri Bohac <jbohac@suse.cz>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20210514172247.176750-1-david@redhat.com>
 <20210514172247.176750-5-david@redhat.com> <YKIQfCjq13dSMHOs@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <016e96c9-82e6-3259-7a99-8627c3be11c6@redhat.com>
Date:   Mon, 17 May 2021 17:18:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKIQfCjq13dSMHOs@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.21 08:43, Mike Rapoport wrote:
> On Fri, May 14, 2021 at 07:22:45PM +0200, David Hildenbrand wrote:
>> A driver might set a page logically offline -- PageOffline() -- and
>> turn the page inaccessible in the hypervisor; after that, access to page
>> content can be fatal. One example is virtio-mem; while unplugged memory
>> -- marked as PageOffline() can currently be read in the hypervisor, this
>> will no longer be the case in the future; for example, when having
>> a virtio-mem device backed by huge pages in the hypervisor.
>>
>> Some special PFN walkers -- i.e., /proc/kcore -- read content of random
>> pages after checking PageOffline(); however, these PFN walkers can race
>> with drivers that set PageOffline().
>>
>> Let's introduce page_offline_(begin|end|freeze|thaw) for
>> synchronizing.
>>
>> page_offline_freeze()/page_offline_thaw() allows for a subsystem to
>> synchronize with such drivers, achieving that a page cannot be set
>> PageOffline() while frozen.
>>
>> page_offline_begin()/page_offline_end() is used by drivers that care about
>> such races when setting a page PageOffline().
>>
>> For simplicity, use a rwsem for now; neither drivers nor users are
>> performance sensitive.
>>
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> One nit below, otherwise
> 
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> 
>> ---
>>   include/linux/page-flags.h | 10 ++++++++++
>>   mm/util.c                  | 40 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 50 insertions(+)
>>
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index daed82744f4b..ea2df9a247b3 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -769,9 +769,19 @@ PAGE_TYPE_OPS(Buddy, buddy)
>>    * relies on this feature is aware that re-onlining the memory block will
>>    * require to re-set the pages PageOffline() and not giving them to the
>>    * buddy via online_page_callback_t.
>> + *
>> + * There are drivers that mark a page PageOffline() and do not expect any
> 
> Maybe "and expect there won't be any further access"...
> 

Thanks, makes sense.

I'll wait a bit before I resend.

-- 
Thanks,

David / dhildenb

