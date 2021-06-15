Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D723A7DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhFOMIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhFOMIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:08:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0895961437;
        Tue, 15 Jun 2021 12:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623758808;
        bh=C59SXF8kM4HNcdZxrEa6z376xr37BIWP3ZfoDwC39DE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ehE4e8soru4vX7YvJZiz5Nmi1Uq/jGfeAvHK2X+uJx9wmR8JrtAIzTzIe4L35Ca1t
         Dt+cmGHyoiZXrwMlLmrbO6XWsKLsumD6uGKiy30ZROwC4Cu1dooG9uhI3MnO6RuFh3
         Tou4xN+SlMDkBA/KOP6GHhAtsKUbOKNhE7HJDotffruyOt+YxgMYQ+ar0F3LIO0TiI
         8PXqq5QqgjBGE98tKRZkUYM+PiBAQn3Ul5fZDMkZ80YjabUdry+R90bbJr5pfGjspC
         8Tvw1ldCE7PX67+au4fk5oOvyvLgf8Al6eCSv07ClotTCiPbCoZv1MZnAtcvG/geoD
         2lMBZafWmHmgg==
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: fsl,spdif: Add compatible string for imx8ulp
Date:   Tue, 15 Jun 2021 13:06:25 +0100
Message-Id: <162375817571.30661.10673881585496337751.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1622613849-10271-1-git-send-email-shengjiu.wang@nxp.com>
References: <1622613849-10271-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 14:04:09 +0800, Shengjiu Wang wrote:
> Add compatible string for imx8ulp, which supports spdif module

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: fsl,spdif: Add compatible string for imx8ulp
      commit: cb7d734ea9b85f49f26d04d8de09ece363cbd6fc

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
