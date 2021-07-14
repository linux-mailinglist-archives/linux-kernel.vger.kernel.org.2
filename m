Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D7F3C8821
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbhGNP7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:59:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239877AbhGNP7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:59:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C76660FEB;
        Wed, 14 Jul 2021 15:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626278180;
        bh=SKCnb/eIuTrVyunpch/wIe19Xz1rsgxRCQg61kM4o5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J3G8yvhXUAmhRLOFvwIkrw+DX/J7EymymYfHm3RspRr24QPHVsZxHEh0TVTC+f31v
         NHHjT3N09kaS14Rr1vaejUP8nkjnty3JyItST0/u6F8hjlhbkwhqT8g40kba7312/L
         SXf6xUBJSNwJ3tRCComaFi9TKmzPYQdvzYpOkdJfwOQ04BH+i9+BXF+Oh3TfACo2X2
         a1yFuBPoA0FdqwNmisv0NAA+OiGc4ejVuQaoFtnE+mZqEPJmWtyjB/lyRZ17zQX9Uh
         r97+AMZ0CfbdGnkAYUuXlqkDZx/uk8sNPeGrOgr+GY+lxyeHl7G7ooNWb4o5g0vvPg
         ew/tqTSJT5YCA==
From:   Mark Brown <broonie@kernel.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v1] ASoC: rt5631: Fix regcache sync errors on resume
Date:   Wed, 14 Jul 2021 16:55:21 +0100
Message-Id: <162627737185.54838.4180550842494082478.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210712005011.28536-1-digetx@gmail.com>
References: <20210712005011.28536-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2021 03:50:11 +0300, Dmitry Osipenko wrote:
> The ALC5631 does not like multi-write accesses, avoid them. This fixes:
> 
> rt5631 4-001a: Unable to sync registers 0x3a-0x3c. -121
> 
> errors on resume from suspend (and all registers after the registers in
> the error not being synced).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5631: Fix regcache sync errors on resume
      commit: c71f78a662611fe2c67f3155da19b0eff0f29762

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
