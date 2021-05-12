Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD1C37EB74
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380467AbhELTbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:31:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245740AbhELRGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:06:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B17F61352;
        Wed, 12 May 2021 17:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620839132;
        bh=Bh2V0sgmyQknZxL4AvMKILIQ6tKp7KM9OxB7PWJ++Mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tCaq2+X3x8gq6wps7DA7W3LzdRJM4e6PvhVfD78dKnxbP0q0TPSV/dzqKkJoVHyGs
         Vaf7cJUPYqOh6P1+BaytbY3E/uW5cowSyHE/BsS8USAK9S6JB04YcuZ/FPe+rSU+yF
         0jXTr36KojbOaYiDLxAGXFDIN3EfAHzIJd8IygeBKlp2KKBibk0thKBpRefVctD4Pd
         nP7nDQeRV9yQ8FqszLOcT2jET+LT0AvxONXa02lyHvI/ByzAtv8I+5j2qUYQC7zJDi
         3wcqhUEWMu7+7l0KmRwXojaYQ6WBURlRdlfRqaEVOXU5YdpIz/t2gs0YzDKOSvdoZv
         ULRjRg9+AUI+A==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Pi-Hsun Shih <pihsun@chromium.org>
Subject: Re: [PATCH] regulator: cros-ec: Fix error code in dev_err message
Date:   Wed, 12 May 2021 18:04:39 +0100
Message-Id: <162083902381.44966.11137962760646106401.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210512075824.620580-1-axel.lin@ingics.com>
References: <20210512075824.620580-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 15:58:24 +0800, Axel Lin wrote:
> Show proper error code instead of 0.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: cros-ec: Fix error code in dev_err message
      commit: 3d681804efcb6e5d8089a433402e19179347d7ae

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
