Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05C23DA148
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 12:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbhG2Kku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 06:40:50 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:34518
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236327AbhG2Kkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 06:40:46 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 79C243F230
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627555242;
        bh=Cti8DGqbNI8YPSuGsMvGoiLdXe5FLuXImkkJsU3HkS0=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=QfKl/5/vgZQOC1MHdycPjE1604IA3JTWMoIzYTcgwP5e05j/fMVDgxF9t2Hpz7mAk
         LIgdnX4v/wGazTZuSQVgx92W2VTpGqKlxXabf7utO5hPfWUgwgyrevR8W0+uDd/QkH
         MouboZLdzIa0ghrTM63aQKrlTm8JoSqCcPCBiWU4weSp8oBvZBW/qUWZ2DCEuTdU9M
         BBeXcGOG3rdMktyXdhtBpfb1XVxmj3+yKYRPeVMmtR746JrrmZmN1n0MaL/Gy9/1hc
         wJ0dzgtQnmNs4qrZP38737BvuSz2vfbl8Y5C98wjmAH/wRWktL+oQE/CWFRlJvWPvg
         HQmEtURtVLhnw==
Received: by mail-ed1-f70.google.com with SMTP id u25-20020aa7d8990000b02903bb6a903d90so2732774edq.17
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 03:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cti8DGqbNI8YPSuGsMvGoiLdXe5FLuXImkkJsU3HkS0=;
        b=i5p2aXDBTjRZmuS985gwJE6+YrxqWO8BaiTA3yxmlT3r6DikAMv9WLGGiCDkAU7Vjl
         F9GXdeXbwgQbzSoMCKr7I5+Rll/HWg+f3eAOnuYo31cZfzqH/1rwAMyETE8xTL8svdkq
         jU8/yZYDG/GsM/UYBe+j6V+WWbhAbOcMQM722zty0yc9PGIX+2Cd9F4RiYihiLGNWAgS
         SJWklppPtMYYwTAM4CJfwvFspDeacEo0+Z1DyBbOcnbZ0+8XfHnKiGYkM6bvrakvfDul
         BcZHHtAwBouyFHGfWUL/ykdio4I9t3wIgdTaIFkI8u401Iqz8v+X8aEs9zHplYMaCnAj
         W3AA==
X-Gm-Message-State: AOAM5318nAq3yDQCNfzAzcXmGuTziOFY1VbOYvXJELoN8uC+GbNcGi1/
        uhIq/gbV3NIgcqiAZSM+GBLRWh8zs3fgk9GoiH13ZLpSJLNpHMeNZvseFVGoAnxbM09oqx1j5U9
        U8Sr2yH4x6mInsyxEmRn3WaNQv1flC4hL8HujVmnV6w==
X-Received: by 2002:aa7:d342:: with SMTP id m2mr5302489edr.40.1627555241275;
        Thu, 29 Jul 2021 03:40:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjxgKl6WmnwX+WqFoKb6oCeo3LEsCBOoKuWEW0W2jjhEWMO4WBVPwCw/S6BOn4eM0m2lGmgg==
X-Received: by 2002:aa7:d342:: with SMTP id m2mr5302475edr.40.1627555241166;
        Thu, 29 Jul 2021 03:40:41 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id c14sm824475ejb.78.2021.07.29.03.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 03:40:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 06/12] nfc: nfcsim: constify drvdata (struct nfcsim)
Date:   Thu, 29 Jul 2021 12:40:16 +0200
Message-Id: <20210729104022.47761-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
References: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nfcsim_abort_cmd() does not modify struct nfcsim, so local variable
can be a pointer to const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/nfcsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/nfcsim.c b/drivers/nfc/nfcsim.c
index 143dc49b815b..15754671eb4d 100644
--- a/drivers/nfc/nfcsim.c
+++ b/drivers/nfc/nfcsim.c
@@ -240,7 +240,7 @@ static int nfcsim_send(struct nfc_digital_dev *ddev, struct sk_buff *skb,
 
 static void nfcsim_abort_cmd(struct nfc_digital_dev *ddev)
 {
-	struct nfcsim *dev = nfc_digital_get_drvdata(ddev);
+	const struct nfcsim *dev = nfc_digital_get_drvdata(ddev);
 
 	nfcsim_link_recv_cancel(dev->link_in);
 }
-- 
2.27.0

