Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D604001E5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 17:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349635AbhICPUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 11:20:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349579AbhICPUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:20:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64FD8610E6;
        Fri,  3 Sep 2021 15:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630682363;
        bh=oYmN5T7sshaoWGSEc1MfWpgCjISXeg/z9xk1wh6OKJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UGlylsOLgVVOjPq+FLhiRA9ULl1yVvH89glH0h7EL/ekI34mqjOimsUgJ0We5A3rY
         W8npyG3wt0agsSjxDzmCfz/nAG+myRyVTa5pPslo3rIdePH9VXUUC8wp2ZW6gsDVSq
         Ym89RMSRrNkM6jKWi8D7b0RPaL050zDIRO7EL3fycbBuJITX7O6FRXM+qCu1ZmnaGA
         MadMpzYWWovy3HHMsr42VW5biCBKEAMsqdHqSV6R+n7qvfH73Fd7SW4KiNlM64gt4h
         NX1AhU1widThJS+yDh0c+IwnUDNE7KGmVz+E+KGa+gIimAUOK7PBGRd9C4FWUvLoNE
         zM8BDsurg013g==
From:   Mark Brown <broonie@kernel.org>
To:     matthias.bgg@gmail.com, Trevor Wu <trevor.wu@mediatek.com>,
        tiwai@suse.com
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] ASoC: mt8195: correct the dts parsing logic about DPTX and HDMITX
Date:   Fri,  3 Sep 2021 16:18:45 +0100
Message-Id: <163068203907.50844.7644629918689811156.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210903060049.20764-1-trevor.wu@mediatek.com>
References: <20210903060049.20764-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2021 14:00:49 +0800, Trevor Wu wrote:
> According to the description in dt-bindings, phandle assignment of
> HDMI TX and DP TX are not required properties, but driver regards them
> as required properties.
> In real use case, it's expected that DP TX and HDMI TX are optional
> features, so correct the behavior in driver.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mt8195: correct the dts parsing logic about DPTX and HDMITX
      commit: 7eac1e24fbf6c56c9e3be302748ae73104bb40bd

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
