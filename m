Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9359F30ACF3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhBAQrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:47:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:34034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231350AbhBAQr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:47:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17DAB64EA8;
        Mon,  1 Feb 2021 16:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612198006;
        bh=3ZSShGaHD21VoaeFlggx+0UQjYQByAjimh392hgvzhY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aCjyPqcfr4ofpETKztXWpYbTGn+/khEH/aQpmzyVz+YL0YwbX4QRAqpuLKlBZSGq3
         IEY6IaslC+Yr/QbSksCQ0O/P2xP3N0EKCSwCSSbyHK9Yw2Yt5fTjCJ94fJNjZMDlTo
         iIA2UohPVL1mg1ao8grbmS5lXDfWAkVDCuq6Fvy47PH0rKh04+HnLVccoSoVRNoUt8
         AhEOdUEpHdgW+meyYLP3LrQRjGewbO8+Cmna6m8HUvcVUqsyTI38SQ4CaYwmCYfrws
         UOc3l7GwaRQw5Bd0lYRXmioc/Ugns3D3zRGi8pKmrB4O7G4uXSw5kQQi7ncDOH6rZR
         ZMc5ZIUy0MBuw==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, vkoul@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, alsa-devel@alsa-project.org
In-Reply-To: <20210201161429.28060-1-srinivas.kandagatla@linaro.org>
References: <20210201161429.28060-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: add missing max_register in regmap config
Message-Id: <161219793996.46194.10385575485346385646.b4-ty@kernel.org>
Date:   Mon, 01 Feb 2021 16:45:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021 16:14:29 +0000, Srinivas Kandagatla wrote:
> For some reason setting max_register was missed from regmap_config.
> Without this cat /sys/kernel/debug/regmap/sdw:0:217:2010:0:1/range
> actually throws below Warning.
> 
> WARNING: CPU: 7 PID: 540 at drivers/base/regmap/regmap-debugfs.c:160
>  regmap_debugfs_get_dump_start.part.10+0x1e0/0x220
> ...
> Call trace:
>  regmap_debugfs_get_dump_start.part.10+0x1e0/0x220
>  regmap_reg_ranges_read_file+0xc0/0x2e0
>  full_proxy_read+0x64/0x98
>  vfs_read+0xa8/0x1e0
>  ksys_read+0x6c/0x100
>  __arm64_sys_read+0x1c/0x28
>  el0_svc_common.constprop.3+0x6c/0x190
>  do_el0_svc+0x24/0x90
>  el0_svc+0x14/0x20
>  el0_sync_handler+0x90/0xb8
>  el0_sync+0x158/0x180
> ...

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: add missing max_register in regmap config
      commit: e8820dbddbcad7e91daacf7d42a49d1d04a4e489

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
