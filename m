Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E01E38E605
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhEXMCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:02:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232802AbhEXMBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:01:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E094D61248;
        Mon, 24 May 2021 12:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621857622;
        bh=x1+yfQ/x/dnpuVfnWYMZ1QGFU5oPJMBLUnB8EGfo8h0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fub7k2kh+wUipBSLgC3yAkYAVHxG6OWVtUYegG2b6HkUBITvdssoxMqHK90zO2TcU
         ZbcIk9DLgOcrjy4mVzg8Ux9ibcnNDVoTsW0oczyXHvzxDIznwYuzUZRye98ar7+wlm
         fnanbWxwFx4rMItloAMNpDwOpK93tUxQKsi9vMTfEW15/QmV/Roh51W/IBNEc/CPC6
         g2BVbF5SzVPhMiVV0SFET2a6H3EXSYW5L0Kq292BS2ZIGpVsz2I4tIO6n7byCweWFO
         eQpihFqQgl4fWpIPXrcW+unIIsfseFPk8y3UcZR+IY1VAeWrayyVm9bUuMso1Mvkdv
         9TdYsdgPOq3WA==
From:   Mark Brown <broonie@kernel.org>
To:     Hao Fang <fanghao11@huawei.com>, puck.chen@hisilicon.com,
        guodong.xu@linaro.org, lgirdwood@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        prime.zeng@hisilicon.com
Subject: Re: [PATCH] regulator: hisilicon: use the correct HiSilicon copyright
Date:   Mon, 24 May 2021 12:59:53 +0100
Message-Id: <162185754506.49496.2821074398186362162.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1621679151-15617-1-git-send-email-fanghao11@huawei.com>
References: <1621679151-15617-1-git-send-email-fanghao11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 May 2021 18:25:51 +0800, Hao Fang wrote:
> s/Hisilicon/HiSilicon/.
> It should use capital S, according to the official website
> https://www.hisilicon.com/en.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: hisilicon: use the correct HiSilicon copyright
      commit: 8d6ee30c11a95f84974c2d7f590a7012f27b8f15

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
