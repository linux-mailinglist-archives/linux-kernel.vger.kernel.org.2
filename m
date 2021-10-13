Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3A142C505
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbhJMPoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbhJMPog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:44:36 -0400
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E391DC061746;
        Wed, 13 Oct 2021 08:42:30 -0700 (PDT)
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
        by m0050095.ppops.net-00190b01. (8.16.1.2/8.16.1.2) with SMTP id 19DDNH7f004949;
        Wed, 13 Oct 2021 16:42:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=jan2016.eng;
 bh=k9yOyr6XpqBefjUfocPkvcZLR2GdgHM0Xy+F3BDcisQ=;
 b=O0eBGW9DZGg1FswK7OdFtLKHSdnaI9qBs7beltR2wavgVyysH/qwuSSf0vuBzsjxE6Oy
 ytfMJm+gVhh4vAnpJEzEfeGCM1XHYiJlro3BZhHtc2eULt5JLtznsPfjawQN1d+iDwTL
 Xlh09hv36EF6RuNpL+2gM8fi7jnd+D7v04y8shF29BYrNx+CH4pHD59A7Hnndks3Tqch
 vsRsFwLZME1KV+xTzOs2Utj7fXA9DpAz/57wVtsMJPP7AF+kNLjnB8yKinEK+ekzX816
 h8q01OQdgx0lcF/1IAn2dIUcgipFpNo0l9pxEUHyQaQ3dbLj/D2r6a4IRK7jVsvqLrDg hw== 
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
        by m0050095.ppops.net-00190b01. with ESMTP id 3bp09vbf6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 16:42:26 +0100
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
        by prod-mail-ppoint5.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 19DFZADa020146;
        Wed, 13 Oct 2021 08:42:18 -0700
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint5.akamai.com with ESMTP id 3bnf6fhn0j-1;
        Wed, 13 Oct 2021 08:42:17 -0700
Received: from bos-lpjec.145bw.corp.akamai.com (bos-lpjec.145bw.corp.akamai.com [172.28.3.71])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id D5EBA27755;
        Wed, 13 Oct 2021 15:42:17 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     gregkh@linuxfoundation.org
Cc:     ahalaney@redhat.com, jim.cromie@gmail.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dyndbg: Remove support for ddebug_query param
Date:   Wed, 13 Oct 2021 11:40:21 -0400
Message-Id: <1634139622-20667-3-git-send-email-jbaron@akamai.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634139622-20667-1-git-send-email-jbaron@akamai.com>
References: <1634139622-20667-1-git-send-email-jbaron@akamai.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-10-13_06:2021-10-13,2021-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110130101
X-Proofpoint-ORIG-GUID: u4X_XlLDBpAFXrFLI-O-9J0NlJFSQ2aV
X-Proofpoint-GUID: u4X_XlLDBpAFXrFLI-O-9J0NlJFSQ2aV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_06,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Halaney <ahalaney@redhat.com>

This param has been deprecated for a very long time now, let's rip it
out.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst |  6 ++----
 Documentation/admin-guide/kernel-parameters.txt   |  5 -----
 lib/dynamic_debug.c                               | 25 -----------------------
 3 files changed, 2 insertions(+), 34 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index b119b8277b3e..d0911e7cc271 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -249,8 +249,7 @@ Debug messages during Boot Process
 
 To activate debug messages for core code and built-in modules during
 the boot process, even before userspace and debugfs exists, use
-``dyndbg="QUERY"``, ``module.dyndbg="QUERY"``, or ``ddebug_query="QUERY"``
-(``ddebug_query`` is obsoleted by ``dyndbg``, and deprecated).  QUERY follows
+``dyndbg="QUERY"`` or ``module.dyndbg="QUERY"``.  QUERY follows
 the syntax described above, but must not exceed 1023 characters.  Your
 bootloader may impose lower limits.
 
@@ -270,8 +269,7 @@ this boot parameter for debugging purposes.
 
 If ``foo`` module is not built-in, ``foo.dyndbg`` will still be processed at
 boot time, without effect, but will be reprocessed when module is
-loaded later. ``ddebug_query=`` and bare ``dyndbg=`` are only processed at
-boot.
+loaded later. Bare ``dyndbg=`` is only processed at boot.
 
 
 Debug Messages at Module Initialization Time
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 91ba391f9b32..9c0c57d1ca78 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -841,11 +841,6 @@
 			Format: <port#>,<type>
 			See also Documentation/input/devices/joystick-parport.rst
 
-	ddebug_query=	[KNL,DYNAMIC_DEBUG] Enable debug messages at early boot
-			time. See
-			Documentation/admin-guide/dynamic-debug-howto.rst for
-			details.  Deprecated, see dyndbg.
-
 	debug		[KNL] Enable kernel debugging (events log level).
 
 	debug_boot_weak_hash
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 84c16309cc63..130ce0eb550d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -746,21 +746,6 @@ EXPORT_SYMBOL(__dynamic_ibdev_dbg);
 
 #endif
 
-#define DDEBUG_STRING_SIZE 1024
-static __initdata char ddebug_setup_string[DDEBUG_STRING_SIZE];
-
-static __init int ddebug_setup_query(char *str)
-{
-	if (strlen(str) >= DDEBUG_STRING_SIZE) {
-		pr_warn("ddebug boot param string too large\n");
-		return 0;
-	}
-	strlcpy(ddebug_setup_string, str, DDEBUG_STRING_SIZE);
-	return 1;
-}
-
-__setup("ddebug_query=", ddebug_setup_query);
-
 /*
  * Install a noop handler to make dyndbg look like a normal kernel cli param.
  * This avoids warnings about dyndbg being an unknown cli param when supplied
@@ -1133,16 +1118,6 @@ static int __init dynamic_debug_init(void)
 		 entries, modct, (int)((modct * sizeof(struct ddebug_table)) >> 10),
 		 (int)((entries * sizeof(struct _ddebug)) >> 10));
 
-	/* apply ddebug_query boot param, dont unload tables on err */
-	if (ddebug_setup_string[0] != '\0') {
-		pr_warn("ddebug_query param name is deprecated, change it to dyndbg\n");
-		ret = ddebug_exec_queries(ddebug_setup_string, NULL);
-		if (ret < 0)
-			pr_warn("Invalid ddebug boot param %s\n",
-				ddebug_setup_string);
-		else
-			pr_info("%d changes by ddebug_query\n", ret);
-	}
 	/* now that ddebug tables are loaded, process all boot args
 	 * again to find and activate queries given in dyndbg params.
 	 * While this has already been done for known boot params, it
-- 
2.7.4

