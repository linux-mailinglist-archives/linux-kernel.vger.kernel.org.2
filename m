Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B833E203F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 02:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243116AbhHFAs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 20:48:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243028AbhHFAsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:48:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EF1C60F14;
        Fri,  6 Aug 2021 00:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628210915;
        bh=ebSCxHPLyiLi3QtLw46r1IOo/s6BBPhByAQ8UJYP2kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UTgayJVEpwi1QPCt4Jq5pi3YwiJznCf/jxdX63XE4S7egAFn1hD0BWykWuoHulg8z
         TiRTWhfBWejXyCydFin1Kp1asf69JymlmBFirTqcaeHes871cn9yFtO/f8gdB/cSEd
         yiYVu+ygwao2Mn5xRz+Iu7vswSCU6o3/eDOEotrj8Gq+7VtMU3nkc9UUQbHi1chkT4
         sDIvBZanMznGFKIEZWwtKIBQjNuykOEECW/hbNRlJApz2gFkNSlS7Ymb2PkkWBY4al
         APzQ+IYe/e3Hnf/3cSoo9FXELSZNuOqmMiZMJ0AP6bJE+Q9OEX+4pMIaUpiZuOwHdm
         2ThIkeqXnWq/Q==
From:   Mark Brown <broonie@kernel.org>
To:     Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: simple-card-utils: Avoid over-allocating DLCs
Date:   Fri,  6 Aug 2021 01:47:53 +0100
Message-Id: <162821054281.18754.4391897780830223126.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210805050706.46833-1-samuel@sholland.org>
References: <20210805050706.46833-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2021 00:07:06 -0500, Samuel Holland wrote:
> The allocation of the DAI link components (DLCs) passed the wrong
> pointer to sizeof. Since simple_dai_props is much larger than
> snd_soc_dai_link_component, there was no out of bounds access, only
> wasted memory.
> 
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: simple-card-utils: Avoid over-allocating DLCs
      commit: 36a9d79e5e9518dfd9548e3237e7a49464c16922

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
