Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286AB3F2BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 14:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240597AbhHTMUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 08:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240458AbhHTMUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:20:06 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CDAC0613A3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:19:26 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d17so5828604plr.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V66TcVnnLLXnsOkSNJoy0NTjFFt1VS/qsJiFjaXSQVI=;
        b=cQ8KZSHFCSwL+XJ9PDlQ1oQzn8JeHlEmym3UjdXgosIz/nhZ6xSxHJsibV9utqbev1
         +CuMLK+H+YkiIJge5x/50Mz1hTgKO6GoBbORG15Do8D1Cg3uElngeRbO6lEee42ONIap
         Bz9/5djBWskuEUkJQVDIU7Sz32JIwgxxi4bvs14LGmnwIqmNRUFfBBDQ6MJJV+NzhL1i
         tttSrk7YQtDj42vckr2nhI5bp8PJ6zkEiS5jNvU94tJuariMtAWZEil3MIbAKttvzvh7
         zIp8rwlr82VpgI24l9selZL+wEhm4gbYpWjvggySVkCgu+YavgaEzH5xSdgGNn1Vc7uY
         dkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V66TcVnnLLXnsOkSNJoy0NTjFFt1VS/qsJiFjaXSQVI=;
        b=Pn8Lg3ZSw6dIEMkglgEGiQ0PpHHmIk+GyhnNMrzQA6RUqj4Gd8/YnSNGnxB/JMIHns
         i5nr8A4YSGemRWpVP5e2rZUoI5j/niRQodladUjA/SpjuHjMufvg0bgf+SLo4zI/IS/b
         GeGx05FJu4PEIsLGiSmU453SlbIlK+18MV8shnsgORD+ovdtgvYmNHSgxzTMDDT3ofgG
         aC6+yZ6boesTh4awWXlZZiJiQ/VhZXIWX0SuZ33QP+j6lilOLJRrkrT/pWhQsuc25s8l
         HJSO3V9glkK3+3XG/w8xlCK6WkIl6Ve7wFlDnf8ynkoMz5Gb06sITBxr/MzVJQc1od2t
         Gg6w==
X-Gm-Message-State: AOAM53336mZ2OShXlV1AwUcD52zVvH1zCLNAztyeO+Js4sfCoiQwL/lp
        MYMnRHfBlGHYCRMBIMx6cOs=
X-Google-Smtp-Source: ABdhPJxMxl8xLi5muELOCWLPLZuAPDmBY3MKRhLEylxTSvdoSeghiNAs2gepE8qcdtRlX7Vlpwu9CA==
X-Received: by 2002:a17:90a:cb86:: with SMTP id a6mr4338830pju.137.1629461965888;
        Fri, 20 Aug 2021 05:19:25 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id t18sm6629554pfg.111.2021.08.20.05.19.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Aug 2021 05:19:25 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     nianfu.bai@unisoc.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] tty: n_gsm: Save dlci address open status when config requester
Date:   Fri, 20 Aug 2021 20:17:52 +0800
Message-Id: <1629461872-26965-8-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1629461872-26965-1-git-send-email-zhenguo6858@gmail.com>
References: <1629461872-26965-1-git-send-email-zhenguo6858@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

When n_gsm config "initiator=0",as requester ,receive SABM frame,n_gsm
register gsmtty dev,and save dlci open address status,if receive DLC0
DISC or CLD frame,it can unregister the gsmtty dev by saving dlci address.

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 drivers/tty/n_gsm.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 9001805..0b52d78 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -271,6 +271,10 @@ struct gsm_mux {
 
 static struct tty_driver *gsm_tty_driver;
 
+/* Save dlci open address */
+static int addr_open[256] = { 0 };
+/* Save dlci open count */
+static int addr_cnt;
 /*
  *	This section of the driver logic implements the GSM encodings
  *	both the basic and the 'advanced'. Reliable transport is not
@@ -1181,6 +1185,7 @@ static void gsm_control_rls(struct gsm_mux *gsm, const u8 *data, int clen)
 }
 
 static void gsm_dlci_begin_close(struct gsm_dlci *dlci);
+static void gsm_dlci_close(struct gsm_dlci *dlci);
 
 /**
  *	gsm_control_message	-	DLCI 0 control processing
@@ -1199,15 +1204,28 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 {
 	u8 buf[1];
 	unsigned long flags;
+	struct gsm_dlci *dlci;
+	int i;
+	int address;
 
 	switch (command) {
 	case CMD_CLD: {
-		struct gsm_dlci *dlci = gsm->dlci[0];
+		if (addr_cnt > 0) {
+			for (i = 0; i < addr_cnt; i++) {
+				address = addr_open[i];
+				dlci = gsm->dlci[address];
+				gsm_dlci_close(dlci);
+				addr_open[i] = 0;
+			}
+		}
 		/* Modem wishes to close down */
+		dlci = gsm->dlci[0];
 		if (dlci) {
 			dlci->dead = true;
 			gsm->dead = true;
-			gsm_dlci_begin_close(dlci);
+			gsm_dlci_close(dlci);
+			addr_cnt = 0;
+			gsm_response(gsm, 0, UA|PF);
 		}
 		}
 		break;
@@ -1756,6 +1774,7 @@ static void gsm_queue(struct gsm_mux *gsm)
 	struct gsm_dlci *dlci;
 	u8 cr;
 	int address;
+	int i, j, k, address_tmp;
 	/* We have to sneak a look at the packet body to do the FCS.
 	   A somewhat layering violation in the spec */
 
@@ -1798,6 +1817,11 @@ static void gsm_queue(struct gsm_mux *gsm)
 		else {
 			gsm_response(gsm, address, UA|PF);
 			gsm_dlci_open(dlci);
+			/* Save dlci open address */
+			if (address) {
+				addr_open[addr_cnt] = address;
+				addr_cnt++;
+			}
 		}
 		break;
 	case DISC|PF:
@@ -1808,8 +1832,33 @@ static void gsm_queue(struct gsm_mux *gsm)
 			return;
 		}
 		/* Real close complete */
-		gsm_response(gsm, address, UA|PF);
-		gsm_dlci_close(dlci);
+		if (!address) {
+			if (addr_cnt > 0) {
+				for (i = 0; i < addr_cnt; i++) {
+					address = addr_open[i];
+					dlci = gsm->dlci[address];
+					gsm_dlci_close(dlci);
+					addr_open[i] = 0;
+				}
+			}
+			dlci = gsm->dlci[0];
+			gsm_dlci_close(dlci);
+			addr_cnt = 0;
+			gsm_response(gsm, 0, UA|PF);
+		} else {
+			gsm_response(gsm, address, UA|PF);
+			gsm_dlci_close(dlci);
+			/* clear dlci address */
+			for (j = 0; j < addr_cnt; j++) {
+				address_tmp = addr_open[j];
+				if (address_tmp == address) {
+					for (k = j; k < addr_cnt; k++)
+						addr_open[k] = addr_open[k+1];
+				addr_cnt--;
+				break;
+				}
+			}
+		}
 		break;
 	case UA:
 	case UA|PF:
-- 
1.9.1

