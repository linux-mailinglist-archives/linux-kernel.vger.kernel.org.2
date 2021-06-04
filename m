Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F6739BD36
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhFDQee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhFDQed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:34:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5DAD610E7;
        Fri,  4 Jun 2021 16:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622824367;
        bh=+mORFr4TKbRDcsYrdc//w+GSAs3hIZH24GdNLhvPoG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JiCYlFN+zDuaPswynU17hKBmUKP2DVhnmVRrSXXwsae+xFdbzXY+qq+JnQrn1Gb6/
         CFwVbknuUnjYqIShfnOshVDqSb9pKBMczpTcC1d0+9iJetrqVGreGFZkZ53L22eK9/
         /Qb9leOb0iww1atVXTnlDUFYiXLAKSVCSjixU18zogZZXPnfVC6NiFHSr05unWfGeM
         ISuqcR/t/NcKswslUCo3qhAyOVjPAuIJdpGB+kh8SH7nnINn76+4Kh9uyPQjvz1nGf
         LaSFbErXddVrtVIou00wFMdB2d27xE6ATPXNG9ScOkr0lFfSx0/7P0XyOLUw1bv7v7
         qM3xBrhN6545Q==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Rudi Heitbaum <rudi@heitbaum.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>, pgwipeout@gmail.com,
        chenjh@rock-chips.com, ezequiel@collabora.com
Subject: Re: [PATCH v2] regulator: fan53555: add tcs4526
Date:   Fri,  4 Jun 2021 17:32:26 +0100
Message-Id: <162282428736.39035.5966034693466191501.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210528101946.GA418765@96e513df87d1>
References: <20210526162342.GA20@8bbba9ba63a4> <20210528101946.GA418765@96e513df87d1>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021 10:19:50 +0000, Rudi Heitbaum wrote:
> For rk3399pro boards the tcs4526 regulator supports the vdd_gpu
> regulator. The tcs4526 regulator has a chip id of <0>.
> Add the compatibile tcs,tcs4526
> 
> without this patch, the dmesg output is:
>   fan53555-regulator 0-0010: Chip ID 0 not supported!
>   fan53555-regulator 0-0010: Failed to setup device!
>   fan53555-regulator: probe of 0-0010 failed with error -22
> with this patch, the dmesg output is:
>   vdd_gpu: supplied by vcc5v0_sys
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: fan53555: add tcs4526
      commit: 5eee5eced95f1b35c8567688ed52932b7e58deee

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
