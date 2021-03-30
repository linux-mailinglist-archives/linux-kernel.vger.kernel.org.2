Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEEC34EA11
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhC3ON7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhC3ONW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:13:22 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B759C061574;
        Tue, 30 Mar 2021 07:13:21 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lRF7I-0000jw-1w; Tue, 30 Mar 2021 16:13:12 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] MAINTAINERS: add entry for Documentation/admin-guide/reporting-issues.rst
Date:   Tue, 30 Mar 2021 16:13:05 +0200
Message-Id: <c8d55ec74d104b90fdb9c155bca3b407e8480fb3.1617113469.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617113469.git.linux@leemhuis.info>
References: <cover.1617113469.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1617113602;38c5c4bd;
X-HE-SMSGID: 1lRF7I-0000jw-1w
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten will keep an eye on the new document about reporting issues
(aka bugs).

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e66ff3daf23c..b5d38fedff6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5413,6 +5413,12 @@ X:	Documentation/power/
 X:	Documentation/spi/
 X:	Documentation/userspace-api/media/
 
+DOCUMENTATION REPORTING ISSUES
+M:	Thorsten Leemhuis <linux@leemhuis.info>
+L:	linux-doc@vger.kernel.org
+S:	Maintained
+F:	Documentation/admin-guide/reporting-issues.rst
+
 DOCUMENTATION SCRIPTS
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-doc@vger.kernel.org
-- 
2.30.2

