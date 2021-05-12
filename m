Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3F037EB77
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380528AbhELTb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241546AbhELRIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:08:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 019B0613C5;
        Wed, 12 May 2021 17:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620839141;
        bh=uR97iHT9TbuhNgLA0XIv+lafc7LtNZqRCCX/bATyQXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y8Nf+/tQc9Nbr79TcfA7g44QxHgGX0xoGTJV96qJY2CiHAC6nIKrY3Yx/KXlIl4N0
         hzFwT0baEKJTlK5J7pecvrl4NPWHlC8+FinZoeNYKinIY2xG4vEvL3zoZ2bEJCB/VL
         kLN30P9Gd6IZlvRO7Vl3cpAHhsquAZj94UbVyZrNXD/eMUign/HSkpLVzXFiWl4xKP
         cd8mKXRysXwUAJiSfOH1/Zfva5UFbkXRDOD0S6h6yvb7alNxZdLhAth4UAcpSrfTPK
         SlP/N6h1FQ0ZlwAJ8wVe2yzgzF+GMBBKkvk9Q3tyO8xrXk0+mQDle8cjkg/erVACYK
         rpVfCn/KHOfLA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Zou Wei <zou_wei@huawei.com>, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, perex@perex.cz
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH -next] ASoC: sti-sas: add missing MODULE_DEVICE_TABLE
Date:   Wed, 12 May 2021 18:04:42 +0100
Message-Id: <162083892846.44734.8935371254397073723.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1620789145-14936-1-git-send-email-zou_wei@huawei.com>
References: <1620789145-14936-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 11:12:25 +0800, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sti-sas: add missing MODULE_DEVICE_TABLE
      commit: e072b2671606c77538d6a4dd5dda80b508cb4816

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
