Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7D33312EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhCHQIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:08:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230486AbhCHQI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:08:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EE6E65210;
        Mon,  8 Mar 2021 16:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615219707;
        bh=dp5CLRZ/qcCLRBLFiX1Elejcb5Arx4EDlbEp0HHDH1Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LfdzLPPbq9W7CZ7v8EHQghN3CFK/Zuhx8Ptho+UIORomAXGE68s+X9ZyN4SceEvh1
         8Br2eVy6SLaJb0vC7ecRnFhW++wAvubKpCz42XKOablLrp73rEVHca9J6/dMgr6zGR
         2Fyy2H0/RTOfVG3jkCVcfSiLYjYCAoH5MXTA+xRVLnkeUeOZ4YOwuCOJGT/sWsvURn
         wuh1Wc7dDzKQitA5V3AO41N1U/CyYFGcHJhZNTPj3AIGSrfuAOwXh9oi5XtB/QdyGn
         MDNCyBiceExcVP9s9Um6vT2rp3sTFJjMu2M1abXdD6g1WHdkGeCxzgEi59002NVdG5
         jpuMJEOK7JsDA==
From:   Mark Brown <broonie@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>, perex@perex.cz,
        timur@kernel.org, nicoleotsuka@gmail.com, tiwai@suse.com,
        Xiubo.Lee@gmail.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210302125002.23900-1-tangbin@cmss.chinamobile.com>
References: <20210302125002.23900-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: Use devm_platform_ioremap_resource_byname() to simplify code
Message-Id: <161521960849.9621.15073900533403359434.b4-ty@kernel.org>
Date:   Mon, 08 Mar 2021 16:06:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2021 20:50:02 +0800, Tang Bin wrote:
> In this function, devm_platform_ioremap_resource_byname() should be
> suitable to simplify code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_xcvr: Use devm_platform_ioremap_resource_byname() to simplify code
      commit: c5f48a78e0cb950eb821af36b8790b794cc745b1

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
