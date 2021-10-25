Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B63438D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 03:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhJYByn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 21:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbhJYByf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 21:54:35 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73277C061220
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 18:52:14 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v16so1448212ple.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 18:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yaB5sMWDeRg8Wvtv8HtqDzaWjvoJExyww+FfG/ZDrT4=;
        b=uflj1WC38Cux4fFGllmthvD+J8givJ+1nYWnprlocYYSxdRRsS0oASqYz00AczK2dy
         YDgKI8F9Umb4dqo4HcBrX5zWM1K7KXw50iu4aRP2U86fC3fdil1v3nV9KfEseAuuoRt5
         b/dNHCYMch/lHaBrysTccht0yTqMg5fbgAwPof+/fbfjZBB7EM6uS7Wp+/ESWkIyjMSg
         T5UHGsJpsht3pz0iwH96EdvJrqCGc8NzcETUz6zldqQbQA9BM9Priibxiszp8P/yUyUp
         4M2yewAfAJo4j2uyLLEOtE/WR3Y6KYstN+t/VjUUnvNq0EvjCTmOQLaz0UC8WbL7m34M
         MdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yaB5sMWDeRg8Wvtv8HtqDzaWjvoJExyww+FfG/ZDrT4=;
        b=3EG8O5LyNhgas7hYxJ0Yceh47r72hs1BECqwdcjyKhIYvhikjM9/kE+azLeSh3LTsr
         VWK4rHDmJEKa/dIFBz/UTlz1ghqfuCPMfNVkTP1/NIqhSWJjqVt3uXR6HbVgMso7GBBW
         DQSUtOg0yYE1hDqMiEvCG+uWOv6ic2bXlVloTz8m5FyRdsGLa4AYXnVvJLUjou93dXsN
         yqtOJIV4VJJl/HATgL8/ia2xrJxPPsGoaPwj49QlxXVhBtc1RVNmfO2OCFxaIqkjJ5RK
         LLIY/oou69XaMkHIGOMscg/wNmtN6rkVF9tJ20zhtdhTMy0okXW5y7FYkhP8yJHaZy9s
         8Ntw==
X-Gm-Message-State: AOAM533aNUrCP4iZDSF8dy/z2AGyNHhF7RMcUP74rA9GHzdsPyJr5ubm
        Xx6Etd7ezpyWl9y9PEzuohMBfA==
X-Google-Smtp-Source: ABdhPJx/BF3zt7qnTYuuniMwBlB4LeVyXKA5Wedd7pQuVPEuVE9XHOC9UGlOEtipxNLf61A5jbVuNw==
X-Received: by 2002:a17:90b:4a48:: with SMTP id lb8mr17619416pjb.236.1635126733999;
        Sun, 24 Oct 2021 18:52:13 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q10sm14855225pgn.31.2021.10.24.18.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 18:52:13 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/11] dt-bindings: spi: Add compatible for Pensando Elba SoC
Date:   Sun, 24 Oct 2021 18:51:49 -0700
Message-Id: <20211025015156.33133-5-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211025015156.33133-1-brad@pensando.io>
References: <20211025015156.33133-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the cadence qspi controller compatible for Pensando Elba SoC
boards.  The Elba qspi fifo size is 1024.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 0e7087cc8bf9..d4413eced17a 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -20,6 +20,7 @@ properties:
               - ti,k2g-qspi
               - ti,am654-ospi
               - intel,lgm-qspi
+              - pensando,elba-qspi
           - const: cdns,qspi-nor
       - const: cdns,qspi-nor
 
@@ -38,7 +39,7 @@ properties:
     description:
       Size of the data FIFO in words.
     $ref: "/schemas/types.yaml#/definitions/uint32"
-    enum: [ 128, 256 ]
+    enum: [ 128, 256, 1024 ]
     default: 128
 
   cdns,fifo-width:
-- 
2.17.1

