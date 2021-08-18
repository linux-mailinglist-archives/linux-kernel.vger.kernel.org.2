Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3393F0911
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 18:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhHRQ1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 12:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229768AbhHRQ1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 12:27:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EC07610A3;
        Wed, 18 Aug 2021 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629304018;
        bh=t2YQMIO3pl9qf7snTp8+NtyRRuFjHQldlBMT/DHdfNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HZ8q6RYUJxPsrFhG7Emkq7SRKkm4IbmlIiS+QNGywCNrGqCyqbaYB1Rg4pObcKvyb
         fxp6csxcg1ogAiQyRi8Kb4b72R94hYXy4X1y8C+wyylZTUAfFJomtAOLddfoX/+eLO
         rgmVjZY8trDsVKRzs0bXTUaQo0SDF05R9BeBS+KkMlENmGQltGZo5aDbuD3gIKzMPS
         dFQ7Hqv1Rq8uc7HrQ7nxeo20mD3w12lqLCj48/ipW4igdcd38RNbCOi/UKQMdVcL7v
         uX6JQanTJ4aqypA124GCGdLEDlKhIRpcwUYjE9U5KOZcgHcuDK1350F+aAVoLzaqAu
         QZxmTgKoZneyQ==
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: Minor regulator documentation fixes.
Date:   Wed, 18 Aug 2021 17:26:31 +0100
Message-Id: <162930370018.11155.6461724137784637883.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210818041513.GA2408290@dc7vkhyh15000m40t6jht-3.rev.dnainternet.fi>
References: <20210818041513.GA2408290@dc7vkhyh15000m40t6jht-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2021 07:18:19 +0300, Matti Vaittinen wrote:
> The newly added regulator ramp-delay specifiers in regulator desc
> lacked the documentation. Add some. Also fix a typo.
> 
> 
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Minor regulator documentation fixes.
      commit: c049742fbc71129c481a6d5e52392b9aa482cc9e

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
