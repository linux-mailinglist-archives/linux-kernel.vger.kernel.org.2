Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263C439AA40
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhFCSoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:44:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhFCSoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:44:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54D4A613E3;
        Thu,  3 Jun 2021 18:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622745747;
        bh=gZ2Rm6evSOWowhlfUYvshPZr79z61vRuWyiSg76ynts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l6fXn2zl1C4X7JHdT5uUWW4Z9naLRCYI+hSoCSTvE/MhuR54CDaIilMKk0w02jbUi
         81ZCV6HxbJfquldRlRBeYfiPVzZrxOQA7DwLXmNpkFLIpQtbHBFxI4LtV7AgAQGfdQ
         W3bUn+XRBOLutEZB/Fv3YM5O5ZG1YH8cH4Et+SK1EV82sm6cWt4D1hZCn7rYvq+CIN
         TS5jkPcu6+nVEBT6yEY2ltIv/Geoy+057T1aAx8AX6TOQh5Z6lrG8gdjJIvsN3R1R0
         c/0KLSrlKAsXOeg0hR09VDQ+bVyLo7Aa+Bgj8M4wzuaQy2nzsAowsP02bLBdal+OfO
         je+AwaE0sTHIw==
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>, robh+dt@kernel.org,
        lgirdwood@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, cy_huang@richtek.com
Subject: Re: [PATCH v3 1/2] regulator: rt6245: Add the binding document for Richtek RT6245
Date:   Thu,  3 Jun 2021 19:41:48 +0100
Message-Id: <162274566700.14958.271975117890891609.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1622699844-19203-1-git-send-email-u0084500@gmail.com>
References: <1622699844-19203-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 13:57:23 +0800, cy_huang wrote:
> Add the binding document for Richtek RT6245.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: rt6245: Add the binding document for Richtek RT6245
      commit: 1623d767c7ec563d6e52ab76426377bfdde68f97
[2/2] regulator: rt6245: Add support for Richtek RT6245
      commit: a747070e9b629eeb70118651dfbd500bf8bb5ebe

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
