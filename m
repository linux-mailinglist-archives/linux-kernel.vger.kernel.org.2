Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9EB3058BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbhA0Kqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:46:35 -0500
Received: from www.zeus03.de ([194.117.254.33]:37960 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236122AbhA0KpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=5UQI1LYAXwqFKXoEyvUNXKTsLtu
        Vd5ntVDjhbm45UHA=; b=SJ7ZKIqlAOgho+MH/IHhASm5zXTJY6pTNWr2axH7F7W
        pCynBfmsAo2hsKR2hFuiaQsr4ezhADbe0kB+rO4wiGjM/Qa0FE7SfsB3PYlqqhPZ
        6IbMEhJ+4uIiM17YnAj5X8Vr7HyvWSUUaNtcfGAQHgIA9SbLcHAyIPKNF9o9SHtA
        =
Received: (qmail 4028315 invoked from network); 27 Jan 2021 11:43:51 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Jan 2021 11:43:51 +0100
X-UD-Smtp-Session: l3s3148p1@LwJfct+5sr0gAwDPXyX1AEdA8SGgn5QT
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] Documentation: kernel-parameters: add missing '<'
Date:   Wed, 27 Jan 2021 11:43:43 +0100
Message-Id: <20210127104343.5647-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/admin-guide/kernel-parameters.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 06fb1b4aa849..202fac80ea0c 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -60,7 +60,7 @@ Note that for the special case of a range one can split the range into equal
 sized groups and for each group use some amount from the beginning of that
 group:
 
-	<cpu number>-cpu number>:<used size>/<group size>
+	<cpu number>-<cpu number>:<used size>/<group size>
 
 For example one can add to the command line following parameter:
 
-- 
2.28.0

