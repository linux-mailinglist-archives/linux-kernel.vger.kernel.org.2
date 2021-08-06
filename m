Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522583E3087
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 22:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhHFUqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 16:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245169AbhHFUqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 16:46:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2F0C0613CF;
        Fri,  6 Aug 2021 13:45:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h13so12590667wrp.1;
        Fri, 06 Aug 2021 13:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3wJQqYROu53OkfXOxiXbXsaK10t0gPF2sKNTrvl8ijI=;
        b=BzHquhrgcHqfReZNU2wYHzGqZKMPL0CTZ2OkJbkm9j88UaZl0n/9hJlScWFv6KpTrt
         xrLl3Rm4a3jimEJsAkyv68TBZYE4pe4si0m6lmObgYnKIcaJqraxpPvbC4/Rgx/q32Eo
         EK1Jeg3O4sAD0XrAqySM0nDVrV4i+55GPNo05aiKWTGhAhj+RzI8PCK+sSV2PKaHyLVl
         HKCPyV+JoV9U8NyumlbBTW/ZvQmiStt+svyBOvhcmWhPk1haS7kcdxnqYGpohgzVNVEO
         nIst7Goz3Y6xcPF4zhsQKfhiLOunISdG2u+O1c+U3Z0AQK2c8/TBkGAwyetmmmchfRo0
         nwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3wJQqYROu53OkfXOxiXbXsaK10t0gPF2sKNTrvl8ijI=;
        b=mHmCXZPcM+6gClmpAJWVNa6BQuEz/LhBWfYn5np6eHpD9fAsvw+Xo22ytRsJHpUWDq
         FTuSeI6T15aZVLJ8pSKTvFiEXDhx88+Fd5T+6vBTfgtXNKAHKzPdiux4pVSOOPud/2mG
         7vVJfvsjej5cWmhH3jLMhuG7rEtnMUtGV5Y13Bn6uMpAzw/47Cs9KKc2F5h5XqNwYOTT
         /BAbhA0ngczDTVQTdZnhrDGVnsAz36lxPq7qyEd+HKdUKuXz2yyi1U6nHtrx09YF+hPK
         xofPeNNoSRucUatV2UtN09XnCuDjcHUd2eMwnZ7xrn+BQGR5eBS99NBR6+T6OIxayhMb
         00KQ==
X-Gm-Message-State: AOAM531HVVh47dyS8m6Q0N+BfjcUpBI7FFBmo2AHIHjafQoFm4BB8Wav
        B5Kc7FRAlIEkCWnLd6p87OU=
X-Google-Smtp-Source: ABdhPJzgkqKvOTrcDSDK0+Ko6rn4b8UY3tvzal+b9Qp58RK6njFRYCHGasTaYuCovTJ4qVEYOG2TaA==
X-Received: by 2002:adf:fc50:: with SMTP id e16mr13123857wrs.382.1628282749109;
        Fri, 06 Aug 2021 13:45:49 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id a12sm13029248wmj.22.2021.08.06.13.45.48
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 06 Aug 2021 13:45:48 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 5/5] dt-bindings: arm: bcm: NSP: add Meraki MX64/MX65
Date:   Fri,  6 Aug 2021 21:44:36 +0100
Message-Id: <20210806204446.2981299-6-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210806204446.2981299-1-mnhagan88@gmail.com>
References: <20210806204446.2981299-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Meraki MX64/MX65 series.

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
index 78dfa315f3d0..7d184ba7d180 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
@@ -62,6 +62,12 @@ properties:
           - enum:
               - brcm,bcm958625hr
               - brcm,bcm958625k
+              - meraki,mx64
+              - meraki,mx64-a0
+              - meraki,mx64w
+              - meraki,mx64w-a0
+              - meraki,mx65
+              - meraki,mx65w
           - const: brcm,bcm58625
           - const: brcm,nsp
 
-- 
2.26.3

