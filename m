Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A214387D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350829AbhERQe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350782AbhERQeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:34:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C85B561209;
        Tue, 18 May 2021 16:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621355567;
        bh=yYE3C83ZCcen1JqtN6SbUMBER9tKZM+sb+rFDEm69H0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mkVP+fRpjaBmmd34MdGpnv4vm3hnQRlibsdJCq6/jxAEqdFanLOI3Hi3rjjTgM8Ug
         yeGvtT8EGjrX9GbS7T/7U1gVYnwP9ry9T8LFxH1CaOm6fMURT5tuC7/YkGbEhzdOEE
         +wQY1AzmmIis8LFhHlTnLeYH7yF+trO81WnrdbPYxeQcx4XbTd/RgkmPVHmaYFyFub
         8+zus0zqjNjstug/1Z0WLujmXwwAcaZRNC533TE3PmhGmk0/QETmaRq4+MW9UYE2dS
         TGAYCYBhYJ3We+pqdL16dCsnYNnkeQ5+MHBqBaUg9/IY80592ZrF4Hb2YhPWeGPkzk
         3Ko0FL8v3tDEg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: hisilicon: fix missing clk_disable_unprepare() on error in hi6210_i2s_startup()
Date:   Tue, 18 May 2021 17:31:34 +0100
Message-Id: <162135531446.37831.10556462554575862274.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210518044514.607010-1-yangyingliang@huawei.com>
References: <20210518044514.607010-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021 12:45:14 +0800, Yang Yingliang wrote:
> After calling clk_prepare_enable(), clk_disable_unprepare() need
> be called when calling clk_set_rate() failed.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: hisilicon: fix missing clk_disable_unprepare() on error in hi6210_i2s_startup()
      commit: 375904e3931955fcf0a847f029b2492a117efc43

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
