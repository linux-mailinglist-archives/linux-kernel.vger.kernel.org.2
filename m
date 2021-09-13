Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F43408976
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 12:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbhIMKzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 06:55:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238681AbhIMKzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 06:55:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B4C261029;
        Mon, 13 Sep 2021 10:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631530463;
        bh=DHpOSI/Sbc939fySmHxI4IDvfDGcKODzSvP7VQTX05A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rrRATTb4XGfH9IeTJFoXD/EzCGmDKW7YjtbkfNvUDafa4NWpHaqE8h8ARxKigEces
         XAdUKKxdO1eGeL1t+ibk4UXn510X6QenPI66nIfZCEYHD0tBUouK7iUmNwA91KUruA
         Vd+JoDcUBe0/dn9n1fDyscvYrXF7C052sxpkiegCDnAR2tiL7MXi2Fa8ZOyEgeubxs
         5WiojTRblxFMq6/nQ+RPf0577InNXuLAV+3xvAat7YJ1LHGmo2GSdHAVPNRvwGCj86
         ofgvO8M1IdCiY8CtJUyK0ycXXPQehTCmqvD42gZklKCr8EuaWySrP7up1vINuG2+mD
         97oQ82IodDO1Q==
From:   Mark Brown <broonie@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: ti-abb: Make use of the helper function devm_ioremap related
Date:   Mon, 13 Sep 2021 11:53:10 +0100
Message-Id: <163153010300.45871.15102808478461804700.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210908105745.1984-1-caihuoqing@baidu.com>
References: <20210908105745.1984-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2021 18:57:44 +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap/devm_ioremap_resource()
> separately
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: ti-abb: Make use of the helper function devm_ioremap related
      commit: b36c6b1887ffc6b58b556120bfbd511880515247

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
