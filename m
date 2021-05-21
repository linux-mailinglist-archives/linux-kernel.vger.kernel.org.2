Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6DD38C5E9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhEULpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:45:10 -0400
Received: from mail.ispras.ru ([83.149.199.84]:32918 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231377AbhEULpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:45:06 -0400
Received: from localhost.localdomain (unknown [10.10.2.182])
        by mail.ispras.ru (Postfix) with ESMTPS id 8083940755E0;
        Fri, 21 May 2021 11:43:40 +0000 (UTC)
From:   Evgeny Novikov <novikov@ispras.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Johan Hovold <johan@kernel.org>,
        Nikolay Kyx <knv418@gmail.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Abheek Dhawan <adawesomeguy222@gmail.com>,
        Lee Gibson <leegib@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] staging: fwserial: Fix potential NULL pointer dereferences
Date:   Fri, 21 May 2021 14:43:39 +0300
Message-Id: <20210521114339.8469-1-novikov@ispras.ru>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If fwtty_install() will be invoked with such tty->index that will be
not less than MAX_TOTAL_PORTS then fwtty_port_get() will return NULL and
fwtty_install() will either assign it to tty->driver_data or dereference
in fwtty_port_put() (if tty_standard_install() will fail). The similar
situation is with fwloop_install(). The patch fixes both cases.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
---
 drivers/staging/fwserial/fwserial.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index 1ee6382cafc4..d0810896511e 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -1069,6 +1069,9 @@ static int fwtty_install(struct tty_driver *driver, struct tty_struct *tty)
 	struct fwtty_port *port = fwtty_port_get(tty->index);
 	int err;
 
+	if (!port)
+		return -ENODEV;
+
 	err = tty_standard_install(driver, tty);
 	if (!err)
 		tty->driver_data = port;
@@ -1082,6 +1085,9 @@ static int fwloop_install(struct tty_driver *driver, struct tty_struct *tty)
 	struct fwtty_port *port = fwtty_port_get(table_idx(tty->index));
 	int err;
 
+	if (!port)
+		return -ENODEV;
+
 	err = tty_standard_install(driver, tty);
 	if (!err)
 		tty->driver_data = port;
-- 
2.26.2

