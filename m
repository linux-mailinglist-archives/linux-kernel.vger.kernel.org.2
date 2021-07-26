Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D393D68BA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 23:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhGZUy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 16:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhGZUy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 16:54:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8DD260F6C;
        Mon, 26 Jul 2021 21:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627335295;
        bh=0eUNpaZZ6ueHgtkXpBbhh0wR09QD1sB3ybYVv+8S8PA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SKhKEwATCV/CqsbvPKCjIJhsKPeiAcMVIvSwwfR4qtFzGDWKiClqgdzeLTKpqQ0fq
         UaNZ+3SmwvvLtMmWWa7x5u1wmcRAf8J7kpi1y2MR+hQX7Iu//Bw3pzdr4o8EJX9lbG
         9o83WnxtGvQQ/2tpqmnyUgSJv45jMQJqY+7opUDy7vmJDzF83QY4Z7Qkq42OOFd9BU
         en7axm8txpX276V8jA3whDYuTQJQWx4hciFssGezujyD2FXeWmOUYtqr2jjeCYIAG4
         b9GTY6DJpZo3syYLES+u69MtBgAly49P8+gWthTD06irKit7dscAco25t/K49Ldz8Z
         mWaY4uFcaaYog==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Brent Lu <brent.lu@intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Zou Wei <zou_wei@huawei.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>
Subject: Re: [PATCH] ASoC: Intel: sof_da7219_mx98360a: fail to initialize soundcard
Date:   Mon, 26 Jul 2021 22:34:42 +0100
Message-Id: <162733475033.22497.13925594372181904569.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210726094525.5748-1-brent.lu@intel.com>
References: <20210726094525.5748-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2021 17:45:25 +0800, Brent Lu wrote:
> The default codec for speaker amp's DAI Link is max98373 and will be
> overwritten in probe function if the board id is sof_da7219_mx98360a.
> However, the probe function does not do it because the board id is
> changed in earlier commit.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_da7219_mx98360a: fail to initialize soundcard
      commit: 0f32d9eb38c13c32895b5bf695eac639cee02d6c

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
