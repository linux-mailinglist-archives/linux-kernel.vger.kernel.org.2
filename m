Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8593DBEA8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 21:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhG3TDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 15:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230402AbhG3TDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 15:03:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10BB760F46;
        Fri, 30 Jul 2021 19:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627671829;
        bh=GhWE25+yCEhTEp+MXI2OMcrQW+jnObSx+a/YkeinVt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQyzSCjL4oRKIsWKtvtvtep1IV2x3nwWfuSQLlr8RgKvUo4ijMInDrELmcMmJr1Rz
         v9GdsAzKEH5IC96rCi184SVbQFUqCL18dTNIXYDbU+kx4FVyeMWK1c/MUmXnDVCKGh
         f97fxXKG94Mzymo/nAXg6TsnqU2429zBS97MkH8hEMtIOzm2M933Ki6e4h1YunGmyU
         MXB9uaWUyEq6UPrYgxqiuGMMZ1T+iSM19lK9iA0jhnVxh4OHbERJK49+p6pYBQzmbs
         5zolvEMH1Y1Ztt845HM+a1uWepi/8htA2OdhoimaF5eyEGuczKp3jFGNnpgcoEJTN+
         JvxkisRoDYN1g==
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, cy_huang@richtek.com
Subject: Re: [PATCH] regulator: rtq2134: Fix coding style
Date:   Fri, 30 Jul 2021 20:03:33 +0100
Message-Id: <162767162449.56591.7985276191949312287.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1627648326-5026-1-git-send-email-u0084500@gmail.com>
References: <1627648326-5026-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2021 20:32:06 +0800, cy_huang wrote:
> Add empty space and put constant number to the right side for 'if' judgement.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rtq2134: Fix coding style
      commit: 15b4d2b972014b789f22d9267bcff1cc48153738

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
