Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6CD37EB75
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380486AbhELTbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343655AbhELRGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:06:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A46761285;
        Wed, 12 May 2021 17:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620839135;
        bh=ysl0rabFnR2vVlj0XTus2IyiukYHpN/haQ+NeJhNQ5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AzgG6iBTFAAMpt+u9/YbTvFA1pLTvw2/Mf2EinGCBIHqwlhmowa+dYF6awgLNk53r
         vbRWgocpidJ73CWwnxoYGrOgiLDMmVZHkocGQ/nGWB4DLsvXlZHQbK2avYp2fY+KCt
         PdGIcxJV0CkZCf5yhAfz1o0SYcrfPZfvMAIF+CB6pS4muYW3wJOIBocqd/CF/Hx5a3
         qfG2QenAlg+xhtY1tyOiuePOVrtJgWkX2AbGiTR53o5DmOAg9fXiBvn+o4JneqLaYQ
         p4p1GZpDok7nqDP/8gGq0Dkl3ifmZLCUf07eEM3+uL2dqQuq+HuUEoeDJsuyIexLWK
         k2E+AVopULbZw==
From:   Mark Brown <broonie@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH 0/3] regulator: fan53555: tcs4525 fix and cleanup
Date:   Wed, 12 May 2021 18:04:40 +0100
Message-Id: <162083902381.44966.4390626020202703159.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210511211335.2935163-1-pgwipeout@gmail.com>
References: <20210511211335.2935163-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 17:13:32 -0400, Peter Geis wrote:
> The tcs4525 voltage calculation is incorrect, which leads to a deadlock
> on the rk3566-quartz64 board when loading cpufreq.
> Fix the voltage calculation to correct the deadlock.
> While we are at it, add a safety check and clean up the function names
> to be more accurate.
> 
> Peter Geis (3):
>   regulator: fan53555: fix TCS4525 voltage calulation
>   regulator: fan53555: only bind tcs4525 to correct chip id
>   regulator: fan53555: fix tcs4525 function names
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: fan53555: fix TCS4525 voltage calulation
      commit: f8c8871f5eff3981eeb13421aca2c1cfda4a5204
[2/3] regulator: fan53555: only bind tcs4525 to correct chip id
      commit: f9028dcdf589f4ab528372088623aa4e8d324df2
[3/3] regulator: fan53555: fix tcs4525 function names
      commit: b3cc8ec04f50d9c860534fe4e3617a8d10ed9ea9

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
