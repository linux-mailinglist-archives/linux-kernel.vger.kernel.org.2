Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93780429516
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 19:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbhJKREE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 13:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232752AbhJKREC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:04:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5011F61040;
        Mon, 11 Oct 2021 17:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633971721;
        bh=F8/FG4wlt4xTlS+woET9GXpzyRycR0DvcYe7q5SnHFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BOEJGj1u9dbGKE8w4fKpNL0m6V1DxY7jUO7YzAo5XDJSvaDy0deXoz8ZE7n/yCHoT
         QgE7GVO8DoFlM/97lzHoUaw7ZNw3lOiCqGELTDDUzaCtHbkpvXODeglAy6b/ycvH7R
         nZzArhZwMtcT9tnGgjrCXxpbY45ehs3X610CdikbqSsM+CX9Dg+MvfXI2U40ELDPvY
         0RsfLS0GILO3TRUF5R6Ka0sQKKSskMBqqLPisT2Eqka5lHWjsOM3G7Y7xu2sUcESDS
         2Ksst7CyqYJsqRpd7sGIJDprPoTSM4MER8NkZbZHxKfz8VOCT94n2xcUvyI1lp+wFy
         /ar+hSjkKi6Dg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH v2 0/4] ASoC: Intel: bytcr_rt5640: few cleanups
Date:   Mon, 11 Oct 2021 18:01:43 +0100
Message-Id: <163397094549.6567.12509842562892439300.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211007165715.27463-1-andriy.shevchenko@linux.intel.com>
References: <20211007165715.27463-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 19:57:11 +0300, Andy Shevchenko wrote:
> The small set of cleanups against bytcr_rt5640 board file.
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

[1/4] ASoC: Intel: bytcr_rt5640: Get platform data via dev_get_platdata()
      commit: e86c1893d6785a0f5e5d82cd161b991564720eaa
[2/4] ASoC: Intel: bytcr_rt5640: Use temporary variable for struct device
      commit: 81d43ca17506ba32c6ead7fe4cf3b7f37368cc83
[3/4] ASoC: Intel: bytcr_rt5640: use devm_clk_get_optional() for mclk
      commit: a15ca6e3b8a21ff335a2eedbc5ba4708967be2be
[4/4] ASoC: Intel: bytcr_rt5640: Utilize dev_err_probe() to avoid log saturation
      commit: ee233500eea421118cd9d53c82fd5e612f6d7bd5

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
