Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618AF311220
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhBESfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:35:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:35660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233244AbhBESdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 13:33:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED20D64FC9;
        Fri,  5 Feb 2021 20:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612556139;
        bh=QColg4QhhmKDT0696m12WfhGsz46n0/6680quJeMgO8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JmfLmVa9ES3FL/fIk9XkBj8L45zLum7rWngQ9HS/nrkt2bL3ij5mOGCPeynkQmZjl
         p3/6Ou8a81m4ebk0+UqSG1EPcFG7sLcxYbNR23VyCtQktQFzKmwKIwKYwkOMrLw1bi
         3GNJpZN3cT28qUhUucpYLuCfcOWE+oyD5sHy/6MA6aRGrlaoBGaJdTPW0XGc4bMZuA
         Qx93M5OPviuouZE2tLnE56rdsVLpCcHAycZhrIghC3YonS7ktI9SZyF22c18yLZjnT
         GC1/cc20JtCozaZIVWjLVJH1wfgccFBP7exfy4QoX66KbsLV7eI9neowJFJSzCY8wf
         cb4OXS+F8YQwA==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>, Stephen Boyd <swboyd@chromium.org>
Cc:     kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org
In-Reply-To: <20210202183646.38602-1-swboyd@chromium.org>
References: <20210202183646.38602-1-swboyd@chromium.org>
Subject: Re: [PATCH for-next] ASoC: da7218: Drop CONFIG_OF ifdef
Message-Id: <161255607745.56562.5858385783498513973.b4-ty@kernel.org>
Date:   Fri, 05 Feb 2021 20:14:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021 10:36:46 -0800, Stephen Boyd wrote:
> This reverts commit a06cd8cf97a3 ("ASoC: da7218: skip of_device_id table
> when !CONFIG_OF") because we want to make of_match_device() stop using
> of_match_ptr() internally, confusing compilers and causing ifdef
> pollution.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: da7218: Drop CONFIG_OF ifdef
      commit: 0dd4d3e8c3a8ab63e9368e01d7839afad7b804c7

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
