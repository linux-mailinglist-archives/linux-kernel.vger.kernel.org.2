Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A0B3FE239
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344741AbhIASQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:16:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344680AbhIASQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:16:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AEC3610CA;
        Wed,  1 Sep 2021 18:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630520122;
        bh=hgwrdsFNp/PKcYjLFvMeJthQwTPWN5OLQPah0IlGyxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J3oL5crXZty1r1iaWKhAvKkJ3zl/M6on1P4giuyK1suRYmEJGkTNVRzvYiemZxvut
         SkN43mXNKPWahB4y+pzIm15lY9bBm0qVwtBS9jQ7JGkSNrHYdA/5lS8hZpbm/6naO0
         qhgH7b6GPIWp3Q7c/LvhWeu8aXgVT6jz1lEZ5B9mdg5z1uxSr6Y/PgDVuC3OOz69Xh
         zX8rFvqZAit12h+vRQHiZIUMhb5AfhretwGzl0tnJDD8LqXNQFRquAEki4W2w/H6+l
         elp9IYrlEOVBAIrsWXbVYi2hTp85vURuTDws9b9fL3dGhTFathAngwZ0Em76hk3ahR
         OUBX5D6GclxIw==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, matthias.bgg@gmail.com,
        Trevor Wu <trevor.wu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: mt8195: remove dependent headers in the example
Date:   Wed,  1 Sep 2021 19:14:42 +0100
Message-Id: <163051912509.21630.10720008205041847225.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210831083956.9804-1-trevor.wu@mediatek.com>
References: <20210831083956.9804-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2021 16:39:56 +0800, Trevor Wu wrote:
> Drop the use of the defines including clock and power id, so that
> we can remove the headers which are not applied in the example.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: mt8195: remove dependent headers in the example
      commit: 222039a2503e0839f859e18e6f09acb9997480d1

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
