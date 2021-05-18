Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7DC387D97
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350751AbhERQdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350739AbhERQdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:33:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8B26611AD;
        Tue, 18 May 2021 16:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621355549;
        bh=/alZ/eY/uSw2vc0DTVTaTtc0iIV5WKMkyrUowvbP5/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhfvdhMWo7G3uKHRugTcAuSZ+bKX2O6SHwzXiWGjA1z7Y0x/uqaHaELtPG3H1wLAl
         IXHmRB+jAva21Wb1jUOK+KtgozTBOXWfYNGdV8lybgvbg2GGesvC3laAWIeADhffjN
         LukHL2VW24x/elljJdGtxyTCKIrGji0ih5b8lN39xFdBeAGxaNMF86exXS8WcIyMUL
         tnOJRBYGAwn8d+dZ5+xXP1PfP3KtlRBwCbWLBcdm+sNZiU09IvjMo4EAZldP2u3PdX
         HjNgFKG2y51dTwvEAOVEkRnJWENKxPDvQM+4VweC8yOSY3THJCg8JF/ORihcN4HTOw
         /07yhQ5sUsY8w==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: da9121: Return REGULATOR_MODE_INVALID for invalid mode
Date:   Tue, 18 May 2021 17:31:29 +0100
Message-Id: <162135540356.37947.9500143538514467753.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210517052721.1063375-1-axel.lin@ingics.com>
References: <20210517052721.1063375-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 13:27:21 +0800, Axel Lin wrote:
> -EINVAL is not a valid return value for .of_map_mode, return
> REGULATOR_MODE_INVALID instead.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9121: Return REGULATOR_MODE_INVALID for invalid mode
      commit: 0b1e552673724832b08d49037cdeeac634a3b319

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
