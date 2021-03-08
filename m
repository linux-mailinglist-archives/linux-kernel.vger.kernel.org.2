Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A783331737
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 20:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhCHT0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 14:26:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26737 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229813AbhCHTZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 14:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615231546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zhy88DaTlHV0ulu9qH4mRTxbA1BNIYKfudjB13qylLI=;
        b=PT5YQeO8vKaKgIzInfoZcZqwcBn8WMWLTnMBpo/UHxs0Gdncow5qBHSGSmS5qMzjqZf/Pj
        5EuTYcX74mHoEksArIMFonVlbQZaCpKGgdrt2S70JnfBo7y2olWVYTY0QnGCilxCBKDcKV
        6WCVofpM1lwrRHS8saEHkBQBJfIm1mE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-I8DUg0vKNymzknHgB2rQZw-1; Mon, 08 Mar 2021 14:25:43 -0500
X-MC-Unique: I8DUg0vKNymzknHgB2rQZw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00A4C19057AC;
        Mon,  8 Mar 2021 19:25:40 +0000 (UTC)
Received: from [10.36.113.123] (ovpn-113-123.ams2.redhat.com [10.36.113.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42BCC5D6D5;
        Mon,  8 Mar 2021 19:25:37 +0000 (UTC)
Subject: Re: [PATCH v4 2/3] x86/vmemmap: Drop handling of 1GB vmemmap ranges
To:     Oscar Salvador <osalvador@suse.de>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210301083230.30924-1-osalvador@suse.de>
 <20210301083230.30924-3-osalvador@suse.de>
 <62c5b490-353a-ca3a-d2c8-f02189210c32@intel.com>
 <20210308184840.GC25767@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <8cbaa17f-11fe-76eb-a53d-0eb17a7488de@redhat.com>
Date:   Mon, 8 Mar 2021 20:25:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210308184840.GC25767@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.21 19:48, Oscar Salvador wrote:
> On Thu, Mar 04, 2021 at 10:42:59AM -0800, Dave Hansen wrote:
>> On 3/1/21 12:32 AM, Oscar Salvador wrote:
>>> We never get to allocate 1GB pages when mapping the vmemmap range.
>>> Drop the dead code both for the aligned and unaligned cases and leave
>>> only the direct map handling.
>>
>> Could you elaborate a bit on why 1GB pages are never used?  It is just
>> unlikely to have a 64GB contiguous area of memory that needs 1GB of
>> contiguous vmemmap?  Or, does the fact that sections are smaller than
>> 64GB keeps this from happening?
> 
> AFAIK, the biggest we populate vmemmap pages with is 2MB, plus the fact
> that as you pointed out, memory sections on x86_64 are 128M, which is
> way smaller than what would require to allocate a 1GB for vmemmap pages.
> 
> Am I missing something?

Right now, it is dead code that you are removing.

Just like for 2MB vmemmap pages, we would proactively have populate 1G 
pages when adding individual sections. You can easily waste a lot of memory.

Of course, one could also make a final pass over the tables to see where 
it makes sense forming 1GB pages.

But then, we would need quite some logic when removing individual 
sections (e.g., a 128 MB DIMM) - and I remember there are corner cases 
where we might have to remove boot memory ...

Long story short, I don't think 1G vmemmap pages are really worth the 
trouble.

-- 
Thanks,

David / dhildenb

