Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8527C3FC593
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240983AbhHaKWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 06:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240908AbhHaKWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:22:41 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4D8C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 03:21:46 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s3so30808226ljp.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 03:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wQ8kS/+bTV4avdS2tU6jC3f6zz+Ryry/9cKDRK1gufo=;
        b=jiP1wMEEvsgc3n7vYx1ledvZpCZkUX5FcfCU/d4NmQ10imEb+nTwuV7AvPQyuAhzpe
         YsP/UU3DHPPh2i10yLbc78f5nCMLrerGJ6O5w2qQxXo1os1R5iEn/nQbRPHBGoAOHkXS
         1aGLp5y3Z3p+M9xTR3mVec6Ve/Wj+o+zBAE2jyiAeEhGtBnmOfK3J7BHgoO9AKlkFMG8
         XHtHiuMg1cbBY5AtMl5rgl7rqbMvAu7ThdDV0Pq3/ED5GoRF4shP/c5KQGW9yKirDnmq
         d2LCC2MTmPF6h0Symi6YMYf/1TDJKL/EaXJSAYRhHwpoTPEraIaRvdsHZ1cUt089Z39h
         /jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wQ8kS/+bTV4avdS2tU6jC3f6zz+Ryry/9cKDRK1gufo=;
        b=GVT642kgXLymB/1je6WpmTf6dQSZX5N7pk6/ywd6pzKREfrfnqPcq7JB7aiSXduBRr
         dvdUU4yfwk65YAKPYTQ9sjZmLY1PRLuyxmt1icPtV2z392791A2crpvTXKQGkPH+Wuas
         EP6giU2UziZkedQJH19KmZPmT6n71Kl9ZGufTJsidYohU4mOxwkFT/jbW7fqmjveBDIc
         KeXTzbfC3PRIByeHReil+Y9DCF6+ZScGUdH58/yQXdqvAiBYXBTe+DX9SA0zj2msafpk
         C/hyOdClXJoFXHBidCET8aJoFlhWLwBe5KALzg7nTxkoED2eKDf6NNZAJtOEK5Bn8mcy
         6MgA==
X-Gm-Message-State: AOAM532UUCwdmd6TrjyK1FNYGpWGvD7EKVqGEmMUmqtsFHyq0kNGMHUr
        wAHUznlZR455qyfisRPjBRZQgg==
X-Google-Smtp-Source: ABdhPJyfAO80CqzIGBt9m8D2PiuI5w5PJosyAgh/JmPeY8WX1k4mcSvpAtqPgpVYTTOGtXaXZQRtog==
X-Received: by 2002:a05:651c:2ca:: with SMTP id f10mr24621298ljo.211.1630405305074;
        Tue, 31 Aug 2021 03:21:45 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id d13sm1687864lfk.232.2021.08.31.03.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 03:21:44 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] of: property: fw_devlink: Set 'optional_con_dev' for parse_power_domains
Date:   Tue, 31 Aug 2021 12:21:41 +0200
Message-Id: <20210831102141.624725-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power-domain DT bindings [1] doesn't enforce a compatible string for a
provider node, even if this is common to use. In particular, when
describing a hierarchy with parent/child power-domains, as the psci DT
bindings [2] for example, it's sometimes not applicable to use a compatible
string.

Therefore, let's set the 'optional_con_dev' to true to avoid creating
incorrect fw_devlinks for power-domains.

[1] Documentation/devicetree/bindings/power/power-domain.yaml
[2] Documentation/devicetree/bindings/arm/psci.yaml

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Some more details of what goes on here. I have added a debug print in
of_link_to_phandle() to see the fw_devlinks that gets created.

This is what happens on Dragonboard 410c when 'optional_con_dev' isn't set:
...
[    0.041274] device: 'psci': device_add
[    0.041366] OF: Linking power-domain-cpu0 (consumer) to psci (supplier)
[    0.041395] OF: Linking power-domain-cpu1 (consumer) to psci (supplier)
[    0.041423] OF: Linking power-domain-cpu2 (consumer) to psci (supplier)
[    0.041451] OF: Linking power-domain-cpu3 (consumer) to psci (supplier)
[    0.041494] device: 'platform:psci--platform:psci': device_add
[    0.041556] platform psci: Linked as a sync state only consumer to psci
...

This is what happens on Dragonboard 410c when 'optional_con_dev' is set:
...
[    0.041179] device: 'psci': device_add
[    0.041265] OF: Not linking psci to psci - is descendant
[    0.041293] OF: Not linking psci to psci - is descendant
[    0.041319] OF: Not linking psci to psci - is descendant
[    0.041346] OF: Not linking psci to psci - is descendant
...

The relevant dtsi file:
arch/arm64/boot/dts/qcom/msm8916.dtsi

Kind regards
Ulf Hansson

---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 2babb1807228..4d607fdbea24 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1356,7 +1356,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_io_channels, },
 	{ .parse_prop = parse_interrupt_parent, },
 	{ .parse_prop = parse_dmas, .optional = true, },
-	{ .parse_prop = parse_power_domains, },
+	{ .parse_prop = parse_power_domains, .optional_con_dev = true, },
 	{ .parse_prop = parse_hwlocks, },
 	{ .parse_prop = parse_extcon, },
 	{ .parse_prop = parse_nvmem_cells, },
-- 
2.25.1

