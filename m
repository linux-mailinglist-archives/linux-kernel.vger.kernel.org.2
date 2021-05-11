Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E5E37A1DC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhEKI2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:28:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230338AbhEKI2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:28:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0049613CF;
        Tue, 11 May 2021 08:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721646;
        bh=WPcOH1hz8LFi2fMAUx1mSnzJWiTl0dEjkzO5Nqmct2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UtNcltODfvT7w2yRGDCOauN3wcPhkqW6S5c6S+BIXkfF+0b8wTkho934NFdtCbdSr
         VXkPHW0fNRYTrshywUbENRUtSJZrekQaiQrDtv+P/WdF0KO/vjnY9n44qLXEax65H2
         hqo+9HiddSaRwze51yz7jpousDFkJQPDjzj7HpzIE1vo/0pUuFLdiQ5J0wJY8CD5S5
         33Y/fx6+RfAegayvTjdE9in0uNbnZnWeRf8o9Ur2BCYIb4Fgb2LfKAzPlbKYSxAGms
         DT4ondEC8RWnpFJFZe8vxp4uWrVk1fRMxrJWn/gqr1nSst2sBgrETgl8Wq1DYWB3z5
         JZi9iudcSyl9Q==
From:   Mark Brown <broonie@kernel.org>
To:     David Rhodes <david.rhodes@cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 1/3] ASoC: cs42l42: Add support for set_jack calls
Date:   Tue, 11 May 2021 09:25:44 +0100
Message-Id: <162072058166.33157.1893164114712321283.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210426155303.853236-1-tanureal@opensource.cirrus.com>
References: <20210426155303.853236-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2021 16:53:01 +0100, Lucas Tanure wrote:
> Replace the internal jack creation by set_jack call, so users can map
> buttons in their machine driver
> Also only enable jack detection IRQ after set_jack call

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: cs42l42: Add support for set_jack calls
      commit: c26a5289e86597e8826ad3093ad71ca0d5d9510a
[2/3] ASoC: cs42l42: Use device_property API instead of of_property
      commit: ab78322a0dc8e5e472ff66ac7e18c94acc17587f
[3/3] ASoC: cs42l42: Add support for ACPI table match entry
      commit: 66df9477bd35dd851e9803e5fdbbf40ee4598af5

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
