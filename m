Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8453F39AA4B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhFCSok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:44:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230228AbhFCSoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:44:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3CC0613EE;
        Thu,  3 Jun 2021 18:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622745773;
        bh=14roOXPcs5DCgt6AKrjuC09a0UVpqCCBpqmcJOOjjOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t8wUNjTcGcWkZ5DfqA0kY0P2Izzr820EMwg6e3LAOS6MPs/RLZX6KNbxgAPK5ZMU9
         /NT8Ca669gPagahF46HoK+HiRs3swYgS1UkOhfdQP1BFDAc/K2T+HlsTQZ6pkYzumU
         UXYOh6qs9dj+Y7+qY2xUFPzjGIcIvIHuB+ejKkzdGzzy0Sp5cC5DQt0lyBzm0gvmtR
         Meo1sEhEO4cuKnv6wBFjyugWnYKHf66WegNc8oPaAwK0dK6gGu8IsIfkQj9y629ldR
         lp4gIU6HV+9zlmyCwUwYkWvhw+gtfa4Uod9w9PaBjnIIcPY4otK6xkO2yjgK9V+XWg
         uLyAW46gf6tNg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Richard Weinberger <richard@nod.at>
Cc:     Mark Brown <broonie@kernel.org>, grandmaster@al2klimov.de,
        robh@kernel.org, linux-kernel@vger.kernel.org, tiwai@suse.com,
        lgirdwood@gmail.com, dmurphy@ti.com
Subject: Re: [PATCH] ASoC: tas2562: Fix TDM_CFG0_SAMPRATE values
Date:   Thu,  3 Jun 2021 19:41:58 +0100
Message-Id: <162274557550.14795.17431456709023435037.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210530203446.19022-1-richard@nod.at>
References: <20210530203446.19022-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 May 2021 22:34:46 +0200, Richard Weinberger wrote:
> TAS2562_TDM_CFG0_SAMPRATE_MASK starts at bit 1, not 0.
> So all values need to be left shifted by 1.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2562: Fix TDM_CFG0_SAMPRATE values
      commit: 8bef925e37bdc9b6554b85eda16ced9a8e3c135f

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
