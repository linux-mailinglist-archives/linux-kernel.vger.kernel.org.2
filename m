Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C301438E600
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbhEXMBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232494AbhEXMBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:01:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0790D6128D;
        Mon, 24 May 2021 12:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621857610;
        bh=j1jw5RgOHXbGIAoCzn+wtPvjGxENvgoOQWy+bDj6ZCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bbpG5yBvEf8C81T47p/DUjNY6Vr5gSlskHH/u4y85bT/3b7pW78jK5nvQOYMaEP2d
         tpPUkZVIcuVYoHNud0Uj3jr+2K3eTctA5A41b4mkog5afnD9ysCMqoZFfiWMm52S9Z
         TBzclZ+1JGts4W2POVposnNBGArQJ0BJl8aMUEF5NBfIdolZ4Zgkns10/Mkvi2HWjL
         nJMhe3TXR4Qp4sh67KEfIrf4UrTRfn5u5KLlD1XT9vMbKhMrIVXT0wRirtIZTuzuVg
         0ax5yl2epuaAPhztMna0Yps0ZUe497VC47kvptYG2h+zicQKyPuK1Cz1JNgWa73Af7
         a9cITD5H98Ukw==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: bd70528: Convert to use regulator_set_ramp_delay_regmap
Date:   Mon, 24 May 2021 12:59:49 +0100
Message-Id: <162185754506.49496.1856166711739385035.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210522124250.2121076-1-axel.lin@ingics.com>
References: <20210522124250.2121076-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 May 2021 20:42:50 +0800, Axel Lin wrote:
> Use regulator_set_ramp_delay_regmap instead of open-coded.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd70528: Convert to use regulator_set_ramp_delay_regmap
      commit: 7c556aec14099c87c95bb7011c74fafe45d93679

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
