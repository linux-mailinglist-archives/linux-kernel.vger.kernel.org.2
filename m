Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4CB408D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242050AbhIMN0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:26:35 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34172
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240582AbhIMNXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:23:38 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 821254027A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631539253;
        bh=YdMV9AtCFFKriT3c6sHpvFf+xJsEOIFlGHmRsaTySis=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=D1QZmaEEOA+p+xPrbqrB3Dt2d7Lynrmjuk9snjpLUG8giQXNVkNpMVWrA2J2ES5V2
         ALweacX8DmOVcxZXCNXPj/nGYKeYzM61wjeLsQm1B4+VYt/JlKJ3F4iFaIzYLlTOx2
         TUN5GOEmStfnKE6M23Fbhr5KsTzS8tWwGNllE57SUFsxKGtv36a3v+KPlh8n/xno+a
         OhO1aEEiAMpNsbu+Pp3pUCuCXyvDZbSID6uRwP6KS8MgfpSmZZ5PxgOYoGo+MqZmUs
         b1uDlqzjZ9QVf2UA6v/V4ijxbF2DuPQuj4OSSEuDg9UxkTHN/FuPzws6w1N03HcTSH
         mAsEOTQ9gJ2kA==
Received: by mail-wr1-f70.google.com with SMTP id r5-20020adfb1c5000000b0015cddb7216fso2581972wra.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 06:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YdMV9AtCFFKriT3c6sHpvFf+xJsEOIFlGHmRsaTySis=;
        b=pd0YN+q7bBxlNZrvaqyHTN9gHNAAfPRn2P4iQij6IeeVyaTrOr3MIdf6Eg8SSk0Mgu
         pWccsy4eG79rl8pJNnYOtAxfn332PUl/j/ENiDWn7mF+1kDbpPTa8kdHzBhYMPqVfp+0
         jHZtqOTB+dfjQO8J5GXhWFXbvRd5htL0kUrGb14wNxoVLdAUbfoRkfQ9pEmLi4R2dQPA
         Eb1wdPwzh0dRC7H2UsMRisjqeFfVIrGt6j4bLdRLNl9eiuLPbJuVr5ahUhlxOwER+t4b
         dO3BirCDg7X+QhrxFRLpDLlQIaXUaeu+BCvfBNublte5ocmTycXNb/qQAWsb+bO+Jm65
         y43w==
X-Gm-Message-State: AOAM533IsHaMDTVofNEGa61wbBgJVonPlUldmgPIL83cG2H7ZSiSnBc4
        UsOq1BKsPWiaztwSophoJDaSOk/ZFFg+sVjslRU1PuDCT/kffmY5o3OvM850UJSGl4C4Fl30Fgp
        opsBBHiU9Vsqoho4+NmnIOR4a3ycmyK/dbv67D02FZA==
X-Received: by 2002:a1c:a911:: with SMTP id s17mr11244121wme.84.1631539251775;
        Mon, 13 Sep 2021 06:20:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDKCa2J0aDKEwfGljc8lrJwSBXahWxEFgvrIqIssT5ml8sBzDELvL1CsHBBwjLD7+R1dAL1A==
X-Received: by 2002:a1c:a911:: with SMTP id s17mr11244098wme.84.1631539251649;
        Mon, 13 Sep 2021 06:20:51 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n3sm7195888wmi.0.2021.09.13.06.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 06:20:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 06/15] nfc: pn533: use dev_err() instead of pr_err()
Date:   Mon, 13 Sep 2021 15:20:26 +0200
Message-Id: <20210913132035.242870-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
References: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print error message with reference to a device.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/pn533/pn533.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index c5f127fe2d45..da180335422c 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -2171,7 +2171,7 @@ void pn533_recv_frame(struct pn533 *dev, struct sk_buff *skb, int status)
 	}
 
 	if (skb == NULL) {
-		pr_err("NULL Frame -> link is dead\n");
+		dev_err(dev->dev, "NULL Frame -> link is dead\n");
 		goto sched_wq;
 	}
 
-- 
2.30.2

