Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9601451FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350507AbhKPApC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:45:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345115AbhKOT0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:26:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58B2D60174;
        Mon, 15 Nov 2021 19:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637004068;
        bh=gm8WyhiuPVpzggL/7VQuMhi+RUWWclkq8Gwz3rUzJVg=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=qIu9qnQGmWCg1BdymwlPybT6BHe5QC301qotNHHwB57gkWF2/Z50PlXM65xSQjxPL
         qAEkiJaQ+tfXlnoVz7Epsr5wcYvRdJoujPbkplSi45MuJNoLZUces7WR/wW6iAHz5l
         cgwNQW+8eOgo//+FZ9vJ261vHT86wqyadjIcOeOx7fSRuom4HGu6VU5gV0DYB3bQSu
         0oTIpSZAj+euqkq6XldM27wsLf93wJTpVJKSkUwHI3GCvOmXfUtiGf7YJUcG/XWAFg
         /e2aTm07jnOIpFrktkqvtzPK7wKSdOzxUgecCOz+4kf5CQbHtxzW7Gd7SJoZ+aDrKb
         4SlVVhPqoh/Mg==
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20211102220203.940290-1-corbet@lwn.net>
References: <20211102220203.940290-1-corbet@lwn.net>
Subject: Re: (subset) [PATCH 0/9] Remove some unused header files
Message-Id: <163700406707.683472.13536842768773786666.b4-ty@kernel.org>
Date:   Mon, 15 Nov 2021 19:21:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Nov 2021 16:01:54 -0600, Jonathan Corbet wrote:
> While working on something totally different, it occurred to me to wonder
> which header files in the kernel are not used anywhere.  Writing a little
> program to figure that out in Rust was the perfect distriction from the
> work I really needed to be doing...  It turns out there aren't many under
> include/linux; this gets rid of the ones I found.
> 
> Jonathan Corbet (9):
>   Remove unused headers <linux/jz4740-adc.h> and
>     <linux/power/jz4740-battery.h>
>   nfs: remove unused header <linux/pnfs_osd_xdr.h>
>   Remove unused header <linux/cnt32_to_63.h>
>   Remove unused header <linux/sdb.h>
>   Input: remove unused header <linux/input/cy8ctmg110_pdata.h>
>   mtd: remove unused header file <linux/mtd/latch-addr-flash.h>
>   ARM: ixp4xx: remove unused header file pata_ixp4xx_cf.h
>   spi: remove unused header file <linux/platform_data/spi-clps711x.h>
>   net: remove unused header file <linux/ks8851_mll.h>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[8/9] spi: remove unused header file <linux/platform_data/spi-clps711x.h>
      commit: 45971bdd8ca8b5a99a49f4db86737401c45e246f

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
