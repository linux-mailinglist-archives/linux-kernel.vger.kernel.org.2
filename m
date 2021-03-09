Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5801D332EB6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhCITIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:08:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230173AbhCITHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:07:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 548BE6523B;
        Tue,  9 Mar 2021 19:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615316860;
        bh=hwkOb9GSNa4+vO3k/+jgdbf0VkBnReZAqNBE9CLOGRM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=U5LFJGLXFzlSiypYuDxkGO83uvFm3APTKwrbvISYEuhQUKgIBK0tOAlMHFQd34d62
         g7vy5pq4uW2hMEcxidcmOOwbVSmjszJPx18i1RiiJvmqdzgROr2ACj/iaWZmMuSnCX
         XvM8td4KuJhS2zyCY5q6QyISvwbfARKTgpuUq1iOxWpDwoobMjUKtLusr7pcDTBoR5
         e7lnIASzNfE8IgxUGEbPbxTTkfzB24dOxdVL3af1NCTAFHI55NxiSXMt4YWzHWVECH
         NdyXLPs81JM8nqmirXxKlWYKAactevs0+Nsqq5mcIGIoWCUHgiLF/mb1Kn95DaULDi
         E07biXA1s1+MQ==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, amit.pundir@linaro.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com
In-Reply-To: <20210309142129.14182-1-srinivas.kandagatla@linaro.org>
References: <20210309142129.14182-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 0/3] ASoC: sdm845: array out of bound issues
Message-Id: <161531678411.49117.14765657958455012863.b4-ty@kernel.org>
Date:   Tue, 09 Mar 2021 19:06:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2021 14:21:26 +0000, Srinivas Kandagatla wrote:
> During testing John Stultz and Amit reported few array our bound issues
> after enabling bound sanitizer
> 
> This patch series attempts to fix those!
> 
> changes since v1:
> 	- make sure the wcd is not de-referenced without intialization
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: qcom: sdm845: Fix array out of bounds access
      commit: a5fd5e475655d3830f376e29ca6a7222dc7074cf
[2/3] ASoC: qcom: sdm845: Fix array out of range on rx slim channels
      commit: 3ed85d1e1aa53db6fa4398846fbd213a7d87ceac
[3/3] ASoC: codecs: wcd934x: add a sanity check in set channel map
      commit: 480c25e7003d0222f64824d4c7afcd274bc66ebd

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
