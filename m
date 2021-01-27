Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942F73061B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbhA0RRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:17:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234603AbhA0RP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:15:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8018864DA0;
        Wed, 27 Jan 2021 17:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611767687;
        bh=lQkobph4usbUMMigcmlpp7KsK1FvowDUodLLlOaWFrs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=k41fwHk99+lNz176E44xBeipUPX0pvdK/StQvWNv4QLo9BOHPmqkpaoNMRBgLflX4
         CNmRslfAy3/YJrfpLfipC4iKaDnK0kdCmnDLOh9bXyhcmx0aVksylbGkJW6G7jL/Eu
         XDT13wWf541eduEAiE9AgD/3q2uGdf9eSGCSbpZ7VpBDsbNm6QSHvq4EOisVAWLV+a
         m+tovQ+IUd6HFzA9c/sRbf9TqGpSUgNGA7xJ+/MSalpK3bDWNE1w1NxiPhEE8uDHZC
         O2EPyUHKO6H21VnGA0gzcrLh6BAZIkN1jy26DH29msUsMwGkMWV9swQJZ/x3ADYpMm
         jl8AUZ6r9Dn9w==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>
Cc:     dianders@chromium.org, Rob Herring <robh+dt@kernel.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Taniya Das <tdas@codeaurora.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        tzungbi@chromium.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Patrick Lai <plai@codeaurora.org>,
        Judy Hsiao <judyhsiao@google.com>, dgreid@chromium.org,
        linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, cychiang@google.com,
        Rohit kumar <rohitkr@codeaurora.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20210127135620.1143942-1-judyhsiao@chromium.org>
References: <20210127135620.1143942-1-judyhsiao@chromium.org>
Subject: Re: [PATCH v2] ASoC: max98373: Fixes a typo in max98373_feedback_get
Message-Id: <161176762855.34530.16920302960520466046.b4-ty@kernel.org>
Date:   Wed, 27 Jan 2021 17:13:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 21:56:20 +0800, Judy Hsiao wrote:
> The snd_soc_put_volsw in max98373_feedback_get is a typo, change it
> to snd_soc_get_volsw.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98373: Fixes a typo in max98373_feedback_get
      commit: ded055eea679139f11bd808795d9697b430d1c7d

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
