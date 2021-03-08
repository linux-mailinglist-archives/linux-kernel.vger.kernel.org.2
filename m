Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11B93312E5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhCHQIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:08:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229893AbhCHQH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:07:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F2D36521D;
        Mon,  8 Mar 2021 16:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615219678;
        bh=KpYN8PI6rGont5GCMsXRfQCE5sVoEvl9dlIQ+/e+4nI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oxyBs0armHmACQCSY6zvCid+PObSGxP5msB5rpVgTWSerdvtpBjgd9xKC8SROTJ22
         Lh6gnMy1khD3D27x4jG5GLGwhkTyXlo0aeWqtYOhce1jtQIukYJTGHhZnqJeZfohIh
         8vrKaVokZGxX5DBPqfGdVAg5Mfpug4qflalhC7pS2WDB5W+m48sl+5611mDD8L1q1A
         VoeSDD+gmoe7yKluxFAcjKQTXpnhH6zSozwGd9TbdCxgKglLFAuhpO4+TB7QhtlN3f
         Z/u/m352+l1KQ/xrODLui6eD0ysolDAivtDrMFP0Zjvw02QeKpc1XL4zDb2/l97Jze
         RlHkCnXAgFPBA==
From:   Mark Brown <broonie@kernel.org>
To:     David Rhodes <david.rhodes@cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        James Schulman <james.schulman@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        patches@opensource.cirrus.com
In-Reply-To: <20210305173442.195740-1-tanureal@opensource.cirrus.com>
References: <20210305173442.195740-1-tanureal@opensource.cirrus.com>
Subject: Re: (subset) [PATCH v2 00/15] Report jack and button detection + Capture Support
Message-Id: <161521960848.9621.15428448037752400716.b4-ty@kernel.org>
Date:   Mon, 08 Mar 2021 16:06:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2021 17:34:27 +0000, Lucas Tanure wrote:
> Here is a patch series for reporting to user space jack and button events and
> add the support for Capture. With some cleanups and fixes along the way.
> 
> Regards,
> 
> Lucas Tanure
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/15] ASoC: cs42l42: Fix Bitclock polarity inversion
        commit: 97e2b5e5dcd543cd4d85ecb1bfa2a9721a08f411
[02/15] ASoC: cs42l42: Fix channel width support
        commit: 3656667e66858fef45017c8e7c73e9918ed23915
[03/15] ASoC: cs42l42: Fix mixer volume control
        commit: a2ddc577ee4641889bf105d4d6e05be415bd4462
[04/15] ASoC: cs42l42: Don't enable/disable regulator at Bias Level
        commit: 9ad4f9ea976e05d4eba62ea58c7c7c45705b80a1
[05/15] ASoC: cs42l42: Always wait at least 3ms after reset
        commit: ddaa9bea4ffaba50f814585f294a5d98641b41ad

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
