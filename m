Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B7B39D142
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 22:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhFFUTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 16:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFFUSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 16:18:49 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268C3C061789
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 13:16:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w21so17541865edv.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 13:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snejp.pl; s=gmail;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O9ZRLR7Ot8Lsx1jsDhH7FGYDbrZdMu5Zb2VpXOb1xQc=;
        b=N1UVhLrqamh+j37H/CDIXyb9wNotOeqY8s7ZhQKgR8OXEErVi8u36Z/aVUfitvBm7q
         vTzY1BNbpCX0npKT5OFB61G8V4MVlPWoxW4Gk5nl+6kvavgIvKjuiVFvbQ2PdrhyhIe3
         UjgpurD7vaZG9U6KniLkS1K81h53Buquee8qH1Xgkkh5vXa/dFmjjuXqpNlbd+VUviP9
         8SNtxBK+1L9V2nUSgTJMyT83z9B2ROutFkqmnjHGljGadKkfeds+lk0ks2ZrdvP/1gAW
         gzGZqV7Pane9zcDf21MzxJipP24NrC9EonsWFHnsvpy3LrQ3TZKUyOXLBat0O6xseh0n
         SISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9ZRLR7Ot8Lsx1jsDhH7FGYDbrZdMu5Zb2VpXOb1xQc=;
        b=p5WZeNzmcEol2L1EA5dHjJh+eXa49Io52LFgKSovmaQY8XFQCxvqIQqX1+i5F0F0jU
         on4JbYQrv3++0B9vSSMkQBHnbUWUWFvNCQTHs7y4JFXs3NfycAkCtOsRyAgFN1JTm9HI
         JDjZjyKDdkw15n2pdqFcyYd5+v4cR5HsYNEiIDPRCYBpMmQbQ6eF8PPPPSQ3/DI59LXp
         8HAaRAgc+x87QGLQD9XuKXhZK3IjzYKzhg/H8NNiJTHk+3KHNOkZ5/+kcwgew9kIs3vF
         juPh4lJHpu9ujrLpxysaFxF5q6XfkzFx8Xv5PYCiPwndhLTIj/cWi6gCGq0lygTBkQMJ
         3bOQ==
X-Gm-Message-State: AOAM530gXDD8cFKOCwugbgz2h5Kv4NeqBqXJzdB+6RLv1XXjnmaWRok5
        2Gf7TB9mw5HuF4mLVO3+B9S8NQ==
X-Google-Smtp-Source: ABdhPJxn6NWckN7q1uCOM6LS0V8FJjs1rgHxW5ZZ6tI+96nCM4aSmz/RXIcLLRXQ6fatx18IzDKWZw==
X-Received: by 2002:aa7:d5c6:: with SMTP id d6mr16311535eds.290.1623010617652;
        Sun, 06 Jun 2021 13:16:57 -0700 (PDT)
Received: from PackardBell (192038129059.mbb.telenor.dk. [192.38.129.59])
        by smtp.googlemail.com with ESMTPSA id v8sm2211623edc.59.2021.06.06.13.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 13:16:57 -0700 (PDT)
Received: from localhost (PackardBell [local])
        by PackardBell (OpenSMTPD) with ESMTPA id 271784dc;
        Sun, 6 Jun 2021 20:16:53 +0000 (UTC)
From:   Bartosz Dudziak <bartosz.dudziak@snejp.pl>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        David Sterba <dsterba@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: arm: Add SMP enable-method for MSM8226
Date:   Sun,  6 Jun 2021 22:16:11 +0200
Message-Id: <20210606201612.100752-2-bartosz.dudziak@snejp.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210606201612.100752-1-bartosz.dudziak@snejp.pl>
References: <20210606201612.100752-1-bartosz.dudziak@snejp.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding in enable-method property for MSM8226 SoC SMP support.

Signed-off-by: Bartosz Dudziak <bartosz.dudziak@snejp.pl>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 26b886b20b..96912f1a26 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -207,6 +207,7 @@ properties:
           - qcom,gcc-msm8660
           - qcom,kpss-acc-v1
           - qcom,kpss-acc-v2
+          - qcom,msm8226-smp
           - renesas,apmu
           - renesas,r9a06g032-smp
           - rockchip,rk3036-smp
@@ -286,7 +287,7 @@ properties:
       Specifies the ACC* node associated with this CPU.
 
       Required for systems that have an "enable-method" property
-      value of "qcom,kpss-acc-v1" or "qcom,kpss-acc-v2"
+      value of "qcom,kpss-acc-v1", "qcom,kpss-acc-v2" or "qcom,msm8226-smp"
 
       * arm/msm/qcom,kpss-acc.txt
 
-- 
2.25.1

