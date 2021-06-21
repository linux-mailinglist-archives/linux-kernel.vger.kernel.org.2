Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4A33AF578
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhFUStj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232170AbhFUSte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:49:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37B7C61353;
        Mon, 21 Jun 2021 18:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624301239;
        bh=/OILYFrNI8JuScLMPbDFllbR2pKC/ijN5T2alXtxSbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sy3m5mpOG+Bq50cPcVUbpAuPlIwb+Q+vY9yBP80r26VUHZKOcTikj4t+Y/LeAElNH
         YOzGUi+LMQohxt8f1A/mimRX3aXX6Wypf99esEvQ1UGHM0hk07S72+TurhbTvNJkXo
         YRn8VHztouweUnditVvAQDRte2ZIgKVl5SrKOyS9yZnSl+xWO7zGArS2UvXhkIJgiB
         x/l/jIcKZTqDxEr4xRgx21xmmGlDpwbws1lkIovQcRk0M/ZFADOINalUNXlHszjBFE
         UQpyCM7n4lZrlz4YweBaAYCW180zjkvVFQuglSfXMfoYWCKpxUWMrInqbGrkP9FOzd
         ou9awOl8rpYLg==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com
Subject: Re: [PATCH -next 0/4] ASoC: samsung: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 21 Jun 2021 19:46:07 +0100
Message-Id: <162430055264.9224.5838866943547505866.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210616091652.2552927-1-yangyingliang@huawei.com>
References: <20210616091652.2552927-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 17:16:48 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.
> 
> Yang Yingliang (4):
>   ASoC: samsung: i2s: Use devm_platform_get_and_ioremap_resource()
>   ASoC: samsung: pcm: Use devm_platform_get_and_ioremap_resource()
>   ASoC: samsung: s3c2412-i2s: Use
>     devm_platform_get_and_ioremap_resource()
>   ASoC: samsung: s3c24xx-i2s: Use
>     devm_platform_get_and_ioremap_resource()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: samsung: i2s: Use devm_platform_get_and_ioremap_resource()
      commit: 5eb8262c686509ffb60a5b04ca6ee562f02cbaf5
[2/4] ASoC: samsung: pcm: Use devm_platform_get_and_ioremap_resource()
      commit: c3255553d6b6cd5c8de42d2faa80e1d33401cb3b
[3/4] ASoC: samsung: s3c2412-i2s: Use devm_platform_get_and_ioremap_resource()
      commit: 87a32d00249e6e3c6b1ac020d36136b2cd75fcc8
[4/4] ASoC: samsung: s3c24xx-i2s: Use devm_platform_get_and_ioremap_resource()
      commit: b73cbd7b1c2d477d143c544bdc2b3415bae58a14

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
