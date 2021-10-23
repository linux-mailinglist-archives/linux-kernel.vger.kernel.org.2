Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0ED43851B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 21:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhJWUAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 16:00:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231322AbhJWUAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 16:00:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 891FB60EB2;
        Sat, 23 Oct 2021 19:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635019102;
        bh=HFdB5/lOoigdEI1RzF6A7jxq4Lils1FBjWItdFBBewQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYANOnh0tFet7aDLL/hpqtbWhAfIwMh9QzjqmgONhPG66oXyr7lXPwzz2sVpX34Ca
         tOfHjL6JmzHSGfrMpjF+rmlnC9m2vuljYiB44xqmUubls9f0Os/IALnif89o6Prrbu
         DMbD6GVMjXlDGMAe1yZ5WQvf5sNWCjuZP8/oCXXG3pBhJ8TIHcEZkGkMq0esKkIGsE
         4NvMhJ2nyrwTnlYmIIvCjHwL4aK+uz3VVh/Dfx33gUqNHGN8e90dLDHXTK+MYWFWtJ
         oyX+ARVl1/cRRhd1PhzfVtWMJpskpPgt5g96WI/1C9pUKRbL1lYaeGRGGwQFehFFx5
         +gFxM6Ep7mNOw==
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, kernel@collabora.com,
        linux-kernel@vger.kernel.org,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3] regmap: spi: Set regmap max raw r/w from max_transfer_size
Date:   Sat, 23 Oct 2021 20:58:05 +0100
Message-Id: <163501902912.919171.448046009962211592.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021132721.13669-1-andrealmeid@collabora.com>
References: <20211021132721.13669-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 10:27:21 -0300, André Almeida wrote:
> From: Lucas Tanure <tanureal@opensource.cirrus.com>
> 
> Set regmap raw read/write from spi max_transfer_size
> so regmap_raw_read/write can split the access into chunks
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: spi: Set regmap max raw r/w from max_transfer_size
      commit: f231ff38b7b23197013b437128d196710fe282da

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
