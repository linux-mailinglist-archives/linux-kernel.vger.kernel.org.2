Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175C639FC0F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhFHQLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233813AbhFHQIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:08:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DBA9613AB;
        Tue,  8 Jun 2021 16:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623168420;
        bh=F+pSncXIm4bYokUfhJBqiZg+hbimsw+cW4poLZzBDPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pa64KjnR3KVIQkuCxleqfEB+KexIsnygUOSMNtugSbqnnzLdB3sseUmHqmEskdPsh
         yJiggC2TCZwBKn+ZinzvxvR5l+aImM8mQEKHHVei0JssQWqXgebGR5LH47QRu0qDU9
         4k95sEEgvQ0hJKCV5QQqPYBiPGKKsDyHtW3AqG+I8jiA8+o+DU8iZ/DiB0BtYtduQ6
         YMGjD+8L0ecVVL1uUz5ukEc2AwIhj0jWZDmsdB1oY8PxlPS3gvlRXjrAar/J3F4aR0
         nh8ZQPbhmU534+sBfrK9tGS08aRN6d02udSTMEKz4SBCWR2J90OI15ehxfX9T7TcT7
         G2PvJGKSFfclA==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH] regulator: bd71815: Get rid of struct bd71815_pmic
Date:   Tue,  8 Jun 2021 17:06:33 +0100
Message-Id: <162316831092.28178.13063607375213169245.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210607143002.1600017-1-axel.lin@ingics.com>
References: <20210607143002.1600017-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2021 22:30:02 +0800, Axel Lin wrote:
> The content of bd71815_regulators is never changed, no need to duplicate
> it, thus remove descs[BD71815_REGULATOR_CNT].
> The *regmap, *dev and *rdev[BD71815_REGULATOR_CNT] are not really needed.
> The *gps is unused.
> 
> Thus the struct bd71815_pmic can be removed.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd71815: Get rid of struct bd71815_pmic
      commit: 0ea461b4f229739345870a086aa4647a16ff42ff

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
