Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CAE3A6F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhFNT4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:56:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235350AbhFNT4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:56:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B0DB611CA;
        Mon, 14 Jun 2021 19:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700480;
        bh=OFqLWt9YcU2q5M/HjfpqEhWhcGqRS3yWcy7sAyaGMeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XXHHa4xq/Isu9+95fpnbyi2ZUuVcWVETqOU2y5lYYjop2Z0KMVbhP99crM0rdDsD0
         MmwcnZuz6xNJx8gLnUL3pkCyU4tHYbxoF2AP57ivb7ZUTvaKnJJXfkOtWKM8+gbnVc
         z9vnoM8eg9dpGInpzCPv0moeAhHkdqNPEfK7zZER93LoN5HgFN67rx9M9WKqq8Umfa
         D9QyOkL1yrYAk8h0i2owJypIHiSZ7qPegPaURJ3hYaLaMDtKbiTgoLV35d6zln1GRP
         Sfyk/nM9dKthDNMD0AmoOLGy4NsMvkl6C+RgK/L/ORbju9cSDjO2rGYFu+4hzAMsEr
         89swlSD9TdVSg==
From:   Mark Brown <broonie@kernel.org>
To:     timur@kernel.org, tiwai@suse.com, Zhongjun Tan <hbut_tan@163.com>,
        nicoleotsuka@gmail.com, shengjiu.wang@gmail.com,
        lgirdwood@gmail.com, festevam@gmail.com, perex@perex.cz,
        Xiubo.Lee@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Tan Zhongjun <tanzhongjun@yulong.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ASoC:fsl_spdif:Remove superfluous error message around platform_get_irq()
Date:   Mon, 14 Jun 2021 20:53:39 +0100
Message-Id: <162369994008.34524.18042209109927514476.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210610040037.1064-1-hbut_tan@163.com>
References: <20210610040037.1064-1-hbut_tan@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 12:00:37 +0800, Zhongjun Tan wrote:
> The platform_get_irq() prints error message telling that interrupt is
> missing, hence there is no need to duplicated that message.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC:fsl_spdif:Remove superfluous error message around platform_get_irq()
      commit: 2e8a8adb96a335a04f1697dd4314f5569521328f

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
