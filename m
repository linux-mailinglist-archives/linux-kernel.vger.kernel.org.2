Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744363730DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhEDTgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhEDTgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:36:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A85C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 12:35:08 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h4so10600383wrt.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 12:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ECt4IwwEy7FG3zWZdqheu507ZfKamNdvmBcqaTIjkuk=;
        b=Mxe4nYHFsLV8wxZ7XHXPTU3l0fP6YkdfwhuBUv43kA7M0CyJUV4vG21Mu3p7uOj3tw
         +gh9dqFTqYrJXuoXmQFolrLyaQ+5ytlgQPZlB59oisvqstBDT/3+HYY+oR0psZV0khit
         XufuwgIHLwkrhVjEwjg4HyKtovNKDOP90fSdgQfPLwWiB6y+8SrLTR2gGo/QJgVM1t4/
         UeOzKT5cNl1DWqQUCozBTY1z2ULnD55ptmj3HQbYMof6ybPwOYlK2kL8c8J/QKuMVxdY
         +P2KxqBmnopJWAYTTQrtB/3njPWqfuA7hdW7E5foU0VVJqS6bslake8/dnCenMPjxqjT
         Uq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECt4IwwEy7FG3zWZdqheu507ZfKamNdvmBcqaTIjkuk=;
        b=MfT9qe/UNVGLSfCpOMEThSJIG51KXJa+jaPdnG6hkRHHQNO2SNtGESkDaxDdpXN8RV
         ju4Hq/YmZeYVQD0T+LpabawJ2mMcXqvTwNmZmB5/y5W/sDcqVFP9V+u0BCxlK+k2DwPy
         XSCKksBapweZe0wqrn/xop46TBT8h/5ztCwL1FGywu3jIXhu/OayeMuS+p2/ZdRppDHk
         fxqENFtujgmf0YaSggWv0/C0Bxoztz7kxq6sAeJ0WrhM18Si8bMawQCMzgsHNokGhaxc
         6oeUGb1b3F+VEmP0ox4n0+78mAwnUfPDV/VmvWberqHkLd7aO7W2e7CHv3kGYqtIFZDc
         xw/w==
X-Gm-Message-State: AOAM533tb2tLVpWSYNkJaK5fTSRCTKupIUJZAIrC1GK36YgIo92Jel/l
        IcPDo2eVtEgWNHOcv9HZXHkesQ==
X-Google-Smtp-Source: ABdhPJwjwaW9YWol8TjtRGI9aOHMyyniv2xovQHdKggE5A/YFOemELHYW0A8a+iyWw3PG94j2veKtQ==
X-Received: by 2002:adf:f212:: with SMTP id p18mr33315887wro.120.1620156907386;
        Tue, 04 May 2021 12:35:07 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x8sm17072136wru.70.2021.05.04.12.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 12:35:07 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, kaloz@openwrt.org, khalasa@piap.pl,
        linusw@kernel.org, linux@armlinux.org.uk, olof@lixom.net,
        robh+dt@kernel.org, soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 4/5] dt-bindings: arm: intel-ixp4xx: add welltech,epbx100
Date:   Tue,  4 May 2021 19:34:56 +0000
Message-Id: <20210504193457.4008384-5-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504193457.4008384-1-clabbe@baylibre.com>
References: <20210504193457.4008384-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds welltech,epbx100 as a valid intel-ixp4xx board.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml b/Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml
index d72e92bdf7c1..230bffeec0e5 100644
--- a/Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml
+++ b/Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml
@@ -17,6 +17,7 @@ properties:
       - items:
           - enum:
               - linksys,nslu2
+              - welltech,epbx100
           - const: intel,ixp42x
       - items:
           - enum:
-- 
2.26.3

