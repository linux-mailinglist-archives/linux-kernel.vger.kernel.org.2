Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9DF3A8785
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFORbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhFORbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:31:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0F9C6140B;
        Tue, 15 Jun 2021 17:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623778186;
        bh=nQ6dLrkLl3lmk53t/eWVpXauQeo5excqr23JPiTwhVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DjkD6kuRbgxZKIgpzr8Bks7IP5xh6tl+7O//oOh+fbyv/t6FAnkwAbVDC7L9gydVn
         v7g0FbdXcPfiS1ueDLT68yKA9P/RDAw9xHx8r/6Gp6U3bSWjtyUBAcLPoVTm77coRk
         K7QCVZXoZ8rTTzOdd69A+kP2SYK2E6vKLBYN/RaWBouutacM7716RRHxDjo5tJWnTn
         DGjJzQkEqZikXWj4hlCQIN5+oO5S5mNJaBPlsbIPKJOWMM8ttzu9R5EyD6gTcRkoCw
         lpWFAILii6SwgcqBxBwMBqsPovbVPuh1atJ6VyCFzcxnff3EE3Yh72Pu55PxvUCROR
         41VyeG/h5f5EA==
From:   Mark Brown <broonie@kernel.org>
To:     lee.jones@linaro.org, Alistair Francis <alistair@alistair23.me>,
        linux-imx@nxp.com, lgirdwood@gmail.com, kernel@pengutronix.de,
        robh+dt@kernel.org
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com
Subject: Re: (subset) [PATCH v6 1/5] dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
Date:   Tue, 15 Jun 2021 18:29:17 +0100
Message-Id: <162377794811.21860.17738475490023059029.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210615103400.946-1-alistair@alistair23.me>
References: <20210615103400.946-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 20:33:56 +1000, Alistair Francis wrote:
> Initial support for the Silergy SY7636A Power Management chip
> and regulator.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[3/5] regulator: sy7636a: Initial commit
      commit: 8c485bedfb7852fa4de2a34aac2a6fd911f539f4

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
