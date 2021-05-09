Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C7E3777C5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 19:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhEIRXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 13:23:40 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:30455 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhEIRXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 13:23:39 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d87 with ME
        id 2hNZ2500621Fzsu03hNZsm; Sun, 09 May 2021 19:22:34 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 09 May 2021 19:22:34 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        akpm@linux-foundation.org, stefani@seibold.net
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] tty: nozomi: Fix a resource leak in an error handling function
Date:   Sun,  9 May 2021 19:22:33 +0200
Message-Id: <4f0d2b3038e82f081d370ccb0cade3ad88463fe7.1620580838.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A 'request_irq()' call is not balanced by a corresponding 'free_irq()' in
the error handling path, as already done in the remove function.

Add it.

Fixes: 9842c38e9176 ("kfifo: fix warn_unused_result")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I also wonder if the loop above is correct. The 'i < MAX_PORT' looks really
spurious to me.
'tty_port_destroy' can be called twice for the same entry (once before
branching in the error handling path, and once in here) and
'tty_unregister_device'/'tty_port_destroy' will be called on entries
that have not been 'tty_port_init'ed or 'tty_port_register_device'd.
I don't know if it may be an issue.
---
 drivers/tty/nozomi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index 9a2d78ace49b..b270e137ef9b 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1420,6 +1420,7 @@ static int nozomi_card_init(struct pci_dev *pdev,
 		tty_unregister_device(ntty_driver, dc->index_start + i);
 		tty_port_destroy(&dc->port[i].port);
 	}
+	free_irq(pdev->irq, dc);
 err_free_kfifo:
 	for (i = 0; i < MAX_PORT; i++)
 		kfifo_free(&dc->port[i].fifo_ul);
-- 
2.30.2

