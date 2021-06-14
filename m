Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A573A6F86
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhFNT4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:56:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235007AbhFNT4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:56:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB79B6124B;
        Mon, 14 Jun 2021 19:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700470;
        bh=mnOxmUBitkeW0cBqgnYL0/xMwI6MW9v0wy8VCpIvwxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jt0SqJaO3QTtNX/xECIUOMd1sdw0qSCcAELE9Qsz9ha/qg4bCOtnTrBu55iT1CKev
         9mjFbMvl6dczlZ3B1ituQrHqluOEftiJOh2AhJxxwvHIwNb0HfIRmKIpkF89snGbz1
         x/5vDCleANRiSvwPHgnH21f947CoGaQKJEOY5b6GCaRZZOt5lYsj2b7pwFnz3YK3QK
         OPV7o6HwCKih1x0xoEbTr3JwRE3GeHXLeGWMAjn+30ZYSzxSPxDuKfMTIgb4wxe7Y/
         Rkiy3kwd0NWQ5/wnJ/4IXuHOAFn0LbGyGY5XGCzDklTx0yGm4jRZY49InDU8XgtBzl
         UgHt0tLeeeRjg==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: hi6421v600: Use regulator_map_voltage_ascend
Date:   Mon, 14 Jun 2021 20:53:35 +0100
Message-Id: <162370026642.40835.11220503922953408419.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210610134128.2477821-1-axel.lin@ingics.com>
References: <20210610134128.2477821-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 21:41:28 +0800, Axel Lin wrote:
> All the voltage tables have entries in ascendant order, so use
> regulator_map_voltage_ascend to speed up the mapping.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: hi6421v600: Use regulator_map_voltage_ascend
      commit: 00430f71b2b18e42ba3d733cbd2d725ec5b2ca80

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
