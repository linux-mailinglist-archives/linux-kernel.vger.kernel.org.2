Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E1E42C508
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhJMPoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbhJMPog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:44:36 -0400
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A79C06174E;
        Wed, 13 Oct 2021 08:42:31 -0700 (PDT)
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
        by m0050095.ppops.net-00190b01. (8.16.1.2/8.16.1.2) with SMTP id 19DDN64R004848;
        Wed, 13 Oct 2021 16:42:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=jan2016.eng;
 bh=bMgaSW7vsa4IMPeMvdRzcL5EDSL29n9Or2XEQZkEnw8=;
 b=EMFI+aU0FFTFMpAyI8dMSMwYoekLsowAf/k+GZeOCX/5V/Uh2Ym6kWz/X9uRVf+3ebNB
 HnoSVxCt9QHvnMpZZKFYElmsl0AmOSU+fCCq3Az4/+Y8Ipfc+dJkHFCDVzIuO4+exHs8
 C6uEpZ5LngKCWTVQgSGt5zuQMGvC/vkS+k3whYbxf94/5SAlYBNPQDO+YyC52rsine9j
 3Ddb7uE0Q8YQZWn8hDIMxOzkxgDw7wMwBjPkvF9bA9gGgCMwfdcjxvxVOgtk/2+EFGuu
 HpqGaoIHKovSEdjjXxKquaBtJJjWvKqN4bR7zECKXfhj/9uc6kdBc+Cx4oDWkiOzkRuE gw== 
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
        by m0050095.ppops.net-00190b01. with ESMTP id 3bp09vbf6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 16:42:26 +0100
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
        by prod-mail-ppoint6.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 19DFZ623019495;
        Wed, 13 Oct 2021 11:42:19 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint6.akamai.com with ESMTP id 3bnf5ysmg9-1;
        Wed, 13 Oct 2021 11:42:18 -0400
Received: from bos-lpjec.145bw.corp.akamai.com (bos-lpjec.145bw.corp.akamai.com [172.28.3.71])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id E4CAD27752;
        Wed, 13 Oct 2021 15:42:18 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     gregkh@linuxfoundation.org
Cc:     ahalaney@redhat.com, jim.cromie@gmail.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] Documentation: dyndbg: Improve cli param examples
Date:   Wed, 13 Oct 2021 11:40:22 -0400
Message-Id: <1634139622-20667-4-git-send-email-jbaron@akamai.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634139622-20667-1-git-send-email-jbaron@akamai.com>
References: <1634139622-20667-1-git-send-email-jbaron@akamai.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-10-13_06:2021-10-13,2021-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=657 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110130101
X-Proofpoint-ORIG-GUID: 0GY0gYC9xdl0J60BbVVYjWRmMbRhLIPv
X-Proofpoint-GUID: 0GY0gYC9xdl0J60BbVVYjWRmMbRhLIPv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_06,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=624 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Halaney <ahalaney@redhat.com>

Jim pointed out that using $module.dyndbg= is always a more flexible
choice for using dynamic debug on the command line. The $module.dyndbg
style is checked at boot and handles if $module is a builtin. If it is
actually a loadable module, it is handled again later when the module is
loaded.

If you just use dyndbg="module $module +p" dynamic debug is only enabled
when $module is a builtin.

It was recommended to illustrate wildcard usage as well.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
Suggested-by: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index d0911e7cc271..ae264aab42b6 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -357,7 +357,10 @@ Examples
   Kernel command line: ...
     // see whats going on in dyndbg=value processing
     dynamic_debug.verbose=1
-    // enable pr_debugs in 2 builtins, #cmt is stripped
-    dyndbg="module params +p #cmt ; module sys +p"
+    // enable pr_debugs in the btrfs module (can be builtin or loadable)
+    btrfs.dyndbg="+p"
+    // enable pr_debugs in all files under init/
+    // and the function parse_one, #cmt is stripped
+    dyndbg="file init/* +p #cmt ; func parse_one +p"
     // enable pr_debugs in 2 functions in a module loaded later
     pc87360.dyndbg="func pc87360_init_device +p; func pc87360_find +p"
-- 
2.7.4

