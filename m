Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC0432A06C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377817AbhCBETk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:19:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233006AbhCAX5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 18:57:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id ACEC960241;
        Mon,  1 Mar 2021 23:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614642877;
        bh=4POY9hPulA7pZxJfhv2cwLhfelwQTch7J+hsYCBVSKc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NXca2sdpTJjfREDpYr9rsEjLGkOCvA7P4woZcX9IKbtA6Jb44ffp3GyrDPEcK9/mj
         oCpqC7/ZbNmeuZa+11cJTg5rBEjuhB/RFOp7W9GgC/nUlqEhQa6qgWW3vGW5xEJJ5h
         N90q3ur9CX+e/khFoByoIhnLhmoTCQ1quz86oGBX+pRbiNjyRHkfA4l8NCoBE5R+8V
         kL6NNlIYAoYidpK6hwpCJTHhdLh+1iRe2GrzCqBRPiHA6S6LOQ4nqZ+nYyCwUrWoWQ
         z6fpCj7YZXxqwhrE73OM7GyvCAzBmnbOccQ8TRobn5Y3ddzK2BZxdUlxxnR5Xk0cRF
         aqVC15Xg7eHyg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A091260997;
        Mon,  1 Mar 2021 23:54:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: tag_mtk: fix 802.1ad VLAN egress
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161464287765.7970.7338802339733391563.git-patchwork-notify@kernel.org>
Date:   Mon, 01 Mar 2021 23:54:37 +0000
References: <20210301160159.7622-1-dqfext@gmail.com>
In-Reply-To: <20210301160159.7622-1-dqfext@gmail.com>
To:     DENG Qingfang <dqfext@gmail.com>
Cc:     sean.wang@mediatek.com, Landen.Chao@mediatek.com, andrew@lunn.ch,
        vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        iochesonome@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Tue,  2 Mar 2021 00:01:59 +0800 you wrote:
> A different TPID bit is used for 802.1ad VLAN frames.
> 
> Reported-by: Ilario Gelmetti <iochesonome@gmail.com>
> Fixes: f0af34317f4b ("net: dsa: mediatek: combine MediaTek tag with VLAN tag")
> Signed-off-by: DENG Qingfang <dqfext@gmail.com>
> ---
>  net/dsa/tag_mtk.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [net] net: dsa: tag_mtk: fix 802.1ad VLAN egress
    https://git.kernel.org/netdev/net/c/9200f515c41f

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


