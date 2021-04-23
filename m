Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5D83698CF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhDWSH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:07:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhDWSHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:07:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02A3760241;
        Fri, 23 Apr 2021 18:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619201208;
        bh=mt8xzBNFIiy8EM+Iw03Waf263vHIN+QILutR/5xyMCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DMVTyIlUIAP3D/r8LDQYhLnWTT1DmFrqn10JxurGwqd42vHLEG0rqhBr8aziRHZxu
         CFL15ekSQqqA2fEl85wrm6oHyDEEh8ASxwE30X8rkMpSO8KX7/cNUf24xLMXgFJg04
         NtpM51R/uPBKU3QzHoKJET22LFhSMYmGPTOKfX4ThlR1DChf7tdUaRQJp3yukRX8ev
         VQ5n3eetibuE/hDEmJQL9VzYzGSEIrL7b1oMVu5UPPLORIUBek2YwUhXY+3jG6KD+e
         DnrUo8+I5P7ikwsDG2QGxd8yqy8SssSNT4eyD0uwC3FTaAytm0vHQDAE3ZOc/P5Fp5
         ohDaeogndt7Zw==
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel@axis.com, guodong.xu@linaro.org
Subject: Re: [PATCH] regulator: core: Fix off_on_delay handling
Date:   Fri, 23 Apr 2021 19:06:16 +0100
Message-Id: <161920103666.15429.14029390761495428957.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210423114524.26414-1-vincent.whitchurch@axis.com>
References: <20210423114524.26414-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2021 13:45:24 +0200, Vincent Whitchurch wrote:
> The jiffies-based off_on_delay implementation has a couple of problems
> that cause it to sometimes not actually delay for the required time:
> 
>  (1) If, for example, the off_on_delay time is equivalent to one jiffy,
>      and the ->last_off_jiffy is set just before a new jiffy starts,
>      then _regulator_do_enable() does not wait at all since it checks
>      using time_before().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Fix off_on_delay handling
      commit: a8ce7bd89689997537dd22dcbced46cf23dc19da

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
