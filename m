Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C507319B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 09:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhBLIUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 03:20:14 -0500
Received: from pv50p00im-ztdg10011301.me.com ([17.58.6.40]:40546 "EHLO
        pv50p00im-ztdg10011301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229611AbhBLIUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 03:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1613117954;
        bh=mF341d1YTvkybGz/812cN3sUxzz77JK/zSFMtSWK9tQ=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=oZSvsXy30ynig0wGe+j1KV88PpZtUnNowgS/qjTRUjqG3PnXVHqdf8KVElwNckaMp
         gBAYwIejYkGo9xOI9LM0I7cKMPWI1vI2z6TwmUkv/A6tmJBpEwd1L75fWhKXJj+kOG
         1NUJMqXrH3pdGTJOUQPlgUr2iNBZIEKj+jNifb3S8fzoWzx+XcPXorAY6ycZ+7MJX2
         3qZA9xKTgfOfRUJMPtx+e23GJIE6/UDmdebvS8l1somIJNZ++nNq5jC/VONWy4ovy0
         pLwqFvS/b+Q3LQCMhELW7OzIFAsMUaS1DSrhN5EKluGhfJWmd6o42nqN1Xqq6fA/Z9
         WxrE2VSnCZ69w==
Received: from everest.nathzi1505 (unknown [103.17.84.167])
        by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 902077605DB;
        Fri, 12 Feb 2021 08:19:11 +0000 (UTC)
From:   Pritthijit Nath <pritthijit.nath@icloud.com>
To:     vireshk@kernel.org, gregkh@linuxfoundation.org, johan@kernel.org,
        elder@kernel.org
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Pritthijit Nath <pritthijit.nath@icloud.com>
Subject: [PATCH 2/2] staging: greybus: Fixed a misspelling in hid.c
Date:   Fri, 12 Feb 2021 13:48:35 +0530
Message-Id: <20210212081835.9497-2-pritthijit.nath@icloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210212081835.9497-1-pritthijit.nath@icloud.com>
References: <20210212081835.9497-1-pritthijit.nath@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_02:2021-02-12,2021-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102120063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the spelling of 'transfered' to 'transferred'.

Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
---
 drivers/staging/greybus/hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/hid.c b/drivers/staging/greybus/hid.c
index a56c3fb5d35a..6b19ff4743a9 100644
--- a/drivers/staging/greybus/hid.c
+++ b/drivers/staging/greybus/hid.c
@@ -254,7 +254,7 @@ static int __gb_hid_output_raw_report(struct hid_device *hid, __u8 *buf,

 	ret = gb_hid_set_report(ghid, report_type, report_id, buf, len);
 	if (report_id && ret >= 0)
-		ret++; /* add report_id to the number of transfered bytes */
+		ret++; /* add report_id to the number of transferrid bytes */

 	return 0;
 }
--
2.25.1

