Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61162451C65
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356192AbhKPARQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:17:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355092AbhKOXjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 18:39:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D914C63256;
        Mon, 15 Nov 2021 23:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637019298;
        bh=1OzdwxSFvxwVS6C/YLdAtuX4T43pG75TF2Jjh5ogIq0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TfQIsHWD+nxwDZ9mF0DKolJzWPO3OkxEILSAyAUun6rmVx2yRLp07vE/NrKuGpF36
         FkMlqg5Ww1PdjFbDkYkequ4PYf8F6e0tKUz/h/9FNYS3LdIhhbPb4zECluItFtkurC
         MvcyskrbyZ7RRPlcKPxQxhKAcB9TOhGA3UenNin2eWGuKvDNPetCz3KSrJuLfBy/pl
         GPbg2RCWWxU2QQEnqvlfSc27GpMNil1jAuzS00Xlt5KBaSVloTt6JP5z8vzQ1VvsiF
         IPJHaUUB+d4QkhuTNwHg3iThGllFX53EyQ6opvzMVs2V2H1hgovmNDuO2CCSimlPcI
         rc/IH8tHP3vZw==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com
In-Reply-To: <20211101101006.13092-1-rf@opensource.cirrus.com>
References: <20211101101006.13092-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASoC: cs42l42: Add control for audio slow-start switch
Message-Id: <163701929762.675370.12528564443192014904.b4-ty@kernel.org>
Date:   Mon, 15 Nov 2021 23:34:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2021 10:10:06 +0000, Richard Fitzgerald wrote:
> This adds an ALSA control so that the slow-start audio ramp feature
> can be disabled. This is useful for high-definition audio applications.
> 
> The register field is unusual in that it is a 3-bit field with only
> two valid values, 000=off and 111=on.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Add control for audio slow-start switch
      commit: 7ec4a058c16f3da9c2c0c66506f45c083198ed30

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
