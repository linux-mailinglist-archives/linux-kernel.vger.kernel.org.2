Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC87B429513
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 19:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhJKREB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 13:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233373AbhJKRD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:03:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0CA56103C;
        Mon, 11 Oct 2021 17:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633971716;
        bh=jm+MmghP27mX/Vw4z1PWGh2UsatbCOer/kNjOSXtGSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SprZptrV5S23fsND4ATcbmrILSVzjoDUuw2bGr9aAyNU1u1MumrMa7BFyULBRae9O
         JsqmxucdbNDFkuTkBrt6vssF8zUCSKyRA8i9+aVZmpM4ECjKRdo6fg+gdyvRI6l/CG
         gACeQPsyyVJG6RHI/3K9Jm+1BfOlKjwRQuCCjQOLW74DNe/qSFAWiLH+jJCs1poQef
         0Ksv2ME3Fs78L+4gWlbJ2F66sqKkeliJXLAJNpJoPv/VaYrJUIjDLLnIQsUv07ecof
         xbYPDaDNF5rAXkSlyLcRcYxe3yfTCsg3VoFCyKkHOKN86yho4P1vv3rRU3Ue16iSNq
         OWLOA5qlxilsQ==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 0/4] ASoC: Intel: bytcr_rt5651: few cleanups
Date:   Mon, 11 Oct 2021 18:01:41 +0100
Message-Id: <163397094550.6567.12613609707745181814.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211007170250.27997-1-andriy.shevchenko@linux.intel.com>
References: <20211007170250.27997-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 20:02:46 +0300, Andy Shevchenko wrote:
> The small set of cleanups against bytcr_rt5651 board file.
> 
> In v2:
> - added commit message to patch 2 (Joe, Pierre)
> - added cover letter (Pierre)
> - added Hans to Cc list (Hans)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: Intel: bytcr_rt5651: Get platform data via dev_get_platdata()
      commit: 0c465e7a8ea26f4ad52dd9548f22afdaf6e039a5
[2/4] ASoC: Intel: bytcr_rt5651: Use temporary variable for struct device
      commit: 269da8f7626b1de69998fe1a0c0e069749d18a28
[3/4] ASoC: Intel: bytcr_rt5651: use devm_clk_get_optional() for mclk
      commit: a8627df5491e00e23d4f2e648ff796adbfa23cc5
[4/4] ASoC: Intel: bytcr_rt5651: Utilize dev_err_probe() to avoid log saturation
      commit: 45c5dc45d80d41596bc0364fafc523648e6124d8

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
