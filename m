Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACA03C5AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhGLKui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234231AbhGLKuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:50:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DE4761106;
        Mon, 12 Jul 2021 10:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086832;
        bh=aG/LoA6/Vk90nA8XXp1zTMNEBK2UxUpaR3cQWgczELo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vB0Im2iQepR6UJzSJcdY2myRVT1Iv76jmQBa7H3HsWxokcxvQSEO+Ja6jrrP7jYsm
         XYAsCH9g71RWw9Skia4QVuUON4IgdhfWbU2EFSStq35ZRdkRaLyMXfeT4hG0hq6lIt
         gK7C8bTbLVako0H3aakuhWdTy6nVXRWBzoskG8hZnRscFnSw7hcwiuJumUsmN/XFhh
         q3eTZPp7Q4jOzc9y2lY0i6X15LMXLYc8bs9Ftn+dxYTLrkaNnasdfOViBIDUZRc4Bi
         1EvN0M/K/4lI/RiAT8vgMAgEfEQ7Z2ySyLb/zHDz3lvYPaKd1c65LuwghbjGiJNbID
         5Zpsp55jj+jXg==
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: bd718x7: Suopport configuring UVP/OVP state
Date:   Mon, 12 Jul 2021 11:45:47 +0100
Message-Id: <162608654079.4419.9645634631307763759.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210705105416.GA1189560@localhost.localdomain>
References: <20210705105416.GA1189560@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jul 2021 13:54:33 +0300, Matti Vaittinen wrote:
> The ROHM BD71837/47/50/78 do support enabling/disabling the under/over
> voltage protection. Add support for enabling/disabling the protection
> according to the device-tree information.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd718x7: Suopport configuring UVP/OVP state
      commit: fedbfea13cc0e513956abfa5c22158f0523d5687

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
