Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFE93A8787
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFORby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbhFORbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:31:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BB7D613FA;
        Tue, 15 Jun 2021 17:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623778188;
        bh=GEAwyVbCu9FzP4tJk0ycazZjAaockIItbW1zOcgtnD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eX1MFs5SdRZYdboOArHyCe3KH+hld9wSZdB6J9XsMl//rcSw/eheZf04JLhr+JzBo
         smRhD2+nsvraIGjpvAlWC24r381xwFlFL/00BduN8OOcPRVCoB93VVEy4lh+pquCTk
         ZWziAgcGx57J0mf+acJuobuCaRlq3ecc9qcDKGXirKp9KngvF34rju4CRPnZ0oEu5A
         QMjMBCqdqzHif1R5jLXGHQg+0edA0LeWBCfVgci2sQOsRHoulsZgaIHSCTA6szTDun
         tyABhZE4caX7WdvDpDv71jqYaWSvaNDHU8COul+I5JMlxeiHs1uI+1iUdI+dbChB/G
         eyu/DIPvmXnSA==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
Subject: Re: [PATCH -next] ASoC: hisilicon: Use devm_platform_get_and_ioremap_resource()
Date:   Tue, 15 Jun 2021 18:29:18 +0100
Message-Id: <162377763944.21612.17506249147724784597.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210615133515.1376290-1-yangyingliang@huawei.com>
References: <20210615133515.1376290-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 21:35:15 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: hisilicon: Use devm_platform_get_and_ioremap_resource()
      commit: afc3a0b4c408b00787d60225e6d667e1e6f93b6a

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
