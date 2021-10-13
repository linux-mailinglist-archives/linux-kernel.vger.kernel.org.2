Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF5042C507
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhJMPok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbhJMPog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:44:36 -0400
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3887C061570;
        Wed, 13 Oct 2021 08:42:30 -0700 (PDT)
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
        by m0050095.ppops.net-00190b01. (8.16.1.2/8.16.1.2) with SMTP id 19DDN6Bu004835;
        Wed, 13 Oct 2021 16:42:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=jan2016.eng;
 bh=YS3UkTfbElms2s0uMaZvG4sIEcDec9NNHRzVLKPJ1ZU=;
 b=JGxJqTTwaFxoCjzX0GqYJ8hmjWj6+TCoWGzoHJHnfzY31834hHzslhWE3nqUgIf4CiEy
 XP6jHQnR2HBnEbnYEMk3wgrmkE9lNIfLOjSFUUAetGAItJ80xLom7rqoL/ZVxOgzdBk7
 OYLzGZssMplzzq0O7Wnta/bzjBbyyE/j6jQvWVmbONFy2AoCpmX76c7kZio5cX1t7ggU
 LMU6wa08dLkKZ5OoHozh7zMNXzjnDSwg+8PyVtypXG5TPiiiSoe+NPFF+Pg0ZyCpj8p6
 TPBv4Oyweaz1j+IYI0Cgx3k/nSS5fW+CPhntNcXajPO9YN8B+E+geceHPxtonmCFYOxT kQ== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by m0050095.ppops.net-00190b01. with ESMTP id 3bp09vbf5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 16:42:25 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 19DFXYs7013011;
        Wed, 13 Oct 2021 11:42:15 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint1.akamai.com with ESMTP id 3bneah9r5v-1;
        Wed, 13 Oct 2021 11:42:15 -0400
Received: from bos-lpjec.145bw.corp.akamai.com (bos-lpjec.145bw.corp.akamai.com [172.28.3.71])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id CA36D27752;
        Wed, 13 Oct 2021 15:42:15 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     gregkh@linuxfoundation.org
Cc:     ahalaney@redhat.com, jim.cromie@gmail.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dyndbg: make dyndbg a known cli param
Date:   Wed, 13 Oct 2021 11:40:20 -0400
Message-Id: <1634139622-20667-2-git-send-email-jbaron@akamai.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634139622-20667-1-git-send-email-jbaron@akamai.com>
References: <1634139622-20667-1-git-send-email-jbaron@akamai.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-10-13_06:2021-10-13,2021-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=920 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130101
X-Proofpoint-ORIG-GUID: j848r73GxmHbRcwFusgaRALnddFcuPjr
X-Proofpoint-GUID: j848r73GxmHbRcwFusgaRALnddFcuPjr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_06,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=913 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Halaney <ahalaney@redhat.com>

Right now dyndbg shows up as an unknown parameter if used on boot:

    Unknown command line parameters: dyndbg=+p

That's because it is unknown, it doesn't sit in the __param
section, so the processing done to warn users supplying an unknown
parameter doesn't think it is legitimate.

Install a dummy handler to register it. dynamic debug needs to search
the whole command line for modules listed that are currently builtin,
so there's no real work to be done in this callback.

Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
Tested-by: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 lib/dynamic_debug.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index cb5abb42c16a..84c16309cc63 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -762,6 +762,18 @@ static __init int ddebug_setup_query(char *str)
 __setup("ddebug_query=", ddebug_setup_query);
 
 /*
+ * Install a noop handler to make dyndbg look like a normal kernel cli param.
+ * This avoids warnings about dyndbg being an unknown cli param when supplied
+ * by a user.
+ */
+static __init int dyndbg_setup(char *str)
+{
+	return 1;
+}
+
+__setup("dyndbg=", dyndbg_setup);
+
+/*
  * File_ops->write method for <debugfs>/dynamic_debug/control.  Gathers the
  * command text from userspace, parses and executes it.
  */
-- 
2.7.4

