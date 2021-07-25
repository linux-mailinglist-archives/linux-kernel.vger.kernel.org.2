Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4C23D505A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 00:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhGYVfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 17:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhGYVff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 17:35:35 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7EAC061760;
        Sun, 25 Jul 2021 15:16:03 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bp1so12043137lfb.3;
        Sun, 25 Jul 2021 15:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LwrLY/6UukkpivGPZA28M5o/zTQMQpj6un1tsCBTWcs=;
        b=V3akwj4JaWTOlALuu6o+qvsykLX8W+xkTHT08R73aTZgGlYEZFblm2f/SAhAnB4igE
         CWJVxJhGfVaBWfd7DQHWjO7U/aTrVIUAX2x7ATEC6BKGH5l8meRqDZmdcxMO9lOP/r1l
         doJVIVLybCaSdTLLvXA6huR2MobBuyJsauYHBymEvWdyiQ5kyfQjb8sPeufBUZMuFvAz
         V75DHA4kmjNj9oVbq3goeXkzxD/OgWDoyqMRXwaHe8Vg2pAyYWZYwK9O2eLpmdq4QipN
         4IqH+ikLmruX17m/Q2/GZoLUTIEn30Z2+43SJNyRJkFeohby780zTCyjEv9Jt5To8UoQ
         jzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LwrLY/6UukkpivGPZA28M5o/zTQMQpj6un1tsCBTWcs=;
        b=i0f2Rivh7kNEIyPPQN3E5g9jSM5Ms22qmHWOONtr5+KnlhNf17oleVpzFMFsK/xlan
         DiHMu39BLBfysD3A95kfrnOV/Dwm0BBhYYBwe+lEG26I7Ihmhr9zOb9NzJY3Gz7OMOjH
         N6LwbLQntBJr7QBh5pKISgg5brWc7ECbtlgFvN3TyNhzyJRkRU2Rf/3KV7CNSdJuqYd1
         /TG9RGIyxZlGVwe8cQtXUyPUaPkulzfIs0e8TBsmt4VMwIF1y8x8cXsaKfi3LLvlSpMY
         fXGYCl8us649BrtXXjToNWCHavvuZsk0s6BBLSC6FGr3bAoIoPm/FAm6foD4KZ/9sTBc
         BIFA==
X-Gm-Message-State: AOAM533IoAyeXKt3mcVLpMSiKbpfh9YAhG6Lle70Rxy3QIC+fXb1fRf/
        D9BRGhkULH+Ezt13uI4LJ5Y=
X-Google-Smtp-Source: ABdhPJw4Re5hg0FJF/1hnt1A4wQi5aU9/lOS1ItTVVZ5s50rQF+jLxU65cE8fM75iWi9OwUs2bHM8w==
X-Received: by 2002:a05:6512:3eb:: with SMTP id n11mr10588723lfq.418.1627251362167;
        Sun, 25 Jul 2021 15:16:02 -0700 (PDT)
Received: from akaWolf-PC.. ([194.79.5.201])
        by smtp.gmail.com with ESMTPSA id z12sm2862647lfu.53.2021.07.25.15.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 15:16:01 -0700 (PDT)
From:   Artjom Vejsel <akawolf0@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, akawolf0@gmail.com
Subject: [PATCH v3 1/3] dt-bindings: Add QiShenglong vendor prefix
Date:   Mon, 26 Jul 2021 01:15:25 +0300
Message-Id: <20210725221527.1771892-2-akawolf0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210725221527.1771892-1-akawolf0@gmail.com>
References: <20210725221527.1771892-1-akawolf0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Shenzhen QiShenglong Industrialist Co., Ltd.
QiShenglong is a Chinese manufacturer of handheld gaming consoles, most of
which run (very old) versions of Linux.
QiShenglong is known as Hamy.

Signed-off-by: Artjom Vejsel <akawolf0@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b868cefc7c55..1d45a2d7a7bb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -926,6 +926,8 @@ patternProperties:
     description: Chengdu Kaixuan Information Technology Co., Ltd.
   "^qiaodian,.*":
     description: QiaoDian XianShi Corporation
+  "^qishenglong,.*":
+    description: Shenzhen QiShenglong Industrialist Co., Ltd.
   "^qnap,.*":
     description: QNAP Systems, Inc.
   "^radxa,.*":
-- 
2.32.0

