Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35C4402872
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344323AbhIGMTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:19:50 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:36914
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344159AbhIGMTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:19:35 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 426D240191
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017108;
        bh=ZvGFi5U4zjTh+pnHq+nIFd+NOwEdjR6IPvbXckjfAj8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=VcBI7s7Zzh773OfGEa28ToUbrAVjoY8UOQLasDpHp5VR1Aci0UZItRiQYC+ny2eYu
         NxZ3ygSgFnGvgTCCtbCtgoj/yKnckyAhbJuNNKDCv3LwiIyk8Jpw/ArWi2bkdh1l8v
         X1ebg1SXjSCUYpaPYF4k171AwpbHbAHxXl/P9q6m6GEtQ/cycNH54sECQvX+ZKHBOB
         9TsqoTwjWmYQe2KiHj9E79cJOq1SnZLlm9e3bVW+EH+nwp4egBu6/PYfoilsB5ClI9
         YJtEl1U+I/znd0CNs+PI7zV0jRR8sYtImWE8beapFx6iLvuA8Pz6E1wtuzESRoJ/s0
         FYzKHfp3bkn1Q==
Received: by mail-wm1-f72.google.com with SMTP id s197-20020a1ca9ce000000b002e72ba822dcso1112447wme.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 05:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZvGFi5U4zjTh+pnHq+nIFd+NOwEdjR6IPvbXckjfAj8=;
        b=HQBLBnvy70fujmVIXXzdKVleALqTtjMc5S9GYe6snUrYKaUgAEhxJIt0u7fApzLqgy
         JPkaDsVjIwRLzyVQ9g85R51q8vg11bGHb8id3O0EGKsT1oEwEQ8aXr4oiRpxD2WlCuQP
         V2Erjp870qfXq3FQ68cqhHxugYmQvHBuA1a3JGATMg+kVMB/zCnBx5OXWa6NmCQnTp9R
         NkdLYB27yQr+et1nPYI58YMRDph+Q2KONT7Vq7AGa8JEtRqMCBW2Q1uCBmkxB4c/ms5/
         pbuIqj8eRNBQp76cjSisV50gwWTQnyfCK6bfvxclQzTcDDylCztNwn5Imc42kHLAskuh
         1UJQ==
X-Gm-Message-State: AOAM533fWEBL5+9c6T1akcFLeCP32wj96oZi+ostDQDv/A2mAgMOvZ+K
        wnMMBrS/eKDlv24TevrP9cXcVOmkeyaOLZhoqoQoMVVeddKQdnrJElsxsCnx82jF2h//fEGw87i
        XI0EbhDKS+MVoTed77nO7QBeE1MmJAlvG7tT71iru0w==
X-Received: by 2002:a05:6000:1623:: with SMTP id v3mr18866634wrb.288.1631017108010;
        Tue, 07 Sep 2021 05:18:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPP0rxMIlB99OlQytxsYXswgaB3Zazfam9ab+Im0W3DSjzmYqWwvuiOBFhSweZVXznCZOlRw==
X-Received: by 2002:a05:6000:1623:: with SMTP id v3mr18866621wrb.288.1631017107888;
        Tue, 07 Sep 2021 05:18:27 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.47])
        by smtp.gmail.com with ESMTPSA id m3sm13525216wrg.45.2021.09.07.05.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:18:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 05/15] nfc: pn533: drop unneeded debug prints
Date:   Tue,  7 Sep 2021 14:18:06 +0200
Message-Id: <20210907121816.37750-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
References: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ftrace is a preferred and standard way to debug entering and exiting
functions so drop useless debug prints.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/pn533/i2c.c   | 1 -
 drivers/nfc/pn533/pn533.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/nfc/pn533/i2c.c b/drivers/nfc/pn533/i2c.c
index e6bf8cfe3aa7..91d4a035eb63 100644
--- a/drivers/nfc/pn533/i2c.c
+++ b/drivers/nfc/pn533/i2c.c
@@ -138,7 +138,6 @@ static irqreturn_t pn533_i2c_irq_thread_fn(int irq, void *data)
 	}
 
 	client = phy->i2c_dev;
-	dev_dbg(&client->dev, "IRQ\n");
 
 	if (phy->hard_fault != 0)
 		return IRQ_HANDLED;
diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index 2f3f3fe9a0ba..c5f127fe2d45 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -1235,8 +1235,6 @@ static void pn533_listen_mode_timer(struct timer_list *t)
 {
 	struct pn533 *dev = from_timer(dev, t, listen_timer);
 
-	dev_dbg(dev->dev, "Listen mode timeout\n");
-
 	dev->cancel_listen = 1;
 
 	pn533_poll_next_mod(dev);
-- 
2.30.2

