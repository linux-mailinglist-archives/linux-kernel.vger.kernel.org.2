Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA36D3DF7F4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 00:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbhHCWgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 18:36:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhHCWgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 18:36:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C424461078;
        Tue,  3 Aug 2021 22:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628030186;
        bh=hcHr3un6vM6Jy8wur/6t7L/Lhc7LHra5hoSt0Zdm0Nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gt7uODj/2ODw1IRh8Wtq3MriRjB4G8ItAvkRnU21Gm35JbsAP8v5Ykgz8ZdI24naW
         j0uOlC3xxzyLHykiig/C1Fq4TGlwHRNJxX82ardqhmhxgRGkiBTUtOLnnnpvJHrVT5
         q8d+ef/IdAnzof3/sLd1Xj5G4/93vcqqCkORxSB39wJodXaLHvfQo4fZkMUup25B+u
         8zJyYisVT2o7QtgbaSHUDGjM7KlIqkkVFzE7JU6EOpTKUsAaff40ChfAX4/zy3YMIM
         Ah6JhK3/2X7YtWbKktO0o8vBrIqtwJ5F/q74xEEaW5DxfmZFU0CkCjOggihxBq4E5n
         89bFAMNtABpiQ==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] ASoC: cs42l42: Fix inversion of ADC Notch Switch control
Date:   Tue,  3 Aug 2021 23:35:40 +0100
Message-Id: <162802985541.42099.7806067166014112149.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803160834.9005-1-rf@opensource.cirrus.com>
References: <20210803160834.9005-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2021 17:08:33 +0100, Richard Fitzgerald wrote:
> The underlying register field has inverted sense (0 = enabled) so
> the control definition must be marked as inverted.
> 
> 
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: cs42l42: Fix inversion of ADC Notch Switch control
      commit: 30615bd21b4cc3c3bb5ae8bd70e2a915cc5f75c7
[2/2] ASoC: cs42l42: Remove duplicate control for WNF filter frequency
      commit: 8b353bbeae20e2214c9d9d88bcb2fda4ba145d83

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
