Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7829745DB4B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 14:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355363AbhKYNmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 08:42:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:58230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351852AbhKYNkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 08:40:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 356A861059;
        Thu, 25 Nov 2021 13:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637847417;
        bh=YBUe5iaqpRc+freiqsgpPGGUt/uvv62GjcaSgEBy0SE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DLnzZ3fnInJInqcpRZi7dgjPdaG1NeirxE8fZIE/F308Gn6ohRfInj1CtYDN8Oa3a
         2l6Y5+1PJvKmMCHiURFPDeqyTqJuYDgPM4okXiygZxC5XNXkrNoTEzSUI8HwiBKQy1
         +TCLrUqazBIt9Fqs6iNnjElDGXI8G5G0JVzR/XHm0RL8KP4pRhP26jJX/TGv5PHTlg
         vObqXaYnbYLPGXYOivZIlwd5KkGfiwJpopHiPe+ntNtw+bgGirQnSjem1W9WEk2sAK
         bsDru2Z0+e5OkXpDF3x4ONLmsKi9efixko4sUoBea3hG749vPEGVMZOm6Ev46xz/k4
         Rx9s4ShUxCRGQ==
From:   Mark Brown <broonie@kernel.org>
To:     matthias.bgg@gmail.com, tzungbi@google.com,
        kaichieh.chuang@mediatek.com, Jiaxin Yu <jiaxin.yu@mediatek.com>,
        garlic.tseng@mediatek.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20211125042422.2349-1-jiaxin.yu@mediatek.com>
References: <20211125042422.2349-1-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: remove unnecessary CONFIG_PM
Message-Id: <163784741495.3101847.17087805943861117771.b4-ty@kernel.org>
Date:   Thu, 25 Nov 2021 13:36:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 12:24:22 +0800, Jiaxin Yu wrote:
> The unnecessary conditional inclusion caused the following warning.
> 
> Such as:
> >> sound/soc/mediatek/mt8192/mt8192-afe-pcm.c:2368:32: warning: unused
> >> variable 'mt8192_afe_pm_ops' [-Wunused-const-variable]
>    static const struct dev_pm_ops mt8192_afe_pm_ops = {
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: remove unnecessary CONFIG_PM
      commit: faf695517c1c77bb4a4b46d54007a283962eb00e

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
