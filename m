Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489F5429515
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 19:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhJKRED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 13:04:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233445AbhJKRD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:03:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95BDA60F6E;
        Mon, 11 Oct 2021 17:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633971719;
        bh=sA9IPFPv1s4drjA088OPVEJGCy9qliVmy40+zSZtmG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SYyYWH9mT/iTcdd9Z0mFqZXKMTVYnCoSOPHBr/QCsUzmbNnV28TlSnR/5VR+P/FaB
         bWfaHzBfBsr6IOO9IkCYXkCqiT3amj5kcOjOa4YsVWPFJKJNwGCWtCAv1STSuvd8QC
         RGaewUOX+MyOhkQGV1f0t+lAZNbyrsyjFATIQpOOMdiq10nRqpnEcc6/5KADLVCrpG
         7JkETWoPbRO1rb4DvFKAcSk5X09neTSbONIPiMxFBQqejgNRHPlngzQqKbLOrlc/VZ
         bgASmtGH86JPDlLWi2ExGEoPIbqQ1Py2oFWKliNT20BNgVXSjV885PKI8Z/uKCJx8O
         eOmskq8GQilyw==
From:   Mark Brown <broonie@kernel.org>
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <vijendar.mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Basavaraj.Hiregoudar@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Alexander.Deucher@amd.com, Vijendar.Mukunda@amd.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sunil-kumar.Dommati@amd.com
Subject: Re: [PATCH] ASoC: amd: Kconfig: Select fch clock support with machine driver
Date:   Mon, 11 Oct 2021 18:01:42 +0100
Message-Id: <163397094549.6567.3180566951499093730.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011055354.67719-1-AjitKumar.Pandey@amd.com>
References: <20211011055354.67719-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 11:23:53 +0530, Ajit Kumar Pandey wrote:
> We are using fch clock controller as parent mclk source for rt5682
> codec. Add config to enable clock framework support for 48MHz fixed
> clock when machine driver config is selected.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: Kconfig: Select fch clock support with machine driver
      commit: 281ddf62f551321982c7d6f525a83a3b3c1d5eae

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
