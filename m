Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F205E41362E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhIUP1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:27:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234064AbhIUP1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:27:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6D1961215;
        Tue, 21 Sep 2021 15:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632237969;
        bh=vhLzjTgLnOT8QnJf7y/WSgDwF6yaNzF8AzzcaXhlpgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MohmUdb3bmGffzzxtnXNhA6agKbH70gjj8JdakpsgSojS9mXK6M55oQLxrvxK/6AK
         oZvoD54oC8f6oMZN/yA19bqE65wOeCobAYp6MLU1BSH2QSenSpFThMI0co3hza5S8K
         /qQnn3yt7CWD5D7Hwfr3FcJN7iUfpd6v29REudwxaZOdkOB9hxgBuztUm8Pa8qrXYS
         XvuNU/NtivjHppwO6nV9FB23KXQUCdZ1nyVZxfEUsYWUBPuUFQT7oPy+oCW90EvdqG
         4ld1bbfG76aZm4u5FdXXTAC8WMz3KXsMSl3yHh6puxgJr3OHQeMC+VCy3mK7VsKbKb
         j2cQ8whYH6Ynw==
From:   Mark Brown <broonie@kernel.org>
To:     festevam@gmail.com, Xiubo.Lee@gmail.com, tiwai@suse.com,
        perex@perex.cz, alsa-devel@alsa-project.org, timur@kernel.org,
        nicoleotsuka@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_spdif: Add support for i.MX8ULP
Date:   Tue, 21 Sep 2021 16:25:12 +0100
Message-Id: <163223651318.32236.12273348857072894060.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1631238562-27081-1-git-send-email-shengjiu.wang@nxp.com>
References: <1631238562-27081-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2021 09:49:22 +0800, Shengjiu Wang wrote:
> On i.MX8ULP the spdif works with EDMA, so add compatible
> string and soc specific data for i.MX8ULP.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: Add support for i.MX8ULP
      commit: a635d66be1642e59af17383a27b2c61409121241

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
