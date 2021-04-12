Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBC735C6F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 15:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241619AbhDLNFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 09:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241518AbhDLNFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 09:05:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17B2761261;
        Mon, 12 Apr 2021 13:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618232702;
        bh=vD2eYyoPS4jxroHHmL/LuAOn9cgDbkT8Oc6bPY6qgzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1xeaBNNR2u0eedACveIL+oyv1/ucClMVO/EwLyDdUNgi6CT2mseVPq9MoAKTLnjj
         DCCGco58nFoweuTKC5zBI1nNqe01n6FCrkKMgow0F055zt88Kp/RRH1L6WLo8wkNyF
         gyXaM6gkY4pve+MXr5ZykqwAJzfzlyGCixcSZndrJKVTMg5Rn/VcGo7hUQlnpfDe6X
         UfeQouMaiNNYUqIbQajrdMPIN+6HeaK+gw7xBgQdvh2TmEouLdt69D/9SKHYcQ280V
         z+BVktQTkiR6TZV1DGVNHxSFI9Ia8OZ3gX4zQXpbYxRkNu4V+PY6gHCoj3WTMdCyHH
         JQmJomv78hXvA==
Date:   Mon, 12 Apr 2021 15:04:58 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     zhouchuangao <zhouchuangao@vivo.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module: Use BUG_ON instead of if condition
 followed by BUG.
Message-ID: <YHRFegmoOURrmHp3@gunter>
References: <1617106055-6295-1-git-send-email-zhouchuangao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1617106055-6295-1-git-send-email-zhouchuangao@vivo.com>
X-OS:   Linux gunter 5.11.6-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ zhouchuangao [30/03/21 05:07 -0700]:
>It can be optimized at compile time.
>
>Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>

Hi,

Could you please provide a more descriptive changelog? I.e., Is this
a fix for a cocinelle warning? What are the optimization(s)?

Thanks,

Jessica

>---
> kernel/module.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 3047935..f46fc4f 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -1014,8 +1014,8 @@ void __symbol_put(const char *symbol)
> 	};
>
> 	preempt_disable();
>-	if (!find_symbol(&fsa))
>-		BUG();
>+	BUG_ON(!find_symbol(&fsa));
>+
> 	module_put(fsa.owner);
> 	preempt_enable();
> }
>-- 
>2.7.4
>
