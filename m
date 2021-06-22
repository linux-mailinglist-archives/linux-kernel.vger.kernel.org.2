Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F5E3B086E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhFVPRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232170AbhFVPRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:17:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1596160BD3;
        Tue, 22 Jun 2021 15:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624374889;
        bh=36Q0EN0ywk76JIdsYkkzUNCRAO4ZEj+9BRi8a7OzxJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PeAP168UjSx0B9yS1cwdCOXE5zbBuEQ4ShXRWcNdj837L7TNrtpyd82VN9BgasD+L
         Zsr5uUyW9q31vyX9tIUvSDGyxdmD2ehdAOh+Il3ABRFtLxMnDWtW8bV9kdoKNwP6zl
         RvolsX0QT2/9yDMTYj/TduB0ZANH4/uBcRZZI3KWUDT/CMfLWyAO/wl5yitL/YRUNy
         6Xu2+C2QmG54LhG3bhEX1eWtdJngawwLTWyXf/xQiCoZ+Ci4tzOrEFZ2n5QFzu6IjC
         DI4U/c1gG6MMp87FKpYQkoT7jRvloSdklwAk8Dn10Wd60QlnNy5ibx0BMlRzghNU3+
         dEuqf1NBtWnTA==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com
Subject: Re: [PATCH -next] ASoC: SOF: imx: Add missing of_node_put() in imx8_probe()
Date:   Tue, 22 Jun 2021 16:14:08 +0100
Message-Id: <162437355278.1773.16960158765626979060.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210617032756.599359-1-yangyingliang@huawei.com>
References: <20210617032756.599359-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 11:27:56 +0800, Yang Yingliang wrote:
> This node pointer is returned by of_parse_phandle() with refcount
> incremented in this function. of_node_put() on it before exiting
> this function.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: imx: Add missing of_node_put() in imx8_probe()
      commit: 0ba0f44fd516b34c9f40cd82fd480705d0f378dc

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
