Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C5B344BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhCVQmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232058AbhCVQmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:42:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AEB161983;
        Mon, 22 Mar 2021 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616431327;
        bh=9xvqTNezw3tYuoVfeeADeGM3s9v4JWgUTmRGf4uQ2NU=;
        h=From:To:Cc:Subject:Date:From;
        b=effL3sJznDj8ualeXh5XCrDafKag1c2smDyLYgtFi/TZ/nhyq+qP6dzFvy6zU0uXJ
         YI+BBE7mnNAxmrU9dukG9Gx6vnYPWGd+GJCr8g8UiFalENeznr9qCd0/2H+hOO/rHN
         ZnmXT92X720doHPJh3OF2eUW6l8NWz1YDCZLRYPLsfrIBMEGcy/YmKiuxVZv2FPadm
         kYshsDZEnmPM+0VOoE6BRjTAsal86mIFHv+gh7f1/6hPRfSqKpwt1Ot2KfEID/pw+1
         0N5DTaoT3xy7ZfhBogPXIM0BmhyPogSTNRGhogZ3LcSKOXvOlk0jzLTZ5lJfHCcFgl
         rANd6JpBL/4iw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tomi Valkeinen <tomba@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jyri Sarha <jsarha@ti.com>, Tony Lindgren <tony@atomide.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/omap: fix misleading indentation in pixinc()
Date:   Mon, 22 Mar 2021 17:41:57 +0100
Message-Id: <20210322164203.827324-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

An old patch added a 'return' statement after each BUG() in this driver,
which was necessary at the time, but has become redundant after the BUG()
definition was updated to handle this properly.

gcc-11 now warns about one such instance, where the 'return' statement
was incorrectly indented:

drivers/gpu/drm/omapdrm/dss/dispc.c: In function ‘pixinc’:
drivers/gpu/drm/omapdrm/dss/dispc.c:2093:9: error: this ‘else’ clause does not guard... [-Werror=misleading-indentation]
 2093 |         else
      |         ^~~~
drivers/gpu/drm/omapdrm/dss/dispc.c:2095:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the ‘else’
 2095 |                 return 0;
      |                 ^~~~~~

Address this by removing the return again and changing the BUG()
to be unconditional to make this more intuitive.

Fixes: c6eee968d40d ("OMAPDSS: remove compiler warnings when CONFIG_BUG=n")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/omapdrm/dss/dispc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
index f4cbef8ccace..5619420cc2cc 100644
--- a/drivers/gpu/drm/omapdrm/dss/dispc.c
+++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
@@ -2090,9 +2090,8 @@ static s32 pixinc(int pixels, u8 ps)
 		return 1 + (pixels - 1) * ps;
 	else if (pixels < 0)
 		return 1 - (-pixels + 1) * ps;
-	else
-		BUG();
-		return 0;
+
+	BUG();
 }
 
 static void calc_offset(u16 screen_width, u16 width,
-- 
2.29.2

