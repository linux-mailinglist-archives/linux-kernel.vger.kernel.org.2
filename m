Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E57367316
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245423AbhDUTFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245402AbhDUTEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:04:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43CE961457;
        Wed, 21 Apr 2021 19:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619031859;
        bh=akoHHv1+TfekYVfWFIlN4zaa0MgYWAEEB9reVESB0UE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MTu2/pqnQUOt1FIuxEQAHzqs13105b+etZ4mbf1za/lHV1mP/pqPzD6ZPbvmRywtb
         TES8I7RBdtETJo+28/zlXfrhq9Grxhy1Hx0VLuk/3yIhhoxC/6Or+d+RpBdqclGOmq
         LZeVIlwFHtpAFrrzVcoyMRYImJScvq5y48+kn0svi01CJbdQh7EIal4GHlfY4+pILl
         gpo5SiH0QfuvaR52Ecl0aCW0vwm+K2y54pW/SpYifPo8MrGSitmKkA00COb4wICAC2
         MhcOvGVsHbP1X6kNe16hdpLN0XIbxO43ktZgp4bIRpn2aGBO6w+0MM8NGSJ/ft2HCw
         vioAUqZSe25Ew==
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Fricke <sebastian.fricke@posteo.net>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: core.c: Improve a comment
Date:   Wed, 21 Apr 2021 20:03:29 +0100
Message-Id: <161903035951.13561.14721623663345930224.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210421055236.13148-1-sebastian.fricke@posteo.net>
References: <20210421055236.13148-1-sebastian.fricke@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 05:52:37 +0000, Sebastian Fricke wrote:
> s/regulator may on/regulator may already be enabled/
> s/or left on/or was left on/
> 
> The aim of this patch is to make the comment more readable and to make
> it clear, that this is about a regulator, that is already enabled instead
> of a regulator that may be switched on.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core.c: Improve a comment
      commit: 72241e3190f2be668d60493cf0343ec535357b5e

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
