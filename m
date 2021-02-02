Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AB730C7E1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbhBBRdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:33:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237333AbhBBRb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:31:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01DE564ECE;
        Tue,  2 Feb 2021 17:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612287047;
        bh=MsYWS5fR84takhXK5ZPtutS06RculY3MNRJAjqjwzAo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Laas/WDEqIz1PIDtsTH4GdAnfy1yrBNddu0b36XRjEio7LT1P7BhfX4gvVnb9wPPc
         A+lGtedCxIzhaWtltzzzWVon4e3FD/SIWXyJq0Rw6xZ3kKrzqVjIxsr82f2fMVN2vP
         0SwFYEVtn2at8vnfhT4onKoZ6ZO2vubtrB1kLyexgSbxO9ffLe4nNRTUOooWYlD4jd
         q/eKGMpT/urUV8NAwaZjo68CvH1/Z5KKivObsx/E37G0vqSdCXLWTChBiwMJL36F4x
         Nd9UlIO5Zj3+LVHT6ZlXR/c3c+8IZQa4mXfGmh3GkDZ4wyzyr99gmX4WnuyXXZUmRt
         rdRIspXmhkQNA==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, tiwai@suse.com, timur@kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>, Xiubo.Lee@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20210128112714.16324-1-tangbin@cmss.chinamobile.com>
References: <20210128112714.16324-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Utilize the defined parameter to clear code
Message-Id: <161228699993.35075.10104623503101493059.b4-ty@kernel.org>
Date:   Tue, 02 Feb 2021 17:29:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jan 2021 19:27:14 +0800, Tang Bin wrote:
> Utilize the defined parameter 'dev' to make the code cleaner.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: Utilize the defined parameter to clear code
      commit: 68be8ed6a4622d4eb6cf7632bc7cb78464c83c78

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
