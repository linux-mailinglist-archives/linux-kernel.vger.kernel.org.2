Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BC139AA4E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhFCSop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:44:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhFCSon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:44:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EDC1613BA;
        Thu,  3 Jun 2021 18:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622745778;
        bh=NxyUuh91qrqMnBo8ie0krdbQjRaa93rWA9QAM/4o8ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SfKrxZ0v/NC86EzSnJJ5lJTW1h0m9U1FzAWsbAxHUQIWAVQgrnxSlPLcHYun0f/yj
         ZmpHtTCuaeb1+S5s2tpqxQoJRe9GQn+6qB2wl1u9DX3D036ewlONYjhvu1Zqf5Mrpe
         EmU1OxkhCFwAO+M1D1p+LF6e/yjhHAbyOH5xfX+YNnD83QuylQKr7vZDIZDNHFM61L
         K8AlPTC6WZ9rD0bPzxaYbNi22peJdQsNknUeAMYqlvJ4EEXxl8WEKqQDXLJSsxj214
         1wi9DxZYY3NqTLVETFl0o+fpkoZdgllcEeHkzZvRN/MK2wIM5uAOCMuEDG7HKH90pw
         xixoNfx2yKqig==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Cc:     Mark Brown <broonie@kernel.org>, shengjiu.wang@gmail.com
Subject: Re: [PATCH -next] ASoC: imx-audio-rpmsg: use module_rpmsg_driver to simplify the code
Date:   Thu,  3 Jun 2021 19:42:00 +0100
Message-Id: <162274557553.14795.15724219932550119503.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210602082610.3828408-1-yangyingliang@huawei.com>
References: <20210602082610.3828408-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 16:26:10 +0800, Yang Yingliang wrote:
> module_rpmsg_driver() makes the code simpler by eliminating
> boilerplate code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-audio-rpmsg: use module_rpmsg_driver to simplify the code
      commit: b82d0759a3b1e23d4247523c89bdfb27fffb6089

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
