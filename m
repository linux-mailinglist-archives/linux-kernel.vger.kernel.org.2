Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D380944046D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 22:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhJ2U5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 16:57:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230253AbhJ2U5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 16:57:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F72A61040;
        Fri, 29 Oct 2021 20:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635540906;
        bh=2XzSq4mVbWcQ9X6sHFBxKYl/i6WLCiLInFmuv1V6Ido=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SCwi14Q32wkQulSG3D10Dm6er2K3MeGlI+QUsfLSGsZJbzlv07jDgpMx4Yye5akU4
         06Wmo6gO43cbS4g06g93cTtXetvM1MLPwKbTl7AErRrv0jXPZnYZiqxWF6adw+lEah
         udL1sYBYX4dTtYMkcDQ7pY57EkNm73cd4j8BbbrRj16WlMRiAEfwsLVm1sNs3rSevj
         GA40yLMcQv6qWvrhZlN5Hra3fzPhrirN02jM7Hp7O52gD8R9YdI0C2Bu1I5qkQ1qg+
         PFtdog9FbohtpSoxnHJgrkwHztIU6omDZ4CxPjX8UWzY0sW27sntf4Tbfh97g2YUzq
         abEB9occrYu2g==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Brent Lu <brent.lu@intel.com>
Cc:     Gongjun Song <gongjun.song@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Yong Zhi <yong.zhi@intel.com>,
        Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>,
        Takashi Iwai <tiwai@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bard Liao <bard.liao@intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Rander Wang <rander.wang@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jie Yang <yang.jie@linux.intel.com>,
        linux-kernel@vger.kernel.org, Mac Chiang <mac.chiang@intel.com>
In-Reply-To: <20211029171409.611600-1-brent.lu@intel.com>
References: <20211029171409.611600-1-brent.lu@intel.com>
Subject: Re: [PATCH v5 0/6] Multiple headphone codec driver support
Message-Id: <163554090182.1997146.17202242422434789612.b4-ty@kernel.org>
Date:   Fri, 29 Oct 2021 21:55:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2021 01:14:03 +0800, Brent Lu wrote:
> Support multiple headphone drivers in same machine driver. In this
> case, both rt5682 and rt5682s are supported and enumerated by different
> ACPI HID "10EC5682" and "RTL5682".
> 
> V2 Changes:
> - remove useless 'NULL', 'false' in if-condition
> - can use 'comp_ids' field alone to enumerate driver
> - add comma to the end of entry in structure initialization
> - keep the table of byt/cht/cml/icl untouched
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: soc-acpi: add comp_ids field for machine driver matching
      commit: cafa39b650ec3ba8e9efa0825f1c08e029b5a1ed
[2/6] ASoC: Intel: sof_rt5682: detect codec variant in probe function
      commit: 8fe6ec03183ac04fa6529fdf0d4da1328946a9d0
[3/6] ASoC: Intel: sof_rt5682: use comp_ids to enumerate rt5682s
      commit: d4f3fdc2b7e16e8203c5d55bb91d6572647d4b0f
[4/6] ASoC: Intel: soc-acpi-byt: shrink tables using compatible IDs
      commit: dac7cbd55dca4fd9e646e37401079ebfae3935e0
[5/6] ASoC: Intel: soc-acpi-cht: shrink tables using compatible IDs
      commit: 959ae8215a9e8955f45b41e274a1294d7c9aba1b
[6/6] ASoC: Intel: soc-acpi: use const for all uses of snd_soc_acpi_codecs
      commit: 9a5d96add514079660b3f1270a55f8c2dbdbc1b6

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
