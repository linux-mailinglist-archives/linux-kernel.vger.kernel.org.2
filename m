Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE084375CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 13:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhJVLDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 07:03:35 -0400
Received: from m12-11.163.com ([220.181.12.11]:37666 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232560AbhJVLDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 07:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/TWI/
        wIlv7vL2r2JsQRmnbrGFteypbLtGKOofeLv540=; b=VMoeQZW8o2v9XPczyxgO2
        n6jmOuIvjR8YLLDKo79RDrzVbtY57l2Rwe7ASdjeBHueGhXyxXvlOj/UaPtPysCL
        Lfibg8U7Ci2ETuxDmPJtTRZQxUj7GhEs0QhpiruA9N/5ICdpcRngFgTk5rsFnAoF
        xfmZnZy442+SUEJk3OAnYI=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
        by smtp7 (Coremail) with SMTP id C8CowADHy7TmmXJhULhxAg--.52033S2;
        Fri, 22 Oct 2021 19:00:55 +0800 (CST)
From:   dingsenjie@163.com
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dingsenjie <dingsenjie@yulong.com>
Subject: [PATCH] usb: tcpm: Simplify the return expression of tcpm_start_toggling
Date:   Fri, 22 Oct 2021 19:00:45 +0800
Message-Id: <20211022110045.11044-1-dingsenjie@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowADHy7TmmXJhULhxAg--.52033S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw4UXry3ZFy7ur4fWF45KFg_yoWDWFX_u3
        W0gw42g3409a43Jr4jyr9xZryYyayDXF1jgF1vgF9FyFn8ur47GF1DZ3sxXr10qF15XF9r
        Cr9rCryYkrs8WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnlfO7UUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5glqw25hqmxvi6rwjhhfrp/1tbiGAc0yFv2esyHzgAAsx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dingsenjie <dingsenjie@yulong.com>

Simplify the return expression in the tcpm.c

Signed-off-by: dingsenjie <dingsenjie@yulong.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 22a85b396f69..dabe694a7eb1 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2766,14 +2766,11 @@ static int tcpm_set_charge(struct tcpm_port *port, bool charge)
 
 static bool tcpm_start_toggling(struct tcpm_port *port, enum typec_cc_status cc)
 {
-	int ret;
-
 	if (!port->tcpc->start_toggling)
 		return false;
 
 	tcpm_log_force(port, "Start toggling");
-	ret = port->tcpc->start_toggling(port->tcpc, port->port_type, cc);
-	return ret == 0;
+	return port->tcpc->start_toggling(port->tcpc, port->port_type, cc) == 0;
 }
 
 static void tcpm_set_cc(struct tcpm_port *port, enum typec_cc_status cc)
-- 
2.29.0

