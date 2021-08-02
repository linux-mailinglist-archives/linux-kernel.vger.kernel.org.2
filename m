Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170FB3DE0EC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 22:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbhHBUoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 16:44:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231659AbhHBUom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 16:44:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D92FF60F93;
        Mon,  2 Aug 2021 20:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627937072;
        bh=Jtdbyw1KtfZCbl5QABW1yDpMjvPPKCrXpdVs6/siGp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i6GO5xdG7FdvsjacXaTTLv1vh9cr04K3iTE1lLTT7ZFDwsSelwsSg6Uc3NBF0f8xx
         /MCTbqOJYsdvl9ke6NfAZ/zAKkWl2Yz8IBdTCjRWxXS8vldsYUnvj5s/zEIqROko9Y
         cElwZxLdQRr9tB6MBPeP4KdKX5+faQQf8Va+kp0lPz27yr+6HfEAORg5gvlJhPP7WF
         Pm1HnXUMSgpu71XsVXkyb++TI8JImTXHfISIhkkzC1H69Iz9KAiMK9Jpel6HXEGPwI
         hPgq2nnh41hYE1RyEZj9wsBnSIC4u+6th+DFVeptsZo/lvjetEn6Ji3CC9qIGx9Kkh
         bW5BoGwAyddcQ==
From:   Mark Brown <broonie@kernel.org>
To:     vkoul@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org,
        sanyog.r.kale@intel.com, tiwai@suse.de, bard.liao@intel.com,
        vinod.koul@linaro.org, pierre-louis.bossart@linux.intel.com
Subject: Re: [PATCH v2 0/6] soundwire/ASoC: abstract platform-dependent bases
Date:   Mon,  2 Aug 2021 21:44:13 +0100
Message-Id: <162793640708.55982.13298433414874844018.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
References: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2021 19:54:45 +0800, Bard Liao wrote:
> shim base and alh base are platform-dependent. This series suggests
> to use variables for those bases. It allows us to use different bases
> for new platforms.
> 
> v2:
>  - Update the commit message of "soundwire: move intel sdw register
>    definitions to sdw_intel.h"
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] soundwire: move intel sdw register definitions to sdw_intel.h
      commit: f01639589e252a6f72c04716e1b5f9bb10e2debc
[2/6] ASoC: SOF: intel: add sdw_shim/alh_base to sof_intel_dsp_desc
      commit: 1cbf6443f0de6489044909b35962ba71940d48fe
[3/6] ASoC: SOF: intel: hda: remove HDA_DSP_REG_SNDW_WAKE_STS definition
      commit: 781dd3c822683f4b5dc332b68ac49d2db3d400e9
[4/6] ASoC: SOF: intel: move sof_intel_dsp_desc() forward
      commit: 2f1315ae94b46bf0d5b4be29be15cc3641364404
[5/6] ASoC: SOF: intel: add snd_sof_dsp_check_sdw_irq ops
      commit: 198fa4bcf6a1e8685b43e37790d45f3ebcbc2784
[6/6] soundwire: intel: introduce shim and alh base
      commit: 60e9feb781dfe84158b4ec7a4d61c5103e96e6f3

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
