Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871423AF561
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhFUSsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:48:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhFUSsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:48:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33D4A61363;
        Mon, 21 Jun 2021 18:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624301195;
        bh=bjxrCn/o/AhjCP8aaet+ZDvqnwF4V76e88ZV3uuxiCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O7xvFlqNjLQL5vkQC2nW417DQ2XnSxgqVi5N5P9WZGKpUOe6f1pXtWh6dZeq6H2Bf
         P/sa1PEtyh/PX3pXcMI4ulf7ffNzYLpWC+EWMYWR7+bW3AzYhwWndrS7Caosm+Pd7U
         zQOe52b3bvt9uCY/I0kXfrE2IrEO97n55MsVTstNQOLrfbnbwHCeH3L78dWfnW13zu
         2cSwkkalIV2Z3RnsQH0v0KXGmSyj5nPgy1+QqUFvHFaPsCFy9OWz5FKXxA+Bz3+GYK
         5jcZw0gTSiss4AQA9U96hBiZuhEv6vjSL16IdQ4oPD/W5+GAYygtPW5DjOroe8d3rk
         Z8FaiSFiP4p7g==
From:   Mark Brown <broonie@kernel.org>
To:     Sergey Larin <cerg2010cerg2010@mail.ru>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: max8893: add regulator driver
Date:   Mon, 21 Jun 2021 19:45:51 +0100
Message-Id: <162430087046.9551.11451976278911990353.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210618141607.884-1-cerg2010cerg2010@mail.ru>
References: <20210618141607.884-1-cerg2010cerg2010@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 17:16:06 +0300, Sergey Larin wrote:
> MAX8893 is a simple regulator which can be found on some of Sasmsung
> phones.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: max8893: add regulator driver
      commit: d83f778c627ad4e80bd82dbc88ffa1b1b18876bb
[2/2] dt-bindings: regulator: Add MAX8893 bindings
      commit: 01c5741b82969d096ac0870d997b7d2f5a5fe970

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
