Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7498D3573DB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355075AbhDGSDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:03:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49764 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348357AbhDGSDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:03:22 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137HtIBr030161
        for <linux-kernel@vger.kernel.org>; Wed, 7 Apr 2021 11:03:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=1CcQ9x5X2Jkfw8Q9bvOrtQpSZ6g4vQz7LGnG3UaOiBk=;
 b=lc7yeooO73SXdOyiueqQ886L1sJ5lVmuxg8SLucML2Zw7vSa8pmmVOsf92I0PFF5JJsr
 XOFw33Wj+8U6cJVqR2zNTi5laTK8MmRf7/FdcLZP6YX11yux+3CltiqR6yTMRq8OrfL1
 g4SZgwc+N7snGtNPzyGMic6bgvGL6wTLoNo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37seq89h2p-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 11:03:12 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Apr 2021 11:00:10 -0700
Received: from devvm1945.atn0.facebook.com (localhost [127.0.0.1])
        by devvm1945.atn0.facebook.com (Postfix) with ESMTP id 50F1351ACC2D;
        Wed,  7 Apr 2021 11:00:06 -0700 (PDT)
Received: (from saravanand@localhost)
        by devvm1945.atn0.facebook.com (8.15.2/8.15.2/Submit) id 137I05lP4130564;
        Wed, 7 Apr 2021 11:00:05 -0700
X-Authentication-Warning: devvm1945.atn0.facebook.com: saravanand set sender to saravanand@fb.com using -f
From:   Saravanan D <saravanand@fb.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <tj@kernel.org>, <kernel-team@fb.com>,
        Saravanan D <saravanand@fb.com>
Subject: [PATCH] blk-mq: Fix spurious debugfs directory creation during initialization
Date:   Wed, 7 Apr 2021 10:59:58 -0700
Message-ID: <20210407175958.4129976-1-saravanand@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: OIf-LsZBu8MPtbTr26yvToqIYWfTx_ih
X-Proofpoint-ORIG-GUID: OIf-LsZBu8MPtbTr26yvToqIYWfTx_ih
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-07_09:2021-04-07,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1011 mlxlogscore=999 priorityscore=1501
 mlxscore=0 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_mq_debugfs_register_sched_hctx() called from
device_add_disk()->elevator_init_mq()->blk_mq_init_sched()
initialization sequence does not have relevant parent directory
setup and thus spuriously attempts "sched" directory creation
from root mount of debugfs for every hw queue detected on the
block device

dmesg
...
debugfs: Directory 'sched' with parent '/' already present!
debugfs: Directory 'sched' with parent '/' already present!
.
.
debugfs: Directory 'sched' with parent '/' already present!
...

The parent debugfs directory for hw queues get properly setup
device_add_disk()->blk_register_queue()->blk_mq_debugfs_register()
->blk_mq_debugfs_register_hctx() later in the block device
initialization sequence.

A simple check for debugfs_dir has been added to thwart premature
debugfs directory/file creation attempts.

Signed-off-by: Saravanan D <saravanand@fb.com>
---
 block/blk-mq-debugfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 271f6596435b..2a75bc7401df 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -972,6 +972,14 @@ void blk_mq_debugfs_register_sched_hctx(struct reque=
st_queue *q,
 {
 	struct elevator_type *e =3D q->elevator->type;
=20
+	/*
+	 * If the parent debugfs directory has not been created yet, return;
+	 * We will be called again later on with appropriate parent debugfs
+	 * directory from blk_register_queue()
+	 */
+	if (!hctx->debugfs_dir)
+		return;
+
 	if (!e->hctx_debugfs_attrs)
 		return;
=20
--=20
2.30.2

