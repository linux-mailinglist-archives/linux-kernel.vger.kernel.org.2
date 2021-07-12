Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970C93C5B02
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbhGLKuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234348AbhGLKuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:50:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A582E610A7;
        Mon, 12 Jul 2021 10:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086838;
        bh=mN7D9P4k746unRS5uALz6+b275Czv7Yz5sEt5ATJ3tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ho/C5ybnzpPNS8MM7sTsQV3nOVL+akTarE7Li26/rJgyM+5YSmzxY59PYB5C1y3pU
         OrSPF432jdc60+ntuE1YLvpagFSYiHnB7K8Gwe4CNBrdX3Z02YNrYPx4nHpYE/E0Aw
         4tWSHJnFCr0y9VjeKjaI7bXvW5/eZW2AmG3WzOeQz7G7EzgzexHPaL32+aqNDQdEBH
         Y96WIoOYkvn89Iw8zHgv7CFj+JuH7axkzS4Acn3BElWDgsRLO0w8WqVKIS94cN5zEI
         evzib6VkrOluS0r6Ow2ktIx/9RecbWPDzZSyc/77D1EjlCz0Gkxtvouwx7psYikbES
         0d9KMf/hOh5xw==
From:   Mark Brown <broonie@kernel.org>
To:     lee.jones@linaro.org, cy_huang <u0084500@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, axel.lin@ingics.com, lgirdwood@gmail.com
Subject: Re: [PATCH v2] regulator: rt5033: Use linear ranges to map all voltage selection
Date:   Mon, 12 Jul 2021 11:45:49 +0100
Message-Id: <162608654079.4419.15869422318938555013.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1625553939-9109-1-git-send-email-u0084500@gmail.com>
References: <1625553939-9109-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2021 14:45:39 +0800, cy_huang wrote:
> Instead of linear mapping, Use linear range to map all voltage selection.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rt5033: Use linear ranges to map all voltage selection
      commit: 6eb891cf73bd2ecc877e9916951a19f3e4f3c493

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
