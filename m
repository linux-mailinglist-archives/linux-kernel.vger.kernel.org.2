Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA8F40DDB5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 17:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239015AbhIPPQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 11:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239084AbhIPPQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:16:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5722861216;
        Thu, 16 Sep 2021 15:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631805325;
        bh=/AKMHzTSPVI/qO/ETd5TIGSPS0Fx+JquISeWLW/PHP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QoQUKAAQnGEPoA54WXjwVRuEdCxBnpTVrOEsmGt6u4qR0Vu33efC6J647/slHeE75
         3VRh6X7z2qDJpZ/jUsey/XPj1mesb2MwQNm6vXIRzHH6X/T+sfXVDu6fDKwkkA4ydz
         BWI2ac0+uYEAp6lbPQmX4sztj12H3LH01K8bOv6e/k+UT/bPGrmBgF0Vs7Mn2QzW2v
         w3nSzPlERfMqsMEtK4iQFKAWjbzMQgNRT3xND2Dc4k0/mlyxEwZDc52Wua1jTJcuYe
         b7ds1d/bs1z3SAs4xIi0Kt7JIECKhMeFgQhaGtNh27eNMrxA/l3qu0eW8cxcQZ33pi
         s0z3E/8/cLu2w==
From:   Mark Brown <broonie@kernel.org>
To:     James Schulman <james.schulman@cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/1] ASoC: cs42l42: Implement Manual Type detection as fallback
Date:   Thu, 16 Sep 2021 16:14:31 +0100
Message-Id: <163180495858.19842.9757319545626804609.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916102750.9212-1-vitalyr@opensource.cirrus.com>
References: <20210916102750.9212-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 11:27:49 +0100, Vitaly Rodionov wrote:
> For some headsets CS42L42 autodetect mode is not working correctly.
> They will be detected as unknown types or as headphones. According
> to the CS42L42 datasheet, if the headset autodetect failed,
> then the driver should switch to manual mode and perform a manual steps sequence.
> These steps were missing in the current driver code. This patch will add manual
> mode fallback steps in case autodetect failed. The default behavior is not affected,
> manual mode runs only when autodetect failed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Implement Manual Type detection as fallback
      commit: 12451814496a5433f41843ca4e3d9961d69304f7

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
