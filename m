Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027DD3626D4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242623AbhDPRbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242430AbhDPRbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:31:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51605C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 10:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=/83oxjoBsrKTLJD6ELhf3v9qLCntfhe0mYpEazOahKE=; b=GXkzK6JBMjUPGeJewgtWFsix03
        Kmi5255GhtPvfQlUWAEYcjnOXPRyQ1pWa/eNR1/rmVOorpZBKIzji4wFle2g8B2SXWmpXOvlE1uNY
        U0Ol2I5UuODVc7u0gkdyfiCWnadE4KNSlhLiVGwplq2xmT6UFIbc+oM27S3b/ehzno9ge1h0SMvdx
        BJaWeJaL5pvlmAYJAyeES51g/qc8dz1jUReGp1tGDaVIxqmNoXZ5wypk7ILxXJ9WcFb/q//xn1Txn
        CDCncrRKxphnSlpdYIA0yeCA8MFTvqZbbrYC9IerZRwlOkgwR+CAAl0/4vwPDOt2EqUSZFrZY2gy2
        v9k6ynPA==;
Received: from [2601:1c0:6280:3f0::df68]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lXSJH-002xCY-Gx; Fri, 16 Apr 2021 17:31:15 +0000
Subject: Re: Page BUGs
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Drew Abbott <abbotta4@gmail.com>, linux-kernel@vger.kernel.org
References: <CALY-g84i=WPVT7OKwKa1xJaORPwMUyjdX0ewqqoVsC2ihbpvtg@mail.gmail.com>
 <48806d4c-743a-8c63-fd86-04babb149744@infradead.org>
Message-ID: <e39e346d-6d4c-f265-67ca-736d51f16266@infradead.org>
Date:   Fri, 16 Apr 2021 10:31:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <48806d4c-743a-8c63-fd86-04babb149744@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/21 10:29 AM, Randy Dunlap wrote:
> On 4/16/21 10:20 AM, Drew Abbott wrote:
>> Hello,
>>
>> I have been troubleshooting problems with the vanilla and lts linux kernels
>> for a couple of weeks now and saw this mailing list in MAINTAINERS for
>> problems with mm.h; apologies if this is the wrong place to ask. I have
> 
> MAINTAINERS file says:
> 
> MEMORY MANAGEMENT
> M:	Andrew Morton <akpm@linux-foundation.org>
> L:	linux-mm@kvack.org
> S:	Maintained
> W:	http://www.linux-mm.org
> T:	quilt https://ozlabs.org/~akpm/mmotm/
> T:	quilt https://ozlabs.org/~akpm/mmots/
> T:	git git://github.com/hnaz/linux-mm.git
> F:	include/linux/gfp.h
> F:	include/linux/memory_hotplug.h
> F:	include/linux/mm.h
> F:	include/linux/mmzone.h
> F:	include/linux/pagewalk.h
> F:	include/linux/vmalloc.h
> F:	mm/
> 
> so linux-mm@kvack.org would be better IMO.
> 
>> been experiencing many freezes and panics with this hardware:
>> https://pcpartpicker.com/user/Abbott/saved/#view=wXdgt6
>> Originally[0], many of the traces referred to cpu idling funcs that seem to
>> be addressed already[1][2], but now all of the traces refer to problems
>> with paging[3][4][5][6]. I normally mount a mergerfs filesystem at boot
>> that I thought was causing the panics[7], but I have since removed that
>> entry from fstab and can still see paging bugs without that fs (or any
>> other FUSE fs) mounted[7].
>> What can I do to keep my computer from freezing and panicking?
>>
>> Thank you,
>> Drew Abbott
>>
>> [0] https://bbs.archlinux.org/viewtopic.php?id=259571
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=212087
>> [2] https://bugzilla.kernel.org/show_bug.cgi?id=212543
>> [3] https://imgur.com/HT4F7p7
>> [4] https://imgur.com/pTb4Miu
>> [5] https://imgur.com/pTb4Miu
>> [6] https://imgur.com/JVueE3m
>> [7] http://0x0.st/-ATM.log
> 
> [7] tells me:
> SyntaxError: JSON.parse: unexpected non-whitespace character after JSON data at line 1 column 16 of the JSON data

That was on Firefox.
Opera can display it successfully.


-- 
~Randy

