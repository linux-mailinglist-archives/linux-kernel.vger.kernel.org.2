Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B663AB6C0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhFQPDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232943AbhFQPDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:03:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C01AE60C3E;
        Thu, 17 Jun 2021 15:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623942104;
        bh=NK0hn3vw5IKcdns+8rADQfTxpAK7UdjTsHCh/B4bILA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hHuMLbzUhQZbegtkzsLAxghPUBYwDlNPx/Mgbujp25Pc9qfz6uf4XHbFgCBbBaEsY
         IAQGUcoR3E8nzCvgJRUeCegbuIrjgctFpf/baqOQM/nwG/n9M96LAFDwWt2RERH2Ve
         oeI1RUL/3MEZA7otr+8zMIY1kVTaVtIerXdnG2jbQbTImvPPiHDaYpyjcNHc0z2cri
         YqbzqE4Z36kbPArEE6sVpKQPmqPHPoODh44aWp8oL8d+W1etwZVyuiJW/avmFX60X+
         D9xS3b5euA7e0IlSsVSnShxYSKYi4dGbnR7j4Cy1dxOEsMK8S9m2ywMZkm8FlqfWyS
         p612Q6qWPQfTg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
Subject: Re: [PATCH -next] ASoC: sprd: Use devm_platform_get_and_ioremap_resource()
Date:   Thu, 17 Jun 2021 16:01:14 +0100
Message-Id: <162394075659.19104.18167768597198191135.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210617033237.605808-1-yangyingliang@huawei.com>
References: <20210617033237.605808-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 11:32:37 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sprd: Use devm_platform_get_and_ioremap_resource()
      commit: 19b71456f3684f8dba078619a31afab05ee47c3a

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
