Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A23425F3A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 23:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242187AbhJGVjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 17:39:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241753AbhJGVjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 17:39:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD3B961175;
        Thu,  7 Oct 2021 21:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633642675;
        bh=Q/3Zh6BeJ0iOh2f8WH4pqEQ0/pyFSZZFE+3zbz+hEPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uH5ZTUDgYLLeQ6DNOL/qeaXP9z8tc0HzqBKxO6xHh2yQZOR3LreWcUd0Yu7r3mkm8
         Erdg9MED1gPeYR901gUffb/RmGcER8vwGrfsuc48ApRdDhF2c7RPwYpvhIyxjWabAb
         lBVN3xpp97qqwCJYqyuGaRIuboDebSrkjykmFRCtSMLI0Go0xRDnBy8OcbGjAJuFFh
         IMe5nJR/aupA2pCgh33BOo+mh8+QMF0TxP+w9RL/DtlYkUsaW7+SUNKZynNi20dNV9
         jl/B2zgYLh125yuMGLD3wsOqltHiQwPDIUpjj1ls+Y/isIjCaKe/AIIwVp/3tJqV6g
         wYS59zGy3g1cA==
From:   Mark Brown <broonie@kernel.org>
To:     =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH v4 0/2] Add reset-gpios handling for max98927
Date:   Thu,  7 Oct 2021 22:37:28 +0100
Message-Id: <163364264607.649699.766377916130433507.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1633572679.git.atafalla@dnyon.com>
References: <cover.1633572679.git.atafalla@dnyon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 04:38:54 +0200, Alejandro Tafalla wrote:
> The max98927 codec on some devices (i.e. Xiaomi Mi A2 Lite phone) requires
> hardware-resetting the codec by driving a reset-gpio. This series adds
> support for it through an optional reset-gpios property.
> 
> v4:
> * Correctly assert/deassert the GPIO states
> * Wait for the i2c port to be ready after reset
> * Reset device when removed
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: max98927: Handle reset gpio when probing i2c
      commit: 4d67dc1998f1890a9d22d03208037075ea9f2562
[2/2] dt-bindings: sound: max98927: Add reset-gpios optional property
      commit: b23d3189c038c091adc8de382d20a8f5321645a1

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
