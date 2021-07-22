Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB51D3D2AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 19:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbhGVQ3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 12:29:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233707AbhGVQ3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:29:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9F966101E;
        Thu, 22 Jul 2021 17:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626973822;
        bh=WT0nPYdOWKzLqOL6Ke9FE7dJSsZHfDGoId/oXm3Q9m0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FROmpjK4MWNa7wJ1tvm24RZEYGRjAKDMI3rHnfR896ngyHOhpkDjLY0uNXALcLL5f
         komguPWdvvs4oEBGRDZmIo1KSIkDtDbAf2JwSaHwAEMcfUPdehSV10TZcV3x1o8tk4
         WjSwYv/dHiPKY8puu3+6uLcDWvNQl/n0ASIUcaS34+FNHSLN0Vy/rnyqq7GRHz4tpd
         oISF/D6siy3MM1qSYxP1fN3l4cthAvs9rT4P/ca6EqOA+PQu20y7gM38tKV7fcvQmG
         2bSI53vMuy57MDtRYOWGJaJ0agMs/2qyIUwSusQA+YFekpOlY38CKUaYtktuVyBLEx
         W55P9qapEvsgA==
From:   Mark Brown <broonie@kernel.org>
To:     Chris Morgan <macroalpha82@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH] regulator: fixed: use dev_err_probe for register
Date:   Thu, 22 Jul 2021 18:09:59 +0100
Message-Id: <162697098827.2233.993189815712501737.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210721165716.19915-1-macroalpha82@gmail.com>
References: <20210721165716.19915-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2021 11:57:16 -0500, Chris Morgan wrote:
> Instead of returning error directly, use dev_err_probe. This avoids
> messages in the dmesg log for devices which will be probed again later.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: fixed: use dev_err_probe for register
      commit: d0f95e6496a974a890df5eda65ffaee66ab0dc73

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
