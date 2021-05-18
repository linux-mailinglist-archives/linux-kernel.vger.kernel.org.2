Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B797C387D98
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350757AbhERQd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350740AbhERQdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:33:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8883B611CE;
        Tue, 18 May 2021 16:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621355552;
        bh=EzEVnm2Y5CunIGaLAh4VqbVByFAoFKrDnoSTa9kXYGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TounrEgTTWjYTQedosCjwN49rMPr8Jvg90PdNXQ7U+qxKbbjRLfhUnerplCLHZ4XV
         aDwIrN6N+wbgPj/qYXbMtW8WoBzhL7kmmReXVIfuvCAHWgF38grrCWbB/kEPcNR8ED
         uH6w4/ircgd2M3kLOcJlNOQlwpyUpE931vmxwz0Rvo/pRXHRFw4bELv0W/Pw7mPddg
         r/qs+RIj3hK09rXmw+Lkt/HQPlxO5xcuJPoSakbxqDAnOD7V/aEFHRqFMLM8DqUJes
         UFcGhA1GZiru8B/Gl8T+33k/zuILprXKX3L4tvxXOXqqYxlw0GcFnPA95tzX/fDfVK
         d1LPC1XtZYJSg==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH] regulator: bd71815: Fix missing include files
Date:   Tue, 18 May 2021 17:31:30 +0100
Message-Id: <162135540357.37947.10342032964730109695.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210518114843.1495152-1-axel.lin@ingics.com>
References: <20210518114843.1495152-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021 19:48:43 +0800, Axel Lin wrote:
> Include linux/of.h and linux/gpio/consumer.h to fix below errors:
> error: implicit declaration of function ‘of_match_ptr’
> error: implicit declaration of function ‘devm_gpiod_get_from_of_node’

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd71815: Fix missing include files
      commit: 3799fa23afa4cac347739d5290df44a474a82a82

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
