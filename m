Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BE93AB6C9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhFQPEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233025AbhFQPD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:03:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9029F6113E;
        Thu, 17 Jun 2021 15:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623942110;
        bh=syZJZA6AiFXTfA5Kku0tqi/215ifUvvmL7TjrjU9VjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cx3WU0KdGMt/U2Y8hhk/VDOEd3hdXveR1n9wgR3io3a0Zn0OebqZZgkdUsY3JinlD
         m4A89dIpspVDIrjlCNgcFZgFt4BM2IWhUOihH80inMR+tbdX/LgLRFiVS4fLzfjExH
         bxuqszWSMzTLXXT2Gf7neO53EK5eMcbgErNPyqs28DARd9i4Q/MjtAsTU+tj8ARCnS
         ODBZPLMqWJG1sGnK925teM75T4eDYiPWGRtBLbprXUbZc2fKAIvIRRL887rHvMJHlU
         1yIH8WwW7q39PXJi+rUu9/lCtjLr1+fACWtyEG3J3Aakx0Ond8QYPoONx+pW6JNsm/
         crfcQlPPOUnBw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Yang Yingliang <yangyingliang@huawei.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, olivier.moysan@foss.st.com
Subject: Re: [PATCH -next 0/3] ASoC: stm32: Use devm_platform_get_and_ioremap_resource()
Date:   Thu, 17 Jun 2021 16:01:16 +0100
Message-Id: <162394075660.19104.17632705011154431628.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210617043847.1113092-1-yangyingliang@huawei.com>
References: <20210617043847.1113092-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 12:38:44 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.
> 
> Yang Yingliang (3):
>   ASoC: stm32: i2s: Use devm_platform_get_and_ioremap_resource()
>   ASoC: stm32: sai: Use devm_platform_get_and_ioremap_resource()
>   ASoC: stm32: spdifrx: Use devm_platform_get_and_ioremap_resource()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: stm32: i2s: Use devm_platform_get_and_ioremap_resource()
      commit: 2f1776691978dfab30717548ffec0f3fa4ad0981
[2/3] ASoC: stm32: sai: Use devm_platform_get_and_ioremap_resource()
      commit: 003ee640abaeeaa7d11f931e5bb86bdc4becb594
[3/3] ASoC: stm32: spdifrx: Use devm_platform_get_and_ioremap_resource()
      commit: f3babad47e0db3daec301975b46de5bfadc15dd4

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
