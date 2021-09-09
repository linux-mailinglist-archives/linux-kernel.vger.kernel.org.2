Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA0340485C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 12:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbhIIKXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 06:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbhIIKXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:23:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A85C061575;
        Thu,  9 Sep 2021 03:22:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t19so2531078ejr.8;
        Thu, 09 Sep 2021 03:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0xyIdAQXpt15dqFf4oidmqP73PkrOKqqTxCZ753cua8=;
        b=HWWn7V+Ds7mTBd9Fuup9yn1K8icWORPtppmu+kTkuY3q5GYZogWPb8HXK6x/3nDVB8
         2qSSTgkZHd0bKxKUZ2wNJvZOmmEnnK6oyCyYO6+Lf3xE02WjyIsov0GQaxIwwALwAQwZ
         CofM2K9GQf2A65DIhrk6WHtIWNu6Y4PnT+0mWasJKz1VHAAQCuioehXtYIeAzweB/c84
         4GC3kjcZfOXhfgTwB7pRyHMob3jqu8mjgsPiiZZbiCCrG6Oqf0JDUb9u6fLEcnc5mG6E
         jR9MkmwCtLTYbJVCd0Gl5GeCMnP/yCCp5Ayj//497wloS2HUNVrzmoc7Bxoqpk9an0ii
         metg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0xyIdAQXpt15dqFf4oidmqP73PkrOKqqTxCZ753cua8=;
        b=PZ5aYAf6me6ny4syjtuD/gK4wG5ZADetSPbviLDAVePjKcN8j7uzB+sRxdkze/7qgN
         onpbkH+L01Ks1Qv+409w6TMppM4+kE+h4YfGdwSEJ4Kh0d95wJYq+ZYJ+cZErO14mx+S
         bMpdxhImuSVtCZ7k2gw64kRuF05icCV5c4diEGfPUGTaaIZwkC0A/Hk3eyCNqg8vQtNL
         8esEWua/Qm1RLQHFMGYuvzrG6VDqsZCr0c5TowlHoQeA0LeMCPueY9eSC8FP0SjKjk/J
         Qb/utQftTSkFajPzUexjNzI1g1Hubd5lW7dKsQVibExpn+RbFOuQhZTxBDEHozUTp5cJ
         g8qQ==
X-Gm-Message-State: AOAM532UKFWYiqW+MDcCRwyeTGFONb6fpO2/4nkBkJOX3n7K8dfaxLL2
        c5VvIiNQuwxHrkQssAJVBoUh696JIu0=
X-Google-Smtp-Source: ABdhPJwL1ZcoT7+mQ71+IJDlqha5cYDsHkN8c+wOVH6ni9Hx1rzRJd9D70BUMHjmaGHupd5tkkSy3g==
X-Received: by 2002:a17:906:1497:: with SMTP id x23mr2605234ejc.243.1631182921697;
        Thu, 09 Sep 2021 03:22:01 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id cn16sm808571edb.87.2021.09.09.03.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 03:22:01 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: amlogic: add support for Radxa Zero
Date:   Thu,  9 Sep 2021 10:21:53 +0000
Message-Id: <20210909102154.22710-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210909102154.22710-1-christianshewitt@gmail.com>
References: <20210909102154.22710-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radxa Zero is a small form-factor SBC with an Amlogic S905Y2 chip.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 6423377710ee..67dccdd9a5a4 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -141,6 +141,7 @@ properties:
           - enum:
               - amediatech,x96-max
               - amlogic,u200
+              - radxa,zero
               - seirobotics,sei510
           - const: amlogic,g12a
 
-- 
2.17.1

