Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3080E419D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbhI0RtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:49:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236664AbhI0Rs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:48:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62DE860F92;
        Mon, 27 Sep 2021 17:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632764838;
        bh=2YGyL+hXBkGHE1pwjNYrXFcwqsXr+FHDD0uurCfgPHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLDqq0vSUhxyIzWIeYveRYQFxU/sG2mYtbx1oQmFjwe16srp3N34OKNOeDbW7oSFp
         RX6u9hV4V7ChymScJNE7LfSWA+gH5B22J3U1nvhlbV4+G6pQAxbx5qqV4GOVDO78/4
         itJmcnPVyp6EfLxhYRvb/kf62rHgAUJRdc7vDxAFV+eeXvUwDEPI+iDG5e5DowEvRZ
         Ah196uWO3TJ1woklg7crYKdie35jRIG4JQuoCYyS8vj5o7XZvld/R48fcAatNHZiSg
         rJafketEnONqD9SlbrSpMgebFX4HXdwdKnjg9LgBxUNE7Hwow6tz02hp+6MyIguUCV
         QvAu7OUwTrvOw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        James Schulman <james.schulman@cirrus.com>,
        Takashi Iwai <tiwai@suse.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l42: Use two thresholds and increased wait time for manual type detection
Date:   Mon, 27 Sep 2021 18:45:29 +0100
Message-Id: <163276442024.18200.9987078305118050259.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210927111437.18113-1-vitalyr@opensource.cirrus.com>
References: <20210927111437.18113-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2021 12:14:37 +0100, Vitaly Rodionov wrote:
> From: Stefan Binding <sbinding@opensource.cirrus.com>
> 
> Some headsets require very different comparator thresholds for type detection,
> as well as longer settling times. In order to detect a larger number of headsets,
> use 2 thresholds to give maximum coverage (1.25V and 1.75V), as well as a longer
> settling time of 100ms. This will not affect default audotodetect mode
> and applies to manual mode type detection only.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Use two thresholds and increased wait time for manual type detection
      commit: edd6dffdc6670836909972b32a324dbf6c150757

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
