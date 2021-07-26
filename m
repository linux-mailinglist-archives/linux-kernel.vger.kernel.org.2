Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2703D635B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 18:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbhGZPq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 11:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237801AbhGZP3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 11:29:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C014961052;
        Mon, 26 Jul 2021 16:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627315721;
        bh=8pFX6GiB7o4ZaY2PyGFj7PxUvm4+em2B3BbKaRxBDEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oxlzQwo7djZqqInHq/es2pbG2+FW5srBZVt3L/lFuqN90qiOSGHv0E0YzErxChzrs
         +Rm1V6MO4hcOl5mQIY8CikTVvc4Ebx/t0aHHfR7a2bZrfMhFmSK79QndZzjmar114m
         XEGS04+a1YzcvBa9usSBZua4HEqV3loJLMzJ2hcFVrUcIq0XxCkVWJA6GCXOu3kGyR
         Oa4jrieqhoYYuPQF9TIm2oIbXDcusyGn6T08EF4diIJX1W8iv0uXK+Xcmgs9mpm967
         rPj16/wbs75YTGT816ADxLaxJCJ+ZxG98Nl4KleMwWECg759whzuVsOH3Ra0Gh4dgq
         u9gRmmo7ZeWfw==
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, mauro.chehab@huawei.com
Subject: Re: [PATCH 0/2] Address some issues at hi6421v600 regulator driver
Date:   Mon, 26 Jul 2021 17:08:31 +0100
Message-Id: <162730228789.6183.11432905675628892383.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1627121912.git.mchehab+huawei@kernel.org>
References: <cover.1627121912.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jul 2021 12:22:40 +0200, Mauro Carvalho Chehab wrote:
> Patch 1 on this series address a review made by Rob Herring for the dt-bindings.
> It basically use "ldo" instead of "LDO", in order to match the patch I wrote to
> dt-bindings:
> 	https://lore.kernel.org/lkml/b7a775808d9c3a87fbe1c5a6dd71f8f18be7e649.1627116034.git.mchehab+huawei@kernel.org/T/#u
> 
> Patch 2 is just a cleanup patch, changing the namespace for the voltage
> range arrays. IMO, the new names fit better than the previous ones.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: hi6421v600: use lowercase for ldo
      commit: ccb2a74eec211c368ddbe3eaec4a20292e431095
[2/2] regulator: hi6421v600: rename voltage range arrays
      commit: 5e36129f2b4e9629513670fc1df97545ab4bd5a1

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
