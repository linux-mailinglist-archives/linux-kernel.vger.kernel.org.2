Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A6F438D25
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 03:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhJYByg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 21:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhJYByb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 21:54:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35E9C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 18:52:09 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f11so9188774pfc.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 18:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=75BUDHsCAc/I/IWJxwpyHr24/zOyWSJ/QNW0ySt+dfg=;
        b=My3P6rOTPOzPfq2Fz7QDcal86fAyuhU8/JKHhqJv7jrknvkIQmnVXKHgwK4tKxoEgz
         ZmXcMbqZ5IIOZ0//lm868qZBOcLS9yPL+6eD7T1OQkS8aJ+5lJBgSvduEIV2Ddgjn7b8
         Qf4y3fALRYTCynERow8urdMsyKBZLDrtAjPAnriaaBOJOFYvyxlwwhUABqym3Ws5TPwO
         Vi4uP97+R7kn0beA7wSefc8JdEnAyiuPUb3ia4PdaahZY7ght4IP2vmRjdl5Jg56Vfny
         wUaKWkb5jEQCZYwLG91Q5R+T+WP1i3DsIfpWFxyTa6eMC4Lv6s8MltzP6/kpGzBj/AF2
         xxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=75BUDHsCAc/I/IWJxwpyHr24/zOyWSJ/QNW0ySt+dfg=;
        b=ja95Ch6hxONjug9ywleqG3qG+5rLI9kXiUQ3G2PTST8WoIIUX33LDtb95YHrLMZG4O
         jXTGian6orpYPjEgQcZQoqHZzfFiqXkMhSpzco6GW6JDDsTpHLttflyn9nmkvUMU2RKr
         Mv++OpBeNsJ1VU3GxzjMNpTC8ac7rUyRxHmmfPY1O65Zo+HmQApF3eewdOr1qWy3L3ng
         wcEjIjXeDjZdMrvDJFKPzAct1kroZV++4tz5SK9EPfyzuSPEi8PuEvzVIZQPvGI7+xSU
         rEGWV58atUUC3km9SENLBQW0Zlk7rN2A/FTjPLGLm29QvtE2BTcs279OgQHK4NSG6wzi
         TboQ==
X-Gm-Message-State: AOAM533Dwhil5Zbm7g9jeBW9Pk3E4e3syXsqJFPkXR96QAItJLUurSbg
        CGvvMDmmOrXHXSaMN4l7E5XDXA==
X-Google-Smtp-Source: ABdhPJwvmW2dIpmUc08158xMNoS8xGPlQCmkSKopRGJtMHLYtsb/gmoEYjt0Fag/88VD9XPgJuUUHQ==
X-Received: by 2002:a63:7142:: with SMTP id b2mr11127879pgn.433.1635126729456;
        Sun, 24 Oct 2021 18:52:09 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q10sm14855225pgn.31.2021.10.24.18.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 18:52:09 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/11] dt-bindings: Add vendor prefix for Pensando Systems
Date:   Sun, 24 Oct 2021 18:51:47 -0700
Message-Id: <20211025015156.33133-3-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211025015156.33133-1-brad@pensando.io>
References: <20211025015156.33133-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Pensando Systems: https://pensando.io

Signed-off-by: Brad Larson <brad@pensando.io>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a867f7102c35..4d3d29490a12 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -880,6 +880,8 @@ patternProperties:
     description: Parallax Inc.
   "^pda,.*":
     description: Precision Design Associates, Inc.
+  "^pensando,.*":
+    description: Pensando Systems Inc.
   "^pericom,.*":
     description: Pericom Technology Inc.
   "^pervasive,.*":
-- 
2.17.1

