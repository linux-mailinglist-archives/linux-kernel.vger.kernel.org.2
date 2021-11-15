Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C38451C74
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353028AbhKPASS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:18:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351474AbhKOXlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 18:41:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D71BB61B3D;
        Mon, 15 Nov 2021 23:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637019309;
        bh=2BLuML7QlU7NsI1hA9jTUfLKUXT81kLYlx9JSVSAxQM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ECdCqy8bYsf1/UCfEWI36qc+40S1DXBLScAOAQeEkCr4OWKhjDIE4O1q1aHq9ZVDm
         uAPrv65eA5Boy/Ehv/PHcxqWuYg/rD06quBG7Mx6SJhiblxBzxVNNiZL0z9srVfOgp
         Ft8lvyUq3fPfEfg2eqAmY5PaTJbBZjfbjpNUvzBJr3IR4cxRZpzngqJghg+ZI0e6TS
         t/UE/bPXIlD4WcSjQeRmuKJ9y+tBJwbxmV3cfyi4AVuNiDSLuyx4dzihtgtpJBmgbh
         aQcaumIcBJf6B4TSE7s5gWvgmLz2twbgdD08sz/+gv5caB6Lak+67joNIXuuPefX77
         OmtdLp3qAqV2w==
From:   Mark Brown <broonie@kernel.org>
To:     - <patches@opensource.cirrus.com>,
        David Heidelberg <david@ixit.cz>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        ~okias/devicetree@lists.sr.ht, devicetree@vger.kernel.org
In-Reply-To: <20211028124639.38420-1-david@ixit.cz>
References: <20211028124639.38420-1-david@ixit.cz>
Subject: Re: [PATCH v2] dt-bindings: sound: wlf,wm8903: Convert txt bindings to yaml
Message-Id: <163701930762.675370.11238236735151846802.b4-ty@kernel.org>
Date:   Mon, 15 Nov 2021 23:35:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 14:46:38 +0200, David Heidelberg wrote:
> Convert the Wolfson WM8903 Ultra-Low Power Stereo CODEC Device Tree
> binding documentation to json-schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] dt-bindings: sound: wlf,wm8903: Convert txt bindings to yaml
      commit: 5ecc573d0c542c0f95497ba4586a6226814e4e18

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
