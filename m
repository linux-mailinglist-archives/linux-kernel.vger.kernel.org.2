Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D929533497F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhCJVIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhCJVI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:08:29 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00B2C061574;
        Wed, 10 Mar 2021 13:08:28 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id p8so41572179ejb.10;
        Wed, 10 Mar 2021 13:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0SX53bYeJpoRn/Rj8EJYnn/yWlrMIeX4TZ6gWcrZofc=;
        b=bmC+GZuRpPw22iaH2nG9joxOZVNCyQ1ZEe+2lEU2JOh9Ei2AeeP+twZLnzoNb+/5lh
         L7hfz8o+uo0vLTKt6cNNlMNcKCgiRDRjxe/4VpEzHbT3iE8UvfKfbaFHwfF8PGSe1weY
         GE5UKQPgrg2Rf1VmwyWeMutLitQET78oyCiG36084I0rZSY9/upOTWWo/jSQKBrYQL0e
         CdtbQrHk2m/Yl3Wlqb877oxESdLiFMo9aVGaARam8/XrsmirLW4vRakHHcmbHOAFJVGi
         KQ+uioCVj1UhAjc8UofeeIUP+7ZNTmfNmfPsayy8d5azv0LUg96EQbb31mL0sxcNXj8T
         tiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0SX53bYeJpoRn/Rj8EJYnn/yWlrMIeX4TZ6gWcrZofc=;
        b=PsTY3JJaJtrNzsiqAvE6LOIz4CTIRMWbiI0sUYJbdw82C6JV5O9MuhvSqNU74TPgbn
         DxcgULEueOBnrBhdc6RyJSxig6+a9Wb0YbznqLNaFQJVdnLI/wetwyFIUoLwAMY8szOD
         t369D9KwOazxvOHvYsrq4Q6R0m6+BKSzbnfcvf7x/sktX3dhCkV7qUpoCfrc4mRLkvEc
         0aSX0/ho6McxmhF4dtATePzdfO802vC28wxbSI99COqsLG7OU0otgEBpMUSdGCifHokr
         unLfPPY3dLEHo2gGKr6hPaD4ZrGtS1zF0EWk75xZEvTSAESCV2XpGxW9o4e/lchVSxmz
         N4SQ==
X-Gm-Message-State: AOAM533x3DoqVOD9K6GPujUOhujWzKqZutXpG+3LcocQKj3vIYPmpYge
        eLzlcim+l2I34pWCxuP7ywE=
X-Google-Smtp-Source: ABdhPJzKCqWitK4itgJF5gOPWZ9BHxznB01QDhOfG6tEDyip2Frv/S1yKF7GrTdEgH6a7nWKme2yTA==
X-Received: by 2002:a17:906:f1c8:: with SMTP id gx8mr334710ejb.385.1615410506866;
        Wed, 10 Mar 2021 13:08:26 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id f19sm252947edu.12.2021.03.10.13.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:08:26 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] devicetree: nvmem: nvmem: drop $nodename restriction
Date:   Wed, 10 Mar 2021 22:08:03 +0100
Message-Id: <20210310210812.8880-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210310210812.8880-1-ansuelsmth@gmail.com>
References: <20210310210812.8880-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop $nodename restriction as now mtd partition can also be used as
nvmem provider.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 7481a9e48f19..b8dc3d2b6e92 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -20,9 +20,6 @@ description: |
   storage device.
 
 properties:
-  $nodename:
-    pattern: "^(eeprom|efuse|nvram)(@.*|-[0-9a-f])*$"
-
   "#address-cells":
     const: 1
 
-- 
2.30.0

