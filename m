Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C9D34C1C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 04:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhC2CAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 22:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhC2B75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 21:59:57 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD38C0613B9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 18:59:57 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id v186so8438018pgv.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 18:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4v8aBx78UIl9kJyUAEU+fhreTJLmflo7CPIF+/o/lfo=;
        b=Tr+1CWmLMakwQlxhNoswu2buyvgjUudoEUlG2okr8+JGP4rXEKwXWRnZ1qz+nYllZ4
         46TFxNerPY3WEoA2o5miu5flNC/sN1W6f2ClG0GxbTTZttO5iHfrDClCB6q2BhOHhTGn
         oiTUDjuPdD6dKrSfMhQtcBmtIxAHNo0h04NbkSHqHVEdOosu/YTpDVWMqdCA3f1EBLdo
         uLnH4jTTeY4MMCL0YZY0IEnsUZIs1GzlZnclqmAQoRoJC49o5+0g+pjD2uwPvuRl9N0U
         1It7VbeDJtk1EJqERhOxRtKHK26xJI1yj5JKACD3lM/4PHrcPEhFD8bH1QmwgvGHx+ND
         hYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4v8aBx78UIl9kJyUAEU+fhreTJLmflo7CPIF+/o/lfo=;
        b=e1Qtp+9IkXfJV4UWjAr6IV9g/0IONmDhbnoEVNKFbzrni63UzPe3KOJyvzEQx+PMX+
         MMxM7Fg4kPKenB6EaQit79b4fB0HFw519AegHCjKzKosH3gxCJjUOfXXIoRlZ2nGa6E4
         FmpbKMBt8Boy8HJUOPhzExPPQIQwlPu3qhE7mXju0/8ZCqiSbXucafnUzuEtlZjrdddE
         S/Mt+Drgxy1rEzLAqKUdVK6ggLgWzRzm+Z+6KAQTREgB4FFjNoXZiNF49VOCsHSeK5iP
         R/KObkXkJxgoZA2b8+zXRXe5CWNifZ0IeuYFdqHcwgeWT4VZk0aL99Me5FETCNpu9wuq
         Kxeg==
X-Gm-Message-State: AOAM532RNFiSAxXWGiCXFZmd8gDLLumBN7ALe5CpmSovFgYF1JcWYx82
        W7ueg0hO+iHBhX3afUl9yeTiNA==
X-Google-Smtp-Source: ABdhPJw48cz/datRyGFev9rtD2ksuMeSNum0EvrgTUC7185VOSAZOYAli0CmY4fU59gozDw6W7rGGw==
X-Received: by 2002:a62:8c05:0:b029:1d8:7f36:bcd8 with SMTP id m5-20020a628c050000b02901d87f36bcd8mr23211066pfd.43.1616983197090;
        Sun, 28 Mar 2021 18:59:57 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id w37sm14728027pgl.13.2021.03.28.18.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 18:59:56 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/13] dt-bindings: Add pensando vendor prefix
Date:   Sun, 28 Mar 2021 18:59:33 -0700
Message-Id: <20210329015938.20316-9-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329015938.20316-1-brad@pensando.io>
References: <20210329015938.20316-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Pensando Systems, Inc.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f6064d84a424..9a21d780c5e1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -850,6 +850,8 @@ patternProperties:
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

