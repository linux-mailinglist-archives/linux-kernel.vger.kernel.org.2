Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB46430E4A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 22:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhBCVIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:08:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230220AbhBCVIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:08:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A107764F43;
        Wed,  3 Feb 2021 21:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612386481;
        bh=X++DCBsFSqm6GeJb1wRNId0elKmC5l4WSOzoH81rAEM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QaQAXbGfBGb9PwLBEzZlSrCPhUdHjbS2TMJH8Al8LdQbQ7PFBZNIURyoumzdyzlm6
         pUQzdcNQLP6QA1xSG6xQULbo70o0DUC79qzDY+YIkz08JZV5u7zFjRHxVamzS+r0ri
         hrtObF9Nr2HSwP15JXnUgcJdgM0raFLeVuXCnMNsU/2SQS5PayRx+9JQNLGNGWNi6d
         T4qpVObWgNMM1c5jl5tCa578bfGQGM9bOlDJEgWLz6ngWoW9ivMnblA0yD8HCRbFTh
         s/OcTtCax+bzRSikwcco7k+MqYGhvJSPCux3Jx/yxBXDIB+VmvqPXXLU4yYX8qK94J
         EtR3C83/LHB2A==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>, perex@perex.cz
Cc:     tiwai@suse.com, yang.jie@linux.intel.com,
        liam.r.girdwood@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, cezary.rojewski@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <1612166481-121376-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1612166481-121376-1-git-send-email-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH] ASoC: Intel: catpt: remove unneeded semicolon
Message-Id: <161238642667.34424.5355030176481154960.b4-ty@kernel.org>
Date:   Wed, 03 Feb 2021 21:07:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021 16:01:21 +0800, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./sound/soc/intel/catpt/pcm.c:355:2-3: Unneeded semicolon

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: catpt: remove unneeded semicolon
      commit: e01a03db74a88084fb91a4ff18bb8d47a1e12f62

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
