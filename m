Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F8A3BE281
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 07:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhGGF3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 01:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhGGF3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 01:29:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C235261CB0;
        Wed,  7 Jul 2021 05:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625635582;
        bh=1Jt2EOjuauybL/urtVil3M45jBlqRWU4CHPXSfW7V/Y=;
        h=Date:From:To:Cc:Subject:From;
        b=bcoPMJzllLb8lnF6Topa/Hr247ljeS3sFu2huuv+YFMc7QEhuwJifsM2duH4xgCTo
         go6g9R++HRBjjC+BfK6jQ6KqcRTFSGElZDbpfQhByQDhWmc/7MZZo/8rPHRhGXsWZr
         Y7TO4tStIVZbky23MG6x8tPmXm30wyAtr6ujy3Uy09tWTWBS8ylcA0wP37L53A/LN7
         usolDJaMcjfRRFzKaOSvSba8DpVjwKqoqC6KgCpjMSUEMZqkWX2WI12jEy16kw2Brw
         FuR0v/TPvUSG3IeWJGbIHbD3wFsS6kPacZye8qF4asnc9zitjm4pUL0X7RVmBg0Pk9
         1x61KMzZtygXQ==
Date:   Wed, 7 Jul 2021 00:28:22 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] More fallthrough fixes for Clang for 5.14-rc1
Message-ID: <20210707052822.GA35094@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-clang-5.14-rc1

for you to fetch changes up to f1469e568bf6dcbdff9fd7cd7d2cc9ca9d06efeb:

  Input: Fix fall-through warning for Clang (2021-07-06 16:26:17 -0500)

----------------------------------------------------------------
More fallthrough fixes for Clang for 5.14-rc1

Hi Linus,

Please, pull the following patches that fix many fall-through warnings
when building with Clang 12.0.0 and this[1] change reverted. Notice
that in order to enable -Wimplicit-fallthrough for Clang, such change[1]
is meant to be reverted at some point. So, these patches help to move
in that direction.

BTW: After these fixes are applied, there will be only 10 recently
introduced of these issues remaining in mainline (by recently
introduced I mean they never showed up in any release candidate
for v5.13), which I plan to fix once they show up in 5.14-rc1 and
send you a pull-request for 5.14-rc2, with the corresponding fixes
together with a patch for Makefile to finally enable
-Wimplici-fallthrough for Clang, globally.

Thanks!

[1] commit e2079e93f562c ("kbuild: Do not enable -Wimplicit-fallthrough for clang for now")

----------------------------------------------------------------
Gustavo A. R. Silva (4):
      net/mlx4: Fix fall-through warning for Clang
      i3c: master: cdns: Fix fall-through warning for Clang
      scsi: aic94xx: Fix fall-through warning for Clang
      Input: Fix fall-through warning for Clang

 drivers/i3c/master/i3c-master-cdns.c                  | 2 ++
 drivers/input/joystick/sidewinder.c                   | 1 +
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c | 1 +
 drivers/scsi/aic94xx/aic94xx_sds.c                    | 4 +++-
 4 files changed, 7 insertions(+), 1 deletion(-)
