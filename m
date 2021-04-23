Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C01A3689EF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 02:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbhDWAlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 20:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhDWAlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 20:41:52 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE7AC061574;
        Thu, 22 Apr 2021 17:41:15 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id x11so48184826qkp.11;
        Thu, 22 Apr 2021 17:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=00AZkOPFLYj+78Qt8S3aqJKmQoaYOsFThULUOdLSMzA=;
        b=RNSJMv2Rh5SwI0FMZCxGC0218anlBgJ7WBNTX/iJPPXDsKmmBLzgb51LsFU3z94693
         RSEtYtVRIM0XVHEsh0OV/jecGJwslJEEUY/UEKfRCKRVu534YDjWKAkoxo6j+FiUIR8J
         60JS7U/x0gQ0Rcr5w/neFU3fMJDOPPyyNWUNfPlmBJNJ3pZe6wW/g08fDTcbl8eeALB2
         tcLDDvqszc4UbuK4XU4O1DiKBrVCCbrjmh+dtXygZu/2VOOOo1m1ZPAf4jeNcyyXsBJI
         Z2DshIUmBJPcuiwkYp8nNIU6Bij3E6qd3z6nF2pGdwCmg38rRH64qezopwEpuleNWHNg
         UQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=00AZkOPFLYj+78Qt8S3aqJKmQoaYOsFThULUOdLSMzA=;
        b=j21vp3Br7FucM/o4ZZVUQFglVt90wcTeHu6CG905I2RryY41rm/Nv92TNCd483LY9B
         9r4vqwWYVXhHn5hxLbc0l+bRt9pGtmES5A+tLbZ6bbMw9zewzKDcfrr8qlyKhfGI8ea+
         grPkvCQs3sahZp5pEeczko8wb7wjR9T4/xKvwOXSeflCw8qPMAAa7jaMjnGC3vKMtEW0
         sC5kziIvZ11+7hfXO5/0MHdQYkWDX5BRTDpEFl/jaom2e8NJ3wqf0G5JNKKztruktVew
         ws/oKx5weDoji3nbPkKx76sGj7o1KOPZdQbJsqX3/XrDXAJkJ3mnexFSNxMtyw+Cf8Qn
         VONw==
X-Gm-Message-State: AOAM531c3elqgTnDnKg4wHjPWWLrTJp+iZaAdnnpzbtpdWU+lV4k5yzY
        GodNz0YJnn3OTuBmZIeziH4=
X-Google-Smtp-Source: ABdhPJyR2S5b6/1ydJk3KUu8WyKefqvEd8qvKpIcFmbUHtaL38NWVjIKngUYMa4hcawYeFABMEnYLA==
X-Received: by 2002:a37:e47:: with SMTP id 68mr1536814qko.372.1619138475053;
        Thu, 22 Apr 2021 17:41:15 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id n15sm3241586qkk.109.2021.04.22.17.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 17:41:14 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, mturquette@baylibre.com, sboyd@kernel.org
Cc:     julia.lawall@inria.fr, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: [PATCH v5 0/3] add support for the lmk04832
Date:   Thu, 22 Apr 2021 20:40:54 -0400
Message-Id: <20210423004057.283926-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Hi,

The LMK04832 is an ultra-high performance clock conditioner with JEDEC
JESD204B support and is also pin compatible with the LMK0482x family of
devices.

This driver adds initial support to configure the LMK04832 clocks using
the clock framework.

This has been tested on a system using JESD204B subclass 1.

At the moment, the VCO rate has to be set manually from the devicetree
and a dclk (or sclk) rate change isn't propagated to the VCO
automatically.

Changes since v1:
- add yaml devicetree documentation,
- add links to datasheet,
- use {u8,u16,u32} instead of Uint_ variants,
- drop redundant debugfs code,
- use a pointer to device_info instead of struct copy,
- add of_device_id table,
- add support for SYSREF digital delay and JESD204B subclass 1

Changes since v2:
- fix dt-bindings documentation, apologies for the broken build
- fix property vendor prefixes
- split dt-bindings into a separate patch

Changes since v3:
- add missing properties in dt-bindings

Changes since v3:
- address coccicheck comments
- update dt-bindings


Thanks for your time,
Liam

Liam Beguin (3):
  clk: add support for the lmk04832
  clk: lmk04832: add support for digital delay
  dt-bindings: clock: add ti,lmk04832 bindings

 .../bindings/clock/ti,lmk04832.yaml           |  209 +++
 drivers/clk/Kconfig                           |    7 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-lmk04832.c                    | 1596 +++++++++++++++++
 4 files changed, 1813 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
 create mode 100644 drivers/clk/clk-lmk04832.c

Range-diff against v4:
1:  cb6a8ea514d8 ! 1:  11461912b3c4 clk: add support for the lmk04832
    @@ drivers/clk/clk-lmk04832.c (new)
     +		if (ret) {
     +			dev_err(lmk->dev, "missing reg property in child: %s\n",
     +				child->full_name);
    ++			of_node_put(child);
     +			goto err_disable_oscin;
     +		}
     +
    @@ drivers/clk/clk-lmk04832.c (new)
     +
     +		lmk->clkout[reg].sysref =
     +			of_property_read_bool(child, "ti,clkout-sysref");
    -+	};
    ++	}
     +
     +	lmk->regmap = devm_regmap_init_spi(spi, &regmap_config);
     +	if (IS_ERR(lmk->regmap)) {
2:  8464eac02aab = 2:  01b64b5af4ed clk: lmk04832: add support for digital delay
3:  a2c4e8d53d1c ! 3:  96b514765de0 dt-bindings: clock: add ti,lmk04832 bindings
    @@ Documentation/devicetree/bindings/clock/ti,lmk04832.yaml (new)
     +    const: 1
     +
     +  spi-max-frequency:
    -+    $ref: /schemas/types.yaml#/definitions/uint32
    -+    description:
    -+      Maximum SPI clocking speed of the device in Hz.
    ++    maximum: 5000000
     +
     +  clocks:
     +    items:
    @@ Documentation/devicetree/bindings/clock/ti,lmk04832.yaml (new)
     +    required:
     +      - reg
     +
    ++    additionalProperties: false
    ++
     +required:
     +  - compatible
     +  - reg

base-commit: f40ddce88593482919761f74910f42f4b84c004b
-- 
2.30.1.489.g328c10930387

