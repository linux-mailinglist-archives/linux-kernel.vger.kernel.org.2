Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157444383CE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 15:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhJWNgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 09:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhJWNgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 09:36:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AFFB6101B;
        Sat, 23 Oct 2021 13:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634996071;
        bh=xLPxRUzLKQ4rn5/2l6LyXgKNELhYzrPv2Oduj7+M1JQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XRXRSbS5cQz7qDmckPaA0wjEtyZ1TjMo6Ge9Br3KQC207cx7SJurnQdQjwVG5f29C
         8zpWGe36Qk6lAjBexiSZtE9SZeZVVvXgRnSeXSg9jZcJrjKyF/Dc0PB9MT9NUn6Fau
         2e28BLqdenG6Nry9CcLi8BlIHqjs3vhqhcaJ2eTeOmTGV9IlF6EEFNt649STZwwS81
         YPzkYHLuLxYUlbrYB6xbNmgxMtsfpw+nfa1HyaWWZrgN/+lgyr5LrybIyixyZOjC4e
         djNODggOPvdQ0UzYn5laHt6JOaqcnBi5cNDxu3WiN4VAP/+TFjZU9v9jJMSMqtKP+j
         cbfPICzRbHzhA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 0/2] ASoC: meson: axg: fix TDM channel order sync
Date:   Sat, 23 Oct 2021 14:34:25 +0100
Message-Id: <163499605422.842779.12859165358802966225.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211020114217.133153-1-jbrunet@baylibre.com>
References: <20211020114217.133153-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 13:42:15 +0200, Jerome Brunet wrote:
> On the Amlogic AXG series, the TODDR FIFO may get out of sync with the TDM
> decoder if the decoder is started before the FIFO. The channel appears
> shifted in memory in an unpredictable way.
> 
> To fix this, the trick is to start the FIFO before the TDM decoder. This
> way the FIFO is already waiting when the 1st channel is produced and it is
> correctly placed in memory.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: meson: axg-card: make links nonatomic
      commit: e138233e56e9829e65b6293887063a1a3ccb2d68
[2/2] ASoC: meson: axg-tdm-interface: manage formatters in trigger
      commit: bf5e4887eeddb48480568466536aa08ec7f179a5

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
