Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A008D38E60A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhEXMCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232824AbhEXMBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:01:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 795626128D;
        Mon, 24 May 2021 12:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621857624;
        bh=82DvYIV9/aEEAKqJ4R1oI4szzj8x1gyRP5rOJ/OQdkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fE14ww220mJAaneXvEB1VXiYQgW5Mn7aJI0F6OwgXX+5I8CrHAZh/rVjeuyEdrFsT
         GSrQjiEdOt5XBNShBYKiV2576h/wt6JAMkOE3CJlonDwpzXmrkrh7KiNV6YHpXBiaR
         9w1ynBlJsXkt6o7jaIzNSfxzHN2fbZmWPzoDIPBzfwdIzfNGtKbRdndEOjAVOvWGV/
         WIz7M5tlnSsByIVTWdXXy3mCnR5oj5use4RJzCyILTlpmDAUuEM4znNLFGmVMAhUXx
         gw84rbPcb0x8T5LkMK4Rr9+klWf1aLErYEBGzWROTh7HNy1fNSTtYRFsLlGHUVKR5L
         JiG3/WUEedX2Q==
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Fix MAX77620 regulator driver regression
Date:   Mon, 24 May 2021 12:59:54 +0100
Message-Id: <162185754507.49496.13485707426497775591.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210523224243.13219-1-digetx@gmail.com>
References: <20210523224243.13219-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 01:42:41 +0300, Dmitry Osipenko wrote:
> The next-20210521 started to fail on Nexus 7 because of the change to
> regulator core that caused regression of the MAX77620 regulator driver.
> The regulator driver is now getting a deferred probe and turned out
> driver wasn't ready for this. The root of the problem is that OF node
> of the PMIC MFD sub-device is shared with the PINCTRL sub-device and we
> need to convey this information to the driver core, otherwise it will
> try to claim GPIO pin that is already claimed by PINCTRL and fail the
> probe.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: max77620: Use device_set_of_node_from_dev()
      commit: 6f55c5dd1118b3076d11d9cb17f5c5f4bc3a1162
[2/2] regulator: max77620: Silence deferred probe error
      commit: 62499a94ce5b9a41047dbadaad885347b1176079

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
