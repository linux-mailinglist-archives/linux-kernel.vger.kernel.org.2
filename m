Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039063F72E7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbhHYKYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:24:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237446AbhHYKX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:23:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C07EB60F58;
        Wed, 25 Aug 2021 10:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629886993;
        bh=tL7vzePFTdLCCmodujY/NanR9r8e1EVRA9OUWU++xVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DkMlb3x15kaHAS5yBC0QcWkok6jr2m8aKitWs2fJ1cynennGpTOdO2D9WyftZpOjN
         6DhBQhwiwnZ7PJ0Rul1S8KYYHiUaut07duUFPBxRn1BWZPaWmkXMoF2suZAO51jY+i
         uM8I4cC1Vszj4WcPGx4NdzD7L7UTEbNxxcqEYMwd5HiNJv5ZbhljOkfMtcYDTwGFYe
         e8jKZNZ5shMo9ntlEj/sfnJmTKI5C/wKo5tN6QNOqW3+GpNeOrvfLIFKLN7gNgzTBR
         K1QwO6PVbIuD0H3nbOULPakzQ/q39tutsO3upYERzs6rj5c99dTczFtAJrHAQni8jt
         xXZKJvSkRRxMw==
From:   Mark Brown <broonie@kernel.org>
To:     CGEL <cgel.zte@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, Bard Liao <bard.liao@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        sound-open-firmware@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Zeal Robot <zealci@zte.com.cn>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH linux-next] ASoC: SOF: intel: remove duplicate include
Date:   Wed, 25 Aug 2021 11:22:38 +0100
Message-Id: <162988521424.7213.4488311947948918308.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210824030015.57267-1-deng.changcheng@zte.com.cn>
References: <20210824030015.57267-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 20:00:15 -0700, CGEL wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Clean up the following includecheck warning:
> 
> ./sound/soc/sof/intel/pci-tng.c: shim.h is included more than once.
> 
> No functional change.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: intel: remove duplicate include
      commit: 0be10d7122ceb8f322086283420a59ee89c1947f

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
