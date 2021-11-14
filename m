Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A1144F6F7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 06:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhKNF7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 00:59:09 -0500
Received: from smtpbg604.qq.com ([59.36.128.82]:39612 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhKNF7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 00:59:08 -0500
X-QQ-mid: bizesmtp50t1636869215tj5i0zs0
Received: from localhost.localdomain (unknown [125.69.41.88])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 14 Nov 2021 13:53:34 +0800 (CST)
X-QQ-SSF: 01000000002000C0F000B00A0000000
X-QQ-FEAT: F3yR32iATbj7zgJd4OfOTFZ4Jln/cK0WR1Cg+SbDW0cqJ2SNgB2MXngvnAgpo
        iVjaRRhM1FE3M5g2B1+IFLMeQovqRK+KpzxZqnXkh0LqpDEY9IjMV2uDCvTf0Lft4lp2JC/
        jiiXvuRoXHloixReVGMclO5B1TpvVnF5HuYybS4p3ncuYTwJNrDFfMHgcAaCYDyrJmGRf8X
        8qvQ7zyglXYmfJzgMJ/rDZxfOxa2Y+d19JTXNdTPNyAUIznOFawGXdQwLyaQUwJUX57JYKz
        gdi6LJS6sl5lo3nUWqlxwBLACmBQAICZkc8hdv+9dEtX3XkqaqMBSVu6uCMF4k/ZhpuTPf0
        qM26zWjHhreGw4pjX+y6EhcULateQ==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     kristo@kernel.org
Cc:     nm@ti.com, ssantosh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] firmware: ti_sci: rm: remove unneeded semicolon
Date:   Sun, 14 Nov 2021 13:53:33 +0800
Message-Id: <20211114055333.217919-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The semicolon after `}' is unneeded. So, just remove it.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/firmware/ti_sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 235c7e7869aa..5ae2040b8b02 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1759,7 +1759,7 @@ static int ti_sci_get_resource_range(const struct ti_sci_handle *handle,
 		desc->num = resp->range_num;
 		desc->start_sec = resp->range_start_sec;
 		desc->num_sec = resp->range_num_sec;
-	};
+	}
 
 fail:
 	ti_sci_put_one_xfer(&info->minfo, xfer);
-- 
2.33.0

