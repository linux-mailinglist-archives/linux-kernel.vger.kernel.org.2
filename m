Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BC740DDB4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 17:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbhIPPQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 11:16:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238551AbhIPPQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:16:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7D2F6124B;
        Thu, 16 Sep 2021 15:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631805323;
        bh=mIZBLtgTVepC4euvVy0u2XkqTe2j3KMWlM2rpeK+new=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DroIQkDwsFILs63vTg/OR5CTakw1WQO2KktSTfrOPv8FOchaqtplhyyEyxyxo6r8T
         72NKQqbidW3OP4wZIrph0SpEihc2/pvDLzAT1ojo5safgJl+aQSQ1duS89Y7GksasO
         ea6iaDwmbT4arBDOhDxcelqyPev+w7OEhTVsBQLX/RXCt+DX/4mW/lz1busF0QqiJo
         IEfZmh8keeuFJGD/b49ALJcTS+jRNVibZzLrFzujE8wu4mhmoLqBKtetCVnOJuhg1X
         HtQhXi2kUSJWs5i5sBrJvqcewkVZFOZHQ9cwgaVZTI2sAn7ETbpExgMN9fDpxkdAWU
         rasCjRR5sHaIQ==
From:   Mark Brown <broonie@kernel.org>
To:     James Schulman <james.schulman@cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: cs42l42: Minor fix all errors reported by checkpatch.pl script
Date:   Thu, 16 Sep 2021 16:14:30 +0100
Message-Id: <163180495858.19842.11561225019667500130.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916110932.10293-1-vitalyr@opensource.cirrus.com>
References: <20210916110932.10293-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 12:09:32 +0100, Vitaly Rodionov wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Minor fix all errors reported by checkpatch.pl script
      commit: 7a20dec45d0701671abca965b0dd3e4cda2af3d3

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
