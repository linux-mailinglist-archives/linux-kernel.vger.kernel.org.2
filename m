Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6602D3698D1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243429AbhDWSHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:07:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhDWSH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:07:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E34C60FE6;
        Fri, 23 Apr 2021 18:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619201211;
        bh=zY8W3QUzcAWl6AFnPYVD24wO4KnCsJRKIXsxHN8wx1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dTiTKJSplBFdws7Z670JSl0N3QnlSoG/MoXHlgmknls69QEaMI4AZS0zAiJVGn6Sn
         80zKX+YZ7XvG4iXz0s4AVJF7PHczSnd/AQyvbSPpNTLmdAyn5lOtZNTpooK7p/6FC1
         tYpZxIH9z9nzGB0SI+BfDZ9E2AzLg15qzJrGXI7jqb/mpOpg1Jm17zVT5pVi2O1jwY
         DMnxOBp4giIJ6ylJop8R/4fT32MRGwUN31+Hqn+yShNjHWYwq9skVN5ws+UvxLITk6
         WHyYdsAyNQGxXM95V//QHFcNbIjUOm+qm21Uw46Or6ZeP4jSGF8o5Ss30h+6QcdSiP
         spTh0yeAk27/g==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        devicetree@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Joseph Chen <chenjh@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Tang Cheng (TCS)
Date:   Fri, 23 Apr 2021 19:06:17 +0100
Message-Id: <161920103667.15429.2219995515166264842.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210421210338.43819-1-ezequiel@collabora.com>
References: <20210421210338.43819-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 18:03:36 -0300, Ezequiel Garcia wrote:
> Shenzhen City Tang Cheng Technology (http://www.tctek.cn/)
> is a power management IC manufacturer.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] dt-bindings: vendor-prefixes: Add Tang Cheng (TCS)
      commit: 3007accc39776e0888f7692bd1cb639c51cc29c5
[2/3] dt-bindings: regulator: Add support for TCS4525
      commit: f80505fdff771c89c9350895e99140ffc824e564
[3/3] regulator: fan53555: Add TCS4525 DCDC support
      commit: 914df8faa7d6fdff7afa1fbde888a2bed8d72fa7

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
