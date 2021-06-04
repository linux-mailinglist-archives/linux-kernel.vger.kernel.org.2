Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE7739BD34
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhFDQeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhFDQeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:34:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 316C8613F4;
        Fri,  4 Jun 2021 16:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622824364;
        bh=TFY60E/1BpH2r3cBnHpES2AH6tjaTWJgbyVIU0ro3zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDU5/z4qpZDo7IZNacM6DjmipnyNqBKKI7IpLx0zl7aFiClbBeR8n5y0CPsNP36Hq
         3PaR4vhhd/WL7nF//zcrpYc7JZoz7SkUxKe0uJmiyNax5glLHNPrI2/YNjyYGfhp/u
         e+Rjg9LahFSCtHsZf/A3H4jGmwpImYyCm9X+YEQB8OMLJxnaGCVCEn2gLDzQcR8fVG
         CReGOgckvOD30QPFdt5/QpSgwnR5bvFd6oLQN7mEoxEQEyA9vgbrcFfATLbPf5wol+
         1Fyl+4+G9hFyzjws5f/KTPp57kXh7iAvJRXxX9N4NvXiGWhSpHfh2SjQUQ9FN+oM3u
         75eM1OteVuELQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Rudi Heitbaum <rudi@heitbaum.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>, chenjh@rock-chips.com,
        pgwipeout@gmail.com, ezequiel@collabora.com
Subject: Re: [PATCH 2/2 v2] regulator: fan53555: add tcs4526
Date:   Fri,  4 Jun 2021 17:32:25 +0100
Message-Id: <162282428736.39035.1786506812708182335.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210602112943.GA119@5f9be87369f8>
References: <20210602112452.GA98@5f9be87369f8> <20210602112943.GA119@5f9be87369f8>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 11:29:47 +0000, Rudi Heitbaum wrote:
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

[2/2] regulator: fan53555: add tcs4526
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
