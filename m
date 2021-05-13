Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2866B37FFFD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 00:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhEMWTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 18:19:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48863 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhEMWTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 18:19:45 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lhJf7-00089j-Lv; Thu, 13 May 2021 22:18:33 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: pty: remove redundant initialization of variable fd
Date:   Thu, 13 May 2021 23:18:33 +0100
Message-Id: <20210513221833.137672-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable fd is being initialized with a value that is never
read, it is being updated later on. The assignment is redundant and
can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/pty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 9b5d4ae5d8f2..2251330e7e00 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -626,7 +626,7 @@ static struct cdev ptmx_cdev;
  */
 int ptm_open_peer(struct file *master, struct tty_struct *tty, int flags)
 {
-	int fd = -1;
+	int fd;
 	struct file *filp;
 	int retval = -EINVAL;
 	struct path path;
-- 
2.30.2

