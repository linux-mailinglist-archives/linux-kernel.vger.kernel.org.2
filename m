Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C563DF8F0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 02:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbhHDAYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 20:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbhHDAYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 20:24:35 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348B8C061764;
        Tue,  3 Aug 2021 17:24:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x8so1499704lfe.3;
        Tue, 03 Aug 2021 17:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LwrLY/6UukkpivGPZA28M5o/zTQMQpj6un1tsCBTWcs=;
        b=GTNBf52OLnhvYLjsS6mwdexNtknfTjxS53LsMKJ0C6muLAFzoMkVs/szLlRRCxyW1X
         qPrTbfaFUy6XqdRlGPIs0i3FzJerK735eHUimkd1dnKkCxguOk31wKLupxXPOpNS+gqv
         FWeNfD6qEy91nuZiBWHDUG+NcUIpc8eEmdEVocl/DG7EshXfzeqEtRoEgbnog9R77igR
         Ge4q2gfuH113c/2sOMd7Wzwri71kPUoQFDWW4cRSd7rIZTFfCn/zqWw8LxsqpLudtbHV
         6MyrwI2iB8LwXdw6fIz/0uzdI0WeJKD6UC004pW01+T01EraSPEcq8MGRvK2rJeJ1hDF
         3Qmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LwrLY/6UukkpivGPZA28M5o/zTQMQpj6un1tsCBTWcs=;
        b=fgopiXGUUOAPYDj32C0WdFP65E7HJ4QsPz4fhu6gGgyQT0hJ3ThSeM3agkbC1wD7/b
         /tjQtxN3EIch8S798MF2mwbuLOysOZgDOpANoHxQ+kPafFd2DozxcYdqrVC97Z5TY4g2
         dGOHBOFulo9FVyA5FBu9WWhxCs7xVP2DDHM6LVgP05NKA3d7lopY2NDjj248lUb3lOW0
         I7Fv+9/vtMEU/vwGF9hckZryeBr/QV7j/V6rWU+Kh8lWOutwU5ReVVoFg8yJgXTXKgPE
         8XurAzwG5l7MziQ7qsCv4AB69+A/SUNO2e6M6IBU8F3DVl9CXsF3kjNf64JdHH/MDVU3
         oTxw==
X-Gm-Message-State: AOAM530RzpOjLghfVXwgmCOTTkCe2u4RVlBDHnoZrwJEqLIlWVO6hiOs
        Ug2bpu3+ABYP+e3jvtztKWk=
X-Google-Smtp-Source: ABdhPJzEtU+tSz7TTxXibyiV9Pqjl9Ur7dpwIVuY8Yahr+tY/7Y5gyu42mE5AozJecRcssTsJsArUw==
X-Received: by 2002:a05:6512:15a3:: with SMTP id bp35mr12869844lfb.99.1628036645662;
        Tue, 03 Aug 2021 17:24:05 -0700 (PDT)
Received: from akaWolf-PC.. (broadband-5-228-138-51.ip.moscow.rt.ru. [5.228.138.51])
        by smtp.gmail.com with ESMTPSA id t17sm40992ljk.102.2021.08.03.17.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 17:24:05 -0700 (PDT)
From:   Artjom Vejsel <akawolf0@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, akawolf0@gmail.com
Subject: [PATCH v4 1/3] dt-bindings: Add QiShenglong vendor prefix
Date:   Wed,  4 Aug 2021 03:23:51 +0300
Message-Id: <20210804002353.76385-2-akawolf0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210804002353.76385-1-akawolf0@gmail.com>
References: <20210804002353.76385-1-akawolf0@gmail.com>
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

