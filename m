Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9117642EAD3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbhJOIBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:01:18 -0400
Received: from mx24.baidu.com ([111.206.215.185]:55946 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236454AbhJOIBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:01:17 -0400
Received: from BJHW-Mail-Ex13.internal.baidu.com (unknown [10.127.64.36])
        by Forcepoint Email with ESMTPS id 2C981B763F1651A4C1D6;
        Fri, 15 Oct 2021 15:59:06 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex13.internal.baidu.com (10.127.64.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 15 Oct 2021 15:59:06 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 15 Oct 2021 15:59:04 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] docs: checkpatch: Add the description for RFC_TAG_PREFIX waining messsage
Date:   Fri, 15 Oct 2021 15:58:52 +0800
Message-ID: <20211015075853.4038-2-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211015075853.4038-1-caihuoqing@baidu.com>
References: <20211015075853.4038-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex31.internal.baidu.com (172.31.51.25) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex13_2021-10-15 15:59:06:217
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A check item for RFC tags is added to checkpatch.pl,
which will report RFC_TAG_PREFIX warning. so add
the description for RFC_TAG_PREFIX.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 Documentation/dev-tools/checkpatch.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index b52452bc2963..0da827af3d93 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -554,6 +554,16 @@ Commit message
 
     See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
 
+  **RFC_TAG_PREFIX**
+    RFC tag is outside subject prefix.
+    RFC tag outside subject prefix is incorrect like this::
+
+      Subject: [PATCH v2] RFC:
+
+    Perfer::
+
+      Subject: [RFC PATCH v2]
+
   **FROM_SIGN_OFF_MISMATCH**
     The author's email does not match with that in the Signed-off-by:
     line(s). This can be sometimes caused due to an improperly configured
-- 
2.25.1

