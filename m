Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733F9425F38
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 23:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241732AbhJGVjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 17:39:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241534AbhJGVjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 17:39:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF2FF61152;
        Thu,  7 Oct 2021 21:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633642667;
        bh=RUK0kPmHAOwiyfYYe+mPAhOc9DXX1luwgMqnlpuewis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bky+hSk1pXSFDlknPO5K1ZVCm7ONjtvUy1WUgxq2PlDMFy33iR4Cesoss4nyTIcud
         Y64940WlXiX7C80VtmeuC+mO9CX7vmUzuwncx5TbOqfp6jmWQ7OYupIshAeG2zeAPg
         Mo8BaRQUauvNr8Ie12ot72Wh30Cxzig8SbcrGP9DkncCbhb6bxSuBaBQOBl42P14mF
         02AoHWxV3suPP18Dz/Ejz1TTiwmRjZuO6UOtzDQve3NBBvPx03g2WBlleIJmngUOwd
         kSN6BQaUO4MJLi4MsQxf+WLAR6QbMCKoaNBEd1bEBu2HNnDhcFZeqtvPdn80msSiyj
         cN2nuO7gTkIUw==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v1 1/4] ASoC: Intel: bytcht_es8316: Get platform data via dev_get_platdata()
Date:   Thu,  7 Oct 2021 22:37:25 +0100
Message-Id: <163364264608.649699.14383378670565096509.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006150428.16434-1-andriy.shevchenko@linux.intel.com>
References: <20211006150428.16434-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2021 18:04:25 +0300, Andy Shevchenko wrote:
> Access to platform data via dev_get_platdata() getter to make code cleaner.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: Intel: bytcht_es8316: Get platform data via dev_get_platdata()
      commit: 2577b868a48ef3601116908738efbe570451e605
[2/4] ASoC: Intel: bytcht_es8316: Use temporary variable for struct device
      commit: 6f32c521061b704c0198be3ba9834f5a64ea5605
[3/4] ASoC: Intel: bytcht_es8316: Switch to use gpiod_get_optional()
      commit: 10f4a96543b744c8cc7ef8b0799af21d911dd37d
[4/4] ASoC: Intel: bytcht_es8316: Utilize dev_err_probe() to avoid log saturation
      commit: c25d4546ca452b2e8c03bc735e4c65bc6dd751dd

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
