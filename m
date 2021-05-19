Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DF1389224
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347805AbhESPCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:02:21 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:42374 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhESPCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:02:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621436460; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=638YVhE9uQAJ1yHYklSQlB/9IUMfzjqyYCUeaH69iag=; b=JagaSfnkfQ7IWmr0l4qgdRu8x4H6iFM0y4gP0dgOR6tCA36b6k9mbpIA54VX39mpzViyvbq6
 8C0yDowShSJ1+/y4LzkZrA75YnI25K4aMS7X8ZymEs2ZzC942zjemcmlO0jvSkuKDUdYu6Kp
 lSUxj2Zs+HfqMfEahQyODAmJsNI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60a52809063320cd1387e32f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 19 May 2021 15:00:25
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9CA42C43146; Wed, 19 May 2021 15:00:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 14244C433D3;
        Wed, 19 May 2021 15:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14244C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Thomas =?utf-8?Q?Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Serge Belyshev <belyshev@depni.sinp.msu.ru>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        regressions@lists.linux.dev
Subject: Re: [i915] b12d691ea5: kernel_BUG_at_mm/memory.c
References: <20210519024322.GA29704@xsang-OptiPlex-9020>
        <CAHk-=whcr5M=4Mz2ydu4XtxTL_34WkXPnmFmA4f8r+ELXDC6hg@mail.gmail.com>
        <20210519133330.GA14452@lst.de>
Date:   Wed, 19 May 2021 18:00:14 +0300
In-Reply-To: <20210519133330.GA14452@lst.de> (Christoph Hellwig's message of
        "Wed, 19 May 2021 15:33:30 +0200")
Message-ID: <87y2ca6a69.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> On Tue, May 18, 2021 at 04:58:31PM -1000, Linus Torvalds wrote:
>> On Tue, May 18, 2021 at 4:26 PM kernel test robot <oliver.sang@intel.com> wrote:
>> >
>> > commit: b12d691ea5e01db42ccf3b4207e57cb3ce7cfe91 ("i915: fix remap_io_sg to verify the pgprot")
>> > [...]
>> > [  778.550996] kernel BUG at mm/memory.c:2183!
>> > [ 778.559015] RIP: 0010:remap_pfn_range_notrack
>> > (kbuild/src/consumer/mm/memory.c:2183
>> > kbuild/src/consumer/mm/memory.c:2211
>> > kbuild/src/consumer/mm/memory.c:2233
>> > kbuild/src/consumer/mm/memory.c:2255
>> > kbuild/src/consumer/mm/memory.c:2311)
>> > [  778.688951] remap_pfn_range (kbuild/src/consumer/mm/memory.c:2342)
>> > [  778.692700] remap_io_sg (kbuild/src/consumer/drivers/gpu/drm/i915/i915_mm.c:71) i915
>> 
>> Yeah, so that BUG_ON() checks that theer isn't any old mapping there.
>> 
>> You can't just remap over an old one, but it does seem like that is
>> exactly what commit b12d691ea5e0 ("i915: fix remap_io_sg to verify the
>> pgprot") ends up doing.
>> 
>> So the code used to just do "apply_to_page_range()", which admittedly
>> was odd too. But it didn't mind having old mappings and re-applying
>> something over them.
>> 
>> Converting it to use remap_pfn_range() does look better, but it kind
>> of depends on it ever being done *once*. But the caller seems to very
>> much remap the whole vmsa at fault time, so...
>> 
>> I don't know what the right thing to do here is, because I don't know
>> the invalidation logic and when faults happen.
>> 
>> I see that there is another thread about different issues on the
>> intel-gfx list. Adding a few people to this kernel test robot thread
>> too.
>> 
>> I'd be inclined to revert the commits as "not ready yet", but it would
>> be better if somebody can go "yeah, this should be done properly like
>> X".
>
> I think reverting just this commit for now is the best thing.

Yes, please revert it if there's no quick fix. On my Dell XPS 13 9310
laptop (with Debian 10) X won't start until I revert commit
b12d691ea5e0, so this is a major issue.

Also adding the new regressions list, as this is an i915 regression
introduced in v5.13-rc1.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
