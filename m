Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C115A3FAE32
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 21:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbhH2Tsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 15:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231354AbhH2Tsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 15:48:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8982760C41;
        Sun, 29 Aug 2021 19:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630266469;
        bh=Ksu2vYoflPDWXoUQE5SmdmZfKvHqGucVHmVRQOzB+mY=;
        h=From:To:Cc:Subject:Date:From;
        b=jCYcyzzb+5ZLzbEmhrVZqrJJPsqWKy0GpV2d5mT/2bQukmOmDq4Px7qzMAphIK4lZ
         09STacznATYO40bVpfa1/1HlzhdbojL4yXau2kwrjwCWN38Pjjd08eSamBu4CgE+iE
         F93sFuuVA/2doKqfKN+FyqTFofGuj2SvBkR+j1qd9EWsgdyq3L/AUb7qO7melhgHmN
         42TwuC3JeqL8SFEV+6k/GstK/31DhBlQ60DA9m/RxB0hFsM5ThTYzDMWz7IiHPYU1y
         L2lnyDrCkTK+YT/+G3MhjLL1bMBCblmLG3hGSAJLDAPEEISSIdDyoEAFzUX56B0HSK
         QPzVS7rZSv0hw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.14-rc7
Date:   Sun, 29 Aug 2021 12:47:48 -0700
Message-Id: <20210829194748.682333-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9711759a87a041705148161b937ec847048d882e:

  clk: qcom: gdsc: Ensure regulator init state matches GDSC state (2021-08-05 18:19:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 1669a941f7c4844ae808cf441db51dde9e94db07:

  clk: renesas: rcar-usb2-clock-sel: Fix kernel NULL pointer dereference (2021-08-28 21:29:36 -0700)

----------------------------------------------------------------
One hot fix for a NULL pointer deref in the Renesas usb clk driver

----------------------------------------------------------------
Adam Ford (1):
      clk: renesas: rcar-usb2-clock-sel: Fix kernel NULL pointer dereference

 drivers/clk/renesas/rcar-usb2-clock-sel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
