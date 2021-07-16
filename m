Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BAD3CB95B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 17:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbhGPPJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 11:09:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236673AbhGPPJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 11:09:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8C6C613BB;
        Fri, 16 Jul 2021 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626447970;
        bh=Ng9aXIpcrMEQTWqACJH4fgSVmzieQSPALIVV2r5pRGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=loFdi4GdZF5zuYC3nCxhNOKLyU3Lpf3Yo5sLk8rWaVaE3KI/2GOmrxTK3QUuMv0xi
         GUDR4P6mJBxHSbuvaogIoY3Ibjiqt7nnKS9wOJp1q13Gzsts6X2ii6EqOdp7a0OJ/U
         mhsWARCLZdy9+VmH3zJrNk4/2AVtxfZn5gu7Pu07NKcuIW9eZZLFg7brUvhrdCsCic
         XPHEBtaPYR/RZuuoSOhcz01tmOB7IUg/JdTfgwPC0FMFM2lmm3Bb7fk3FGS1mAkqvt
         28BrrI6zfNlLtHzsoPUYze/7RHXRBE0MifsrrabTMrQN3CgaBFf+5BYKiJGTtuP/kC
         hRNVN7Q9zY2VA==
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, ChiYuan Huang <cy_huang@richtek.com>,
        axel.lin@ingics.com
Subject: Re: [PATCH] regulator: rtq6752: fix reg reset behavior
Date:   Fri, 16 Jul 2021 16:05:28 +0100
Message-Id: <162644777059.26191.15104652877216907814.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1626407746-23156-1-git-send-email-u0084500@gmail.com>
References: <1626407746-23156-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 11:55:46 +0800, cy_huang wrote:
> Reg will be reset in below two conditions.
> 1. 'Enable' pin from H to L.
> 2. Both PAVDD and NAVDD are all disabled.
> 
> And 'Enable' pin also control i2c communication capability.
> 
> This patch is to Seperate the if condition in enable/disable callback for
> reg cache manipulation.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rtq6752: fix reg reset behavior
      commit: 513d14045a2dad0bf202b7d4c07a2ca2afdba0b4

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
