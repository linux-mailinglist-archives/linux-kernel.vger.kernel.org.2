Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFEB39AA4D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhFCSoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:44:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230324AbhFCSok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:44:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80F45613F8;
        Thu,  3 Jun 2021 18:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622745776;
        bh=aKL4P90UklmZRmziqJ/4jcRmInWRC0xeazGe6Lr2jnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gCFuQkJ81vzUEtnrRDrzXadZrf0q7YjMasCaVD30QD5waYSlkzz7Gp9XqlCf4WW1p
         53ZYMO5SzDVoqBQy0Pvvi2xBWpSyvfXp75MCEy4MNPCKGdd1qKfTnAwm6m/2PksaA2
         /9OCyjB1D/sHKE/BIPQkFGClsam8tVih6netE2WQ+qNl5QTq8MrYRvOaUsQSuFx1dL
         zOIwKWFDYim+LkEZhWgIgQ4R4vBPbm+Xl69Uu5SA2kdlRKhtboVFS9/aG0qoq4entZ
         lkJ1NhUMy01y5grIdP+xi7O/phdyev9u2lnOmPLaoou1jduKopebM/uQCj/bbbMnn2
         hK8n4N5fTDM9A==
From:   Mark Brown <broonie@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, kernel@pengutronix.de,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: Convert imx-audmux binding to json schema
Date:   Thu,  3 Jun 2021 19:41:59 +0100
Message-Id: <162274557552.14795.1322019660591642626.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210531064752.8809-1-o.rempel@pengutronix.de>
References: <20210531064752.8809-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2021 08:47:52 +0200, Oleksij Rempel wrote:
> Convert the imx-audmux binding to DT schema format using json-schema

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: Convert imx-audmux binding to json schema
      commit: 14aa731dbf464f7272bcc2f0c4f32f6de28cbe8c

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
