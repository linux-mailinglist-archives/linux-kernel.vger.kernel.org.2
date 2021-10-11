Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6E7428E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbhJKNl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:41:26 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:57240
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236144AbhJKNlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:41:20 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 890EE3FFF7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633959559;
        bh=8wnvnlFr7Z9I1aV6d98j8RCw9C64nkeTjGiPt6idSBY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=W1dcfBkY7Jenv4mB9j8xfvVHd83YBBDaAy8eATdwOZ6S3Ok1kFuBGcWeT4tCVV7pK
         Ch7tmnEfnoSTrl4C+ncKAoFe7s6bPzNUJQpc0t2AtEiPRm6KEZRhS1uW1QeXTu8oE7
         m87bM4TduBQ1zfWFXxBO1VlGr6ln2t26dPp1/g+w5m6G2Z56iuZQl+a023D1loTQHk
         geOL01xmG6ZzIKf+9U2m4Ze/RnOoZVc7cDpadMZkHtE2dQjp3/bjTjTP51ORAvBxNG
         VcDZG+ilGasRMj4rJTKTdKIZg/jZZpiySAd1Ex8i+5C9NJrjzEYOtUj4E4SMl9GV58
         esDvRuVfQ2tUg==
Received: by mail-lf1-f69.google.com with SMTP id bq35-20020a056512152300b003fd45087a72so12748673lfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 06:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8wnvnlFr7Z9I1aV6d98j8RCw9C64nkeTjGiPt6idSBY=;
        b=PlHHIIHyiFsDIFH5lwftAtl4Ngj4epTbA0UjWUNVnO/SeUnEemRD+YFgW1LsC4UqbU
         es8IhoWerlMoXFr4cYxP1iaeiYt7Wr+7s6g/xhcmxzfZ/rF830hbe2CRj8R0Ca2bFJS5
         wzO8oHAgcJRvHj7GVgw1v/aY2qtqrN9FSG2NJ01gayQR/6TkOQiTYVN5Z0hHG6VH8i+O
         zbVEmeqhnO37L5OH+jXYj2E9PTejI4Kkpd1X6yFuxd1yIucKPngfQqbTfLq78NGF0l4H
         omZOh30/t33LlLapO8yBvdBoFCHrgQjtgF0E8rj2ir4Ffl1wdLsckkG1rRQsNLSfaeYW
         M2kA==
X-Gm-Message-State: AOAM533CkLrSguifcOsA0ygg63Hfoq1sJK2cjWaIj2gUl3QHnJNN87nu
        6EuqVhKRGouHXlHRLTiSrTPZRA5RVOWazwY8UQdYPMkqC1zPju+c1kjZ/KjWG/Uz1BfLeethTBq
        R7OOI+oFrFZfKlAKm/rWi3q12N1pzlnNsb8HGL6IWHA==
X-Received: by 2002:a2e:6e0d:: with SMTP id j13mr23981199ljc.91.1633959558152;
        Mon, 11 Oct 2021 06:39:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1mjKnXef4PGGuh6A2lQ0EMTl+ZwPQ5YLz++4hccLWfHMjPwyjX1r4pco9/JD2L+P+ga9cPg==
X-Received: by 2002:a2e:6e0d:: with SMTP id j13mr23981169ljc.91.1633959557980;
        Mon, 11 Oct 2021 06:39:17 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a21sm738971lff.37.2021.10.11.06.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 06:39:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Cc:     joe@perches.com
Subject: [PATCH v3 2/7] nfc: nci: replace GPLv2 boilerplate with SPDX
Date:   Mon, 11 Oct 2021 15:38:30 +0200
Message-Id: <20211011133835.236347-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011133835.236347-1-krzysztof.kozlowski@canonical.com>
References: <20211011133835.236347-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace standard GPLv2 license text with SPDX tag.  Although the comment
mentions GPLv2-only, it refers to the full license file which allows
later GPL versions.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 net/nfc/nci/uart.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index 9bdd9a7d187e..c027c76d493c 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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

