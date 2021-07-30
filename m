Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCB83DBADE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239420AbhG3Om0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:42:26 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:32788
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239338AbhG3OmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:42:21 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 175B93F243
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 14:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627656136;
        bh=VTZKLd4Cikiu9JLg7PgN5ojxKk/zgZVaneS8eoEANNg=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=wG4q3F2QwIMWJeVKxe6/BaXgZlq4lh8fmwMXSqQ5qeo/j21FgAiWBC+m0AKZSa0RL
         Y5iS8JlzOzplGVG5GclJu01t5iyHzrqPXrMUKNQI8/ehW/iGCGUv6vOjiRk4K6NGML
         7Uoq3GD2e29/eVXf8jiPax6YHIC7o5caMPQ7u2A3Qgak2rXIM+2eJaYV0AjPurSvdg
         gh20AOwPUkDyeaTGvLBxtRYHFKT3nE8Z1a8tPJsRwYIZIiQ+tvQRKe2GIVXfn5HV7T
         dZoB34Txu5X47HMnQw3NFYdx1idP657Mzfo8U249FsXtOoc39l7ScFcqofqV4rkq7O
         As0PM8hqaxZ+Q==
Received: by mail-ed1-f71.google.com with SMTP id x1-20020a05640218c1b02903bc7f97f858so3115094edy.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTZKLd4Cikiu9JLg7PgN5ojxKk/zgZVaneS8eoEANNg=;
        b=GcG141YXmof9tDrhLaFPgZQjUBxc1Ilxdgf3P/WhrXJEnN9mizUKo6DK5ERwp6p0P8
         3VKpWQr2GQFuZLGT7sXNbUTLhN8lYctWsPdu4oU9J3BifK4MyzZwJ6Tyl9bZoBUm8y+C
         Iy4MzHZQdq2M9YMJ1M1u3Pdn9W9wf5sjyvnK1LwNLrHKV+00NmrwITVS6lvgbxg8WqWo
         JqCDVwjNYVbXz+r+IGr2dsB5aaDNQPKVZ9hRmYtgdrt9Zqj7KUIagY90zhuRfckY7yEm
         t8TqwOUzCYwRXL/k4BeRRXqzmEKd+JhlLiNudvB7U4GFJjE3zkUf/uO6H6hLY1qsXsi6
         nU/A==
X-Gm-Message-State: AOAM533Ac5cg9UhGlqbkUUS+w3VfiLs23RAW4a0GMoM/JfsjR+0tSLIs
        w674FqIu4GjNyvYcXqhH+f2OQrPaLoyAjLUWHGv8zTlilWR3oIwj2GRNaNMFgbtnIo4OZYCGixx
        6jkNMafF/I4n9lDtBqb0uHCRL4KgoIRm1g7/0EBF0xQ==
X-Received: by 2002:a05:6402:d5a:: with SMTP id ec26mr3436357edb.4.1627656135827;
        Fri, 30 Jul 2021 07:42:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTklZlpNPU1+0JaWvnxKZnRAAAubw23rxdRY2xTtGKFHycvUIP2Hj5u3KPcqBIf0isib80/w==
X-Received: by 2002:a05:6402:d5a:: with SMTP id ec26mr3436345edb.4.1627656135731;
        Fri, 30 Jul 2021 07:42:15 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id z8sm626325ejd.94.2021.07.30.07.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:42:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] nfc: hci: annotate nfc_llc_init() as __init
Date:   Fri, 30 Jul 2021 16:41:58 +0200
Message-Id: <20210730144202.255890-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210730144202.255890-1-krzysztof.kozlowski@canonical.com>
References: <20210730144202.255890-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nfc_llc_init() is used only in other __init annotated context.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 net/nfc/hci/llc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/nfc/hci/llc.c b/net/nfc/hci/llc.c
index fc6b63de3462..2140f6724644 100644
--- a/net/nfc/hci/llc.c
+++ b/net/nfc/hci/llc.c
@@ -11,7 +11,7 @@
 
 static LIST_HEAD(llc_engines);
 
-int nfc_llc_init(void)
+int __init nfc_llc_init(void)
 {
 	int r;
 
-- 
2.27.0

