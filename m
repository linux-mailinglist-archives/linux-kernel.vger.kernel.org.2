Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E42364913
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 19:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbhDSRe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 13:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239906AbhDSRe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 13:34:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 823DB61027;
        Mon, 19 Apr 2021 17:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618853667;
        bh=YCfcgeyod+s62omSZg8wbLwKTLkzYlS6VAq3eMipkLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNg2kVB5WIN+gLZi5vNQeft3fhkV0o8FE8k2udUtCjcHNhOYdzCyRcBhPrVfvBk1/
         SUPdh4HMcFrvNA/TU6Y0BKnDqeZ26G9mmqEhrfkSWe4LK2Kzr+OO1rG61VYZCHBnZ1
         4MJUwue5Auz5iNy3J3TTpNNuTmRhc2lOiR8vyDWbpH3RnnGVaWJR7BajWnHgsCRUBw
         JbBeR6AUYxO8+Qwc+EYkZImhxkWSsIHoYP8Gu/tVxdVxJuAPLvxlzrozgQcqRrHuFa
         W6m08g3tWTZYzQ+xr1iEeNx/OcBI7lKKAmow9dwErwB32RIkTqmKRVvgwdnxRG/ctZ
         AlckM549ysADA==
From:   Mark Brown <broonie@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Niklas Carlsson <Niklas.Carlsson@axis.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     Mark Brown <broonie@kernel.org>, kernel@axis.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Niklas Carlsson <niklasc@axis.com>
Subject: Re: [PATCH] ASoC: sigmadsp: Disable cache mechanism for readbacks
Date:   Mon, 19 Apr 2021 18:33:48 +0100
Message-Id: <161885301897.45150.10509642492570383427.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210419144901.9441-1-Niklas.Carlsson@axis.com>
References: <20210419144901.9441-1-Niklas.Carlsson@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 16:49:01 +0200, Niklas Carlsson wrote:
> The ALSA control readback functionality only works for non-volatile
> controls, i.e. control values that does not change on their own without
> driver interaction.
> 
> This doesn't work for readbacks since the DSP firmware updates the
> control value. Disable the cache mechanism in the driver if the control
> name matches the prefix used for readbacks to ensure that the control
> value is valid.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sigmadsp: Disable cache mechanism for readbacks
      commit: 11a9b987611f17e6a95e9bb34c1f5f9aa0b6ae25

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
