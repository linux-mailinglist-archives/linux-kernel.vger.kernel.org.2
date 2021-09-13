Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728CE408985
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 12:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbhIMK4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 06:56:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234958AbhIMK4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 06:56:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E35EF610A6;
        Mon, 13 Sep 2021 10:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631530499;
        bh=oRmb9RFSDD9BpTeblLtC7yBA1uU7R97XAGDSNw6NsME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fp4DepS+BORdOAJho0LvkruiFnEiCugLdI/LYht8Y+gr/8fyunbRswMMhfsuDTNul
         uXFi/uY4ue8nBKZUHpfPDpIQXBbj5e1FhdsZJYBa5ldTHPT5QIYAKbPcqAg1NVeGri
         rpWgm0SxiTGVNGwRpX7m2Gf7f7Lc1bP9g9nJ0+7KQYmwXw7Vk1Jqjo0840wLGK/slg
         2lLHxJDeqXQwcRFya7pUV7OZfEfk5eIuAePaiMUzwasYnfY9kw5p1v+mVd8ZS6wRuI
         knlfaYiZWNgT8vC17H/h+QDEFQ36zjOptAT9BLdDNDm32MKMO2ZYEas65ekyvMwPGV
         7Ih8Dq/BKII3Q==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, nicoleotsuka@gmail.com, festevam@gmail.com,
        alsa-devel@alsa-project.org, Xiubo.Lee@gmail.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, tiwai@suse.com,
        timur@kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] ASoC: fsl_rpmsg: add soc specific data structure
Date:   Mon, 13 Sep 2021 11:53:22 +0100
Message-Id: <163152996584.45703.10310868616819481458.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1630044038-19036-1-git-send-email-shengjiu.wang@nxp.com>
References: <1630044038-19036-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2021 14:00:38 +0800, Shengjiu Wang wrote:
> Each platform has different supported rates and
> formats, so add soc specific data for each platform.
> This soc specific data is attached with compatible string.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_rpmsg: add soc specific data structure
      commit: b7bbbf01362720a8066e3f6d880cae6d63fc92f6

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
