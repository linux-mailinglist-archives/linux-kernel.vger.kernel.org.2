Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEB83A878D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhFORcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230502AbhFORcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:32:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 954B8610A3;
        Tue, 15 Jun 2021 17:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623778204;
        bh=I+jgj6nQlpvNNyLiWopyqY9UP0+/vKlXRtn+3XYdWwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sBqAAbFUZgTBINdXHKBYSRNeJPFojOkr9GmnEdaWDL+VvAMXGyIJYNYBcbUSSdo5D
         Na3OWrh1bLPaUAWoXdvVhVba7OkGA9va5ra0accxiFQETti2Cyb3K1ZYWRnR6eUchw
         /nXr3q18KJ8qMiHRuSD8t00hDzU5vKm5u8wXdT83Ag0bnPHoNys+ACgb45T4RptkRK
         vlkoglORLLaQ05kvnEhXIpr0jjRRsw/Qk0mnv6hc3HWFPrbjh2hAnz06XsAcmCvtts
         qljG4/Ofx7OtEbMi6/12FCWtigudo1R+/zaHo/wAF5EPldzIQkYxmiVS2tMsH9TkOb
         MwLQx8HirIrQA==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
Subject: Re: [PATCH -next] ASoC: dwc: dwc-i2s: Use devm_platform_get_and_ioremap_resource()
Date:   Tue, 15 Jun 2021 18:29:24 +0100
Message-Id: <162377763945.21612.7111520770208595617.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210615132933.1372463-1-yangyingliang@huawei.com>
References: <20210615132933.1372463-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 21:29:33 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dwc: dwc-i2s: Use devm_platform_get_and_ioremap_resource()
      commit: 1f65c9bdd6dd7bd292cfadfb135f660aeaa928f1

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
