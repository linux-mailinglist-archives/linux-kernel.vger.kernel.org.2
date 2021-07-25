Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DBC3D4DE2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 15:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhGYNRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 09:17:19 -0400
Received: from [138.197.143.207] ([138.197.143.207]:54178 "EHLO rosenzweig.io"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbhGYNRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 09:17:17 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Jul 2021 09:17:16 EDT
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Jani Nikula <jani.nikula@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] maintainers: Update freedesktop.org IRC channels
Date:   Sun, 25 Jul 2021 09:51:16 -0400
Message-Id: <20210725135116.15774-2-alyssa@rosenzweig.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210725135116.15774-1-alyssa@rosenzweig.io>
References: <20210725135116.15774-1-alyssa@rosenzweig.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like many free software projects, freedesktop.org issued a non-binding
recommendation for projects to migrate from Freenode to OFTC [1]. As
such, freedesktop.org entries in the MAINTAINERS file are out-of-date as
the respective channels have moved. Update the file to point to the
right network.

v2: Correct typo in commit message pointed out by Lukas and Jonathan.
Add Hector's ack.

v3: Add acks.

[1] https://lists.freedesktop.org/archives/dri-devel/2021-May/307605.html

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Acked-By: Hector Martin <marcan@marcan.st>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Cc: linux-kernel@vger.kernel.org
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b706dd20f..3349c2338 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1651,7 +1651,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	https://asahilinux.org
 B:	https://github.com/AsahiLinux/linux/issues
-C:	irc://chat.freenode.net/asahi-dev
+C:	irc://irc.oftc.net/asahi-dev
 T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
@@ -5970,7 +5970,7 @@ M:	Daniel Vetter <daniel@ffwll.ch>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 B:	https://gitlab.freedesktop.org/drm
-C:	irc://chat.freenode.net/dri-devel
+C:	irc://irc.oftc.net/dri-devel
 T:	git git://anongit.freedesktop.org/drm/drm
 F:	Documentation/devicetree/bindings/display/
 F:	Documentation/devicetree/bindings/gpu/
@@ -9118,7 +9118,7 @@ S:	Supported
 W:	https://01.org/linuxgraphics/
 Q:	http://patchwork.freedesktop.org/project/intel-gfx/
 B:	https://gitlab.freedesktop.org/drm/intel/-/wikis/How-to-file-i915-bugs
-C:	irc://chat.freenode.net/intel-gfx
+C:	irc://irc.oftc.net/intel-gfx
 T:	git git://anongit.freedesktop.org/drm-intel
 F:	Documentation/gpu/i915.rst
 F:	drivers/gpu/drm/i915/
-- 
2.30.2

