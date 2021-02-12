Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E6D319C73
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhBLKO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:14:59 -0500
Received: from pv50p00im-ztdg10021901.me.com ([17.58.6.55]:52148 "EHLO
        pv50p00im-ztdg10021901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229906AbhBLKOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1613124830;
        bh=zKxn6CR/gmXhVeTG2aKkLvzoS7M7r385JLEcPBaeWp8=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=r83pITR4RBAHpGZED7IN+IVT3ijUdmE5PZh3GB9EcoRaWsIa5sZKi/NJ1LzM/tCYk
         zoQ3OEg0bL2DxUQw65zVLorZlwZJoaoLp/a9LRoF4GbqlxdLTQJwDB2b8ScMC0fv5+
         DThfJp6xoqd0AN8dQWqhMEY5HyBwFVt4zXS+GSIEp+Mwm5r4b6Ovm9OFA4HchUCO0p
         P+RMpu9SR8ZKmqGiFsi2WlPvElbRmUTk8kmKomUXRK/fTveBYksgSpFKxyRngcTDei
         5ptNdy1/tKGb7pe+Xn87lShwlNBeESr+n52wcCs2BZ+/6Dzx8QdzaiQogy/al4E/pa
         uEYF5CBIJ5pGw==
Received: from everest.nathzi1505 (unknown [103.17.84.167])
        by pv50p00im-ztdg10021901.me.com (Postfix) with ESMTPSA id 53AA788034D;
        Fri, 12 Feb 2021 10:13:46 +0000 (UTC)
From:   Pritthijit Nath <pritthijit.nath@icloud.com>
To:     vireshk@kernel.org, gregkh@linuxfoundation.org, johan@kernel.org,
        elder@kernel.org
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Pritthijit Nath <pritthijit.nath@icloud.com>
Subject: [PATCH 2/2] staging: greybus: Fixed a misspelling in hid.c
Date:   Fri, 12 Feb 2021 15:43:24 +0530
Message-Id: <20210212101324.12391-1-pritthijit.nath@icloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_03:2021-02-12,2021-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102120077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the spelling of 'transfered' to 'transferred'.

Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
---
 Fixed the typo in 'transferred' which crept in last time.

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

