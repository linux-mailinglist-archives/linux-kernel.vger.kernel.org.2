Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5707402876
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344150AbhIGMTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:19:55 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33486
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343945AbhIGMTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:19:35 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3A2FB3F312
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017107;
        bh=Lf3U+DHYhMpuIl7nTJH6GPAYe+llXfLG7+wtuS7r1DY=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ZqBmJz151XtW1mLYyG3fITpN6r+KWDmBZvnKEWfw/C9sOMIA0dEqEj+Y2/1dQ59iX
         XFu6benIRgdLd/HK7JGBQ6YRIRpU1cyIQwMoh1tgG3IvPPZBe/rH0Eb0gmV0i3Cgc8
         sZzvDvhUoNAKHNfzn9774hktXoO+3UxGtE6kdj1pIFH1wJnET5iV2OAImX5OtnV1wQ
         f4F/6o1KOcv8dAIvzTDZLQAeA0rY1lBFiT+TuUl6BpzrM6LLVaAS3KUJXyMyH0BdwU
         1ULVQkfrqX/jiqnVx5l3Zsde4VxwnVbm3q8EIqgV+kseP1XjuH90Bva6vHKt2BZDen
         evBddlxJObtVQ==
Received: by mail-wm1-f70.google.com with SMTP id r4-20020a1c4404000000b002e728beb9fbso1102647wma.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 05:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lf3U+DHYhMpuIl7nTJH6GPAYe+llXfLG7+wtuS7r1DY=;
        b=bw6CaBodLYp/AA/lU7UiQ0I+mlhJ7gR9h6IVegNkSrAxP/oZAVb0uFKKWy7IWuO6fL
         8KN4+RP0S9oLAw8NTP1KFC9B2tDg6MGqeACuQ687XvSpi3roVjrLUW/MREwy4ZmWiyV/
         98mzq0U3smvFMu05bwnucB3xyWQfMy/mHQpXNSsbgnOYu2SMaEvNCL4vpuoXGPTqFYhM
         TeBev2jZDwZFs1xj9lY2zb+ObwU2rd//sdpnjxLiutIz20T4VIZROhg6/Y5r07/QVHCz
         UFrwsLieiUMM240S1jsYw1bz7DdwZ+jB+2AYXdVT6a+uEQ8AveJPPzTj5QEVAVVXfFUQ
         geOw==
X-Gm-Message-State: AOAM531kRT6ZMxPg7CWfgOYR5VCa4AlzXC23T9H3i8pmJc2DhhgRCAp1
        uQ5mOSETK7yxrCaPaOOuLFy5PMHVW2B1MOIwdbjVeCTW3F52NPnDgE7YNGptNqjJmmrQmIbXDPJ
        E7xpQ6+b254otqUOL/YC95uOs3tLC5ZH1HzloPZxtPQ==
X-Received: by 2002:a05:600c:a49:: with SMTP id c9mr3543977wmq.159.1631017105644;
        Tue, 07 Sep 2021 05:18:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGnITbLQyBPqv15Y5qGEl25iI8Aaoxxgo0CFdcBuZBhKAuVcx8mn1j6CPUzijO1vm85/0Uww==
X-Received: by 2002:a05:600c:a49:: with SMTP id c9mr3543965wmq.159.1631017105503;
        Tue, 07 Sep 2021 05:18:25 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.47])
        by smtp.gmail.com with ESMTPSA id m3sm13525216wrg.45.2021.09.07.05.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:18:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 03/15] nfc: nci: replace GPLv2 boilerplate with SPDX
Date:   Tue,  7 Sep 2021 14:18:04 +0200
Message-Id: <20210907121816.37750-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
References: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace standard GPLv2 only license text with SPDX tag.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 net/nfc/nci/uart.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index 502e7a3f8948..65814dd72618 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015, Marvell International Ltd.
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
- * (the "License").  You may use, redistribute and/or modify this File in
- * accordance with the terms and conditions of the License, a copy of which
- * is available on the worldwide web at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
- *
- * THE FILE IS DISTRIBUTED AS-IS, WITHOUT WARRANTY OF ANY KIND, AND THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE
- * ARE EXPRESSLY DISCLAIMED.  The License provides additional details about
- * this warranty disclaimer.
- */
-
-/* Inspired (hugely) by HCI LDISC implementation in Bluetooth.
+ * Inspired (hugely) by HCI LDISC implementation in Bluetooth.
  *
  *  Copyright (C) 2000-2001  Qualcomm Incorporated
  *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
-- 
2.30.2

