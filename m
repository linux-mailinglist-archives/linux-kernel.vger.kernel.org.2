Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F0C32A055
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhCBEPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:15:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345981AbhCAXhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 18:37:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85AB661477;
        Mon,  1 Mar 2021 23:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614641780;
        bh=cZUXtiovZI/tzqijypqjrzq6gBu3W8SMAC9WklSHYws=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dCaF9pF4GRmEI4DE44lP4QN+Xroxj01DFpBfqqFQgpr3XTZGB6WONfW0O2O9bnEzD
         uURGw8GvAUEEjUqNTlCdWSKQLsTFenL8jaJVuFaoNeU4wNOJaZCsfzwCjcxA+gg9im
         63BvJ22/zLB70SoFZNe2Y/yT3QKw5sTgUm4YU5QaUdfmaCGfsXuJ67WKkTz2fVKiNv
         G3e6UKMTqEjg8E7RQ/NdHVh4gPRbfaAvPdFxZN3NkeiYNk/Q67S1pPPgzU0u/h+z7K
         FvpuvIq5L5l6GpR/79/MDh0tvcVRgsBWiQ7O20spaK1FHP2Ub8DXpV22jmHp19klND
         QgGg6uDcOiyWA==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        Oder Chiou <oder_chiou@realtek.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20210224211918.39109-1-rikard.falkeborn@gmail.com>
References: <20210224211918.39109-1-rikard.falkeborn@gmail.com>
Subject: Re: [PATCH 0/4] ASoC: rt*: Constify static structs
Message-Id: <161464168097.31144.1513145502519193305.b4-ty@kernel.org>
Date:   Mon, 01 Mar 2021 23:34:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021 22:19:14 +0100, Rikard Falkeborn wrote:
> Constify a number of static structs that are never modified in RealTek
> codecs. The most important patches are the first two, which constifies
> snd_soc_dai_ops and sdw_slave_ops, both which contain function pointers.
> The other two patches are for good measure, since I was already touching
> the code there.
> 
> When doing this, I discovered sound/soc/codecs/rt1016.c is not in a
> Makefile, so there is not really any way to build it (I added locally to
> the Makefile to compile-test my changes). Is this expected or an oversight?
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: rt*: Constify static struct sdw_slave_ops
      commit: 3ebb1b951880d3152547ac4018bfcce0fd7810bd
[2/4] ASoC: rt*: Constify static struct snd_soc_dai_ops
      commit: 84732dd4ff3ad28cc65eedfa3061fe3808e8469b
[3/4] ASoC: rt*: Constify static struct acpi_device_id
      commit: c85ca92c716bd04981ebcd2c67cd03f96748859e
[4/4] ASoc: rt5631: Constify static struct coeff_clk_div
      commit: 39f9eb61307061eed197eae651ef56cb3544f9b2

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
