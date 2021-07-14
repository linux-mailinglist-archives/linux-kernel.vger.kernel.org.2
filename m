Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923EE3C881B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239785AbhGNP7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239775AbhGNP7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:59:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 279F2613CF;
        Wed, 14 Jul 2021 15:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626278169;
        bh=E0sbg0M0ocyf6VkUrKaPVCDLNkU0SdHrK7wgF4xeYjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jzxaodBUycHnj95sPiOWFeTjCo2njjf9wo+VzDaj0R0ryDe3CzMJwYJw9s10rMB2K
         qt9MLFEm7OHhpzjK5whAqo8CcJBiPLcSqjs3M3xrvqBxF0vwWrCthGNxonfqqPTmJt
         DABDL4zVrSWGx93ocmY4Qj20JJgs5Xmd6rMs8rEwDv8X/aiH6r8qTXvEquN5OoZiay
         SqsO1Xr4u8u16bbbiywfEkE0DtH8JsTcSKb3UgQrspMgOx/M/7qyZ1zCvm6c1isuZM
         pn5/e3Az/PJH8En3RPK8OJY0CzXbOqGlHJVQGIUV17mooeQm/o7p9CtwH7DDq8D5hW
         +153+IW4PEdlw==
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>, robh+dt@kernel.org
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] regulator: rtq6752: Refine binding document
Date:   Wed, 14 Jul 2021 16:55:17 +0100
Message-Id: <162627768618.55091.3455363305744240999.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1626229532-13037-1-git-send-email-u0084500@gmail.com>
References: <1626229532-13037-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 10:25:32 +0800, cy_huang wrote:
> Drop regulators property reference and remove the status in example dts.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rtq6752: Refine binding document
      commit: e98fb032170bfa2e671a01e356a7ee86a2038312

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
