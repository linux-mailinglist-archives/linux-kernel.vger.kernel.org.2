Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781C641F8A1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 02:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhJBASq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 20:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232406AbhJBASi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 20:18:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6CEE61ACE;
        Sat,  2 Oct 2021 00:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633133812;
        bh=SqkMJsnkHZDT+eZzsrisFKTL2JeLsdSMMioQ/miBr24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V+GLco18UbSCDYlixqfJ9E5tda0Fa/sW5GEE6hFZwJnfxEfOUVMC9i5tm3nE8tW5d
         de6aoIagpe8OLsXHUlTfV1lYmvS1rvszVC8BP6oHp7XDwF4T+XMEOQPOI79Y/lpf//
         2+EFtyujN+k52GqtZ03Vd4uo4KfWYJKf8++qJeiaMvrfQ5attEOXoocz3R9BcEGYRw
         k2pWIh7XAvSVUPO3qbywCECoobcJGiSSZBz4Lzy6WhruFBjFg/guTQb/Fj5b14tJ6X
         C5XpJzVz/WsO7HF8nUIXbQYNWa0MvSPqiC+Ha+1PYliM/ox9LCx4hoyZXiJ6J6/vOW
         Zdt+3LfuHF89Q==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, Trevor Wu <trevor.wu@mediatek.com>,
        matthias.bgg@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        bicycle.tsai@mediatek.com
Subject: Re: [PATCH] ASoC: mediatek: mt8195: move of_node_put to remove function
Date:   Sat,  2 Oct 2021 01:16:27 +0100
Message-Id: <163313339131.45396.13424331817826400710.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001031601.3953-1-trevor.wu@mediatek.com>
References: <20211001031601.3953-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2021 11:16:01 +0800, Trevor Wu wrote:
> platforms->of_node and codes->of_node are assigned in probe function,
> and of_node_put is called at the end of probe function, because of_node
> seems to be not used after probe functon
> 
> In this patch, of_node_put is moved to platform remove function in case
> of_node is used at any occasions after probe function in the future.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: move of_node_put to remove function
      commit: bd8bec1408ab2336939bd69d93897bf19d0325ed

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
