Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BD53C5B04
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbhGLKux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234440AbhGLKuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:50:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6E9C61151;
        Mon, 12 Jul 2021 10:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086847;
        bh=7/UmWKH1Ozyu7TpzG2ClSbp/MKl50ujt2+/1olErqcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ms19c+MabGKab61s1CkGBCCzfDqITq5vzb3pRKlzwj5Agt00ZFD0wKskd59QAEg3R
         xY7h5E2hYxkrxZTY3Yg5Pss0vAzNyQKLy3Y67EezV//4UYpdbvZQ/EDKQA34w4MrbI
         H8N5oI2PH8n1MjbpoHN+cVrSZ7sUrNrMzqJb+aWuieMs2pwS3zuRmqcY1j9jO1B8de
         B4jcLl0ZzA/K2WwSXQq3HYmvpes4mR5jvBJoNQ9MV3dmvlyK6TF7cs/5JBuGiGw/EP
         jUK3rKKG7jUOyf2ROmpZXUPBdOZumsR6coLV+YSKQBSXsDidzHdZI8bVbbCu3kVG5g
         tuwc9NhBAXbQQ==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Henry Chen <henryc.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>, linux-kernel@vger.kernel.org,
        Wen Su <wen.su@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 1/3] regulator: mt6358: Remove shift fields from struct mt6358_regulator_info
Date:   Mon, 12 Jul 2021 11:45:52 +0100
Message-Id: <162608654078.4419.67036586786666358.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210629130503.2183574-1-axel.lin@ingics.com>
References: <20210629130503.2183574-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2021 21:05:01 +0800, Axel Lin wrote:
> The shift setting can be calculated via the corresponding mask field,
> so remove these shift fields.
> 
> The usage of da_vsel_mask is different from other mask defines because
> current code does shift regval before mask with the da_vsel_mask.
> Do proper shit to da_vsel_mask setting so we can calculate the shift.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: mt6358: Remove shift fields from struct mt6358_regulator_info
      commit: b99b7b79a7c57d5f1550b9a507521c791c5f92ed
[2/3] regulator: mt6359: Remove shift fields from struct mt6359_regulator_info
      commit: d6208ba87066c981589ca41f07d29a5803807ead
[3/3] regulator: mt6397: Remove modeset_shift from struct mt6397_regulator_info
      commit: 12401a1cef787167aff52ef2dd28286e61054c38

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
