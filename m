Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E660398FC2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhFBQS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhFBQSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:18:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C149D6161E;
        Wed,  2 Jun 2021 16:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622650632;
        bh=3/iBJt9UxTC5puBU90lxDSixTBujpghEA7SaRtO8qW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YQYo7tOHJ/f4TjQ6Nis7IDhpQGztcQDLcdG1PmdaYCWPREo4/DXXfd8/O8KU3J9eN
         fnJ2YOuG0Sbr5lVRrIXXS3+9M2WX+v+Z7Wm+lC6U8k+cnOws0QagiHQuQLoTDaYYpT
         FesR0b3HEGkHs9G3n5XwrgWqM06v1iCgPsPz52cuFpqPIwXHxrhlu7CFx/m9kuINYu
         fndOSBEmEeMi4yaMBKrjkP1Wbuip0uNebm0N7EvwveeiIvIv4sXv9OVwEetGD9nCMx
         adwo8lREGw/mVEsPqVhy8RjZT6/pKP5lhQgVSDIb7+NpGVxfA8wdy1c4CVmJIqQMtN
         VS12qys+TKi2w==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, lgirdwood@gmail.com,
        cy_huang <u0084500@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/2] regulator: rt6160: Add DT binding document for Richtek RT6160
Date:   Wed,  2 Jun 2021 17:16:48 +0100
Message-Id: <162265054258.22587.17942580965862271486.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1622611906-2403-1-git-send-email-u0084500@gmail.com>
References: <1622611906-2403-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 13:31:45 +0800, cy_huang wrote:
> Add DT binding document for Richtek RT6160 voltage regulator.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: rt6160: Add DT binding document for Richtek RT6160
      commit: bce18e52c866ff6ded13ac8ac37e9271f786c005
[2/2] regulator: rt6160: Add support for Richtek RT6160
      commit: de20b747c5836ffc6768914b95d7617139fac4f4

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
