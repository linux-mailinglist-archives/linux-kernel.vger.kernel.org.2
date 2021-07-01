Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549AE3B8D8E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 07:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbhGAGAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 02:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhGAGAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 02:00:45 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB5AC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 22:58:13 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m26so5106271pgb.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 22:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=w1Bq+kJRyA057syxHf+Tmh9JfZh4++bngk6HSluw2rg=;
        b=gnvQA8UQq1NadvHsGM31YIBg2gzoXVyhgQ32vUS43r13bvt6uIMJqrFMl3gkjSPLpq
         XpDctWiUY7glRw6NuW3p6D2tXryc6o/zfLYHjVsiyqb+UcaKSj9Rdwl6rkLSi3/yuv3U
         4bKDC+eErTh9ELfMq/4Mw1iDzx999yZJnq/dktHxLybrip54zz41FX6SuSCibJUJwBLz
         eUQvppq/I5sXz7CWVsg2O9YaekBDRBuzfsmh5IzhLBDEFQ6ug/WnytSuaIk4ORAM5Sl7
         KtRm1d0io+KYOPLOC0DAvG94dUnw32h5CSpJyZPESEliY5g6d7A8bAvKuSTIJZcxmF+N
         X1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w1Bq+kJRyA057syxHf+Tmh9JfZh4++bngk6HSluw2rg=;
        b=lMrQ7pX8y2vZLCyGU1xjRvi2pKlltzI3G9SO/i1mJy5kaxGT4rTihMX4jH7OtuPO6F
         3fCrs9FEmvgEu1CTTW0eheujD23i3L9W1pILINJlt80JWxQiOdt1iORoDMwoDeBpAE7b
         OtCadPfSpSOsDn/+ckwdH6c1kpuacye7ak6N/IZvhHtgYE15HOtT3tsFVPeVss0lWGsP
         9eSTQXXAtmVJilUmCaxX4Hg0vHqNH7pTJAf1Zcs2B6kOWrtPczD21eGGrIL6pqPK9P3w
         VoH+7oiER1Typ/9gBbj52zOGF0KNCftD0hfHLCpWsVpnRkZpFmstyylWeUxmJmSFVF87
         08bw==
X-Gm-Message-State: AOAM532qX6MoS235XZ0sjR0SnBCPO7NvO/a4L4OFVVNMeUrV+Ubrpkgf
        NwQa48dDQBToLzIlAUXkVhg=
X-Google-Smtp-Source: ABdhPJx7wyNSx/rY7fo1A3NLwwFS5f4Hj0a4NHsOpHY7efDT+oLMGWEb0NfZKL5eNTXqBh0AFqmBVA==
X-Received: by 2002:a62:7cc4:0:b029:302:f75a:69ab with SMTP id x187-20020a627cc40000b0290302f75a69abmr40314386pfc.74.1625119092615;
        Wed, 30 Jun 2021 22:58:12 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id gg18sm8996742pjb.0.2021.06.30.22.58.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jun 2021 22:58:12 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     zhenguo6858@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tty: n_gsm: delete CLD command frame as requester
Date:   Thu,  1 Jul 2021 13:58:05 +0800
Message-Id: <1625119085-18200-1-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

as initiator,it may be send CLD conmmand ,as requester,there is
no need to send the CLD control frame,it will cause redundant data.

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 drivers/tty/n_gsm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5fea02c..eecbc76 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2043,9 +2043,11 @@ static int gsm_disconnect(struct gsm_mux *gsm)
 
 	/* In theory disconnecting DLCI 0 is sufficient but for some
 	   modems this is apparently not the case. */
-	gc = gsm_control_send(gsm, CMD_CLD, NULL, 0);
-	if (gc)
-		gsm_control_wait(gsm, gc);
+	if (gsm->initiator) {
+		gc = gsm_control_send(gsm, CMD_CLD, NULL, 0);
+		if (gc)
+			gsm_control_wait(gsm, gc);
+	}
 
 	del_timer_sync(&gsm->t2_timer);
 	/* Now we are sure T2 has stopped */
-- 
1.9.1

