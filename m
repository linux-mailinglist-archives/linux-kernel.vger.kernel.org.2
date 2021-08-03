Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035143DF7EE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 00:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhHCWgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 18:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233273AbhHCWgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 18:36:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CEE960F22;
        Tue,  3 Aug 2021 22:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628030167;
        bh=asQGxyx3ZQN4Q8Miaysp1gcVWV+6cQfAcxrxVEvCo+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhxuQomV0wCq1Jjb+mXjx/qWoagW9G9af6iUrIcAi3rsKvSemsFwgxWXs0oxd7KYj
         9QIGkbAp8SUQmFHc+3aU6eViq6Lwr7kN+ucBiLli2KXcXXmJc5ZBCzlIEoD7gEJF65
         AN6aTUj4+T3Dj43fBSA2b6sJs/fVZOZ6WhlABdbgbX6xftHCy3oJ6lRk7hkWNAw8c5
         J03Nou2NqD958V/Tj71VTMNuuZK4WCZfnMp7oZgunIjBGPNOtBjvH7j4COR+ZWv862
         evOq/5CE1auJ9TQSdqwTz5BnLNqKQNwFco4QA9fFzffWtoUuRpQYSmee/eOfd3MRMG
         RHkYTy+G1tiQg==
From:   Mark Brown <broonie@kernel.org>
To:     kernel@pengutronix.de, lee.jones@linaro.org, robh+dt@kernel.org,
        lgirdwood@gmail.com, Alistair Francis <alistair@alistair23.me>,
        linux-imx@nxp.com
Cc:     Mark Brown <broonie@kernel.org>, alistair23@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v8 01/11] dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
Date:   Tue,  3 Aug 2021 23:35:33 +0100
Message-Id: <162803004553.42325.11270112719956797147.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803084456.198-1-alistair@alistair23.me>
References: <20210803084456.198-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2021 18:44:48 +1000, Alistair Francis wrote:
> Initial support for the Silergy SY7636A Power Management chip
> and regulator.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[05/11] regulator: sy7636a: Remove the poll_enable_time
        commit: e5dad32d90e0e9b006f5c330e92fa0ec9042ae79
[06/11] regulator: sy7636a: Use the parent driver data
        commit: 4cafe1aeb5fb4eb1778d5e1b91d50a078369dbe1
[07/11] regulator: sy7636a: Store the epd-pwr-good GPIO locally
        commit: d38d49b140043bba3ea27b89cca5fefaf08e2034

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
