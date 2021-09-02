Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D253FF07D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 17:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345911AbhIBPwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 11:52:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231942AbhIBPv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:51:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6C6D603E9;
        Thu,  2 Sep 2021 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630597861;
        bh=n+fcc/Ub9f6mKkgV3xaS1g7ny+8ESxl5WnwJsctvzG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uX6Tyh5B7FV+nIUoIKjPXxp97L37MM+R+QE3KSsOWCf+d6Poz17k91CJ4s1akYrr+
         AX8m4b4SwPERs1b+1zvGxtHEWx4QU1g7nh80JyhE/Y1AKFE3TY9K4UIBwnJD6E1a0f
         ppy76lt9kUw/8GcccfhymlrdgqLKlCyRrC/Ahp/oy7vCnib2eaQ4cSo6AM91UG9kww
         YjMABzgIvPI+cGALPlMbfO4XUF1IaBr2bgGYxYxn/eWwQd5SBk7KDsXa+t0mNO4kZn
         iKuBQv6Az5yMfsYvFfYiE01OZT/+QqJziOQceBjzD7n7pAeV/cDlv27GVbbMg9gv/a
         1t04SjAV9K93A==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, lgirdwood@gmail.com
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: fsl_rpmsg: Add compatible string for i.MX8ULP
Date:   Thu,  2 Sep 2021 16:50:29 +0100
Message-Id: <163059750027.34506.2833380124820785822.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1630553525-25655-1-git-send-email-shengjiu.wang@nxp.com>
References: <1630553525-25655-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2021 11:32:05 +0800, Shengjiu Wang wrote:
> Add compatible string for i.MX8ULP platform which support audio
> function through rpmsg audio channel on M core.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: fsl_rpmsg: Add compatible string for i.MX8ULP
      commit: 4f89ff026ddbaab49dba993ad2dc757920d0ad49

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
