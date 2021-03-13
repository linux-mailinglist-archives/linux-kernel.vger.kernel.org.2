Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DD6339CDE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 09:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhCMIW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 03:22:58 -0500
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:48376 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhCMIWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 03:22:46 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id EE096400168;
        Sat, 13 Mar 2021 16:22:42 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] mailbox: Remove unnecessary THIS_MODULE
Date:   Sat, 13 Mar 2021 16:22:38 +0800
Message-Id: <1615623758-16108-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQkhNS0tDQx9DGk9PVkpNSk5NSUhMTUhKTktVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKSkNITVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KxA6SRw*UT8RIVEDFwI0KUtN
        TT4aCzJVSlVKTUpOTUlITE1IT0xPVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKSk9LNwY+
X-HM-Tid: 0a782aae3481d991kuwsee096400168
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As THIS_MODULE has been set in platform_create_bundle(), so remove it.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/mailbox/pcc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index ef9ecd1..4b1a2d2
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -577,7 +577,6 @@ static struct platform_driver pcc_mbox_driver = {
 	.probe = pcc_mbox_probe,
 	.driver = {
 		.name = "PCCT",
-		.owner = THIS_MODULE,
 	},
 };
 
-- 
2.7.4

