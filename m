Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A4D40C839
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 17:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbhIOPYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 11:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238167AbhIOPYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:24:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7AEB611C6;
        Wed, 15 Sep 2021 15:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631719372;
        bh=3ShNs2T5I39S0p3SxP9AwLoQW+1rLFcWivepK75NQNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M9yfEL2teC8hA2DvNGeXr0f44vJ6ulN8XJG2guVPYRySTcFcIay2d7EoNdJFkw4rB
         u2pCoC35xPmluMRHVq5TcsuG8EpzFw9fFPilHdZTGJww3KUFB2lszjdbvybjDTkkUx
         Lmigquln0yCxd9SxlXVnxdK7BV+n6ODJdnJFjbwijCubo+fn8rPru7JGFO2bkgtYxp
         0r06D9pVAyfRkes/HK17tNINrHsT/IIyUgdU31l3m73NgCKKoHJayMUx4zFJsjSFJh
         GIVE4KPf9pH5Tlwmit9GielbaO9FPHSAb89Q48YsGAEZcW5kRDaKp8kASeZNOH+q9t
         aAlOe9gBoUAOA==
From:   Mark Brown <broonie@kernel.org>
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rander Wang <rander.wang@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH 0/4] Support ALC5682I-VS codec
Date:   Wed, 15 Sep 2021 16:21:49 +0100
Message-Id: <163171901943.9674.3853249840000451457.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210914101847.778688-1-brent.lu@intel.com>
References: <20210914101847.778688-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 18:18:43 +0800, Brent Lu wrote:
> Support the ALC5682I-VS codec in Intel's rt5682 machine driver with
> three board configurations.
> 
> Brent Lu (4):
>   ASoC: Intel: sof_rt5682: support ALC5682I-VS codec
>   ASoC: intel: sof_rt5682: support jsl_rt5682s_rt1015p board
>   ASoC: intel: sof_rt5682: support jsl_rt5682s_rt1015 board
>   ASoC: intel: sof_rt5682: support jsl_rt5682s_mx98360a board
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: Intel: sof_rt5682: support ALC5682I-VS codec
      commit: 9a50d6090a8bbaef1c7a9252c904d85182a6a902
[2/4] ASoC: intel: sof_rt5682: support jsl_rt5682s_rt1015p board
      commit: 46414bc325df42ed0b18a50e2ee707e0424163a8
[3/4] ASoC: intel: sof_rt5682: support jsl_rt5682s_rt1015 board
      commit: 04afb621f9236dcfd7eb322d8554d7af8ce92dde
[4/4] ASoC: intel: sof_rt5682: support jsl_rt5682s_mx98360a board
      commit: e224ef76fa8aa2410731f0df13c93dffa443a970

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
