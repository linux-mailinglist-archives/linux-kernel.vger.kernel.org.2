Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BA53C5B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbhGLKvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:51:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234337AbhGLKuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:50:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2EA8610A7;
        Mon, 12 Jul 2021 10:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086855;
        bh=OMXa5doo2o5GpvYVKNPrhP1Va7dqh0QTPyy4PIyvpu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y8wIgmfqo7yux6+e6qbhD0pVtwAxSZ09mCY784kyLdtdEq0Dh8UQI9V9/fYz5fpFc
         jMcnAQAeA69+qxpIvGXsVGtoQGBbXZaqTipqv6kc0f/TyYoih2zpmDhlTDtju19kAA
         Re2I3i85/qDn4g6jGd5+N/pIuklLzsiwDUeO7xiAJTaXWUsCXVlBN6+D/ic/tYMTVj
         MoATQjkTI+/tpmTpHX9xDywuu0Yi1gj9cp/Epe2DZt7DrfO6epNtThYv/c71EwEwzZ
         bJea+J53HZCP2RE0/pW7vX0xiXcC+tN1Ngk7j8YqDOE1RI0U3yZbYrYx2ErnbBpKBz
         PSDLCTez3y9Lw==
From:   Mark Brown <broonie@kernel.org>
To:     Jinchao Wang <wjc@cdjrlc.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org
Subject: Re: (subset) [PATCH v2 1/2] regmap: Prefer unsigned int to bare use of unsigned
Date:   Mon, 12 Jul 2021 11:45:55 +0100
Message-Id: <162608639129.3337.411748124735250764.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210628171907.63646-1-wjc@cdjrlc.com>
References: <20210628171907.63646-1-wjc@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2021 01:19:06 +0800, Jinchao Wang wrote:
> Fix checkpatch warnings:
>     WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: Prefer unsigned int to bare use of unsigned
      commit: d63aa09f7c53bdeb83edb4d84c07d759a92223bb

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
