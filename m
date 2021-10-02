Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FCA41F8A4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 02:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhJBASy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 20:18:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232416AbhJBASv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 20:18:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1604761B1F;
        Sat,  2 Oct 2021 00:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633133826;
        bh=IEy8aoAh4I/HW4q0ag1u2eggzk6jXZTIk99KZWIufao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TVtztCJATBTBXx+HR3jKoupcDsN4qy4XJKmDWcD92ThR4rcvYcyMtOxyAdG+TuSo6
         cZkv/DCFQnyjh4xOFenZXUkdHu9tvJ7UHC/0dmM13GjHM33MprwbXWU4Xjm94HkLr1
         Ccm57XZMtKnU7dbT2Ht64zKxV4/PiNJGk7dpZVy6wkCZXsRj4nE/EW2LyE90JDj4h2
         wfR2kznxrVbO71K9ys8lkcRZpff1JDUAZieBG9gw1PUGKKAhLmoFR4gpqMXi3EwJAn
         ryjPJFE/0nQ49j5xhQy2rnXYkvewKdZzyVdzN803KD9cddNSIrkLXjSZcgc64ilkMA
         TT3+i0DoEvgGQ==
From:   Mark Brown <broonie@kernel.org>
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Rander Wang <rander.wang@intel.com>,
        Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, Bard Liao <bard.liao@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: Add support for max98360a speaker amp
Date:   Sat,  2 Oct 2021 01:16:32 +0100
Message-Id: <163313339132.45396.5370991907979359672.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001150316.414141-1-brent.lu@intel.com>
References: <20211001150316.414141-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2021 23:03:16 +0800, Brent Lu wrote:
> From: Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>
> 
> Add a board config adl_mx98360a_rt5682 to support alc5682 headset
> codec and max98360a speaker amplifier. Follow Intel BT offload design
> by connecting alc5682 to SSP0 and max98360a to SSP1.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_rt5682: Add support for max98360a speaker amp
      commit: 9c892547624ff277546a9d4fede3d95259e6faea

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
