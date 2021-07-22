Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915E53D252E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 16:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhGVNZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 09:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbhGVNZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:25:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26922C061760;
        Thu, 22 Jul 2021 07:05:58 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m16so8676154lfg.13;
        Thu, 22 Jul 2021 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SOSmzvWDnV1n+6dhGf47+1g6nbwp/1OAUc7BCbVeW+M=;
        b=uKldJXrG1YhdQp0OJwXKaAdtdz1+SW0ptLgGX9sTRZX8Sccd77jAnqn5c7TY/O/4dj
         1f6/nxEPnLT3zzo+C+vsV/UBAmSVftTeE8EWG6FOnrxGptGkD2ny7L0NkQYUZ5supgLu
         Iyz760KN9bNqjC/CHfCnCQ7vRllmBive6StX7SYuYbmoWDOqz/1o7aUMNWIzK4cJJzT/
         +00Mx1EY5YNFpWodJVgY/gAqxraIZN4p2XLNMQlhvlCNui5k/wTORmP2BxcT+skVOTI8
         Ed4nDi8ECW6KfKDhDf2/nzz1vMLdc7icbhRCJr1vk21otzXNI2O4JUKvqClj0gKBOOoZ
         9ZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SOSmzvWDnV1n+6dhGf47+1g6nbwp/1OAUc7BCbVeW+M=;
        b=Trz4h5kuMcEnrtwMrk5JoJvXKRLTMPKJ3SLqsd47mB1cMfNkEDW1UoIiMhsuOuHp6I
         pZMcKyEysehEVVBuU13tbyQGBQ2HSyCripuyKl+xhXxNJHXVyOjzBn1FG+hxQq5fwbjV
         OBjNP4FRMe0ASH2+qhLoYIGQwg8qnQ2Z45lovm83zPOA5CMeAIsqd+4YxmKZIcSe7og3
         WVXz2oJvdLM14fgEMrc1qZtpMEMJia1C7XAaT7usoDmJSQV+y8+l8jHX4JBgTEiVMqgz
         6rlbF+78jmBx8DWpSL0eXl6MEOptWNE4WZtLgB9V2HFUEf1ONX0ShkpxHekj/6qUs5Xd
         4Jmw==
X-Gm-Message-State: AOAM530ymWuJKaq0bGHl7XJBlcFNXQQ3nuV8u4aO5d4qTW+3CPHWY4CF
        DBG8kPqxHz8iTuuNBYUPA58=
X-Google-Smtp-Source: ABdhPJwYxSivOMyygZ3RW7OhMkKi4qlqKdtB5TAH5fJ63oXm1RRjDOeZdx4rR4FHk7vZn0xYJL8VzA==
X-Received: by 2002:a19:7514:: with SMTP id y20mr29224931lfe.623.1626962756497;
        Thu, 22 Jul 2021 07:05:56 -0700 (PDT)
Received: from akaWolf-PC.. ([194.79.5.201])
        by smtp.gmail.com with ESMTPSA id p8sm190584lfu.163.2021.07.22.07.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 07:05:55 -0700 (PDT)
From:   Artjom Vejsel <akawolf0@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, akawolf0@gmail.com
Subject: [PATCH 1/3] dt-bindings: Add QiShenglong vendor prefix
Date:   Thu, 22 Jul 2021 17:04:30 +0300
Message-Id: <20210722140432.1426173-2-akawolf0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722140432.1426173-1-akawolf0@gmail.com>
References: <20210722140432.1426173-1-akawolf0@gmail.com>
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
index b868cefc7c55..52996cbf2cc4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -924,6 +924,8 @@ patternProperties:
     description: Qi Hardware
   "^qihua,.*":
     description: Chengdu Kaixuan Information Technology Co., Ltd.
+  "^qishenglong,.*":
+    description: Shenzhen QiShenglong Industrialist Co., Ltd.
   "^qiaodian,.*":
     description: QiaoDian XianShi Corporation
   "^qnap,.*":
-- 
2.32.0

