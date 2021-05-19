Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C26E389352
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355155AbhESQMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355144AbhESQMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:12:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B06DB6124C;
        Wed, 19 May 2021 16:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621440684;
        bh=na6FALQoNuy8u03ZG29zB+aTDGjiYRhmATrXpQWBCAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M8qK9qlv1xTdKbAIltgvg+rJeQrfD6rWZ3qGsvDwCpkySLGOY7w0PLI5svRkIbHoh
         RLhl5ybGt7z1ZSI3GzedvHOtWdotKfkJQV9AmmLoRdX+1Foun3bUCvhBsDCKcqx6L3
         Z+MpvafZ95wCw35PONHCbVpL2f2+TYLMLlhjVbMRPEL5fuKcNzCOhIhmDpWi++i3vG
         y+IY7va2TV4EMoRbuTBPDt0Gk/4A70DiSyitS2AAkLjdolxeNiQRKLgqcQIVCuaH6m
         9VQIHm10JySYHd/RpBCkdu8ukCjHg1KWBKgW06XPO8lbggU8qLK+2GL5P0rVLStKyc
         OMF/RJXyoy0Rg==
From:   Mark Brown <broonie@kernel.org>
To:     jbrunet@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] ASoC: meson: g12a-toacodec: add support for SM1
Date:   Wed, 19 May 2021 17:10:18 +0100
Message-Id: <162144027324.37060.1996054206902696511.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210511074829.4110036-1-narmstrong@baylibre.com>
References: <20210511074829.4110036-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 09:48:27 +0200, Neil Armstrong wrote:
> This patchset adds Amlogic SM1 support on the TOACODEC driver, first by switching
> to regmap fields for some bit fields to avoid code duplication, and then by adding
> the corresponding bits & struct for the SM1 changed bits.
> 
> Changes since v2 at [2]:
> - use raw values instead of defines in REG_FIELD() for g12a_toacodec_match_data
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: meson: g12a-toacodec: use regmap fields to prepare SM1 support
      commit: 172dd9216d2b8a3fa162039d89c4361ef35c85ae
[2/2] ASoC: meson: g12a-toacodec: add support for SM1 TOACODEC
      commit: 7487238c5f530b418745ce134d1b0a7fba3a0d8d

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
