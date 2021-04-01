Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DC4351249
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhDAJbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:31:33 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:35908 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbhDAJbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:31:00 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 89A4698050F;
        Thu,  1 Apr 2021 17:30:58 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] mfd: abx500: Remove repeated struct declaration
Date:   Thu,  1 Apr 2021 17:30:52 +0800
Message-Id: <20210401093052.1004712-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZS05CTxlIGEtOTk1JVkpNSkxJTUJPTkNNTExVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MVE6Fyo4Mz8ULCsePjJKIQxK
        DBUKFDhVSlVKTUpMSU1CT05DQkxKVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTU9KNwY+
X-HM-Tid: 0a788cc586b4d992kuws89a4698050f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct ab8500_fg is declared twice. The blew one at 457th line
is closer to user. Remove the duplicate here.
Move "Forward declaration" annotation to the suitable place.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/linux/mfd/abx500/ab8500-bm.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/mfd/abx500/ab8500-bm.h b/include/linux/mfd/abx500/ab8500-bm.h
index 903e94c189d8..0b88eddcc5af 100644
--- a/include/linux/mfd/abx500/ab8500-bm.h
+++ b/include/linux/mfd/abx500/ab8500-bm.h
@@ -296,9 +296,6 @@ struct batres_vs_temp {
 	int resist;
 };
 
-/* Forward declaration */
-struct ab8500_fg;
-
 /**
  * struct ab8500_fg_parameters - Fuel gauge algorithm parameters, in seconds
  * if not specified
@@ -452,6 +449,7 @@ struct ab8500_bm_data {
 	const struct ab8500_fg_parameters *fg_params;
 };
 
+/* Forward declaration */
 struct ab8500_btemp;
 struct ab8500_gpadc;
 struct ab8500_fg;
-- 
2.25.1

