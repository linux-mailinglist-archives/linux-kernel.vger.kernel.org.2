Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE1637BD7A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbhELM4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233560AbhELMzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:55:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE660613F8;
        Wed, 12 May 2021 12:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620824048;
        bh=s63/YJ4rfJgTZzM8uR7M0raGMpzNRGRCgreL8WEBXdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iSWdCs42qLZHX2ToG41t7al8jA2FDsE9y5DGWzMyqPTV7ldBCszU/dCVM5pmB23ln
         Nxeqm5eS8LBZzGvfHr5P4oBu80yPT0cI1rXim5a+J2MokjMFjdjbdWYRDvcetofq39
         AdRj332k+PLgLfIjDjh84V+hVAaQU6oTFJjoQSsY7nAZFzMq5RpTPaaRWnTQeFq1Bh
         yu3ooTHmAUWnmclclXHqV7qFBTR25Q5pE1bO9im87xM0lGqjCKrKmXWyflv8t3xU/S
         kc6hk/oHF6j/cX4ifwcYDeo4SwqbNp6UNpEDxfEzkkmT0IyA/WMy2Eyyw9bZemiurq
         6gno/8flQsjtA==
Date:   Wed, 12 May 2021 14:54:04 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     zhouchuangao <zhouchuangao@vivo.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module: Use BUG_ON instead of if condition
 followed by BUG
Message-ID: <YJvP7JLKwJbcEYIg@p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de>
References: <1620610682-25567-1-git-send-email-zhouchuangao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1620610682-25567-1-git-send-email-zhouchuangao@vivo.com>
X-OS:   Linux p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de
 5.12.0-2-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ zhouchuangao [09/05/21 18:38 -0700]:
>This patch comes from cocinelle warning.

Please include the output of the cocinelle warning here as well.

See commit 56149c8cd820 ("media: pci: saa7164-core.c: replace if
(cond) BUG() with BUG_ON()") for an example. Thanks.

>BUG_ON uses unlikely in if(). Through disassembly, we can see that
>brk #0x800 is compiled to the end of the function.
>As you can see below:
>    ......
>    ffffff8008660bec:   d65f03c0    ret
>    ffffff8008660bf0:   d4210000    brk #0x800
>
>Usually, the condition in if () is not satisfied. For the
>multi-stage pipeline, we do not need to perform fetch decode
>and excute operation on brk instruction.
>
>In my opinion, this can improve the efficiency of the
>multi-stage pipeline.
>
>Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
>---
> kernel/module.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index b5dd92e..faf9114 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -1014,8 +1014,7 @@ void __symbol_put(const char *symbol)
> 	};
>
> 	preempt_disable();
>-	if (!find_symbol(&fsa))
>-		BUG();
>+	BUG_ON(!find_symbol(&fsa));
> 	module_put(fsa.owner);
> 	preempt_enable();
> }
>-- 
>2.7.4
>
