Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4563941B3C6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241840AbhI1QZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241792AbhI1QZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:25:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E250D60F5B;
        Tue, 28 Sep 2021 16:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632846250;
        bh=NARFtHeqyRbAbSEFSnqZt8yx8JZc2xoc5EO9W5fLgL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7wIT0DYG1goVQMsotXBiZEpTm0YD1dAGPTcw8EF/g2zSddmskJDlB4/fLkwJXYCY
         apWIW10YC0SVQvIp0/zoncJRGWK4YK9AZ/7WAlW8kc7bbwsbQZBicXcYb6lOpcbD/O
         vkfrxEAQqH2d2oKUr1xdDdXLtCuDiK8peF2s6vieVHBwq/l23Ukpj601wLCzWdUdWS
         mVfK8SeeuJTvXaFTjeeTh40t3LOnFWwzOIQHKhnIpsSHjVxd7H8aiWSbTtoR3b4fhQ
         3AohWufsbDa1w+DM+OouZS40gsjLRYTYTtaaKftmOg8TDdrLLaa1GBCwzEL4GgVQC0
         pFfEHYuIOFWnA==
From:   Mark Brown <broonie@kernel.org>
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Rander Wang <rander.wang@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yong Zhi <yong.zhi@intel.com>, Takashi Iwai <tiwai@suse.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH] ASoC: intel: sof_rt5682: update platform device name for Maxim amplifier
Date:   Tue, 28 Sep 2021 17:23:04 +0100
Message-Id: <163284573551.17390.4087071777524402599.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210927143249.439129-1-brent.lu@intel.com>
References: <20210927143249.439129-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2021 22:32:49 +0800, Brent Lu wrote:
> To follow 20-character length limitation of platform device name, we
> have only 7 character space for amplifier. Therefore, the last
> character of mx98357a and mx98360a is removed to save space.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: intel: sof_rt5682: update platform device name for Maxim amplifier
      commit: 3c561a090c7920624b83005a279a66cc8a7bed2b

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
