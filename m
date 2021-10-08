Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71A242634B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 05:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242755AbhJHDr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 23:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242577AbhJHDry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 23:47:54 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D915C061714;
        Thu,  7 Oct 2021 20:46:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q12so1122552pgq.12;
        Thu, 07 Oct 2021 20:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7DEKEwn1sYlj7MiLzk6fLL0vy4MseGtQcchsFCXbjxQ=;
        b=HuS8xXU9n3RP9Z8wRKHlz2xxxem//6yMnrYPm59Skz7x+qdISQYod8sdKRSgl3DjHx
         BRAyGuFd4NcXzd+nX0rXIncqskgHbHac5lQJRjydO+IyXoYMyP4/eWdIfRTSFxccvRmM
         WWeexgXuPwFmZeUvuyaReODqGp0Fnuv5FMwVByCZ01h4QnmOYlH1du1iApH6Rhvfyn7C
         cYpG4q+Yo55ImbnBVCWSrN2CRu2bY5a5TAxQIHq952bEsmniyJ1wl1n9R8L54nKZacEy
         rQfMSdc1GRePJtY/vPJ5Zms6T2ucyu0Em7Y4d08sRUs8rtmdKPY6WLYxllcEC85PgmQX
         WnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7DEKEwn1sYlj7MiLzk6fLL0vy4MseGtQcchsFCXbjxQ=;
        b=0DW1l8eEvC54RZXzPLFZkrasfECpLlEu+gVE/J2ihLEDmiCHZbfHbri9JJ6ZDCYUf9
         VvP8Vx6AMUfem+qoFd2r9wvLHBbYG6rT97jVct/VQaUJveZsv3UelN0ujW18ZUb62PA1
         /BOVOvsdMLpgzUQhW5pPsmsU99Yvm4bTkyPguctK5zhaWlXLGBvOIC9dItF87wvJ39RR
         TJ7K+MQap6r0N6RUndgDqPSJzjw22xqmyhQIMdVK8di7t+uWFxcWD5e1D18pvPd/hNnV
         TndgT472+VvmF/lnHDC2Arpn656wEAUGUH5uGqakGH6iwAxgOwdXm7UPjcMk78gAtxaQ
         94SA==
X-Gm-Message-State: AOAM533jR6c1nLHgHNMbsGljo0pUXwf20IQD95i19FWeBV5dHAqk8q+K
        wFsAUHjljoNbLhEmBOBrVYs=
X-Google-Smtp-Source: ABdhPJyYZCr7OAVfyNM+Z8n7lEgEBUMJyQtz8tYm+zp2CgOO2iEtifROiJAfELasAfD60h1FegN+SQ==
X-Received: by 2002:a63:d2:: with SMTP id 201mr2730054pga.400.1633664759558;
        Thu, 07 Oct 2021 20:45:59 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s3sm9253776pjr.1.2021.10.07.20.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 20:45:59 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: Add bindings for Unisoc's UMS512
Date:   Fri,  8 Oct 2021 11:45:32 +0800
Message-Id: <20211008034533.343167-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008034533.343167-1-zhang.lyra@gmail.com>
References: <20211008034533.343167-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Added bindings for Unisoc's ums512-1h10 board and ums512 SoC.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/sprd/sprd.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sprd/sprd.yaml b/Documentation/devicetree/bindings/arm/sprd/sprd.yaml
index 7b6ae3070396..2c12e571394b 100644
--- a/Documentation/devicetree/bindings/arm/sprd/sprd.yaml
+++ b/Documentation/devicetree/bindings/arm/sprd/sprd.yaml
@@ -30,6 +30,11 @@ properties:
               - sprd,sp9863a-1h10
           - const: sprd,sc9863a
 
+      - items:
+          - enum:
+              - sprd,ums512-1h10
+          - const: sprd,ums512
+
 additionalProperties: true
 
 ...
-- 
2.25.1

