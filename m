Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37464340D24
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 19:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhCRSgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 14:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232320AbhCRSgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:36:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C6A664F1B;
        Thu, 18 Mar 2021 18:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616092571;
        bh=32MVLQm5NpcZUcsApMkyjQjmNOtHJjts4RMDAFFvCzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNXtAxGmRKnJVgNHIolBdNvPsmQPjzPJQU+/Qz3yuc5vhALZ7DdilOG80VV1cZu7W
         HGrxD/cZ0lqIAjjZB+Wt7BwptR2JLkrqbygoq/vc/gqugvLUJ4BeBo1L1uHErsaAqo
         1wkjXRMWaqd4DzEVZ0SY52/RsU8RMAmvgu9TWVa2yh+FXds7LVvwPOnmUkXLuej3WC
         A4/5GS6EoGijDo8RuL5a72zHyuGSAgn/vMXPjB/57TwcNmXtwRXhVBWJNy6xKJUyYB
         k7TeDxEn1sA/shqo3x18vb6Fovf1puarEmrCXzrK8KHJLIMf/4fxKHtqRzEKQEhbC0
         mKa3RZ8zuABBg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Brent Lu <brent.lu@intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Libin Yang <libin.yang@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dharageswari R <dharageswari.r@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org, Fred Oh <fred.oh@linux.intel.com>
Subject: Re: [PATCH v3] ASoC: Intel: sof_rt5682: Add ALC1015Q-VB speaker amp support
Date:   Thu, 18 Mar 2021 18:36:01 +0000
Message-Id: <161609213719.41838.1344950391495541076.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210317110824.20814-1-brent.lu@intel.com>
References: <20210317110824.20814-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 19:08:24 +0800, Brent Lu wrote:
> This patch adds jsl_rt5682_rt1015p which supports the RT5682 headset
> codec and ALC1015Q-VB speaker amplifier combination on JasperLake
> platform.
> 
> This driver also supports ALC1015Q-CG if running in auto-mode.
> Following table shows the audio interface support of the two
> amplifiers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_rt5682: Add ALC1015Q-VB speaker amp support
      commit: ad83b1adc58d6693036fd330d6af95a33564eaae

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
