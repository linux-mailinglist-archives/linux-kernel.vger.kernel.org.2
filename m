Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7693AB6CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhFQPEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:04:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233072AbhFQPEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:04:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D674060C3E;
        Thu, 17 Jun 2021 15:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623942113;
        bh=CTtyfFQGWWovOtDS+qRZsuHugOAENWrHm4AEZc6unu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qxe1zkqKtDabjy+ZL2MWvHHi0JxpH/YBPg6BO59pdSrx7QfNxKwAvIrjYcCJ0tLFJ
         G0KLsmTFrDkPYSyficsVgAb84jqh50l50rEMUnDXjCKzDCQpm4KYhAkCIsHIEQIv+o
         6hJ+6jfcy3l/KBGXPdb6ld0Iinm9emyjhDPuY3MwLMQvCxP+Raqxrx3OQnKF2mTh3j
         VbUMrmojWEojC0LZzHaOCA1wQ0Z2JVCg9lilmo+BWp947YEen9B2Ektp/YkbaQlsWv
         wnhxTwxYeaeLXMuZuV3zXgjtCFtVxFcH7SWn30WTkQ4fZ5rEwh32buyBn1XnBRDbCL
         PR//6WMnqYX0A==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
Subject: Re: [PATCH -next] ASoC: spear: spdif_out: Use devm_platform_get_and_ioremap_resource()
Date:   Thu, 17 Jun 2021 16:01:17 +0100
Message-Id: <162394075659.19104.4524131228561652515.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210617032900.600124-1-yangyingliang@huawei.com>
References: <20210617032900.600124-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 11:29:00 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: spear: spdif_out: Use devm_platform_get_and_ioremap_resource()
      commit: 114bacc75c2189a6ed7ee208545e8d6777c94aec

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
