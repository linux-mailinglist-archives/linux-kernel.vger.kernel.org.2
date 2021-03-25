Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5805C348AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 09:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhCYIBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 04:01:25 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:35432 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhCYIBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 04:01:01 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id F0D3B980582;
        Thu, 25 Mar 2021 16:00:56 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] [v3] drivers: staging: _adapter is declared twice
Date:   Thu, 25 Mar 2021 16:00:46 +0800
Message-Id: <20210325080050.861273-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0hMTk5DSRoaSkwdVkpNSk1NTkJJTkxJSEJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hOT1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxA6Cww6KT8VQz4QIQpJORcx
        OggKCzVVSlVKTUpNTU5CSU5DSE9DVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTE9JNwY+
X-HM-Tid: 0a786866974cd992kuwsf0d3b980582
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct _adapter has been declared at 23rd line.
Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
Changelog:
v3:
- Delete trailing whitespace.

v2:
- Delete the blank line.
---
 drivers/staging/rtl8712/drv_types.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index 0c4325073c63..a44d04effc8b 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -36,8 +36,6 @@ enum _NIC_VERSION {
 	RTL8716_NIC
 };
 
-struct _adapter;
-
 struct	qos_priv	{
 	/* bit mask option: u-apsd, s-apsd, ts, block ack... */
 	unsigned int qos_option;
-- 
2.25.1

