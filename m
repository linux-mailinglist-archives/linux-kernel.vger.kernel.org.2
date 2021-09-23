Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DD64163DA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242272AbhIWRJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbhIWRJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:09:36 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A5FC061574;
        Thu, 23 Sep 2021 10:08:04 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i24so3259041wrc.9;
        Thu, 23 Sep 2021 10:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IvlYwMJ6XAVpgLYVyPYDsIW2zKVqln8G4gH8tVla7vA=;
        b=hACYGrr1gKMmyGT28hjxOEZADRDTfqHvzWKpQwt6s6JUDlwq8NlB491piCB41BVXyf
         NL/QcPzjMYKXaxq1oMD6LMTMt7n72Ocv4b72PRkND0xdG8thNbggr14DQsBu9Zldo2lH
         ZUg4OZjFBrJtjhdReaFLoGlLPqI1aDJpiJuSR+LFbFjxUP97isxPvZh4snjeFNWaYw49
         GOz6kDiRmlN2F9C0pTWXtA983GbtP87BBMfH66ICAq1K0fZy6zGJz04DkTibpQxW99tQ
         ZJhGYOmU9DeOHbnn1zgXVThLuXIPShhmQ+BaPZ4FeW5xxsW34wKKEVbtkbk7/PETpU+i
         ZyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IvlYwMJ6XAVpgLYVyPYDsIW2zKVqln8G4gH8tVla7vA=;
        b=7/mHsGi+Cxqgkd9D2tvWdma8fTHqlrEeJvo5MFwPTYc6QPPD0D8ynH4YAvPMZMjHaR
         FaxvuXP9upwLsdFFCwoVkuwfswt0s9US9wg1QepXTiU2lq62NK6ihryzfdUp35nwo6id
         YpYclqugNMO2vRC5EmXt533USHzzNr3FFVmSAJxuf9moTArDCjeMrfSEbOLcbhFMkex2
         Z1OKCcjSTvK6UqGBPNC2Ql2gPhJpJ2/cEh2C1HrNviKFh/r1wimWBgDTOWV1cBJzc4tq
         zSzFKPVWfbBQHf8k0ckznGoYqA3tl4OXmLjkciMoPBShxKbzFkPE6Acr50eoSeLWbrx1
         s3cA==
X-Gm-Message-State: AOAM530+rSgZjJbW7/s6ChCi+eTAdRCAdCv2kF6sCTXPq2q5sWnK9C+0
        G+JhWUNvD81uSLmRjBns2QU=
X-Google-Smtp-Source: ABdhPJym6aI9MUsWn0xe6+XmUGG3SRoWNq+qXjv4ejD+zTldk2wJFtnWlPA55sP0XHfSUrTZ4ul0eA==
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr6372262wrb.274.1632416882680;
        Thu, 23 Sep 2021 10:08:02 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id m29sm6028736wrb.89.2021.09.23.10.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 10:08:02 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: add vendor prefix for Wireless Tag
Date:   Thu, 23 Sep 2021 19:07:46 +0200
Message-Id: <20210923170747.5786-3-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923170747.5786-1-romain.perier@gmail.com>
References: <20210923170747.5786-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a vendor prefix for wireless tag boards and SOMs.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a867f7102c35..de18b6fdbf56 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1296,6 +1296,8 @@ patternProperties:
     description: Winbond Electronics corp.
   "^winstar,.*":
     description: Winstar Display Corp.
+  "^wirelesstag,.*":
+    description: Wireless Tag (qiming yunduan)
   "^wits,.*":
     description: Shenzhen Merrii Technology Co., Ltd. (WITS)
   "^wlf,.*":
-- 
2.33.0

