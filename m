Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6FF41B3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241790AbhI1QZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241814AbhI1QZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:25:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D83E460462;
        Tue, 28 Sep 2021 16:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632846245;
        bh=0O6L4H/cextfv26B46FKY+zqtsTMb2PqJijiEx87F6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDO+sk4Wwji7L2scdsEF3f+WFkOFCFOl1U7q9vzm9NWJ8IcF8oRBCXgOfpUb55lr+
         mmGBEPM07EZ0ys049J7VAom4eUh/Zz9ioqlLiv6aOdW0O7N0qvmUZD18ASME+sDy4p
         sn52BtG5hwI30SIi4FNxviuCW/+7thKPUh1+nGjKq7osK7FCV0L56S5G95/bwa3YUv
         XQgty2j9FjApH/4+SYIfcTcn6A79FGhjvfKfTxYzIxvIw8yuikUUxXOciRA/nwe1WY
         psNywYARIBft7yYaavzV9HHO3u5yFSq+AIbmfbxI2lKCoSqWyJDcioUBwXsD0NmpOy
         ZyHsP2zkDFoyA==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, Trevor Wu <trevor.wu@mediatek.com>,
        matthias.bgg@gmail.com
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, bicycle.tsai@mediatek.com,
        cuibixuan@huawei.com
Subject: Re: [PATCH] ASoC: mediatek: mt8195: add missing of_node_put in probe
Date:   Tue, 28 Sep 2021 17:23:02 +0100
Message-Id: <163284573552.17390.11297095158911786787.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210928063520.23927-1-trevor.wu@mediatek.com>
References: <20210928063520.23927-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021 14:35:20 +0800, Trevor Wu wrote:
> dp node and hdmi node are retrieved from of_parse_phandle(), so using
> of_node_put() on them before return.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: add missing of_node_put in probe
      commit: b05cfb1215223a750cff5367b625f0ed285a36cf

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
