Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C25348918
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 07:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCYG3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 02:29:08 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:13064 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhCYG3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 02:29:03 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id CEA49980342;
        Thu, 25 Mar 2021 14:29:01 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] drivers: staging: _adapter is declared twice
Date:   Thu, 25 Mar 2021 14:28:40 +0800
Message-Id: <20210325062843.852204-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGRlNQk5DHR1JGExLVkpNSk1NTkhMT0lLTUtVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KzI6IRw5CT8UOD4RLDRNCQEL
        TEIaCxVVSlVKTUpNTU5ITE9JSElMVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTUpMNwY+
X-HM-Tid: 0a7868126f95d992kuwscea49980342
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct _adapter has been declared at 23rd line. 
Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/staging/rtl8712/drv_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index 0c4325073c63..976d19cdcf87 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -36,7 +36,6 @@ enum _NIC_VERSION {
 	RTL8716_NIC
 };
 
-struct _adapter;
 
 struct	qos_priv	{
 	/* bit mask option: u-apsd, s-apsd, ts, block ack... */
-- 
2.25.1

