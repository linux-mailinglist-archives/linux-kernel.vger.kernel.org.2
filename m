Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0813DC1AE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 01:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhG3Xs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 19:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhG3Xs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 19:48:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D60D160EFF;
        Fri, 30 Jul 2021 23:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627688901;
        bh=f6q+H13wgYJiez7omm0CrRokrHgcc4Jfz9N8xk7Ur54=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OeCT6v0YaN+2zeHoyvr1eoMaZ/UVirYeQYxY9d9K7SZFoPlXYKKpbTtUgICU9X1YL
         CH1WfGGEwK8wnRRQU5iShUx4SHNeIGFudnM1EZqK/KZJAIhjzs1TBh6031FLg69dIa
         HP7plJEu0dz5ntfL2oHGscEU8sjGAcxpz/t/wADMvpUlaGlvbbnt5RVoD0J0xp7wps
         lVFn46CbIFuGKrxi2ZFdchfXN4vaBetCMM9jWRFN6BBRXiqXbMYLrWmEqIwSvuKzeg
         YkLVt1lKMwCjcSMbMzDcdmbbLwTL73g+ILCXg/t9s+RczZBhk+DkY/iJDc+xNPIpzl
         ke59o1aC3ZqKA==
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce nosmall_discard mount option
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <chao.yu@linux.dev>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210730100530.4401-1-chao@kernel.org>
 <YQREtmDLBNKSQViC@google.com>
 <c0af2126-7383-a579-e020-6480216c46fe@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <1a540deb-4219-4000-2f8d-a72695f1dfde@kernel.org>
Date:   Sat, 31 Jul 2021 07:48:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c0af2126-7383-a579-e020-6480216c46fe@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/31 7:41, Chao Yu wrote:
> On 2021/7/31 2:28, Jaegeuk Kim wrote:
>> how about adding "discard_gran=[small|segment|section]", and keeping discard_map
>> in the small case only? And, I think we should set the section mode for zoned
>> device automatically.
> 
> Yup, better,
> 
> About the naming, it look discard_gran is not clear here, since there is another
> sysfs entry /sys/fs/f2fs/<devname>/discard_granularity has the same name, and
> also semantics of newly added mount option is not only control the smallest discard
> size, but also indicate discard start offset should be aligned to segment or section.
> So how about using: "aligned_discard=[none|segment|section]" instead?

Maybe: "aligned_discard=[block|segment|section]"?

> 
> Thanks,
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
