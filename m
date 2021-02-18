Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D1331EF10
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhBRS6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:58:00 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:15400 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233092AbhBRRKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:10:49 -0500
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11IH2f92021653
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=smtpout1;
 bh=AL6O6/4UzNnSX1pXXdvIbx6l2dOBH2jL6kSua+5++PA=;
 b=RwJTANEIy1yHGUJiHwMqW8b7x4NQxg7Knqh5u+ZUU09+CV8VUTguUlWLOJpYVKqoecxs
 thvpcP4dNFM5+qO+JrxZ8tB5RQiJvK/3RIOU3+k9mFCQUVQGzL5ZM/ysX6DpuIh1QFbi
 nJG/R3gtL29Aktfd5UhP4gfBZFsWLBcfinBc46CnE0BRVTjUDWsoDxclWjaL3CCLfvO4
 DcenMiVUtKNCyYyy/WaZop+hjE0d/iZh++FoJFYVtbw6ii4f9WMWakIeNunReHECRu3X
 LVQRdKW/A/BioVkfZL+vDoWRV2fxpTIPs/PFJ0iPPGfD0k5Fm4Ujn8WYUmI891oDJ8Sr mg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 36paveh5u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:09:54 -0500
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11IGxh2D024487
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:09:53 -0500
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0a-00154901.pphosted.com with ESMTP id 36pw7qbfw8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:09:53 -0500
X-LoopCount0: from 10.177.160.151
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.81,187,1610431200"; 
   d="scan'208";a="1047578352"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>, jorgelo@chromium.org,
        campello@google.com, Mario Limonciello <mario.limonciello@dell.com>
Subject: [RFC 1/2] capability: Introduce CAP_FIRMWARE_UPGRADE
Date:   Thu, 18 Feb 2021 11:09:46 -0600
Message-Id: <20210218170947.15727-2-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218170947.15727-1-mario.limonciello@dell.com>
References: <20210218170947.15727-1-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_08:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180144
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split out permissions specifically for firmware upgrades from
CAP_SYS_ADMIN to a new separate capability.  This will allow userspace
applications that would traditionally have needed CAP_SYS_ADMIN to perform
firmware upgrades to have a reduced permission set.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 include/linux/capability.h          | 5 +++++
 include/uapi/linux/capability.h     | 7 ++++++-
 security/selinux/include/classmap.h | 4 ++--
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index b2f698915c0f..e9233e217402 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -267,6 +267,11 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 		ns_capable(ns, CAP_SYS_ADMIN);
 }
 
+static inline bool firmware_upgrade_capable(void)
+{
+	return capable(CAP_FIRMWARE_UPGRADE) || capable(CAP_SYS_ADMIN);
+}
+
 /* audit system wants to get cap info from files as well */
 extern int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data *cpu_caps);
 
diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index c6ca33034147..0f204c6a1c0b 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -275,6 +275,7 @@ struct vfs_ns_cap_data {
 /* Allow setting encryption key on loopback filesystem */
 /* Allow setting zone reclaim policy */
 /* Allow everything under CAP_BPF and CAP_PERFMON for backward compatibility */
+/* Allow everything under CAP_FIRMWARE_UPGRADE for backward compatibility */
 
 #define CAP_SYS_ADMIN        21
 
@@ -417,7 +418,11 @@ struct vfs_ns_cap_data {
 
 #define CAP_CHECKPOINT_RESTORE	40
 
-#define CAP_LAST_CAP         CAP_CHECKPOINT_RESTORE
+/* Allow a device firmware upgrade */
+
+#define CAP_FIRMWARE_UPGRADE	41
+
+#define CAP_LAST_CAP         CAP_FIRMWARE_UPGRADE
 
 #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
 
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 40cebde62856..188318eefb41 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -28,9 +28,9 @@
 
 #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
 		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf", \
-		"checkpoint_restore"
+		"checkpoint_restore", "firmware_upgrade"
 
-#if CAP_LAST_CAP > CAP_CHECKPOINT_RESTORE
+#if CAP_LAST_CAP > CAP_FIRMWARE_UPGRADE
 #error New capability defined, please update COMMON_CAP2_PERMS.
 #endif
 
-- 
2.25.1

