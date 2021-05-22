Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627B738D61C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 16:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhEVOJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 10:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230301AbhEVOJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 10:09:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4897461163;
        Sat, 22 May 2021 14:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621692473;
        bh=Dj7btGZhjC8HmA/lmm1kAa2DNki43ozhToKBO4EfoZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIRMIHM0l/izLQ4oRZRhkP6TlV7N9BJa6m7wODYLWAEMoSd4gzmCSoDKQgPfRFzeE
         a9yjokiZ8XmaCwn9GzGJaysi7gkSb6Yl+aJwEO76ZCrzH8b+SNohsxAxawRQWGIbJm
         kTeN77ZF3SewcyB7uLVpVCyKgRuIY6SxlYwAN5mXnb7wPk+u7QmHavC71usdM5zQUw
         w1ZW3gffksKRHdlFwMCL6OhCXa0jPR1kEK5fbBt1E4AONKw6GkjJ+relpr6gALcnpG
         jcyAf0ihp3LotmWKK6E5Qrc9F/RGqs9qVO+N6nBn72MhA9pX26r6mAuByntF1XsOsM
         mxLxmhuj+IuQA==
Date:   Sat, 22 May 2021 22:07:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        shengjiu.wang@gmail.com
Subject: Re: [PATCH] ARM: dts: imx6ul: Switch to fsl-asoc-card sound card
Message-ID: <20210522140747.GD8194@dragon>
References: <1619664739-12589-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619664739-12589-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 10:52:19AM +0800, Shengjiu Wang wrote:
> There is issue with simple sound card, the simple sound
> card can't configure the pll of codec.
> 
> [  115.352669] wm8960 1-001a: failed to configure clock
> [  115.358843] wm8960 1-001a: ASoC: error at snd_soc_dai_hw_params on wm8960-hifi: -22
> 
> So Switch to fsl-asoc-card and the fsl-asoc-card can support
> asrc module as front-end component.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Applied, thanks.
