Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2148F4426C1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 06:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhKBFaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 01:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhKBFav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 01:30:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD30C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 22:28:17 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id u11so1975560plf.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 22:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=date:message-id:in-reply-to:references:from:to:cc:subject
         :content-transfer-encoding:mime-version;
        bh=ddY1h2eGYLfbs2x7Sg+P0Vwdzd/3/Mm7kKddSfpI7pQ=;
        b=gwmn2ZjJcnxOyqAnLS8H4wwi8yTOW3eNImQ+znCVvqycgN5fpO0nBU/ELClCz2w75c
         nt5dP4SvmyLw+j1ZN6utGKQ4gRpwYs4Qge0NXIHN6DS07S9lm6/dfHlT1u/Z+cLBuhGm
         Ng2nd9GUOvFB3KjHKMzmfv06ORLplk8rNtiFzv58MG03HtFKYuCIvOoqQWtERFM8yZMn
         c/0xBn5/9BFCWtLny7NWaiUqqxCg3d+cZMf/lQ8qqYljXOejtmtV5kUsMt/1km/zucB4
         zYGj3bSpjSk4ubiD+tqImcLKnjPIEcnRAZ7Z4uheKMxdu4ftg3VqJLUcOIYThJs//3Uf
         QleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from:to
         :cc:subject:content-transfer-encoding:mime-version;
        bh=ddY1h2eGYLfbs2x7Sg+P0Vwdzd/3/Mm7kKddSfpI7pQ=;
        b=yPhdYl+ASElJcvZpsGn+RNM2h2KYUoukGv9b73y/4DkFTVB1ZKqBH8L0oSQzpblYDa
         SRVuJ9juWjN4BLfU5ySmcM3UI3aV4KW7qf4Z69zQlJTbgDbRTPF6YNJwnrMELvaOQXg9
         mEtfP4mE6tlKDs2Ic72sWXjL1Tw2MVEYLlckkX6Kncg+qJEk1cDT1C/OplO2xic2AQE0
         W/nJE5noOZxD9iuo6vGWszM7O5a5MtRmIDNsYyOPQvheV7Pcx9yW/0qTzWiiZEa82o0H
         RS5Iv/wR3QJko6uy3PStavLAa4T0IsKLI6kbiWeOPk4pDPc4QwGEPTuTVUUJwSlfUdxE
         Ko5g==
X-Gm-Message-State: AOAM531Au4UCgso51qp7yNBQxAouLDSZDa49t6P2ekhitfcesy5zEG/2
        dVQlcQdK3sZsNqCQaRpNdIt2Tq3CvfUMksbL
X-Google-Smtp-Source: ABdhPJyzQyW2vVc977ENPz6lzXGwxknQqwgLYJJ8BApXSW9HGT7quZVgRxyGTVFmvNMsz6VR1dnIAw==
X-Received: by 2002:a17:902:758c:b0:141:4c99:22b3 with SMTP id j12-20020a170902758c00b001414c9922b3mr29400168pll.40.1635830896759;
        Mon, 01 Nov 2021 22:28:16 -0700 (PDT)
Received: from [127.0.1.1] (117-20-69-24.751445.bne.nbn.aussiebb.net. [117.20.69.24])
        by smtp.gmail.com with UTF8SMTPSA id x9sm14344439pga.28.2021.11.01.22.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 22:28:16 -0700 (PDT)
Date:   Tue, 02 Nov 2021 05:27:54 +0000
Message-Id: <20211102052754.817220-1-nathan@nathanrossi.com>
In-Reply-To: <20211102052754.817220-0-nathan@nathanrossi.com>
References: <20211102052754.817220-0-nathan@nathanrossi.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
To:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nathan Rossi <nathan@nathanrossi.com>,
        Nathan Rossi <nathan.rossi@digi.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: hwmon: ti,ina2xx: Document ti,ina238
 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Rossi <nathan.rossi@digi.com>

Document the compatible string for the Texas Instruments INA238, this
device is a variant of the existing INA2xx devices and has the same
device tree bindings (shunt resistor).

Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
---
 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
index 6f0443322a..180573f26c 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
@@ -26,6 +26,7 @@ properties:
       - ti,ina226
       - ti,ina230
       - ti,ina231
+      - ti,ina238
 
   reg:
     maxItems: 1
---
2.33.0
