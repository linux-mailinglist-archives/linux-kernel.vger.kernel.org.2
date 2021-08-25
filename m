Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEBC3F7841
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 17:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241030AbhHYP2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 11:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240735AbhHYP2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 11:28:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07C24610FD;
        Wed, 25 Aug 2021 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629905252;
        bh=m7p6daCSPgaKes4En6UWW7yVDDqC2Pu4GbLK9AYNzPA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pwqs1G+F8QgIMdzNMMHzE0kJbxkJNt+b1ROTl740x1V4KaRL8HKLsoRgtYHCuOq8B
         NSMyx+YhZ4l1jYSxxc2S3/u8PWayvsRd9sr9AsTZOEbk0oJ6qrTJZRXEFA/G+a1+XZ
         A1bUiridukYUIdmppaUUNtYamjRmRwJVZlp+Zdb6VO4nWeikhSJKSEjZzJJd0wG4ty
         HloV2VjYfH8l8063pC3RT7AEB4QYNxMIYYYnlk5PrkQRE1GkZzTT6lGB35Ov+I1C2M
         5/967vfvf2+L2ReL6C8bXjyOqX/1NacOO4v6+4FiB/94v4GXQ9n5yoeiH0kb9Xh4hA
         CXg394utPd6Ng==
From:   Mark Brown <broonie@kernel.org>
To:     nicoleotsuka@gmail.com, festevam@gmail.com, tiwai@suse.com,
        Xiubo.Lee@gmail.com, timur@kernel.org, alsa-devel@alsa-project.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>, perex@perex.cz
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1629875681-16373-1-git-send-email-shengjiu.wang@nxp.com>
References: <1629875681-16373-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: imx-rpmsg: change dev_err to dev_err_probe for -EPROBE_DEFER
Message-Id: <162990401497.56501.6446443015923932557.b4-ty@kernel.org>
Date:   Wed, 25 Aug 2021 16:06:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2021 15:14:41 +0800, Shengjiu Wang wrote:
> Change dev_err to dev_err_probe for no need print error message
> when defer probe happens.
> 
> 
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-rpmsg: change dev_err to dev_err_probe for -EPROBE_DEFER
      commit: a8946f032eeace6eeb4e51e518275010e5528660

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
