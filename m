Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D23319C20
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhBLJv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:51:58 -0500
Received: from pv50p00im-ztdg10011901.me.com ([17.58.6.50]:50393 "EHLO
        pv50p00im-ztdg10011901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhBLJv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1613123461;
        bh=9GBiUZ1WuOiLbK9rV9T1+uUAqkzPi3muDJd+lEHIoTw=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=ith6ixhrNDlV1C6oZFTxA+isgdnQaP9ZgO1VCMYr1Qis+EEl5pK+yRH43CnqvIhXu
         wy+A9edZYnvzn6u2OtHVx8l92MIk627ZErukDxQjMUX8JSN8XaOn3NdsM2DfUGSpcd
         DrHHVsKCyCabs5agicF3FfkoL4G9lzTiZ2AFbZ9/YQAQoREjJwI8KvBw93sh+44w/T
         p4ESENchHxJFCrlkFtAlVUS8PafHt45O7wHUGgKkHNvwtpFK8jZR1nxyS0ZFv2ijSe
         tI0/yRsRePO1DS+kRwPtRpO4tpfVf3URccJj8MtQT4xuekNNkFmuVUIPJRSqDwwkbe
         CLgJJfVkqWd8w==
Received: from everest.nathzi1505 (unknown [103.17.84.167])
        by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id E8C0F80059B;
        Fri, 12 Feb 2021 09:50:57 +0000 (UTC)
From:   Pritthijit Nath <pritthijit.nath@icloud.com>
To:     vireshk@kernel.org, gregkh@linuxfoundation.org, johan@kernel.org,
        elder@kernel.org
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Pritthijit Nath <pritthijit.nath@icloud.com>
Subject: [PATCH 2/2] staging: greybus: Fixed a misspelling in hid.c
Date:   Fri, 12 Feb 2021 15:20:08 +0530
Message-Id: <20210212095008.11741-1-pritthijit.nath@icloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_02:2021-02-12,2021-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102120075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the spelling of 'transfered' to 'transferred'.

Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
---
 Fixed the typo in the patch which was meant to fix that very typo.
 Really sorry for last time.
 Hope this does not have any other typo.

 drivers/staging/greybus/hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/hid.c b/drivers/staging/greybus/hid.c
index a56c3fb5d35a..adb91286803a 100644
--- a/drivers/staging/greybus/hid.c
+++ b/drivers/staging/greybus/hid.c
@@ -254,7 +254,7 @@ static int __gb_hid_output_raw_report(struct hid_device *hid, __u8 *buf,
 
 	ret = gb_hid_set_report(ghid, report_type, report_id, buf, len);
 	if (report_id && ret >= 0)
-		ret++; /* add report_id to the number of transfered bytes */
+		ret++; /* add report_id to the number of transferred bytes */
 
 	return 0;
 }
-- 
2.25.1

