Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51B13FE23C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344974AbhIASQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:16:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345027AbhIASQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:16:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55BA3610E8;
        Wed,  1 Sep 2021 18:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630520127;
        bh=3L67LVXG3RetBW0+Au0YysC6Ac0wjuq3UwkXEFY4DSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fWvVE/FUPAGe9f6U4fr7EPTzUZofW55UT/vXCXcjLEI4QnfG36ZeAvbdLkZ8Sok2X
         Es31UEQ5WSqSJ6b7L8pzJom9FQy+tQsyWS1JjzNmpeIVVACSSQLNVmUbB26KhuDn3X
         5E76ujvdIIOqDs02/bCMVHFQGLRVLyHrQBSBoJMvWljKgtHumyrZS9slYyMg5XbO/5
         c19F7O4bA+TnCaycPGRx+M2KBjeTWWw0y2eQaqNfhVBn2GM/MEoTBB6MoXc1vemB+E
         Y4uSLSi89oXErPlWzX1SxaD9ecyZrP+6HV7hmRzY0Q71sVL9S76T+ioHcNChGYXRnV
         64vxdd5bR1MBw==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Colin King <colin.king@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: samsung: s3c24xx_simtec: fix spelling mistake "devicec" -> "device"
Date:   Wed,  1 Sep 2021 19:14:44 +0100
Message-Id: <163051912510.21630.1337130075674390913.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210827185003.507006-1-colin.king@canonical.com>
References: <20210827185003.507006-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2021 19:50:03 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err error message. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: samsung: s3c24xx_simtec: fix spelling mistake "devicec" -> "device"
      commit: 2a6a0a03117ee349308ab77ac0925fdca8ef32f5

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
