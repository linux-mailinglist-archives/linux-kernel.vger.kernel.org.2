Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB928319B1A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 09:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhBLIUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 03:20:02 -0500
Received: from pv50p00im-ztdg10011301.me.com ([17.58.6.40]:39873 "EHLO
        pv50p00im-ztdg10011301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229625AbhBLIUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 03:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1613117944;
        bh=mCP60QzB4Xmc4Ln+UcyddAgkfpo4+d8gMR9T+A+GPF4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=OE4HAGp9xHIpz6mRtPVtsLn7ImTn+FW0FIVtttbqBPYNEn5yNpJlP3fFNH57l4Rro
         IeW77yodSj/vpGAhBLfsIrX94EksuIKFg5bhWwtOxJtzcJUzWBWDE8l7RwAn+BZEHr
         S50fNm4I7CHCiRVCv9iYf0tByzrP3meH/q8aYgo7O6pa+9Ev0pV+HiRg0hKecuuUPU
         SKuYCKS44fEpkFdMq5FCYqaBTwL2xhu8VWoeJ9qPLwEVmqmfRmsSLcooqQes0RvBt4
         QnelrOwIJ5c/qMAC035EJKJZ/NYCkjTmThlxH6bHJXLl+6tq7NSs5N5jfJ756520KW
         FFQS0n3Hmdc+g==
Received: from everest.nathzi1505 (unknown [103.17.84.167])
        by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 736FF7605AB;
        Fri, 12 Feb 2021 08:19:00 +0000 (UTC)
From:   Pritthijit Nath <pritthijit.nath@icloud.com>
To:     vireshk@kernel.org, gregkh@linuxfoundation.org, johan@kernel.org,
        elder@kernel.org
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Pritthijit Nath <pritthijit.nath@icloud.com>
Subject: [PATCH 1/2] staging: greybus: Fixed alignment issue in hid.c
Date:   Fri, 12 Feb 2021 13:48:34 +0530
Message-Id: <20210212081835.9497-1-pritthijit.nath@icloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_02:2021-02-12,2021-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102120063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change fixes a checkpatch CHECK style issue for "Alignment should match
open parenthesis".

Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
---
 drivers/staging/greybus/hid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/hid.c b/drivers/staging/greybus/hid.c
index ed706f39e87a..a56c3fb5d35a 100644
--- a/drivers/staging/greybus/hid.c
+++ b/drivers/staging/greybus/hid.c
@@ -221,8 +221,8 @@ static void gb_hid_init_reports(struct gb_hid *ghid)
 }

 static int __gb_hid_get_raw_report(struct hid_device *hid,
-		unsigned char report_number, __u8 *buf, size_t count,
-		unsigned char report_type)
+				   unsigned char report_number, __u8 *buf, size_t count,
+				   unsigned char report_type)
 {
 	struct gb_hid *ghid = hid->driver_data;
 	int ret;
--
2.25.1

