Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FD432F27D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 19:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCES13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 13:27:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229813AbhCES05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 13:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614968817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TEPnFeg5EaQcMTzMLTO+/1iyn6ySAsFp6AQcgB5ZDLg=;
        b=ZP0RhBnDTEdi7A3Kr9mdjX6+B9/Et+WNx7Pld/C5pOvIrzmz05fCbZWwmaC3gVCXLgxhdJ
        a9RhrnuoSUKbuiUtxFdg8q04vFT4S7a25uLp/safU9zPRNLQUnj9UPCmi3qgY2gUxi74RX
        LlRGkowtqWvAf6UpvajEnw5AGCeern4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-rOwcDg17PraTmR56KJSk6g-1; Fri, 05 Mar 2021 13:26:53 -0500
X-MC-Unique: rOwcDg17PraTmR56KJSk6g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8962710082E8;
        Fri,  5 Mar 2021 18:26:51 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6346160843;
        Fri,  5 Mar 2021 18:26:48 +0000 (UTC)
Subject: Re: [PATCH v4 3/3] x86/vmemmap: Handle unpopulated sub-pmd ranges
To:     Dave Hansen <dave.hansen@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210301083230.30924-1-osalvador@suse.de>
 <20210301083230.30924-4-osalvador@suse.de>
 <b1aff368-8321-0fa7-05ab-3d6c856c00f8@intel.com>
 <3d49fdca-de12-aa7d-ffc4-b2a8c7d79bee@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <57d317ff-8106-7447-f505-6cbd04254879@redhat.com>
Date:   Fri, 5 Mar 2021 19:26:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <3d49fdca-de12-aa7d-ffc4-b2a8c7d79bee@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.21 18:08, Dave Hansen wrote:
> On 3/4/21 9:02 AM, Dave Hansen wrote:
>>> +#define PAGE_UNUSED 0xFD
>>> +/*
>>> + * The unused vmemmap range, which was not yet memset(PAGE_UNUSED) ranges
>>> + * from unused_pmd_start to next PMD_SIZE boundary.
>>> + */
>>> +static unsigned long unused_pmd_start __meminitdata;
>> This whole 'unused_pmd_start' thing was unmentioned in the changelog.
> 
> One tiny suggestion: *Sometimes* for these optimizations, it's easiest
> to write the code up without it in one patch, then add the optimization
> in the next patch.
> 
> It makes it 100% clear what is part of the "core" algorithm and what is
> pure optimization.
> 
> I don't know if it will work here, but it might be worth taking a look.
> 

For this reason the s390x part by me (see patch description) was two 
separate patches. Maybe it also makes sense to split it up here.

-- 
Thanks,

David / dhildenb

