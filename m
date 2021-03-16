Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACFD33DBDE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239556AbhCPSBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:01:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239555AbhCPSAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:00:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56D5065138;
        Tue, 16 Mar 2021 18:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615917606;
        bh=iGiBNRxaPcDr+iH013raTIVuSi+f7uXGwsktWMiJ3zA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vk1OzZljn21yoof0f5+sxZerNH5nku57uhEErWCu0wqClyD4i6+Q2gbSbinH/hoX/
         Poq/vNUJiY/GJRdmdYa4dy0OgbxuWygENGWFNGJxR89EDL9/78UysElnpg21NKbXw3
         dHmhgaKTG+tQt/c3LtCQ8qWbaLFIFrWbvqrfSGFAcNarYf5zhp/nPIvochh1Nk2zX/
         /iQmt9+9gN+yM1Qzw0QDlvx610nIKv6apmWOqSYnVYx7KkGj4UQwREqOEzXHtdR7lx
         3h+LSG2S/3G7RkIPagCZMjiVT9fa2EGi41cX+jUOfYFHx+iHShBzl51X69GHAScRa1
         i8iYkO/X4yU8A==
From:   Mark Brown <broonie@kernel.org>
To:     timur@kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Xiubo.Lee@gmail.com,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, linux-imx@nxp.com,
        festevam@gmail.com, lgirdwood@gmail.com, nicoleotsuka@gmail.com,
        alsa-devel@alsa-project.org, shawnguo@kernel.org,
        shengjiu.wang@gmail.com, kernel@pengutronix.de
Subject: Re: [PATCH v2] ASoC: imx-hdmi: fix platform_no_drv_owner.cocci warnings
Date:   Tue, 16 Mar 2021 17:59:44 +0000
Message-Id: <161591744695.13544.5664238144081084443.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1614848881-29637-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1614848881-29637-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2021 17:08:01 +0800, Yang Li wrote:
> ./sound/soc/fsl/imx-hdmi.c:226:3-8: No need to set .owner here. The core
> will do it.
> 
> Remove .owner field if calls are used which set it automatically

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-hdmi: fix platform_no_drv_owner.cocci warnings
      commit: 2e2bf6d479616a15c54c4e668558f61caffa4db4

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
