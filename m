Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240CC387D9B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350743AbhERQeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:34:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350739AbhERQd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:33:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C8156124C;
        Tue, 18 May 2021 16:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621355559;
        bh=sd481hao0IvKarDjopwS5z1QyDhGwAXg6X3FMDmBoVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rwK7OTX6zAJxyUItiymRzKwWLo+PKSpUa4x1sC6Kb7eJf1JPssuB1L7lOgGZsil0o
         N/APL1OzLgOOOcKqOlj5fsioTzuX6lQtF8bYFIEy1VxtcyeE1+ySpgE1XzOlAXRbcV
         mE+/uTnTFhI4r08QCfmgIkyUZvgmTLThn5L9WNz1zgl3CAlo8lrpyMUbBxchZCFaB4
         V6GfruVvyMr6TzURrD5tslfDcBnM1vputL4aM131y0JEvtnO6Z5/E7xg65eh3Qovj8
         TOrxINez0m4CMb62GRSgIIbJs+rTRafwi1wBtc35d8pKoUvF26uo8MJqaVaBU6jhzs
         VhuexZuMmRjNw==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, YueHaibing <yuehaibing@huawei.com>, perex@perex.cz,
        lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: soc-core: use DEVICE_ATTR_RO macro
Date:   Tue, 18 May 2021 17:31:32 +0100
Message-Id: <162135531445.37831.1353258100383358131.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210514081100.16196-1-yuehaibing@huawei.com>
References: <20210514081100.16196-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 16:11:00 +0800, YueHaibing wrote:
> Use DEVICE_ATTR_RO helper instead of plain DEVICE_ATTR,
> which makes the code a bit shorter and easier to read.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-core: use DEVICE_ATTR_RO macro
      commit: 5a3f869c5b4d230b60ba0197c10506dd4ae30851

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
