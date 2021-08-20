Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EF63F2BDF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 14:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbhHTMUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 08:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbhHTMTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:19:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF4AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:19:14 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k19so8445707pfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HsozwHcGNELaVbD6vEcBhhj++t7FB0K5FUlbgXVI6Vs=;
        b=g6n9QK6ZXs7tWtWh8QVS6zUglVM+RZkERc4xZwwKwyPosKaeU+8Xyi15Kfkt7fvOfl
         WhhSWAcrX5oew1oWmTO67Hyzl9F/s2GVZtOo0bRrMXv4XpFf1fCj2sOyYe4KQ7d89oP3
         WCxXpE25EBO8wvUKps7Z5q5lz+OQ5kiircc7S2qNpByt7HDq8tRX0zsh0XGLOD62Cll4
         FJ9R8KkY2MZLQ+Acj4JaRJ6PeNYP8+CIYHeOCNYM/qne2w00R4LaJU1t2nf+Rmj2YlEz
         nQNaS7B4d/si+/OeKvRWfplYGkXoOEpcobfvL3Ixw/JNUKfgPlVwvA6njF8KUaUekzRN
         LOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HsozwHcGNELaVbD6vEcBhhj++t7FB0K5FUlbgXVI6Vs=;
        b=tL+z/8gt5gb2LAP0X4uRo18iwsuaMzYgKFjuFi3Ol9tQ/wnGx6rzCN+TggAvZJBaAb
         VAvHywR+All+peuuMeaS5iVQeu56JIgLCxW2YII27SYoAHyJczwjuxpnUHhoo2BflX7q
         +HC58M62Z1AZxz4aUuSUQlYAG6QtdIfU04KBtfnWNYyajKwv3kQ9y7SgdFGMX08pVO0x
         rKlINL+jGLIZo29W7Q+jpn5lo97AxiVw8EfsrkaADUGPz/w22WjDdzMmsEaMx8YXcKto
         K2+Xh7l0gUZVWMjXFwsSzUFRrTSatnaUy3yoC7fbyfoPZlfzEJJHSbhQhDErwC2s9MxO
         MQQA==
X-Gm-Message-State: AOAM533UBMcn3vACIOiIbMKv9E8akn4mzsMt7OCLf4tH1c9q5XYTW1+h
        ynuCgVkwrEIWhbxP9ufv9n0=
X-Google-Smtp-Source: ABdhPJxrx2pSr4hu48eqoFzLBt9GlJbLmJuOai0GN7s7gP7Vvqyib4N/9TAjHN+o8m2C0rveynaMjQ==
X-Received: by 2002:a62:78c1:0:b0:3e2:bdc:6952 with SMTP id t184-20020a6278c1000000b003e20bdc6952mr19051098pfc.45.1629461954301;
        Fri, 20 Aug 2021 05:19:14 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id t18sm6629554pfg.111.2021.08.20.05.19.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Aug 2021 05:19:14 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     nianfu.bai@unisoc.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] tty: n_gsm: Modify CR,PF bit printk info when config requester
Date:   Fri, 20 Aug 2021 20:17:48 +0800
Message-Id: <1629461872-26965-4-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1629461872-26965-1-git-send-email-zhenguo6858@gmail.com>
References: <1629461872-26965-1-git-send-email-zhenguo6858@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

When n_gsm config "initiator=0",as requester,gsmld receives dlci SABM/DISC
control command frame,UA frame printk info is error.

Example:
Gsmld send UA frame "f9 03 73 01 d7 f9",but CR,PF bit printk info
looks like error.

Kernel test log as follows:

Before modify

[   78.837626] c0 gsmld_receive: 00000000: f9 03 3f 01 1c f9
[   78.846356] c0 <-- 0) C: SABM(P)
[   78.854021] c0 gsmld_output: 00000000: f9 03 73 01 d7 f9
[   78.862574] c0 --> 0) C: UA(P)

After modify

[  261.233188] c0 gsmld_receive: 00000000: f9 03 3f 01 1c f9
[  261.242767] c0 <-- 0) C: SABM(P)
[  261.250497] c0 gsmld_output: 00000000: f9 03 73 01 d7 f9
[  261.259759] c0 --> 0) R: UA(F)

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 drivers/tty/n_gsm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 7aa10de..e3e1be3 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -587,6 +587,10 @@ static void gsm_send(struct gsm_mux *gsm, int addr, int cr, int control)
 		return;
 	}
 	gsmld_output(gsm, cbuf, len);
+	if (!gsm->initiator) {
+		cr = cr & gsm->initiator;
+		control = control & ~PF;
+	}
 	gsm_print_packet("-->", addr, cr, control, NULL, 0);
 }
 
-- 
1.9.1

