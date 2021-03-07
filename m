Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE44D3301D0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 15:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhCGOA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 09:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhCGOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 09:00:33 -0500
Received: from smtp.gentoo.org (dev.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5DEC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 06:00:32 -0800 (PST)
Received: by sf.home (Postfix, from userid 1000)
        id E36655A22061; Sun,  7 Mar 2021 14:00:25 +0000 (GMT)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] docs: don't include Documentation/Kconfig twice
Date:   Sun,  7 Mar 2021 14:00:18 +0000
Message-Id: <20210307140018.757576-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before the change there were two inclusions of Documentation/Kconfig:
    lib/Kconfig.debug:source "Documentation/Kconfig"
    Kconfig: source "Documentation/Kconfig"

Kconfig also included 'source "lib/Kconfig.debug"'.

Noticed as two 'make menuconfig' entries in both top level menu
and in 'Kernel hacking' menu. The patch keeps entries only in
'Kernel hacking'.

CC: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index 745bc773f567..97ed6389c921 100644
--- a/Kconfig
+++ b/Kconfig
@@ -28,5 +28,3 @@ source "crypto/Kconfig"
 source "lib/Kconfig"
 
 source "lib/Kconfig.debug"
-
-source "Documentation/Kconfig"
-- 
2.30.1

