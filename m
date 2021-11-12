Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEC744EE91
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 22:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbhKLVaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 16:30:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:32974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231877AbhKLVaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 16:30:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A06A60F51;
        Fri, 12 Nov 2021 21:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636752436;
        bh=AgghWFlwj08jaTwHsQSldw9SQNW5vIHNTtQtXlYwbGE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=n2UXpwF46ZHr8RG9z+KSfNX3P7bqADR4UCcejG6a16Dlvxa7hZ2j3W9tqnsOukEM8
         ovvD1b01DPBDORbfKPIZbGfAy0VpCMQqtODj95CuvcOOSZtrWeGW2jVz7gjKcXJZSJ
         qgKEL0dZSJ59EE58ZvXq4swBtokITPUevjJtFjIHunj0EdzbqzbNqI/E2yr0JBHYpr
         baQgKGJRvdy8XO5fReaB4rcgW4c2fyONBxZfslARfEh6508OU43MFPPynVvLc1+OLy
         4DPwWqrrUyw2Mag2swc58KGkP3/bLwOGnjQAjuu1CzfucXV/bCrzqSVCbODUVR0jc2
         EDkT3zOtW2eRw==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, perex@perex.cz, cy_huang <u0084500@gmail.com>
Cc:     linux-kernel@vger.kernel.org, allen_lin@richtek.com,
        cy_huang@richtek.com, alsa-devel@alsa-project.org,
        oder_chiou@realtek.com, lgirdwood@gmail.com
In-Reply-To: <1636515921-31694-1-git-send-email-u0084500@gmail.com>
References: <1636515921-31694-1-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH v2 0/3] ASoC: rt9120: Fix settings and make compatible with rt9120s
Message-Id: <163675243417.742274.8712537973718036345.b4-ty@kernel.org>
Date:   Fri, 12 Nov 2021 21:27:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021 11:45:18 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> This patch series add the below changes
> - Fix the wrong ocp level setting.
> - Fix clock auto sync issue.
> - Make the driver compatible with rt9120s
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/3] ASoC: rt9120: Update internal ocp level to the correct value
      commit: 9bb4e4bae5a19ca68527392e85ad5ee88fc4b786
[2/3] ASoC: rt9120: Fix clock auto sync issue when fs is the multiple of 48
      commit: 8f1f1846d78a318c7cdb8268b47a964a3dbc0075
[3/3] ASoC: rt9120: Add the compatibility with rt9120s
      commit: dbe638f71eaed5c7b5fbbf03fb044e429c4a2d48

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
