Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E2238B8C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 23:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhETVJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 17:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229971AbhETVJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 17:09:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 865D561353;
        Thu, 20 May 2021 21:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621544907;
        bh=LG9V/TQafsoAsE88DwTNEoOzd9py69hLE9jxEkJQCPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EbMNMGWokIwMGVWGnzQ6B+yMcpTNPUl9VU02RDoGJAUjKWfdRVyoIus65bfiMQnbL
         L1micb+F1YUSYQHmtXAt84+JpWWAT8CmSMPTIw4YdENcJ9zrsL2t0s0w7wzHWP/o70
         7KwKB+7x1U4vOs/vG5TpIuoFRxXWQmihTEnUFAk2gQd8nvU5VA7Z/iFoBJSy9OnxTa
         Ez6fNGw1yupI+1xIpvwgYzUbkIM8b+E10bDeOW6ucfcXROjM0IhsL8lPQyBi5kj58T
         PvncV6jUEBkpvh2Yi9TbRV6Hr8XAbSOnKrjLqzkRvDz9/ozc6UiQBSMisTnlNNOFfg
         ZMdvDdS0F5v2w==
From:   Mark Brown <broonie@kernel.org>
To:     linux-imx@nxp.com, perex@perex.cz,
        linux-arm-kernel@lists.infradead.org, nicoleotsuka@gmail.com,
        festevam@gmail.com, shawnguo@kernel.org, Xiubo.Lee@gmail.com,
        alsa-devel@alsa-project.org, timur@kernel.org,
        s.hauer@pengutronix.de, Shengjiu Wang <shengjiu.wang@nxp.com>,
        robh+dt@kernel.org, kernel@pengutronix.de,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: imx-card: Add binding doc for imx sound card
Date:   Thu, 20 May 2021 22:08:06 +0100
Message-Id: <162154465460.5161.5323165215525240615.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1621247488-21412-1-git-send-email-shengjiu.wang@nxp.com>
References: <1621247488-21412-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 18:31:27 +0800, Shengjiu Wang wrote:
> Imx-card is a new added machine driver for supporting
> ak4458/ak5558/ak5552/ak4497 codec on i.MX platforms. But these
> DAC/ADCs are not only supported codecs. This machine driver is
> designed to be a more common machine driver for i.MX platform,
> it can support widely cpu dai interface and codec dai interface.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: imx-card: Add binding doc for imx sound card
      commit: 623cd9cfcac522647e3624e48bf0661a39e8502a
[2/2] ASoC: imx-card: Add imx-card machine driver
      commit: aa736700f42fa0813e286ca2f9274ffaa25163b9

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
