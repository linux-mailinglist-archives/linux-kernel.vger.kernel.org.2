Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3074F3F2BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 14:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240423AbhHTMTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 08:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240374AbhHTMTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:19:46 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72D6C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:19:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o2so8976457pgr.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4IoaSoz+yhJYow9blF8c4/D4fnFjBG0C58GGMCAZVyA=;
        b=XEpva0fCfpZVjUpNEhel1OjQ4Q5HHmESW9uNKEQS39Dj97QzXNC4viA8YHXferFo2h
         S4g4euG6upmzEjBE/zqCBg5oFy4v4wSe+z34u1LTzgFRqfuFHFHWTiYItHCiylj4Oei0
         CSGwiswoJnQOM9G2qTIVbfbquFogPh3nQkleYqj7yJGFost3bBPshhwQ9WNF8YnB8YN9
         zLswvwrqiGD/J77RdKsm3wBEBaxVxmzf3hw55tuh8X+3z1B+j2ilwFEjg0LCxjv2wiQ1
         NUitY0RA2kEJurO18YKRk8XWrTQuGZ+mVFKk05GaV0lXv7d1289temgNTGHR+VtELbwB
         x0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4IoaSoz+yhJYow9blF8c4/D4fnFjBG0C58GGMCAZVyA=;
        b=FEWC3cqj1PrrC+WD433akh3p9Xa0bQHYpGRLv5l2Ex1sRRj4en4m2I/nrfpPECFyZp
         SHbHccXi4ujw2bo2VN0FdGgktL4zEMcFuD+oCgd/rY2yjUoG2ZXc54Y8xB7vzdIW3Yii
         JPa+ELjGmeEbD51ZP7n5p6mxqY7no5V4HooL8xjaACnE1ZciVUqZB471+uEwFWnHvaN1
         axpk/S7Fj48KUYl1t8N504Snt+Wj1FQi3Iz7nC4LfQXJYnXQmeAXraM0KHoOifT8m9aJ
         f9A59VGvqETs+FOh1EkbxFJQNmWU9ThvpRJYB64JzK6NPE83Sayn2jqcjC9rc3CAAzrf
         f0Cw==
X-Gm-Message-State: AOAM533h+yuDQ39GqQz0JWorSKcEckISpCCz5jDP9kMkd3OMaFIo+3fH
        gWNkfiKeTKO4Hopbxc5g/ZI=
X-Google-Smtp-Source: ABdhPJzecxiDTdjvs5d08yBsjSP3L8O0g2Gs81byx7rgg3KfPbvWF5HRX1lcYHL15GAbxvtDxZwyIw==
X-Received: by 2002:a62:5f07:0:b0:3e2:7556:95a0 with SMTP id t7-20020a625f07000000b003e2755695a0mr19159896pfb.55.1629461948555;
        Fri, 20 Aug 2021 05:19:08 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id t18sm6629554pfg.111.2021.08.20.05.19.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Aug 2021 05:19:08 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     nianfu.bai@unisoc.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] tty: n_gsm: Modify cr bit value when config requester
Date:   Fri, 20 Aug 2021 20:17:46 +0800
Message-Id: <1629461872-26965-2-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1629461872-26965-1-git-send-email-zhenguo6858@gmail.com>
References: <1629461872-26965-1-git-send-email-zhenguo6858@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

When n_gsm config "initiator=0",as requester,gsmld will receive dlci
SABM and DISC control command frame,the CR bit value should be 1.

If cr == 0,it will goto invalid,and it can't send UA response
frame and open requster dlci.

        case SABM|PF:
-               if (cr == 0)
+               if (cr == 0) {
+                       printk("gsm_queue invalid\n");
                        goto invalid;
+                       }

Example,gsmld receive dlc0 SABM command frame:f9 03 3f 01 1c f9
but gsmld goto invalid.

Kernel test log:
[  101.794705] c0 gsmld_receive: 00000000: f9 03 3f 01 1c f9
[  101.803341] c0 <-- 0) C: SABM(P)
[  101.811371] c0 gsm_queue invalid

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 drivers/tty/n_gsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5fea02c..becca2c 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1779,7 +1779,7 @@ static void gsm_queue(struct gsm_mux *gsm)
 
 	switch (gsm->control) {
 	case SABM|PF:
-		if (cr == 0)
+		if (cr == 1)
 			goto invalid;
 		if (dlci == NULL)
 			dlci = gsm_dlci_alloc(gsm, address);
@@ -1793,7 +1793,7 @@ static void gsm_queue(struct gsm_mux *gsm)
 		}
 		break;
 	case DISC|PF:
-		if (cr == 0)
+		if (cr == 1)
 			goto invalid;
 		if (dlci == NULL || dlci->state == DLCI_CLOSED) {
 			gsm_response(gsm, address, DM);
-- 
1.9.1

