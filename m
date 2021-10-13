Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7243842CA8B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 22:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239146AbhJMUCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 16:02:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238928AbhJMUCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:02:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F2C5611CC;
        Wed, 13 Oct 2021 20:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634155217;
        bh=PbioJUSgrHswROc8bHM1Hz526HYB0Fa9UFSIVps9jJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nI2INLRSGzBt06O/pBDE5Sy+EZh75tLEQXq/OhqVaXVbrpuAnuXHrjFZloogtDNLX
         OKGbneFh777Xc8AIK4GMO17Hu7199qV3fwW6/TyV2VObM67p6hMAtreEcqnlDQaP+H
         9ckR4BySj2or3UqvkcG5M7IXkO2OMKYuz/pB/NHsaKYesp7xv6R6oziJl7dxCMd/I0
         BWATO4bRfRH77wbgkOEQdj6MOf40lAiomavsuG+h9RbhEXdU74AhZglDpLt93vztSq
         nlnHz6gFcD3KM6eG2EHKyXUnsx4KnfeE0pQyj78KMdcLXbnjLcxU0z1OSbq3Q/XBG3
         Nvm0MiHK7SMNA==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, cy_huang <u0084500@gmail.com>,
        oder_chiou@realtek.com, robh+dt@kernel.org, perex@perex.cz
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, allen_lin@richtek.com,
        devicetree@vger.kernel.org, cy_huang@richtek.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 0/2] ASoC: rt9120: Add Richtek RT9120 supprot
Date:   Wed, 13 Oct 2021 20:59:51 +0100
Message-Id: <163415517074.1358186.14156300933559857070.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1634088519-995-1-git-send-email-u0084500@gmail.com>
References: <1634088519-995-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 09:28:37 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> This patch series Add the Richtek RT9120 support.
> 
> In v4:
> - Add 'classd_tlv' for 'SPK Gain Volume' control item.
> - Unify the tlv declaration to the postfix '_tlv'.
> - Fix 'digital_tlv' mute as 1 to declare the minimum is muted.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: rt9120: Add initial bindings
      commit: 126a76ada98f17c7f4ed1cc8b8e0429c574924e5
[2/2] ASoC: rt9120: Add rt9210 audio amplifier support
      commit: 7228d83531fcd801aeac97db99a028a386a2e828

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
