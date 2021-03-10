Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5777933461B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbhCJR7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:59:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233701AbhCJR6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615399115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sN3rfVQ5mWC4zIRNCuy+nBt59u74/cvs2MbFtdHtVIo=;
        b=gRXIYb65oiTZe30KM1Z5sq3rfJqW4CLsMNBU6jmVGG0jJCZFW4Knwf9lp7Pu1SJ6D2ZCoQ
        QOT0u7sW71l2fWqa/ju1EuEHswfrM5Kea2r8aCUwMFQv+M2HSdVm1NuBk0nbL0rmPPOhL9
        V6//Y4HrLXmIcI0ipGwiO0Tx9tvmzP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-_wKzQ_dVNDOyILlTmxpsVw-1; Wed, 10 Mar 2021 12:58:31 -0500
X-MC-Unique: _wKzQ_dVNDOyILlTmxpsVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02E9657;
        Wed, 10 Mar 2021 17:58:30 +0000 (UTC)
Received: from [10.36.112.107] (ovpn-112-107.ams2.redhat.com [10.36.112.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DA4718C7A;
        Wed, 10 Mar 2021 17:58:27 +0000 (UTC)
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210309174113.5597-1-osalvador@suse.de>
 <20210309174113.5597-4-osalvador@suse.de>
 <3471fe0e-d8f4-c8fe-2096-8d9c8b1ab5bc@redhat.com>
 <20210310174953.GA16289@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v5 3/4] x86/vmemmap: Handle unpopulated sub-pmd ranges
Message-ID: <1814c21c-b822-0ec6-c16d-92424d00663a@redhat.com>
Date:   Wed, 10 Mar 2021 18:58:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210310174953.GA16289@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.21 18:49, Oscar Salvador wrote:
> On Tue, Mar 09, 2021 at 06:52:38PM +0100, David Hildenbrand wrote:
>>> -#define PAGE_INUSE 0xFD
>>> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
>>> +#define PAGE_UNUSED 0xFD
>>> +
>>> +/* Returns true if the PMD is completely unused and thus it can be freed */
>>> +static bool __meminit vmemmap_pmd_is_unused(unsigned long addr, unsigned long end)
>>> +{
>>
>> I don't think the new name is any better. It implies that all it does is a
>> check - yet it actually clears the given range. (I prefer the old name, but
>> well, I came up with that, so what do I know :D )
> 
> Sorry, I did not mean to offend here.

Oh, I didn't feel offended - I was rather expressing that my opinion 
might be biased because I came up with these names in the s390x variant ;)

> 
> Something like: vmemmap_is_pmd_unused_after_clearing_it would be a bit better
> I guess.
> Tbh, both this and previous one looked fine to me, but I understand where Dave
> confusion was coming from, that is why I decided to rename it.
> 
> Maybe a middle-ground would have been to expand the comment above.

Thinking again, I guess it might be a good idea to factor out the core 
functions into common code. For the optimization part, it might make 
sense too pass some "state" structure that contains e.g., 
"unused_pmd_start".

Then we don't have diverging implementations of essentially the same thing.

Of course, we can do that on top of this series - unifying both 
implementations.

-- 
Thanks,

David / dhildenb

