Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378C53D9968
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 01:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhG1X2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 19:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232609AbhG1X2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 19:28:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 040DF6101B;
        Wed, 28 Jul 2021 23:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627514898;
        bh=O+//6IJ/VPQ62CUgWxVD82JUZheq3ea8zHr1YC2khU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JQRw58bjtYCNMizbYEe/o+pyprfdExpIxGQFN8yiWlY/viVeE9z5mPuo7P9AbOf12
         DmSP8aCGhgGnPH97bGg58DnLnLoTJbMRDyYomYKzdqbdHZp6d5jGwyLCILSYTPpJlu
         5haPpcGiN60gzdNNgqJmLvTpfkFiXVk0LZQxflLDdLhKbXKrck5aZTa+0nIeZfP91H
         Nkcdy9QrP/WQw+eYNC7rj5MOSrvUWKwegmGcywAf54m3brX0L8Ad08OPNU8p4mZhKj
         fMTJrID7/Lvu3Ki+RYc2ly7qnbfLdBliMEpe3fdMVEm97IVcp95vGjoXuW2XbAJxPv
         YgovX1W/vvg0A==
From:   Mark Brown <broonie@kernel.org>
To:     Jie Yang <yang.jie@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Colin King <colin.king@canonical.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ASoC: Intel: Fix spelling contraction "cant" -> "can't"
Date:   Thu, 29 Jul 2021 00:27:55 +0100
Message-Id: <162751391069.10122.6012833198246486438.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210728103602.171817-1-colin.king@canonical.com>
References: <20210728103602.171817-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021 11:36:02 +0100, Colin King wrote:
> There is a spelling mistake in a dev_err message. Fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Fix spelling contraction "cant" -> "can't"
      commit: 0f6b04adb58d80e7fb5f8d9229ad22c9931c3bd1

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
