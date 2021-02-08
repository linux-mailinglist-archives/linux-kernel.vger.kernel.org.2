Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B397D314012
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbhBHUMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:12:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235686AbhBHSkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:40:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C962F64E6C;
        Mon,  8 Feb 2021 18:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612809569;
        bh=5IBhQ7c3BzKenFcsQ0x87dAwNhuhz1U+iCIXHPWQyxM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VU2VcT7TaDO3lBZ+GiDsY1XzFCoiEFRHjkWoyS5jY75bIxBkybh+BXvUmZR3aQexr
         i5/tDc4C08lpVQ6qJWPmzIg4cjhfZuowj47xMC1wkaV05c6mSTupTFN+IhSfIq/Fxs
         DTHkE4k3cBun8UqU0mmmDvlDQnYIlVSOO2GOv7tK9/Vm4Rn0BKHp881myK23Y9NMei
         l3AEJUcKYtBlrfOvjaQaiQTiwBDnVk0YqrwCylJf9hABDBIkCsKohzRxg5NrC4XZjH
         AoCt9qt7JjwtYz2JujdAeicrUJLpNmVH2b1xvTDhsrbIsP6duqD3JfJ4xw26EKb6Ct
         BqF7FZYwICdcQ==
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        patches@opensource.cirrus.com,
        Charles Keepax <ckeepax@opensource.cirrus.com>
In-Reply-To: <20210120214957.140232-1-hdegoede@redhat.com>
References: <20210120214957.140232-1-hdegoede@redhat.com>
Subject: Re: (subset) [PATCH v4 0/5] MFD/ASoC: Add support for Intel Bay Trail boards with WM5102 codec
Message-Id: <161280948306.10741.6212553639750410303.b4-ty@kernel.org>
Date:   Mon, 08 Feb 2021 18:38:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 22:49:52 +0100, Hans de Goede wrote:
> Here is v4 of my series to add support for Intel Bay Trail based devices
> which use a WM5102 codec for audio output/input.
> 
> This was developed and tested on a Lenovo Yoga Tablet 1051L.
> 
> The MFD and ASoC parts do not have any build-time dependencies
> on each other. But the follow-up jack-detect series does have
> patches depending on each-other and on this series. So IMHO it
> would be best if this entire series would be merged through the
> MFD tree to make merging the follow-up series easier.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[4/5] ASoC: Intel: Add DMI quirk table to soc_intel_is_byt_cr()
      commit: 8ade6d8b02b1ead741bd4f6c42921035caab6560
[5/5] ASoC: Intel: bytcr_wm5102: Add machine driver for BYT/WM5102
      commit: 9a87fc1e061900e81ab13d823e85012a78849244

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
