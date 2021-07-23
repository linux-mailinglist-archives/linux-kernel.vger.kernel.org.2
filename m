Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BBB3D3E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 19:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhGWQV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:21:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230098AbhGWQVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:21:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 506DD60EAF;
        Fri, 23 Jul 2021 17:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627059719;
        bh=s/BHG12tgApqgvctm7zwp9zN19QNZZdnL+jeha8tQ4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KmGPOxeXPGzlvOFhqckW50tj9xuuxJoTMPjuVpT0WPDtcIPJMU1yLOD0OEnuGgQV8
         B6iMQ1iOUbwyBTts5+eeyl6XZnlWD4yC+iOppPMdDP4wZGgfDEq4eSMflU3+M/tzAk
         t0H6vOOlO5/nOiTDCs2a80trWjLoHU1VfRVPmGE9/U0E+YhpI9bWFTvi+nFhasjueE
         vvXHArxD8B19lN4jARW1vvz/KfibjrIRju72TeVRu6cAnqtHZeLjWMTHWVKDHDMvZc
         Co5CeujziRhR0bfjIe468Fpv6nM3anFePsck5ROUL+asE+l4N5q8S57viiwwxezu8l
         jl/0kH76zSc6A==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        markpearson@lenovo.com
Subject: Re: [PATCH v3 1/2] ASoC: amd: Don't show messages about deferred probing by default
Date:   Fri, 23 Jul 2021 18:01:51 +0100
Message-Id: <162705877778.18788.10167377888396986791.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210722132731.13264-1-mario.limonciello@amd.com>
References: <20210722132731.13264-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2021 08:27:27 -0500, Mario Limonciello wrote:
> Nearly every boot with a Lenovo P14s is showing
> acp_pdm_mach acp_pdm_mach.0: snd_soc_register_card(acp) failed: -517
> 
> This isn't useful to a user, especially as probing will run again.
> Use the dev_err_probe helper to hide the deferrerd probing messages.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: Don't show messages about deferred probing by default
      commit: af7dc6f194a866cb3e991ef5248ffdeb3ef5c46a
[2/2] ASoC: amd: Use dev_probe_err helper
      commit: 718693352d8bcea65276615f4f8c8d531246b644

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
