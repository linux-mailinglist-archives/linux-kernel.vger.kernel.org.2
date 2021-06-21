Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3393AF56A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhFUStN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231853AbhFUStG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:49:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D0B6611BD;
        Mon, 21 Jun 2021 18:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624301212;
        bh=MOO73DEGhW1d22CxLcZCw47NDPO4vbpIGcI1cX5HFcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p85Y09DRjTpOKNpxLV7F1BPWX8xocpqQenD28wxTPBBOjK+BxoTRsvsqRv9Ur/FQp
         9PFv4jbBoD74kyXzAiZd/topDWCILOFCGTo1CsoNkts3uRJC/hLWWTnV8NrwrmYryn
         O48brFyvao0wDxU1xv75GSso3ZX+f16OcHgroNyQkQetb/28YTFJbT4UvyO0fb1rWZ
         wZK1aigwlRQt8GfMd+9ERz9ysz9tkcXgVmfmHCa5ku4l67XCaVfU/DQ/1iQEnAYTMw
         G9N0Z+p09K1dTuF9uTYPyY2auUDp2XsNT3bV5DgNwXxxusOsJojtpbk6w6Heq1pj5L
         VVXllDbZhQLMw==
From:   Mark Brown <broonie@kernel.org>
To:     linuxppc-dev@lists.ozlabs.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, timur@kernel.org
Subject: Re: [PATCH -next v2 0/9] ASoC: fsl: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 21 Jun 2021 19:45:57 +0100
Message-Id: <162430055263.9224.2887926675781712898.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210615013922.784296-1-yangyingliang@huawei.com>
References: <20210615013922.784296-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 09:39:13 +0800, Yang Yingliang wrote:
> patch #1 ~ #8:
>   Use devm_platform_get_and_ioremap_resource()
> 
> patch #9
>   check return value of platform_get_resource_byname()
> 
> v2:
>   change error message in patch #9
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/9] ASoC: fsl_asrc: Use devm_platform_get_and_ioremap_resource()
      commit: c66d7621737fb07e660b3d6eef40636ef4e9103a
[2/9] ASoC: fsl_aud2htx: Use devm_platform_get_and_ioremap_resource()
      commit: 41e90cbbc50085487b4633f08c86dd71b0f18d7f
[3/9] ASoC: fsl_easrc: Use devm_platform_get_and_ioremap_resource()
      commit: 2cd16cf0d6bbb47adddc633c60ca405f672e64f4
[4/9] ASoC: fsl_esai: Use devm_platform_get_and_ioremap_resource()
      commit: f25bb69e6f04a3d45effbe1c571f5f3ac10253bb
[5/9] ASoC: fsl_micfil: Use devm_platform_get_and_ioremap_resource()
      commit: d9bf1e791ae61d606b0da0003ad19dbe7f252fe8
[6/9] ASoC: fsl_sai: Use devm_platform_get_and_ioremap_resource()
      commit: 664107f63888bdd8a5e1d38c8246b9508a1dc46a
[7/9] ASoC: fsl_spdif: Use devm_platform_get_and_ioremap_resource()
      commit: cbb7ea0aebf0c07061be615cab97ac9cab8a48a0
[8/9] ASoC: fsl_ssi: Use devm_platform_get_and_ioremap_resource()
      commit: 67798860e6d0114149562e6897cf07ba4bebc1d6
[9/9] ASoC: fsl_xcvr: check return value after calling platform_get_resource_byname()
      commit: a2f6ed4a44721d3a9fdf4da7e0743cb13866bf61

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
