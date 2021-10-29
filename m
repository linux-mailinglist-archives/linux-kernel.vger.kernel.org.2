Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAD343FF55
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 17:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhJ2PXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 11:23:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhJ2PXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 11:23:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB2EA6115B;
        Fri, 29 Oct 2021 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635520841;
        bh=rOheY0c4ksMLoID1zAZkXiKjzdta0g5IXspWnZj9+aw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ncmkwINq4yXDj8JbMwe0rb1GxUNShaIosYOwDlbvDQ1dsBN8ORnXDmF6zrzj09mbr
         3goaBSZa0giEDVLGem5J8Z2IV1YDRSCwfU39fs6l9rCpvnXjxjV6uQY//NNskkcK7h
         k6SYbLO6cAlGHgKprHUT0tHjvkuiWs2gfWLsS8Dr7N7prGPFWnGQNffmc+DHHl/fQz
         G7I8SkdbrvSgAcsMvGSAfPc2TI1nLCLFhnuVzg8riqpc7rqkiuBOsPTYLczDLNx1mw
         DNvU1RrQvX697Fgxk/6Q9oRh1V9/y/nH3/IP98/Dc0FIZ7jjUigD99jblgKlY7bgUQ
         1Z7o6N3jlpTXw==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, Vincent Knecht <vincent.knecht@mailoo.org>,
        lgirdwood@gmail.com, robh+dt@kernel.org, tiwai@suse.com,
        stephan@gerhold.net
Cc:     devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211024085840.1536438-1-vincent.knecht@mailoo.org>
References: <20211024085840.1536438-1-vincent.knecht@mailoo.org>
Subject: Re: (subset) [PATCH v1 0/4] Add tfa9897 speaker/receiver modes switching
Message-Id: <163552083943.187214.842641047380618790.b4-ty@kernel.org>
Date:   Fri, 29 Oct 2021 16:20:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2021 10:58:36 +0200, Vincent Knecht wrote:
> Two tfa9897 are used in tandem on some devices (eg. alcatel-idol347)
> to drive two speakers, for both receiver (earpiece) and speaker modes.
> 
> This series:
> 1. adds a control to allow enabling only one tfa9897/speaker
>    (for the typical phone-call usecase)
> 2. adds a control to switch between speaker and receiver modes
> 3. adds support for an optional gpio also used to switch modes
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/4] ASoC: codecs: tfa989x: Add support for tfa9897 RCV bit
      commit: b6a4e209fb7da1b49cb72fedb405f90e485d5a48

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
