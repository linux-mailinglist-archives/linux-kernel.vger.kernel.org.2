Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D5C41AA8A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbhI1IZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:25:32 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:47136
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239043AbhI1IZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:25:30 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0C80F4019A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 08:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632817430;
        bh=hCpkTZoM4n3uBZpcQB8z06X1QRNDpVNEm2rAShQKtzU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=qyiiJxtf66z1YC8O+On/5QDQ4Gk2qP4USH5COhl2yTdWREofPufPZ5Gt53hHWwMQz
         twCQV2ucZDzDd5/aHyD0TEUJogTpWYwi/Zr1FYzPJG3PUwNHGOItPwrQuh+zY5dwnT
         y3+GUh5LGd/4nBzlFGO8cltvp+4He3nYJsMCJoZqdY5Or+hap/OP5ff4TDCK24RLTD
         D0M5SCOFLW61eR62BZMwyyVyhAEUnXh18sOrWwVNFjFOprgBiJOzZqMhEK6BaWZI9Y
         S3TqewUOzuAEdXoR2kxkFZgSlm2brHckZizFQ6D9w2ZfqkcmDAODRCSSjoSLtTgZz8
         fO6paGLBTaVDw==
Received: by mail-lf1-f70.google.com with SMTP id x29-20020ac259dd000000b003f950c726e1so18522892lfn.14
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 01:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hCpkTZoM4n3uBZpcQB8z06X1QRNDpVNEm2rAShQKtzU=;
        b=H9y+Gz8fR5YEG/GSBSBgK1+YXp+HXJUDEoOcVFiFOj8UbvrOT6zqANslOGtxH2RVjV
         tZ51BEEDeIWh82lpsSGDccB+MJdrwI7/Z8NnO8zg5QCs4QA9JlB6f8hk/F68GST6v6bq
         +IuRwOBOpZjmHma5ep9Wa/CKmrffZa3XfRehgDVQ2Da/ahydJDysEU0o8GvJoJZxYHps
         8iuizJNm+582D2vXd2LeIPcyj7J6JVE5ix0S8OODzCkfPIZNVfdKCDFo88sFpe/m6IGg
         4/Exb0tr8v6t+RPsN1/uJG57JY+tFMyTSO37/8AnNv+/wAUk0Rj6h4VQjh4FkncStVvg
         Mh+w==
X-Gm-Message-State: AOAM530WAVy5iisytyLdY0sdOOcfeZleG3tSGowO+03pcOfIyZAKOnJv
        vvzbrXc7ActiCknlfvoCp1NM/jHjC5LZ7x8ZmwWtShkk6BUITzgPK/UL6j5yiO5Y+qsEAyohVcw
        GfKEN0ABFUMqE65wr33L7+JBCxVZef5h8X1W/c7Lk2g==
X-Received: by 2002:a05:6512:3341:: with SMTP id y1mr4623525lfd.496.1632817429477;
        Tue, 28 Sep 2021 01:23:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0kiQhvPEnXkPPjDKvzDmgWIBkyJznAjn8DmsrfGeFcE9vto/pgYlvsJ9re4+/35+AKYMcPQ==
X-Received: by 2002:a05:6512:3341:: with SMTP id y1mr4623518lfd.496.1632817429338;
        Tue, 28 Sep 2021 01:23:49 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y5sm1491271ljc.56.2021.09.28.01.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 01:23:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] dt-bindings: mmc: arasan,sdci: drop unneeded clock-cells dependency
Date:   Tue, 28 Sep 2021 10:23:46 +0200
Message-Id: <20210928082346.22398-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The meta-schema already defines dependency between clock-cells and
clock-output-names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 23abb7e8b9d8..dd70431df0b7 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -158,10 +158,6 @@ properties:
     description:
       The MIO bank number in which the command and data lines are configured.
 
-dependencies:
-  clock-output-names: [ '#clock-cells' ]
-  '#clock-cells': [ clock-output-names ]
-
 required:
   - compatible
   - reg
-- 
2.30.2

