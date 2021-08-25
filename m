Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A743F7750
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241704AbhHYO0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:26:48 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37572
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241582AbhHYO0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:26:35 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4B514407A2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 14:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629901544;
        bh=/Sti3d7dTsAvFFog+hxbk2kz5ugUXJNgSZrotBprAFw=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=WWpJ20v0MS0PpUdRnaoVkD6soYjRUz6qwZ+i/xt+SfTomU0Icqfph7Si81KC8qkO2
         jv74gyzFZadn5GVJsWADF9UvJaPvXS2ynj31pqoVfP3gHleLrFZou4XFxX7ZNJuZQc
         9aBE80gl4uQYRFCNwa9p+KJm4ARXetqKTP1nWgM7OclbQ6fW8BbRu18FtTt5//qYOa
         +hl0tc2W7+uPZjCOFwHiQo9GaYjGElF/QbH5Mds2xgePV59+LftJifDlmdjdyisNRx
         d/LDyXNw5gdeUcakMu3WfVytpyR3ts2IaDExLecoz7UvhN4p5zRAonCKvC9jJevc5d
         eOKCJ1DWdKU/A==
Received: by mail-wm1-f71.google.com with SMTP id 201-20020a1c01d2000000b002e72ba822dcso2905884wmb.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 07:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Sti3d7dTsAvFFog+hxbk2kz5ugUXJNgSZrotBprAFw=;
        b=fX4hOhNnm2lMvsQEiNyKLptEO2i9RI+m5KlbOTXmG1ipQteZ4IKXf62c6i7ivwzJZs
         peM5WNvkxSAr6S0yCmvATB+9QTKYAOCuvgOk8WqeRLK6qhtKAsOJ0IxUELANYP7GyyfB
         lb2oEF2/NgUQvo6gZz9ncuEZUQITlyxxJ3bXMemwQN0GrTGNZAnkcu/EdIPbDAanY8lK
         9G0kuQw0YdOMSUd+0zrtNlfQdnDjC3KOehb6dwzoEw5YnjvfkVWXixftIjNDkCj/quxT
         1pnyDncUtUhFRGmp1TRVEUh3gHhx0rPV/5Cv8uRveW4olww0/LhLOz914UOJh8JrRWtd
         JmUA==
X-Gm-Message-State: AOAM531rLMeICNjn0Bf5+3nK+i9A5M4BuXqFdjLuZUvry5CBXdqs+5zO
        IEODEsDkMFFeLIPhmY59m0UlF51c+Dp+OgJILV447U7Ifl9cRZSDFyita0z+MMeoVQCbDPv3UJb
        s09747QzFt5/UBotXF+zbJHTTD11blwd+NNGe5ryIRg==
X-Received: by 2002:adf:f743:: with SMTP id z3mr18233458wrp.211.1629901544047;
        Wed, 25 Aug 2021 07:25:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpfqvpRdkvZvU3MkWbfHGPyUtkfWdIQce42bWzJoCqPmksHWSzq/AF1H2GKY6BtbSsA66n2A==
X-Received: by 2002:adf:f743:: with SMTP id z3mr18233446wrp.211.1629901543956;
        Wed, 25 Aug 2021 07:25:43 -0700 (PDT)
Received: from localhost.localdomain ([79.98.113.233])
        by smtp.gmail.com with ESMTPSA id i68sm60375wri.26.2021.08.25.07.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 07:25:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] nfc: pn544: remove unused header includes
Date:   Wed, 25 Aug 2021 16:24:56 +0200
Message-Id: <20210825142459.226168-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825142459.226168-1-krzysztof.kozlowski@canonical.com>
References: <20210825142459.226168-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not include unnecessary headers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/pn544/pn544.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nfc/pn544/pn544.c b/drivers/nfc/pn544/pn544.c
index 092f03b80a78..32a61a185142 100644
--- a/drivers/nfc/pn544/pn544.c
+++ b/drivers/nfc/pn544/pn544.c
@@ -13,7 +13,6 @@
 
 #include <linux/nfc.h>
 #include <net/nfc/hci.h>
-#include <net/nfc/llc.h>
 
 #include "pn544.h"
 
-- 
2.30.2

