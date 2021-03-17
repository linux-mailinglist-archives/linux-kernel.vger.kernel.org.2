Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DC533F155
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 14:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhCQNmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 09:42:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230434AbhCQNlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 09:41:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08AC364F50;
        Wed, 17 Mar 2021 13:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615988508;
        bh=XgvDN9+ZI5AiUc+xPeXnYranTBmsXCf/a6s6tclb1O4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ry/J/KELDZqxjjGdXfoG66TK374xNVt0uqjTCVcsRBI+G/RGWlxaMMmDiAcM/YlgP
         4DSYTP0oWfVNcAFChbYikuLsRfJ6naMVaxDm6naCaHuBIg1Zei+62uvq0cvOZ9pGdL
         PoypXouEOUX7vQ0zZCulTmi5C4jqsTnoJS++kXGzWBpKE0PmVMJWOKaQOk53hF5OGS
         qucohmKbvnj2q6+y2QwQmFWmZ5dF3DRUFGsiqCoqYU5M501yw5J+8qVvi8xN4swkB8
         MV4i0DaAEHnBa3SmuuumI+gv9vxRdvNSAFgtV9UfGerKdalb4BcFxUddirI+hhXAVk
         jdnL16wVulrDw==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, tiwai@suse.com,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        peter.ujfalusi@gmail.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, perex@perex.cz
Cc:     Mark Brown <broonie@kernel.org>, rdunlap@infradead.org
Subject: Re: [PATCH] sound: soc: ti: Fix a typo in the file ams-delta.c
Date:   Wed, 17 Mar 2021 13:41:38 +0000
Message-Id: <161598838274.8460.1631004595185849740.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210317082042.3670745-1-unixbhaskar@gmail.com>
References: <20210317082042.3670745-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 13:50:42 +0530, Bhaskar Chowdhury wrote:
> s/functonality/functionality/

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound: soc: ti: Fix a typo in the file ams-delta.c
      commit: c00f4f2598d334470b49385f811ca8f5c966a63e

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
