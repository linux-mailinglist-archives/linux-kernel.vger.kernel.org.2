Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35635394C78
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 16:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhE2OZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 10:25:19 -0400
Received: from [138.197.143.207] ([138.197.143.207]:52538 "EHLO rosenzweig.io"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhE2OZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 10:25:18 -0400
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 May 2021 10:25:18 EDT
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     dri-devel@lists.freedesktop.org
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] documentation: Update #nouveau IRC channel network
Date:   Sat, 29 May 2021 10:16:37 -0400
Message-Id: <20210529141638.5921-1-alyssa@rosenzweig.io>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like many free software projects, Nouveau recently moved from Freenode
to OFTC. Update the reference.

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/driver-api/thermal/nouveau_thermal.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/thermal/nouveau_thermal.rst b/Documentation/driver-api/thermal/nouveau_thermal.rst
index 79ece266c..aa10db6df 100644
--- a/Documentation/driver-api/thermal/nouveau_thermal.rst
+++ b/Documentation/driver-api/thermal/nouveau_thermal.rst
@@ -90,7 +90,7 @@ Bug reports
 -----------
 
 Thermal management on Nouveau is new and may not work on all cards. If you have
-inquiries, please ping mupuf on IRC (#nouveau, freenode).
+inquiries, please ping mupuf on IRC (#nouveau, OFTC).
 
 Bug reports should be filled on Freedesktop's bug tracker. Please follow
 https://nouveau.freedesktop.org/wiki/Bugs
-- 
2.30.2

