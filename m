Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062FB3A6FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbhFNT5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:57:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234248AbhFNT5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:57:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3273E6128A;
        Mon, 14 Jun 2021 19:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700516;
        bh=JVtF7puJ1shUATjeFrsP6yt4dbeRT4TfQ9U1qhmr9XI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QYOp/m5nxHRC4+bYA1QhNmN6LilNQyXoZGj0ljlVLpHAOlIFcJ5CY9m8kAnquMeRC
         M/L9VxR8gq85iwomsDoO3IAbWt0/max/UCMgls/JrD/A/61JQfAiQ9HYGxCMvWa6Du
         XC0awlcK5lceUwBxOEAdv64W6rmRXsB5RaqG6YkcN8hwpYyA9dMYAeseMIpueKGuH5
         B9KSBKX2arje8GCXfUjfuKyTTMSy1H106mYMJN7AYpRGBDDHOEZjnGthAseXWAfGeJ
         Dty8OynM3u6yf73tAVQzOOt29gRZ6pUnB33rpYPmY038/ldId8m5OhrfHGxe0/8WO1
         tbyc8JGOeu2Lg==
From:   Mark Brown <broonie@kernel.org>
To:     timur@kernel.org, tiwai@suse.com, Zhongjun Tan <hbut_tan@163.com>,
        nicoleotsuka@gmail.com, shengjiu.wang@gmail.com,
        lgirdwood@gmail.com, festevam@gmail.com, perex@perex.cz,
        Xiubo.Lee@gmail.com
Cc:     Mark Brown <broonie@kernel.org>,
        Tan Zhongjun <tanzhongjun@yulong.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ASoC:fsl_easrc:Remove superfluous error message around platform_get_irq()
Date:   Mon, 14 Jun 2021 20:53:51 +0100
Message-Id: <162369994009.34524.4963839891327399167.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210610125052.1280-1-hbut_tan@163.com>
References: <20210610125052.1280-1-hbut_tan@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 20:50:52 +0800, Zhongjun Tan wrote:
> Clean up the check for irq.dev_err is superfluous as platform_get_irq()
> already prints an error.Remove curly braces to confirm to styling
> requirements.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC:fsl_easrc:Remove superfluous error message around platform_get_irq()
      commit: 4d5f3a096f3d9e7067c7c2e730d989668e06d552

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
