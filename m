Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAAB32735E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 17:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhB1QsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 11:48:24 -0500
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:43938 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhB1QsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 11:48:23 -0500
X-Greylist: delayed 616 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Feb 2021 11:48:22 EST
Received: from kamenik.kam.mff.cuni.cz (kamenik.kam.mff.cuni.cz [IPv6:2001:718:1e03:810::8f])
        by nikam.ms.mff.cuni.cz (Postfix) with ESMTP id D30A02805B6;
        Sun, 28 Feb 2021 17:37:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kam.mff.cuni.cz;
        s=gen1; t=1614530243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8CGa4uqAHGbgSuKWpiVbdnIdyuSgJntNKxif9nAs7uA=;
        b=icW8oCL9h2VY16hO9S/P7+WTdU9OW18xx0ZQ3Di2tIADhKIEvAc6ULZ+UopN7Fw4uV+sbH
        +gAOnhX1POrntDDWEIHivrqTdsqcd8gd8cQ/VixLc0C0s5SQcQHDSp5aCIw/vz0ooArJhO
        1AuxKfW8eEinQWbRLjYZt2V6hiNkb4g=
Received: by kamenik.kam.mff.cuni.cz (Postfix, from userid 3165)
        id C75602400B1; Sun, 28 Feb 2021 17:37:22 +0100 (CET)
From:   =?UTF-8?q?Pavel=20Turinsk=C3=BD?= <ledoian@kam.mff.cuni.cz>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pavel=20Turinsk=C3=BD?= <ledoian@kam.mff.cuni.cz>,
        trivial@kernel.org
Subject: [PATCH] MAINTAINERS: update drm bug reporting URL
Date:   Sun, 28 Feb 2021 17:36:58 +0100
Message-Id: <20210228163658.54962-1-ledoian@kam.mff.cuni.cz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original bugzilla seems to be read-only now, linking to the gitlab
for new bugs.

Signed-off-by: Pavel Turinský <ledoian@kam.mff.cuni.cz>
Cc: trivial@kernel.org
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bfc1b86e3e73..434adb869522 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5793,7 +5793,7 @@ M:	David Airlie <airlied@linux.ie>
 M:	Daniel Vetter <daniel@ffwll.ch>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
-B:	https://bugs.freedesktop.org/
+B:	https://gitlab.freedesktop.org/drm
 C:	irc://chat.freenode.net/dri-devel
 T:	git git://anongit.freedesktop.org/drm/drm
 F:	Documentation/devicetree/bindings/display/
-- 
2.20.1

