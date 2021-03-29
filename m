Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CCE34D8B8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhC2T7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:59:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231906AbhC2T6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:58:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD2D261981;
        Mon, 29 Mar 2021 19:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617047914;
        bh=u6ACrZWGumDoalB5NQX3JFz6rDEZMDWEtoyXeuanOmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dMhvtU4diIdI8b8gBUkD+8PCCTgY6vZ97c3QBXsIEdnnv/A4/uNxAoLd6oOgEX7MV
         j5oqCBD7lkkl2Bj7f4c7PO/MReDZro7S1LsRn2a/9L8aNftkn2L9bJoqK2qPyzYBs4
         z6ZOJdN3cuaRK4QPcsE68s/1Mlwy3x5fL1I1JZTmy31Ac3m2ZKJ/Bxe66RHyenNWQP
         76tWUplbD8gnBwAf/5tcrBlx9c22D3NECZaJCPEa4DxB3zLeuVw2VBabmEQxR5lqhn
         oMre4fFGPjavQRzMiwgCvaOdY+WUDZ1nr4uGwd4ZcqKC66FkUgKf7UywGipfZkXDI9
         mz5bcvH6bY4FQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        nicoleotsuka@gmail.com, tiwai@suse.com, perex@perex.cz,
        linuxppc-dev@lists.ozlabs.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_rpmsg: initialise pointers to NULL
Date:   Mon, 29 Mar 2021 20:58:10 +0100
Message-Id: <161704724765.10039.8726528619377342527.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1616988868-971-1-git-send-email-shengjiu.wang@nxp.com>
References: <1616988868-971-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 11:34:28 +0800, Shengjiu Wang wrote:
> This fixes the following sparse warnings:
> 
> sound/soc/fsl/fsl_rpmsg.c:45:45: sparse: sparse: Using plain integer as NULL pointer
> sound/soc/fsl/fsl_rpmsg.c:45:56: sparse: sparse: Using plain integer as NULL pointer

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_rpmsg: initialise pointers to NULL
      commit: 502e5321d89214a34a7b8bda697fc98d14b51cae

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
