Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB4833791A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbhCKQT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:19:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234497AbhCKQTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:19:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84D9464F97;
        Thu, 11 Mar 2021 16:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615479571;
        bh=AFZsDVrJrAtJWcG1GG6obs737AUKvX7hTKFiz+JZZUg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=r1JtU5sjp3BLfF9gHUENNxLxY79k7OPlkh1srmbQ7Y+WbT6av82T4RB7ntRanXv+b
         AwdOQI48IGX2lcQ2Z1teGxn0mjC4NaftgNso9qzTuyEAMnCuXpg/9zUnU1FZnbQE4u
         WRQjwVbvxrl2kjvY/gGeyKnTq3UGgbc3R6ifDpmVZp9g5nBSrLwt5RFjRKYvRfKu/2
         QltXMs4+zspF859ua4Mk5tH024cTcC4G7+8OKZYklLA0UXPG4me2qymCPI+Q8MLlhw
         J9J7tF09GTFQIiofuompfwzvsjiqbB7j9Y8qhzAWJ7YFmgyPeafNwQwhip/OHAmtTT
         UqSSSihiMz0Yw==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20210310193928.108850-1-pierre-louis.bossart@linux.intel.com>
References: <20210310193928.108850-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: soc-core: fix DMI handling
Message-Id: <161547949199.51229.15758316133624899795.b4-ty@kernel.org>
Date:   Thu, 11 Mar 2021 16:18:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 13:39:27 -0600, Pierre-Louis Bossart wrote:
> When DMI information is not present, trying to assign the card long
> name results in the following warning.
> 
> WARNING KERN tegra-audio-graph-card sound: ASoC: no DMI vendor name!
> 
> The initial solution suggested was to test if the card device is an
> ACPI one. This causes a regression visible to userspace on all Intel
> platforms, with UCM unable to load card profiles based on DMI
> information: the card devices are not necessarily ACPI ones, e.g. when
> the parent creates platform devices on Intel devices.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-core: fix DMI handling
      commit: c68fded79a9fe1376a60049f2ab45d611969de5c

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
