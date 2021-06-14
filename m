Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8403A6F99
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbhFNT5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235496AbhFNT47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:56:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C83DF6124B;
        Mon, 14 Jun 2021 19:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700496;
        bh=PnHK/VR5cOpnsRVccuzXTfVuyVHxXtdD1FlUCiH5SLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JCv6KE1exAGVCpty7wHJatW7A0B7P1MM4+B0iiwLOjf5FMS3jhQ0Eqt/8UY/Xj6Rm
         zOu9wjOEZv2Re/Xmgidnlw+qxmvYGig/BhqxkbOCQXqsLHmkGQqMO5BPkP/Uj8kHfF
         BXDWeHiDVdpSyREMRwJ5YZthQ+zcBPc/mzI6rF5nonCzGwBoL5dhDcTA3gyYOTnFqz
         rYyknQIC1pLozUVfVy97BFeLlgS4PmN66pVeQZjj7ZNrOH7yz+OGONAzn222pJTduy
         OapCgU/8NBNr5uo0/XicG4WXUuP003OajhSF/6zX+3NWz7QCi7fa+9zZ8CN4L+qSgN
         iSU1XzrbQvLMQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
Subject: Re: [PATCH -next] ASoC: bcm: cygnus_ssp: Use devm_platform_ioremap_resource_byname()
Date:   Mon, 14 Jun 2021 20:53:45 +0100
Message-Id: <162369994010.34524.11074726668440482305.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210611050235.4182746-1-yangyingliang@huawei.com>
References: <20210611050235.4182746-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 13:02:35 +0800, Yang Yingliang wrote:
> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap_resource()
> separately.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: bcm: cygnus_ssp: Use devm_platform_ioremap_resource_byname()
      commit: 3814c41778f3489ac103c9a045ae26c082d19be3

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
