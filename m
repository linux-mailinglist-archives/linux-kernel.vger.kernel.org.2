Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C45395424
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 05:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhEaDMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 23:12:35 -0400
Received: from [138.197.143.207] ([138.197.143.207]:52550 "EHLO rosenzweig.io"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S229952AbhEaDMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 23:12:32 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     dri-devel@lists.freedesktop.org
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] documentation: Update #nouveau IRC channel network
Date:   Sun, 30 May 2021 23:10:28 -0400
Message-Id: <20210531031029.4642-1-alyssa@rosenzweig.io>
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

