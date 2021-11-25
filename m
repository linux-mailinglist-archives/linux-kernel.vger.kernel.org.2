Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1A745DB46
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 14:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355223AbhKYNmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 08:42:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350118AbhKYNkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 08:40:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61C9060F58;
        Thu, 25 Nov 2021 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637847411;
        bh=jxmFhSak3x0D2jmlAoXoCpezcEiGF+lrOW1vA5iV5ns=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rVm30AQIwPSxsE7pL3WHUG7CW9VIYdrFXeF76TDbplVi81YC2HHP+fIS3RNB8z47P
         7331yFJeY89S79EVYDgvnR0eidX7+zqqBjaBOIVY526bOeCbg9XqHp0n/N6/nwEM5f
         O36+4eFBiCMbgSwOc5zB2xM6PWi69wOXPag55jYC9Z8EMZOXqAJf243x3oZIO23MBj
         S44hsJizxQhbKojcWVk1TNTEQNJtjh2GqobgeqaIKtmjhhZxg3LY2PNzxl7FCUKEpC
         AkdCoNLRXJJ9hyCdfFtJGpLUue+w5Tw8anPQoUkSLmKPOeVbLkdanXSIoEjeH4gYwD
         ZWo/zMPZYp84Q==
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        - <patches@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     ~okias/devicetree@lists.sr.ht, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Rob Herring <robh@kernel.org>
In-Reply-To: <20211124155101.59694-1-david@ixit.cz>
References: <20211124155101.59694-1-david@ixit.cz>
Subject: Re: [PATCH] ASoC: dt-bindings: wlf,wm8962: add missing interrupt property
Message-Id: <163784740913.3101786.1880598598821673766.b4-ty@kernel.org>
Date:   Thu, 25 Nov 2021 13:36:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 16:51:01 +0100, David Heidelberg wrote:
> Both, hardware and drivers does support interrupts.
> 
> Fix warnings as:
> arch/arm/boot/dts/tegra30-microsoft-surface-rt-efi.dt.yaml: audio-codec@1a: 'interrupt-parent', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	From schema: /home/runner/work/linux/linux/Documentation/devicetree/bindings/sound/wlf,wm8962.yaml
> 
> Fixes: cd51b942f344 ("ASoC: dt-bindings: wlf,wm8962: Convert to json-schema")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: dt-bindings: wlf,wm8962: add missing interrupt property
      commit: 12dc48f545fd349ef2cadcc4d816706951b87998

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
