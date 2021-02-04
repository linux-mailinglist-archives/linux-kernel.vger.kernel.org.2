Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EC430FD8D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239881AbhBDUAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:00:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238271AbhBDTzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 14:55:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 345E564F38;
        Thu,  4 Feb 2021 19:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612468475;
        bh=johKx38ks+oRgpVV0ux+/dl7phAJ1QoQ/fgPvEzdrQI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JK/brJObTu9gBJLprcqtZd8B/w6YPtFm6n4kv3uOuyAivpkb9ksw50X7xpQzBSDmB
         7D8EIn3kjL1+qeV0BdlemtuvOSvZjEqHSEANr7824KwqGNcDbRLxLUg7UPtsbjHKYG
         hbyo7F3yP5FxmwPu57OqFHqRQB+ABQY4EWPOlwruzeGldiwLhrhYvbPbf/nwH0NB6U
         8MYMQvk4TzNOP70ehSxH3VMNZ1oRAnPW6JIUt4Z5EkdpYhDPjKGByBt7FaYFbUmwSz
         5ofwkCewSfBi98Ahmkh3AX8mWua60CnEPjUpTKlFZmONBdsq7GTNN+QuPk6j1StNtB
         KePTllaTTgIeA==
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>, Rob Herring <robh@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>, devicetree@vger.kernel.org
In-Reply-To: <20210202192016.49028-1-swboyd@chromium.org>
References: <20210202192016.49028-1-swboyd@chromium.org>
Subject: Re: [PATCH v2] ASoC: da7218: Drop CONFIG_OF ifdef
Message-Id: <161246842661.26209.4196882203977238370.b4-ty@kernel.org>
Date:   Thu, 04 Feb 2021 19:53:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021 11:20:16 -0800, Stephen Boyd wrote:
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
