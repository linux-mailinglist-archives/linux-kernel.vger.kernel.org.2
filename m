Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1784502D8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhKOK4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237602AbhKOKzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:55:02 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D485BC061206
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:52:00 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 188so14195306pgb.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=r4XyC+5w2S49btR2CrwNd3E7DMZ/stKYlyfPHpipecA=;
        b=eBYa3K/DaoHokSzRNdLBVY1Hv4D3t3eadJjF2waN5NDDgbiN0GxeehSaH9C2Gz3nMq
         SKcaG48xb5EhXMTT1BMWqUuITFMDMMF10Txtug/aqethVZvRyYDvzkpR2ILFWJz7LF59
         EGI+a/95xeTlOeeF412DxmG9ZYJLSw9ltXWwqSOWKk+9Cf5g0Ws2jzb+ukALDtrvrtnd
         w9GQLUF9urbVB8bGtShXcF3yAETJWkZ1TsROqNl1DtLr+9NyeONGyMzSKRiG1/9NsJHv
         o/6cqgB3g6oQDHu0Kp8Daj68T0xROdRrsVqu51yZnGtgF5S5E3W0Qjy4JDcHtRKX+Usy
         8RrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r4XyC+5w2S49btR2CrwNd3E7DMZ/stKYlyfPHpipecA=;
        b=o1H4AaFULclynl9SBf3M5UbjzFHdL6+eVW5ZK0LqO+4O6Aj57GQfGiegjNAPL9XJ5P
         N/CGKopUt4NqPYxU/IRNbk2A6AdkaOINH1gXVuQIM/I19hocQduA52Tk/fNeCwyDJBNq
         8X9zurpD7JYIWm2qt9f27jGqnRbwicAGCRhw/wiP0iyK0S1zBZon0EkSWIQ5D/cjFpru
         oDQ1YV5FO+actG17sTd2cdv+huJMTL5aTMQioSsGukffZuy4jO8xWTf8mA8EAhMM9fXT
         bJ0+dHhfS9odILIlGSeOFs+SsPsB9pzy2XjROoo8ZoO9r8h9Ea+jB3q242y6Fj2j53H8
         9JsA==
X-Gm-Message-State: AOAM5317UgRiQI+XE+SAHkvziW0CfJDnHkqN/0IsEZV7vUWZTI+FlX0n
        OXkseyNDDQCSJf5uXUCx9tY=
X-Google-Smtp-Source: ABdhPJyrrQy1t/cx5rIl/vngM58fdZgcvX3F8Q49/Y30x7GQCj6mtfn4LkVnNKk1eS/hqQY+MhD/xw==
X-Received: by 2002:a05:6a00:22d2:b0:4a0:93a:e165 with SMTP id f18-20020a056a0022d200b004a0093ae165mr32029963pfj.68.1636973519580;
        Mon, 15 Nov 2021 02:51:59 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id f7sm13783094pfv.89.2021.11.15.02.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 02:51:59 -0800 (PST)
From:   yuuoniy <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM/mvebu: Fix possible null dereference in armada_375_380_coherency_init
Date:   Mon, 15 Nov 2021 10:51:54 +0000
Message-Id: <20211115105154.26714-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent potential when access p->name after unsuccessful allocation.
Signed-off-by: yuuoniy <linmq006@gmail.com>
---
 arch/arm/mach-mvebu/coherency.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 49e3c8d20c2f..4fdb1fae63c5 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -194,6 +194,8 @@ static void __init armada_375_380_coherency_init(struct device_node *np)
 		struct property *p;
 
 		p = kzalloc(sizeof(*p), GFP_KERNEL);
+		if (!p)
+			return;
 		p->name = kstrdup("arm,io-coherent", GFP_KERNEL);
 		of_add_property(cache_dn, p);
 	}
-- 
2.17.1

