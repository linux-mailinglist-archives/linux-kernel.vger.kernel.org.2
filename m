Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E781743CFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243274AbhJ0RcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243273AbhJ0Rbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:31:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E069A610A4;
        Wed, 27 Oct 2021 17:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635355756;
        bh=wF4ITQHovrfi+/zFjLWRp1/RkCOOsze0ZdjK6Q3RTvI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AlNsDPBEV84Pene+w55lrYdugdtmn9Sn6nsAUpH0VQ+rOugxtPjcK5mpkbN7tucK0
         OrRA0F6uYaswUBHcViU1yUyWc9c5DT4xNgDRRi2edtBGaN8ukx2f1V7sDjJMN97XD9
         Nf/F9YJOxi1JGSVX47p2BP+iyMoPK55FJy0YhTp9rLSx15wqCkhqd/miC4TDJp+TkL
         Ns9yqQqAM/Ub0PWHXOqG1NT7njNGgmNTftfH2g881weHDg12Zvy+PbGSF3nyUGQjiE
         oWb0/mxwx6oyRCPdlJ2FHgZizSGIdK5K5YqTCBuBk8JpArotEnLxx73LQ5HJhZglNY
         yWOo21a+LXiHQ==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, lgirdwood@gmail.com,
        George Song <george.song@maximintegrated.com>
Cc:     steves.lee@maximintegrated.com, ryans.lee@maximintegrated.com,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        george.song@analog.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211027001431.363-1-george.song@maximintegrated.com>
References: <20211027001431.363-1-george.song@maximintegrated.com>
Subject: Re: [RESEND,v6 1/2] ASoC: dt-bindings: max98520: add initial bindings
Message-Id: <163535575465.4012075.8539101072953032948.b4-ty@kernel.org>
Date:   Wed, 27 Oct 2021 18:29:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 09:14:30 +0900, George Song wrote:
> add initial bindings for max98520 audio amplifier
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: max98520: add initial bindings
      commit: 8af1f903391419809160aef3dac0641fa15680f5
[2/2] ASoC: max98520: add max98520 audio amplifier driver
      commit: f88ee76b8645c6da37eec79cfd45f2cc646bd01a

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
