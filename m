Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810C24214B5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbhJDREc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:04:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237633AbhJDREb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:04:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6D16613AC;
        Mon,  4 Oct 2021 17:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633366962;
        bh=KgzE/3KX5OPGUEh3sOXoWssbiAMutitGc+pWiFxKiaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ErPSG89tbTu13HG+KqsiCLFlB+kKxLTG7nlgh8NuMEle2co5HNAPUdkyq7TAkoIM3
         Ee+CplELPSZ7n3pRAwThaRcthjZnLDilhYs2TN8aVTmlbKXbBk5q1i9rrRDOpRC7qm
         EtQDzHSPtuSxyD4WLrnTN4EIv7pc5oRZ5iF1SPxOgJR4g8yEQTZgMrEg6i5HH34AXZ
         EbB3oN2+UkQ178n6DhhbbbuthiP+R/F59Bd9vpGbtF3IX6T7mnJuJsvo453VnEy11t
         odGpT0pQZGSJgDxtwojgrrclzkV4fxK+tUDbTzYw7Ea4Jb6s/Gd2SRM5PyBwIB1+6l
         gIjtUpj3QEW3Q==
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-power@fi.rohmeurope.com
Subject: Re: [PATCH 1/1] regulator: bd71815: Use defined mask values
Date:   Mon,  4 Oct 2021 18:02:31 +0100
Message-Id: <163336682170.3340396.17429389050231534867.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YVqpujZLZmaiqwe8@fedora>
References: <YVqpujZLZmaiqwe8@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Oct 2021 10:14:02 +0300, Matti Vaittinen wrote:
> Consistently use the defines for buck control mask values.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd71815: Use defined mask values
      commit: 555767fd9136a5d3e911179fde1795c08a502ab3

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
