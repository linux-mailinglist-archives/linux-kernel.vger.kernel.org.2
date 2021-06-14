Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7FC3A6FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbhFNT5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:57:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235667AbhFNT51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:57:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2D62611EE;
        Mon, 14 Jun 2021 19:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700524;
        bh=Ntq4kqfa7yTnx8mVPDsS8IPwujI3mWFLjDWMxG8jalE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RABkBT+nggojxbBjepS2TJ3VTzPGjdLTL36uau2ylN8z5+ED/J8ChW7N8muSgqKaj
         j906CKpN9WJQ8IGjkdqSxRhmI7qtWt+bfCFaYri4HloD5EJhgJzzTXhJoi0RXYQ6gP
         0urj8N1SPZig0dp7YU2G2Z7QTJhYj9oIAD47RWlcQebpA7j8HTlsj0oPR8vXNm1Oiv
         xzqyhwq6wU4KCgdtyWKAVnBI7i38hfNPJ2C7cK59NWR/Qlj9hT8wD1rgL9Jf+veNPA
         Bzb0pWJxKkicVy4SPNgvJTCzytXqjHdrbOOVaWrsQ42vieY5LDwzb/Er/tvcZkEYZ3
         FKnszJfCHZpPw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        codrin.ciubotariu@microchip.com
Subject: Re: [PATCH -next] ASoC: mchp-i2s-mcc: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 14 Jun 2021 20:53:54 +0100
Message-Id: <162369994010.34524.5545642364893372960.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210611044256.3899583-1-yangyingliang@huawei.com>
References: <20210611044256.3899583-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 12:42:56 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mchp-i2s-mcc: Use devm_platform_get_and_ioremap_resource()
      commit: be374dc0b5062eb8ec3feb5cb1795a24c399f6cc

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
