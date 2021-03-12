Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4AF3399E0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 00:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbhCLXCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 18:02:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:56238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235683AbhCLXCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 18:02:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6CC164F4D;
        Fri, 12 Mar 2021 23:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615590127;
        bh=YjpH46E5wsNV0V6as8mJ95+AjvUcvV/u/mVOZl8KRBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UOmoNrl7OW/V8jOFswOIRyhAM8sQ5o9vYGhD/fmFRK5WLqZCmJ68tjNsEaiUsVnmw
         vHxZmeX9O/idptY5NwkhF47YUIHbVKEylfzHlb5ahKME1hlazi2HkXY2RVDOC0Q5DS
         orkVU42K+1JZsL9jOZwGF8qtyc1M0Vr6FArGZchcWZ+XwV7/Q6xNcV12rSd28oQeMk
         EiPje11w5WGeR0E0jx1mG61xBtTTEq5UYhAYpyhifuCC7GXw2ui+tTCsY7GUxI2CP6
         niSgG9YfFmSG6kFkZnXm4cneZv+2f4V8qN7aHM20rJWIdDY+8QI19EENcknga49RNi
         jvKhV3r8FwnRg==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, Xiubo.Lee@gmail.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, timur@kernel.org,
        alsa-devel@alsa-project.org, nicoleotsuka@gmail.com,
        festevam@gmail.com, tiwai@suse.com
Cc:     Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_asrc_dma: request dma channel from specific controller
Date:   Fri, 12 Mar 2021 23:00:49 +0000
Message-Id: <161558981190.31753.12828472795254829304.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1614935977-21638-1-git-send-email-shengjiu.wang@nxp.com>
References: <1614935977-21638-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2021 17:19:37 +0800, Shengjiu Wang wrote:
> Request dma channel from specific dma controller instead of generic
> dma controller list, otherwise, may get the wrong dma controller
> if there are multi dma controllers such as i.MX8MP.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_asrc_dma: request dma channel from specific controller
      commit: ee427ea4f12672e5d7874abaa634ddee0ff2bb97

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
