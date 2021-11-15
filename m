Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF59E451C77
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356654AbhKPASd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:18:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355339AbhKOXlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 18:41:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D0C861B2A;
        Mon, 15 Nov 2021 23:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637019316;
        bh=/i1ppCc2i7+tsF2CovjUzUtrnyP5QUyPtkBbVkKtfnA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tjt1k4N/MzsgGFUe1f5DoqujbzQG4fF5KSsegolZ13kRWMBlfyhNBCjVD+YKaRqKY
         mEBYeG9OLNmwPJLPz93CsQNw1mZgZxnWiv0JqS+SMrZmJdiPyhiNWm8Dp2ImRdTRiB
         TemLWlUxOJqDVMXq9ZbskY0sBL2URe+vdyGJM4GPO+0WVEH9FSRlFBvka/wya0HXEk
         bDOdnzHnCUFWe9NDFibB6xUuCUXEjmcLGPC7TmJdYl8eeQ8K7L5loZTe+orLdJq4M/
         I9/XHLLbiAcZKBbyB7bsSwRsLsia1MBgS9Hqi5jDd1jINJTfxk2AOTv41+pLp4b+8G
         x/7HiQCcEd9yQ==
From:   Mark Brown <broonie@kernel.org>
To:     Simon Trimmer <simont@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com
In-Reply-To: <20211115120215.56824-1-simont@opensource.cirrus.com>
References: <20211115120215.56824-1-simont@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cs_dsp: tidy includes in cs_dsp.c and cs_dsp.h
Message-Id: <163701931525.675370.12192297791993296544.b4-ty@kernel.org>
Date:   Mon, 15 Nov 2021 23:35:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 12:02:15 +0000, Simon Trimmer wrote:
> This patch removes unused included header files and moves others into
> cs_dsp.h to ensure that types referenced in the header file are properly
> described to prevent compiler warnings.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cs_dsp: tidy includes in cs_dsp.c and cs_dsp.h
      commit: 749303055b78bc38ec0790ccc596cae235446367

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
