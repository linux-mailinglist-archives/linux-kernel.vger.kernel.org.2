Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC6145FBA9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 03:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242309AbhK0COE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 21:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhK0CMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 21:12:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4565C08EB23
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 17:29:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6528B60A70
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 01:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6360DC004E1;
        Sat, 27 Nov 2021 01:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637976596;
        bh=mdcPkROBkg6g+bcaNVjEFJmr2PWE2x4mGjdd+HKP0EU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZMTM9jxMVLZOo0Vs2eGBhYKOI2tNG4bFm5tdAEyS+K9NNLD/lLvWOLCMhmHV8LqAu
         J0BFSLxe6W1FAsCY57gZJza8++/h/vOsoiL6h43XNzuKW0GBXBeB9iUy5xObZf8fIN
         +HAZrmYvmz0F0RzL6MXSpGrEVTx9XqHi/AAVh2dV4N5HZlLGjFPhuZ54cRwDdwSlnn
         Vur7Zhm64fubEi0D3OAXVhpFaeRzzet4qpF+E/5KX1hjW9cz38IaqFPGm9Y0Z67nw4
         xpSk2zjyGL8/FoUWyRC0MC18tpYAUFiXyigTJkuVFheKwa3SZY9vvQPTxd5arWKzV2
         1xQjfkqIq1+6w==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com, nicoleotsuka@gmail.com
Cc:     linux-kernel@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, kernel@pengutronix.de,
        Xiubo.Lee@gmail.com, festevam@gmail.com,
        Zeal Robot <zealci@zte.com.cn>, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de,
        tiwai@suse.com, shengjiu.wang@gmail.com,
        Ye Guojin <ye.guojin@zte.com.cn>, linux-imx@nxp.com,
        lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20211110002910.134915-1-ye.guojin@zte.com.cn>
References: <20211110002910.134915-1-ye.guojin@zte.com.cn>
Subject: Re: [PATCH] ASoC: imx-hdmi: add put_device() after of_find_device_by_node()
Message-Id: <163797659312.2987942.8864055300904325575.b4-ty@kernel.org>
Date:   Sat, 27 Nov 2021 01:29:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021 00:29:10 +0000, cgel.zte@gmail.com wrote:
> From: Ye Guojin <ye.guojin@zte.com.cn>
> 
> This was found by coccicheck:
> ./sound/soc/fsl/imx-hdmi.c,209,1-7,ERROR  missing put_device; call
> of_find_device_by_node on line 119, but without a corresponding object
> release within this function.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-hdmi: add put_device() after of_find_device_by_node()
      commit: f670b274f7f6f4b2722d7f08d0fddf606a727e92

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
