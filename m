Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A702A31EF11
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhBRS6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:58:10 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:16304 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233077AbhBRRKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:10:49 -0500
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11IH2gTl021663
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=smtpout1;
 bh=9S4EC0xwqnAuwOEUZFswsiYg05kZ0oxFSLtqtPENi9c=;
 b=mH10P6/xSjA8mClUuLApG77HEMm2865s7WZF/JRj27oPEhm9Qa5KmkCBNGuVsGIBjxS6
 Yeo7n9c+Z3jj2JGupeddUFwsiHm860vXVbl/VbzMeL+gGRXxtT/ZTuUyIkLehjmzD2W1
 pA136SOTpEv7Z5lJo/ocWseOrJz++Oz/3e1unJ/N4lSEStzSYo1JMiSwHTH7JvlynzYW
 iVyEZpk3wQWGslyOeef7wPSwenJnK0FcUZvcZwJ/HUhUrHGOJbLHBs2o8Lr5T8+kcJ+I
 x0LhqE6TSqbSKmD0YgXd3hnG1VmGGHtjXiBQxTCBwTrA9hQMUUVX3GriZkW8EIL/+AD2 /w== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 36paveh5u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:09:54 -0500
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11IGxh2F024487
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:09:53 -0500
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0a-00154901.pphosted.com with ESMTP id 36pw7qbfw8-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:09:53 -0500
X-LoopCount0: from 10.177.160.151
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.81,187,1610431200"; 
   d="scan'208";a="1047578354"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>, jorgelo@chromium.org,
        campello@google.com, Mario Limonciello <mario.limonciello@dell.com>
Subject: [RFC 2/2] nvme: Use CAP_FIRMWARE_UPGRADE to check user commands
Date:   Thu, 18 Feb 2021 11:09:47 -0600
Message-Id: <20210218170947.15727-3-mario.limonciello@dell.com>
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

Software that is running with CAP_FIRMWARE_UPGRADE needs a limited
set of opcode access:
* Identify the disk
* Download firmware to the disk
* Commit the firmwware to the disk

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/nvme/host/core.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f13eb4ded95f..80be3d6b7437 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1593,13 +1593,23 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	u64 result;
 	int status;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
 	if (cmd.flags)
 		return -EINVAL;
 
+	switch (cmd.opcode) {
+	case nvme_admin_identify:
+	case nvme_admin_activate_fw:
+	case nvme_admin_download_fw:
+		if (!firmware_upgrade_capable())
+			return -EACCES;
+		break;
+	default:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EACCES;
+	}
+
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
 	c.common.flags = cmd.flags;
@@ -1637,13 +1647,23 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	unsigned timeout = 0;
 	int status;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
 	if (cmd.flags)
 		return -EINVAL;
 
+	switch (cmd.opcode) {
+	case nvme_admin_identify:
+	case nvme_admin_activate_fw:
+	case nvme_admin_download_fw:
+		if (!firmware_upgrade_capable())
+			return -EACCES;
+		break;
+	default:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EACCES;
+	}
+
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
 	c.common.flags = cmd.flags;
-- 
2.25.1

