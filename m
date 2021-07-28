Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845CE3D9969
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 01:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbhG1X21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 19:28:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232710AbhG1X2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 19:28:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4001160FD7;
        Wed, 28 Jul 2021 23:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627514903;
        bh=+NI/Q1mxn7g59Uo+U5KM4ZKoYVyNYBLPtk1ASgNvUow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sM/HQQxJ9CWHoyXxLvHXxSkkq9COWnITBIWqG+7dcHfD0q8N0JeH1Iy5ZkRMSa35i
         2oWnQzGbQPiQ/yo8c1hePDRUrG0tgi527dxv+9ygKv7hQLaN4e6Bku/yqvcHcOe/Yj
         5dthiKRs6MBRN4SNv+za0//bCuW+BGF26GFHKUuDpX72rg7nIfYO3mRUAIWFe85mGr
         cJTMlk164/qNidvgQs5nHaZ8FjaHo6K+7Z/ojdg36ctbUSk3XToZH71LKCUWaLXXAJ
         kLhlQr032pvKJsPPhhTBIZsjGYVryr+OqH+z6SOzq6znsSR2qmeLy2ZnZ5QdGyqIOd
         EGIeV+28SjGJw==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        James Schulman <james.schulman@cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Adam Brickman <Adam.Brickman@cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: wm_adsp: Let soc_cleanup_component_debugfs remove debugfs
Date:   Thu, 29 Jul 2021 00:27:57 +0100
Message-Id: <162751391068.10122.6522975229334793917.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210728104416.636591-1-tanureal@opensource.cirrus.com>
References: <20210728104416.636591-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021 11:44:16 +0100, Lucas Tanure wrote:
> soc_cleanup_component_debugfs will debugfs_remove_recursive
> the component->debugfs_root, so adsp doesn't need to also
> remove the same entry.
> By doing that adsp also creates a race with core component,
> which causes a NULL pointer dereference

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm_adsp: Let soc_cleanup_component_debugfs remove debugfs
      commit: acbf58e530416e167c3b323111f4013d9f2b0a7d

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
