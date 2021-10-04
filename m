Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D362D4214B7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbhJDREj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238098AbhJDREh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:04:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 847DC6120A;
        Mon,  4 Oct 2021 17:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633366968;
        bh=Gx/CYCFVJu84iQ/txzZ7rjGlD1I/Qy9L32fCT0MwsCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=haCRp0q6vEu7267/hmBwEWWjTOY2l11CSxN7JJkNu7wTw9cdaY+SFa2Bxx3C8Rgx7
         bPjpCj+mWk6uzY0LsKok54Fzi0cB+K3NVUf5E9v2NduyguTKRJVYwetLNdu6RbNz+W
         ZX+Kb0RFA+9BsuqvAQO7kauy1vv40I2p3qjUxiMRAf2mC8TxeFdy8yf1x938/p2Xwr
         1n4iZCxDG6j1fNUQ98HtGVdAH89FvDBM9iHDBNPgSTWoxgKEgG6s6om59U8OyW3njb
         kHFz9e11D3KGiiS6dzKl+wz5WwcDpm4iDe3e4DxXD4SSVVuist4PjaZ90LDseUZxaO
         gVd4vjfhSzFsw==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: uniphier: Add description of each port number
Date:   Mon,  4 Oct 2021 18:02:33 +0100
Message-Id: <163336659968.3340210.15989674520560079639.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1633313546-23258-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1633313546-23258-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Oct 2021 11:12:26 +0900, Kunihiko Hayashi wrote:
> To eliminate FIXME, add descriptions of what each port number is
> associated with.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: uniphier: Add description of each port number
      commit: 2a04151ff95a3c430150064b0c8beb1981f81187

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
