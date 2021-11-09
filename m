Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CE244ABAC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 11:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245409AbhKIKm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 05:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245397AbhKIKmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 05:42:20 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229FBC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 02:39:34 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id k37so519988lfv.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 02:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oc8Lrifjjn81EvdzUKtgI+qBotbqhXpUtXWZyW9sG+U=;
        b=e/x2udiWO9BInIeQn3npp98pDE/Lnn7ElfF8bgSaYjKxonFKpSe5czSQwnkMWZmSar
         QqHfpL2BSyFKyaFZr/bTl78tv1xm1+eueo/HdcEvwET8H5qwkUvs+Ol/E6JZZJr4Owij
         IL1ArX3oGx8TJg91jm9Z1KozodLaQt1rowVFh6O8drkrs6/lFwSRxcn+RpqktYmDaSfT
         KCxAfOP7sF6n2J78scv10ejuzpuczaWR7ocMMoLQ9vDYZqxMKIPbafJrYPR/adiicjNG
         FF9GDed0/7VJHWpWMpg0Rfjn/IIQ3HGQM9H4no3aJfp+Wc4d4CxhoQqJ8i2ks4DJwinX
         /C0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oc8Lrifjjn81EvdzUKtgI+qBotbqhXpUtXWZyW9sG+U=;
        b=R3aliQL96/LPUxRg1zrpqx7pttMOw2s6UoaOBmrfPjMJHuAyBZzVqn2x2/DPMry0ms
         2KpFmpIFJIN/+ZZHf+1XazjhfPJMfpXDCwDW9LJzLnF8aLrvRcjjkqWVh2MFvdtMdbSC
         99l55iU5xCECGRF2ln77y9tLeSFE0WAp3iuLkR3GDyJFwoIsVqEXP2Q5bQ+6GV9DZl1c
         r8VMcGUKn/B3iu8S7PHJgrT47DJrf959mJultW5+OIzww5+sFmg/sTOawGNModXWIKQl
         doHAqlZFV89h3k+o2e7LCwY6utESeOqoReox7omAMmKIN2ujxEQsD/PYhVsBUlqjKdsh
         jWsw==
X-Gm-Message-State: AOAM530grbM6jrd4lBinzGiCNDHWqdkGAagevppLizy9dn6xqwEhX2bn
        oMgR7NTeK6B7kXzUqrrTpP43P9c1iBU=
X-Google-Smtp-Source: ABdhPJx47xQ/VQVjhIGvo/lI5froFbyJQ6JsM0Gx01z29GToqm/m1aob/XnW6RS0IiEKu28fs4yEdw==
X-Received: by 2002:ac2:5f0d:: with SMTP id 13mr6082737lfq.627.1636454372392;
        Tue, 09 Nov 2021 02:39:32 -0800 (PST)
Received: from localhost.localdomain ([94.103.224.112])
        by smtp.gmail.com with ESMTPSA id i32sm911173lfv.295.2021.11.09.02.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 02:39:31 -0800 (PST)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, hdanton@sina.com
Cc:     linux-kernel@vger.kernel.org, Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH] tty: n_gsm: add missing tty_kref_put
Date:   Tue,  9 Nov 2021 13:39:30 +0300
Message-Id: <20211109103930.27494-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My local syzbot instance hit memory leak in gsmld_attach_gsm(). The
reproducer injects allocation failure in tty_register_device(). After
this error only previous tty_register_device() calls unwinded, but not
tty_kref_get().

It leads to tty_struct leak, because ->close() won't be called in case
of ->open() failure and nothing puts tty reference.

Fixes: 0a360e8b65d6 ("tty: n_gsm: check error while registering tty devices")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/tty/n_gsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 1d92d2a84889..1cc3aec17d2d 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2394,6 +2394,8 @@ static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 				for (i--; i >= 1; i--)
 					tty_unregister_device(gsm_tty_driver,
 								base + i);
+
+				tty_kref_put(gsm->tty);
 				return PTR_ERR(dev);
 			}
 		}
-- 
2.33.1

