Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C7A3061B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhA0RQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:16:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234430AbhA0RPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:15:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 074EA64DA4;
        Wed, 27 Jan 2021 17:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611767676;
        bh=1m++LiMxr6/GeKxBb1e6vmPpJo9MAanwj2boIbNLQAQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AtlSoqmt+c8VQOzssp+UyYTJJve8656Jk5lDqWkZTUh20iVnJ3OFsnOFFucmzXAxO
         iDo9GOI5c5C/HOEZvbn19lUarHWRUjfiYG8TGLNJA7cWaHaHdPxsjcmQSrevoPt2Je
         Wi13p+hPWFroldv7IJ5QoAbEh19UrgvwuEZeXw7+8R7yelYPRbyzYNJidd5nj5dOHw
         Y2orMCptR7Gx+pfGkqifzzr9OCJmuDFP20ojB+d/zYK8oVbmTcTmW/agzK8qstR9cq
         dn9MZr0KZYVKvJemG+1c3KIR0tCLccsNWPq6cfnrDBGYLCSwZOa589tI+VRh5hM7ux
         QaPGtc9w7pWXw==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        vkoul@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210126171749.1863-1-srinivas.kandagatla@linaro.org>
References: <20210126171749.1863-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 1/2] ASoC: soc-component: add snd_soc_component_read/write_field()
Message-Id: <161176762855.34530.6617138298808888904.b4-ty@kernel.org>
Date:   Wed, 27 Jan 2021 17:13:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 17:17:48 +0000, Srinivas Kandagatla wrote:
> It's often the case that we would write or read a particular field
> in register. With the current soc_component apis, reading a particular
> field in register would involve first read the register and then
> perform shift operations.
> 
> Ex:
> to read from a field mask of 0xf0
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: soc-component: add snd_soc_component_read/write_field()
      commit: 1da0b9899abdbc7103d3ec6b1a888efda41dbb59
[2/2] ASoC: codecs: lpass-wsa-macro: make use of snd_soc_component_read_field()
      commit: 7db4c4cd767e5c2418e7892c6b2f06982d34369a

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
