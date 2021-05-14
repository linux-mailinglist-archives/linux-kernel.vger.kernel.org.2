Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171B4380CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhENPY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:24:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233639AbhENPYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:24:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A59D361458;
        Fri, 14 May 2021 15:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621005794;
        bh=T5JNKtuv44YwOupv5OHt57JCSRdA5+YtQ22wupXqpz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B5MUVHpaf6d6zPZ3RrckpW0E7JlTP0epDpJ1MFuLVe9jRk9+AlrLkhJDECMor8OyI
         5ps7Z+ormuWWKO96LUU2CHJH1dfeS74Ws2PPUnEf/jtI3JgX+mXBiqRMvy6RpAoEpa
         9XHaY8k3EB3psYO+mJPUTIhzaFSKsO/3dxALANrWC2LKczL97u5qJO8dYaSsb2luWX
         CJe8cMFPJj3b1GX8kavEBJCmeq/V4crbgH7AMfx3qehG0XuTN4i9OKyV76ZvmSO5K7
         CMk51bWol9rH7ypKrMo6P9iA8Uauk/0/+bBd2NIxyAFJwDZ5itVEshmySWSTn3Skf0
         xcLWnsgBfGqUw==
From:   Mark Brown <broonie@kernel.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap-i2c: Set regmap max raw r/w from quirks
Date:   Fri, 14 May 2021 16:22:28 +0100
Message-Id: <162100563578.50624.2004166251363064735.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210512135222.223203-1-tanureal@opensource.cirrus.com>
References: <20210512135222.223203-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 14:52:22 +0100, Lucas Tanure wrote:
> Set regmap raw read/write from i2c quirks max read/write
> so regmap_raw_read/write can split the access into chunks

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap-i2c: Set regmap max raw r/w from quirks
      commit: ea030ca688193462b8d612c1628c37129aa30072

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
