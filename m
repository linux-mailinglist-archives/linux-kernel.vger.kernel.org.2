Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC8F311155
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhBERzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:55:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233284AbhBEP3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:29:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F98064EE4;
        Fri,  5 Feb 2021 16:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612543496;
        bh=o3h3fYmeEdvgWp7HmTFWFie1v+V6mM1T5BeFAVLkmok=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=egd2wtrWuGXbz4EhfdPFspKlVwK7DP3eOxmu3CYdZmZ1ZtaiHNBqi9QbOGkee+9ys
         U4NBZ1p22vxevM15NuzNIwHsdHju0eCqeq5JzCLGcyJvrbur15lgHoHFqHDM2fayJp
         cvqE3cybiM9fXkCFRs3KojclCOXUBfJ6YlI6mG/YXZkJ0Kgg/B7W0iAQOTAPfY5FVC
         hCAAkQ61SOSrM1RABOTTc3dPtFXugKs9Bi4KNBg+CsLU101ncgs3b7iNXyVnP0bMVl
         Ng451/kdG6pRWehZ3G85IN55qu6CrV1hdZL/iSsWDMPOcpI5FPhK1AED+NQwtzBnM3
         PbAI0xjITLv0Q==
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org, cychiang@chromium.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        tzungbi@google.com, tiwai@suse.com, alsa-devel@alsa-project.org,
        kuninori.morimoto.gx@renesas.com
In-Reply-To: <1612513012-27688-1-git-send-email-jiaxin.yu@mediatek.com>
References: <1612513012-27688-1-git-send-email-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8183-mt6358: set playback and capture constraints
Message-Id: <161254344059.9495.1560731100918324010.b4-ty@kernel.org>
Date:   Fri, 05 Feb 2021 16:44:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Feb 2021 16:16:52 +0800, Jiaxin Yu wrote:
> Sets playback and capture constraints to S16_LE, stereo, 48kHz.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8183-mt6358: set playback and capture constraints
      commit: 19657a609b68f37afede259a762765b77914557f

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
