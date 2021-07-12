Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24CA3C5B05
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbhGLKvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:51:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234421AbhGLKuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:50:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8BED610CD;
        Mon, 12 Jul 2021 10:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086844;
        bh=lXHGRNxf/iCoxHRArpMNpBnOW9X1dO+GFhEZ4lzm8sY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFPtWSTM15NMw8dstSYwW/vuVmmgxCzaLSJc8wAEBVDFvrlF3NzVFFRCy34ip08n0
         FzLH4agFqr9SjNzrUqVm1QxJXQKbgV/zmnwAPVz9QkJarLrs44BoxThneoPHa1QjqI
         k7x7ikMeqcZpk0LJUlwyDWZIWopB6eWs6lGA/3mh6k4CgNvXfgJ3xl0Mpn6YsuLyw3
         Z8JE+IqHV5/HVPdU+wknis4Cs3FPF1MqTBe6pUllWHgE7NwiznjrJyKKJlBD7+oJ0H
         BUBHE4GFt1kzgsKZ8FvqWRAVszFwSM3o0qjCQNovly7DRXshrM4boocnpoqszqEoZN
         O9mT2ZZSSnT9g==
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH -next] regulator: machine.h: fix kernel-doc "bad line"
Date:   Mon, 12 Jul 2021 11:45:51 +0100
Message-Id: <162608654079.4419.4895745506562131881.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210628015422.8845-1-rdunlap@infradead.org>
References: <20210628015422.8845-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2021 18:54:22 -0700, Randy Dunlap wrote:
> Fix warning caused by a blank/empty line:
> 
> ../include/linux/regulator/machine.h:115: warning: bad line:

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: machine.h: fix kernel-doc "bad line"
      commit: 78bbb7c345ab630cfe8b272c6179bf8b19a6c8aa

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
