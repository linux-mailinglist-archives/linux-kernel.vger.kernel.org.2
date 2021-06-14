Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A02C3A6F9E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbhFNT50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235659AbhFNT5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:57:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A142611CA;
        Mon, 14 Jun 2021 19:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700511;
        bh=lT5yzjjUYBYta8C+DB0QxaUERnjC8I3q07nMpoQubhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gNrhW6oZA7SoWcZ4rY9yWpvgI8AASw1k31ct6FZgNluC2uZPP/5XCsLk0JPjwIOd6
         LzUESr3XIo3cwNO0W3B1vzpez/RmcnlRyojmCYQDpUaisMRnXQNqzdIU/e3SUZQzmo
         3lQk1L9Sz9zIZ5Z6+bCgXU44+YOmdpUAaVVs9z28Co/klSW7eDn0ftWD8svj+/oTHS
         tfLJoMmXCJ1jjNR3/K7MabA1Mau2/ulz6FjRw+LdMj6/6Vjb9JztM4gmApmePCX2qY
         J68muXB+sztOVrTaCgrv9HI2CRKtxscqPLizscJeVPr61pRxnpl/6qCqHUL/QlA+wx
         zvuLNVs3sePKg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        codrin.ciubotariu@microchip.com
Subject: Re: [PATCH -next] ASoC: atmel-i2s: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 14 Jun 2021 20:53:49 +0100
Message-Id: <162369994009.34524.4469647809595882038.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210611034122.3871022-1-yangyingliang@huawei.com>
References: <20210611034122.3871022-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 11:41:22 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel-i2s: Use devm_platform_get_and_ioremap_resource()
      commit: 39175acd699ae73abd855748e05fb117dcc05a1f

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
