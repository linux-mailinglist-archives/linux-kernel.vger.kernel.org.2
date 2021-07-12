Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49EE3C5AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhGLKuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234186AbhGLKtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:49:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6054610FA;
        Mon, 12 Jul 2021 10:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086823;
        bh=K8JA+GZIR0moqPsbr68M2IZNchJumbNEl/vGc6yfXnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nS5EZcGhtv/iBMcjpUkCIwtjS0SEgAJDRkeN0i4c4PWb8vliL31g1pmsWvyk0Mdue
         mJlUtyS1Yh+NbdQy+of6iCHBvTtoIVBuOxxp2r6ba1tHRoaNFMQEiliYA8yVzZlQM1
         Wc5mWIcIqWWqIrQZBa1KhUW1kM83jvZ5Z90IkKfj9R2ox9SVffGCjTUeu08FsJ60sW
         pc+h7YEf2QImBQ6aWhwu73YGA1EKVm7VMKGY+yytNQVtujEBdnISGolujeaEWengyw
         4+My0khk72Cfungk/XAfstBsb4Ua50eOZHLqI10pY8T5GNlA+puiyLy3D6RxXy2j6D
         z22t6fOKdmzBA==
From:   Mark Brown <broonie@kernel.org>
To:     Matt Merhar <mattmerhar@protonmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] regulator: tps65910: Silence deferred probe error
Date:   Mon, 12 Jul 2021 11:45:44 +0100
Message-Id: <162608654079.4419.957906590754593944.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210705201211.16082-1-digetx@gmail.com>
References: <20210705201211.16082-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jul 2021 23:12:11 +0300, Dmitry Osipenko wrote:
> The TPS65910 regulator now gets a deferred probe until supply regulator is
> registered. Silence noisy error message about the deferred probe.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: tps65910: Silence deferred probe error
      commit: e301df76472cc929fa62d923bc3892931f7ad71d

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
