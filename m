Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0230B349850
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhCYRiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230228AbhCYRhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:37:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90FB061A2F;
        Thu, 25 Mar 2021 17:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616693853;
        bh=FeQb28pNS2AdW2pbIgoRXK1sd/ExR2r66h+k/Zc5vpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NXuZCDQ54LwxGOQ65eoPGAjJnEwMR+CEgirer/rQnlUOqG6B8e5zYPaAS76QL/oo6
         F2X58hkbhzi6pFcUrhCnufhUsOL6kj+uG+NNsI+6cn+j12wjQGH/8P8ABYs+z4k7GV
         CsDl9RPSBdzi7NY/1IqJmOuBcVo00ei4EdaGVBbADrS9c520/8/XOawBwc7ZLXxiEX
         MUYZ5S8L8y526cRXV9MN2wmkhW7dJpgVjcy9f9Lb6CpQb7LkW0KaF3k0Q3n7bO8bkm
         Z1z7gspS3viFRgiD6f5MF+tGhUnEceyyWFSRaOvX4o784r+KfdiZfeuf86QF61owZu
         M4O2nCBf8c9AQ==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, perex@perex.cz, festevam@gmail.com,
        Xiubo.Lee@gmail.com, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nicoleotsuka@gmail.com,
        linux-kernel@vger.kernel.org, timur@kernel.org,
        alsa-devel@alsa-project.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        lgirdwood@gmail.com, robh+dt@kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: fsl-asoc-card: Add support for WM8958 codec
Date:   Thu, 25 Mar 2021 17:37:05 +0000
Message-Id: <161669370551.41585.15951987176621269157.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1615986303-27959-1-git-send-email-shengjiu.wang@nxp.com>
References: <1615986303-27959-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 21:05:02 +0800, Shengjiu Wang wrote:
> WM8958 codec is used on some i.MX based platform.
> So add it support in this generic driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl-asoc-card: Add support for WM8958 codec
      commit: efd0b1660829a987354cea6a446179c7ac7cd0e6
[2/2] ASoC: bindings: fsl-asoc-card: add compatible string for WM8958 codec
      commit: df8077c6fe64fe98c1b1c1f9ecf84afc773e726f

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
