Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27034407AED
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 01:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhIKXqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 19:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232655AbhIKXqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 19:46:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4348861212;
        Sat, 11 Sep 2021 23:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631403929;
        bh=R9YlOcuzzuAyv3ThEs6dM+K+vfoxM4pDPOUXDaUkkuQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q8IxT5dr2TeAtl0aZu9vsQu7yyYT+lIYc6bLY1U+f3wz/r1Rf2Mt4O74l47U5vtZR
         y8BfcUouXX6BQpCQSdVufrX63szUir719LYmXvW/zZ6Jj7Z0NLYjf/SrxFGcTfbntV
         WJXJWOKqHcD0MMoYdjc1bF8M68/JqKouFI4akm3TF9U2TkptrGsT6iGLnMUOQiW9hN
         X12pdJdUSbvmbNUUjhT+FseO5CT58kGVdH1oVCqR9iq/GVHWz7//ilTXP1gdaz175t
         EEvv9HIKSunif+MmTkIbO+S3JDRC/2KxdgQnZK7f5YoUPLIElMRv1VPHWLVsjZM4E9
         On3YM8O4bqFAg==
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: introduce fragment allocation mode
 mount option
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Daeho Jeong <daeho43@gmail.com>
Cc:     Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210902172404.3517626-1-daeho43@gmail.com>
 <YTvmhVhLlBPeASHT@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <9f4a2954-e8c9-abc5-5df4-a7cec53433a3@kernel.org>
Date:   Sun, 12 Sep 2021 07:45:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTvmhVhLlBPeASHT@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/11 7:13, Jaegeuk Kim wrote:
> Wait. Why do we need to add so many options here? I was expecting to see
> performance difference when getting random segments or random blocks as
> an extreme case. I don't get the point why we need the middle of those cases.

I guess we can simply the aging test procedure of filesystem by changing a bit
based on this patch.

See comments in below thread.

https://lore.kernel.org/lkml/425daf77-8020-26ce-dc9f-019d9a881b78@kernel.org/

Thanks,
