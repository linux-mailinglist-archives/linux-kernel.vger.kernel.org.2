Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AD43400B2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhCRIOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhCRIOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616055276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=15NAKS9Isxz1mUr9bz1U2OlYkIPx+9vW+iRsoYJamYs=;
        b=V9GxgI7nFMhvI7JAADXLRYryZpTbeBEAVZMl/URLcCH78mlLm1CVRk4MIRnvz3d8J1/jU8
        3KldLIHCPmLBkQFAFuPppfATpQNPbjQ6QzcjTtL1LqTzAVvqJURHL4+GnMDJ3Y+qLJWExm
        5oeiNZBChnWKQMtla0bmWEjdWuUuP28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-gDW63DTcOSiKUSClNJiSTA-1; Thu, 18 Mar 2021 04:14:32 -0400
X-MC-Unique: gDW63DTcOSiKUSClNJiSTA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1974D8189CD;
        Thu, 18 Mar 2021 08:14:30 +0000 (UTC)
Received: from [10.36.113.61] (ovpn-113-61.ams2.redhat.com [10.36.113.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 456C21F41B;
        Thu, 18 Mar 2021 08:14:27 +0000 (UTC)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Aili Yao <yaoaili@kingsoft.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yangfeng1@kingsoft.com,
        sunhao2@kingsoft.com, Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20210317163714.328a038d@alex-virtual-machine>
 <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
 <20210318044600.GJ3420@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH] mm/gup: check page posion status for coredump.
Message-ID: <5cc2ccb8-16bc-bbbf-6c94-124be1d95458@redhat.com>
Date:   Thu, 18 Mar 2021 09:14:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210318044600.GJ3420@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.03.21 05:46, Matthew Wilcox wrote:
> On Wed, Mar 17, 2021 at 10:12:02AM +0100, David Hildenbrand wrote:
>>> +	if (IS_ENABLED(CONFIG_MEMORY_FAILURE) && ret == 1) {
>>> +		if (unlikely(PageHuge(page) && PageHWPoison(compound_head(page))))
>>> +			ret = 0;
>>> +		else if (unlikely(PageHWPoison(page)))
>>> +			ret = 0;
>>> +	}
>>
>> I wonder if a simple
>>
>> if (PageHWPoison(compound_head(page)))
>> 	ret = 0;
>>
>> won't suffice. But I guess the "issue" is compound pages that are not huge
>> pages or transparent huge pages.
> 
> THPs don't set the HWPoison bit on the head page.
> 
> https://lore.kernel.org/linux-mm/20210316140947.GA3420@casper.infradead.org/

Oh, okay -- I was missing that we actually already set the HWPoison bit 
before trying to split via TestSetPageHWPoison(). I thought for a second 
that if splitting fails, we don't set any HWPoison bit.

-- 
Thanks,

David / dhildenb

