Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DB2308006
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhA1U5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:57:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231217AbhA1U5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:57:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBB6464DDB;
        Thu, 28 Jan 2021 20:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611867380;
        bh=7YWg/7qqCEaamJgUhJGjOesv5dRB/I0KuiqrciA2/N4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ANG+h9JUdelx3ORfRF2flAwbtQEtJssY/1v2pQsrNueytWDxa1zE8WR54AVZSVUxQ
         zOsx1ISgdOQOOuauYb8a0AhlvXYkWTqbugjgJ7Ix5H8RWe+uVD2ceOhp8cbOKW15o/
         lSRPBmkOH9jW2/mxtVlNu5+/6RLbOyWyhZjhx1POroc7u/4VYvALiGzMGAW3pGADDc
         6E05T5L4MLKMw8aw1bUK4r8tO1hP3Tb9/kMhGF9X19zvh5g1UaZuTqvpE1fmTXYjSr
         aO8EI8BWZrDhyB/VZrqxkOSQkWB0Le66wQ0QY6QuX71thbMJ+w7IbSiGS0xMlvg/mE
         l0gKjGdqzHx4A==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20210128120151.554411-1-axel.lin@ingics.com>
References: <20210128120151.554411-1-axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: pf8x00: Fix typo for PF8200 chip name
Message-Id: <161186733613.43884.17136128791316394196.b4-ty@kernel.org>
Date:   Thu, 28 Jan 2021 20:55:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jan 2021 20:01:51 +0800, Axel Lin wrote:
> Trivial typo fix.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: pf8x00: Fix typo for PF8200 chip name
      commit: 64f09ea1b551189f491ffb626fdccc2c31fe2d70

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
