Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F385C33339A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 04:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhCJDHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 22:07:13 -0500
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:52506 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhCJDHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 22:07:09 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 51D074001A9;
        Wed, 10 Mar 2021 11:07:07 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] drivers: tty: serial: fix spelling typo of 'wheter'
Date:   Wed, 10 Mar 2021 11:07:02 +0800
Message-Id: <1615345622-2015-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTB4eTEsfHR5DGk5KVkpNSk5IT05NSUxOQ0lVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ogg6Dyo5DT8LOQ0pDy43LjxJ
        OTwaFDNVSlVKTUpOSE9OTUlMQkJNVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKT0NONwY+
X-HM-Tid: 0a781a1a316ed991kuws51d074001a9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wheter -> whether

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e1179e7..e3af97a
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2124,7 +2124,7 @@ static void sci_break_ctl(struct uart_port *port, int break_state)
 	unsigned short scscr, scsptr;
 	unsigned long flags;
 
-	/* check wheter the port has SCSPTR */
+	/* check whether the port has SCSPTR */
 	if (!sci_getreg(port, SCSPTR)->size) {
 		/*
 		 * Not supported by hardware. Most parts couple break and rx
-- 
2.7.4

