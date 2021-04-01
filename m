Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D804B351332
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbhDAKRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232565AbhDAKRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:17:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F2C960FDB;
        Thu,  1 Apr 2021 10:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617272234;
        bh=zCVbEj+QZrf0qeL7NPNaHc+CKMjiPPmnunTrdUaxOoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZUdxuMIgpGv6gbqsJGu57OBWLcLkvfl/AXuSjoxd3fFQSCff+ySkgWI500HEoTwmW
         Tqmu5jB3GKORD4KkusrZD4LEio0mYBJdIHKBLBxjKvQmA7iSShXc9td2XMtJNrUnOB
         CsG9ORuMznyQjAlfhq4Jdg5QCiVmr+zEk6x0rG+kM4EIsdkyeJQmAcVbYCPOboVD3y
         N02tmB4wHsAVLgJ8Px0WRqP766BkKeeOSgP/uaGBeLfzRdprQujut9/TisZAPElzh8
         I1LAbJI5IOdG1Ef6d3e4DJU15i9ATR7ESQQYNWKQvE2FGDt++cMmnkMxtvEQ0ZFF7B
         UuuS/V0VVfsnQ==
From:   Mark Brown <broonie@kernel.org>
To:     robh@kernel.org, lgirdwood@gmail.com, Jack Yu <jack.yu@realtek.com>
Cc:     Mark Brown <broonie@kernel.org>, derek.fang@realtek.com,
        flove@realtek.com, linux-kernel@vger.kernel.org,
        kent_chen@realtek.com, lars@metafoo.de, devicetree@vger.kernel.org,
        oder_chiou@realtek.com, shumingf@realtek.com,
        alsa-devel@alsa-project.org, kenny_chen@realtek.com
Subject: Re: [PATCH] dt-bindings: sound: add address-cells and size-cells information
Date:   Thu,  1 Apr 2021 11:16:23 +0100
Message-Id: <161726938994.2219.8993456253882772159.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210331071046.12526-1-jack.yu@realtek.com>
References: <20210331071046.12526-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 15:10:46 +0800, Jack Yu wrote:
> Add address-cells and size-cells information to fix warnings
> for rt1019.yaml.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] dt-bindings: sound: add address-cells and size-cells information
      commit: e896ec390870287dcc92f3b46d80da88f3b4b1f8

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
