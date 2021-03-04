Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D1432C983
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453395AbhCDBHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:07:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1449414AbhCDA42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:56:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBAD664E99;
        Thu,  4 Mar 2021 00:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614819348;
        bh=J50c6MSt4szRnHViANGO4o4su8hX114G43wCQDJVhz0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TlXEuVYiLV3zoIljPwRVd8uikAbUzeWiSjOvUf6w8Uj9q8IKdd5gQ3zrwlUS/YrQ1
         UnUljVk+NI5VdbrH5omCzobkpii98txBtp1bTtypWdfeKpnJ033HykIHm7HiyMKhPa
         kyX08d3n/fan8pPvhVvk14I57a2Bplm94qCt+gDRudf5iq3JF+wQIKZPZQpiBaJFEN
         D4gCtRRPdBYe1WGpnFtOoG3GuuuhprLHd0b12aPlTKEkOkvcFZhUjFEBtB96AYeCWD
         bG0N2B53nGTZBaA1MBVlWeXmgvZ8jat+cv0JkeWl+Y5edlXa1T1Rjjq4KjQm64rgCk
         5S2JBnbP0Yyfw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        tiwai@suse.com
In-Reply-To: <1614762481-102466-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1614762481-102466-1-git-send-email-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH] SoC: codecs: fix platform_no_drv_owner.cocci warnings
Message-Id: <161481924070.9553.6743190852417137735.b4-ty@kernel.org>
Date:   Thu, 04 Mar 2021 00:54:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021 17:08:01 +0800, Yang Li wrote:
> ./sound/soc/codecs/lpass-rx-macro.c:3588:3-8: No need to set .owner here.
> The core will do it.
> 
> Remove .owner field if calls are used which set it automatically

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] SoC: codecs: fix platform_no_drv_owner.cocci warnings
      commit: 0ce5d3ac4ffe5c3b2d3ead09692e0bd7ff7487ca

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
