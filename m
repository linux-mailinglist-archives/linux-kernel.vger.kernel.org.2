Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F7839AA48
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFCSof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:44:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230228AbhFCSob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:44:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EBB2613F3;
        Thu,  3 Jun 2021 18:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622745765;
        bh=GhUoIYDT2+6mvi67sODfFs97OBasUrnp9SlBcsnTRSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u7jAbMYyaOMM8ndU8gUi4WuGQ+xUTqzey/1xrIfK0KcGVZUoxjIiGaat5aO7xqncV
         AP48nxhzCh7x/iVQTD6ufcl27PXanm96C78llq/pGQJ4zxiueTHGEav1uNPDRDjk3a
         obw8rkAC4l4knUwKveI4G2zp0x6mY4lt/1O/ZLqKWdXlmh/MxAbt919NOPjA5BPO+3
         ZmDlfIgzvOf7LisPQTvZ9ctsnOSlnjY32ZLEFEpxJu+eaktYPMm6IKsj69pC4lpQlk
         n3OxmcCFRakFZfsqI5I+/qJhcn6q7vF913N4mS+EZUyQtZ9HqZzm60w5Vcgj/Wdhj0
         yFrJBw79M7nHA==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] ASoC: atmel: sam9x5_wm8731: use devm_snd_soc_register_card()
Date:   Thu,  3 Jun 2021 19:41:55 +0100
Message-Id: <162274557552.14795.196997960787318113.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210602141619.323286-1-yangyingliang@huawei.com>
References: <20210602141619.323286-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 22:16:19 +0800, Yang Yingliang wrote:
> Using devm_snd_soc_register_card() can make the code
> shorter and cleaner.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: sam9x5_wm8731: use devm_snd_soc_register_card()
      commit: 6522a8486c00d130a32a57c6c8a365572958b4df

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
