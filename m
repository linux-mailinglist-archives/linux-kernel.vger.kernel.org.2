Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39AC408DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241964AbhIMNaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:30:35 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:57750
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240592AbhIMNWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:22:03 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4928340267
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631539247;
        bh=Lf3U+DHYhMpuIl7nTJH6GPAYe+llXfLG7+wtuS7r1DY=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=mYVDVJw/FVHuEz85dm/pCX2VUhK16rHO/p3AbV6ar8DxVVxUv7BVLF2DZfOcd2jmF
         UUpDZfUdLBfWM8BiY/YsjnNr3x3DKlDa71Ea+lw7156adJZvtFkD4W7vOgD2Vuz3Jz
         veO+B4tP5FdxMrB2u514jD8Dlgab09J/aBR31IK/WQWPt8tR3CJ3PWXAF/FQ+EYowy
         jtrK12Y2A9PUQfOTA2lYs3OQJfwTOjuFmGbePxrgTiNX9ZqXZ3A3W2vcsXEbqpiqaL
         JOQisXE/bYOJFLlKsO0CLhlmDF7sDM4qk3rREYWS0CZIqdzzSPF98GiutP2VsGIV93
         LWunScvWeRaxA==
Received: by mail-wm1-f71.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so4922421wmj.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 06:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lf3U+DHYhMpuIl7nTJH6GPAYe+llXfLG7+wtuS7r1DY=;
        b=3pkbk+RgavkPhHRaGEdaovzbCIgR7vh3CbQITMipTbPOJkHM+NoZ0avjTpRl2P88qx
         jEUB4MPg2LWC8E1N94/sV77GEyC6BR/NSGZ2mePWTivTimjz5PJgMR7sjnTBWDXuLyMa
         3zPloGfOD0R5+0eYhAkNc0w5l5jlN0wnnym+0Sx9rZ76Blx0s9C645c4ZdLxZEJp847t
         oFXFOuRf4xa9LyQmbBq9EXoKueuCHgq4Ot2R1uEMCgtw5i3bQCkcxdoZY8wjQ/h3/fnX
         9mSXiF89vROi1wA7smWf8bHpO+lmGhzQi4NA+rAD8nM1j3GHiv31Ns9Ga0ppC5dqAmri
         yZMg==
X-Gm-Message-State: AOAM5330JAcldiC5gYN0xgKnF+LK5SVezT1PZGl4qDj3hIwNScsUEPOc
        RSFiWj20A7Vrnviz5GaNNigK0srwuQEvomu4SywClbtSlvjqXXLmF0863Uf0JqNCbqMJJl/HT+J
        pETivbaEwSL8HNx9u7CRFELyrMudaHhGOhbhQwehnBA==
X-Received: by 2002:adf:f90f:: with SMTP id b15mr12528816wrr.364.1631539246423;
        Mon, 13 Sep 2021 06:20:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO4lsG5wdmhKIDutLLy9acqil5ZkWEOWZw6YwdcZcxBYqUrgu1dwPeeITR5yS7gtM6A2hFVg==
X-Received: by 2002:adf:f90f:: with SMTP id b15mr12528787wrr.364.1631539246274;
        Mon, 13 Sep 2021 06:20:46 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n3sm7195888wmi.0.2021.09.13.06.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 06:20:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 03/15] nfc: nci: replace GPLv2 boilerplate with SPDX
Date:   Mon, 13 Sep 2021 15:20:23 +0200
Message-Id: <20210913132035.242870-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
References: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
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

