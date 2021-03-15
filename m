Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9511533C135
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhCOQFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbhCOQFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:05:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49577C06174A;
        Mon, 15 Mar 2021 09:05:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b16so5212699eds.7;
        Mon, 15 Mar 2021 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tpaD+sXA8R0kAGrrRfdmXvK9xIK7V2SVy6wfJ0s+afU=;
        b=MVR1A9tk0mctbzckejGFDXyXxGu75970Gm539Fi89eGQlttPSYIQC5NGemsLFOeNye
         cVS/sE8YtguGyOOPVlQVm5Wx+Nw48FN1HggmhpNXnBHrUP6NfmM/HNQ2FH+o4JtkbjKD
         RxMjEyR9gVVDWv5TgmIe/E2zZpdD4R0+WEhlq/hc7xKuAaQ4MdiMrliwI7m9btccT54O
         hHSKMuQmx4dWGVFAIEPTFWeeB5m3Rx8rFKY3ongecLTZpW/Wtf4/pPd+yqmLg6PJl5a6
         fztGE8WF3IFfQ1ivDGUBta7wQxUk9pcxk5pG9cIKb3SFdTjSTnO0trOaP9Gr2zggJ+uP
         rz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tpaD+sXA8R0kAGrrRfdmXvK9xIK7V2SVy6wfJ0s+afU=;
        b=PPoDLkJEM0OugGBa4daYp/zO/TDqa5WMNs3uCgnA5tviZO6FL3BoR8GW7dm1/j2gPX
         wh8Eb1z2g76zZ1PMaot++G/5us+aUEmd4N85jb5w32mWgmmsaaY6A58rSJK9rV+AN1zg
         kJaJuzDj73Cl+KL98myOakDrO4eNgJzkE0m9Vhl7CB286/wvw5hXGDOEIaOQaJ8V5ePM
         KfCmSHkNVx/kOLgVQCmHlNszncbo+6Fxfai5oOQO95JNZXQrkUrQxJx9d51P0ujg/Vra
         W8H2w1urqZvoWqiNxwyijUBlKBcBGu9uyWSqI3j0UcavYHzTN30wHYv31j9KyhE6jBzD
         +asQ==
X-Gm-Message-State: AOAM531W/N9jsO9J762dV/T0E30GcwvFDHswp32VSg44XBCgxT4fHaQy
        MrF37EbFdTHLm87SHNesCu0=
X-Google-Smtp-Source: ABdhPJza26hhc1KZ/PQi8gU3jkKohJT/sKNRTqhviJRj6cexeHgoR8xzggQkUeEKPFVzaHS5v+gY7w==
X-Received: by 2002:aa7:cb4d:: with SMTP id w13mr30922963edt.249.1615824312983;
        Mon, 15 Mar 2021 09:05:12 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d28:c000:5c39:c910:15c8:a935])
        by smtp.gmail.com with ESMTPSA id z17sm7748510eju.27.2021.03.15.09.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:05:12 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 5/5] MAINTAINERS: rectify entries for dt-bindings
Date:   Mon, 15 Mar 2021 17:04:51 +0100
Message-Id: <20210315160451.7469-6-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210315160451.7469-1-lukas.bulwahn@gmail.com>
References: <20210315160451.7469-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron converted a number of dt-bindings from txt to yaml in
./Documentation/devicetree/bindings/iio/:

  Commit 58ff1b519753 ("dt-bindings:iio:adc:atmel,sama5d2-adc: txt to yaml conversion"):
    adc/at91-sama5d2_adc.txt -> atmel,sama5d2-adc.yaml

  Commit 8c41245872e2 ("dt-bindings:iio:adc:renesas,rcar-gyroadc: txt to yaml conversion."):
    adc/renesas,gyroadc.txt -> adc/renesas,rcar-gyroadc.yaml

  Commit 9a6ac3138258 ("dt-bindings:iio:humidity:st,hts221 yaml conversion."):
    humidity/hts221.txt -> humidity/st,hts221.yaml

  Commit 1e6536ee349b ("dt-bindings:iio:dac:adi,ad5758 yaml conversion"):
    dac/ad5758.txt -> dac/adi,ad5758.yaml

  Commit 7a2cf8e91390 ("dt-bindings:iio:imu:st,lsm6dsx: txt to yaml conversion"):
    imu/st_lsm6dsx.txt -> imu/st,lsm6dsx.yaml

  Commit b4be8bd1c6a2 ("dt-bindings:iio:proximity:st,vl53l0x yaml conversion"):
    proximity/vl53l0x.txt -> proximity/st,vl53l0x.yaml

All these txt files above are referenced in MAINTAINERS.

Adjust the sections with references to converted dt-bindings yaml files.
As .../dac/adi,ad5758.yaml is already covered by .../*/adi,*, simply
drop the file entry for .../dac/ad5758.txt.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a046e62b619d..7df1e7b37e68 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1142,7 +1142,6 @@ W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
 F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
 F:	Documentation/devicetree/bindings/iio/*/adi,*
-F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
 F:	drivers/iio/*/ad*
 F:	drivers/iio/adc/ltc249*
 F:	drivers/iio/amplifiers/hmc425a.c
@@ -8224,7 +8223,7 @@ M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 W:	http://www.st.com/
-F:	Documentation/devicetree/bindings/iio/humidity/hts221.txt
+F:	Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml
 F:	drivers/iio/humidity/hts221*
 
 HUAWEI ETHERNET DRIVER
@@ -11824,7 +11823,7 @@ MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER
 M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
+F:	Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
 F:	drivers/iio/adc/at91-sama5d2_adc.c
 F:	include/dt-bindings/iio/adc/at91-sama5d2_adc.h
 
@@ -15294,7 +15293,7 @@ RENESAS R-CAR GYROADC DRIVER
 M:	Marek Vasut <marek.vasut@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
+F:	Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
 F:	drivers/iio/adc/rcar-gyroadc.c
 
 RENESAS R-CAR I2C DRIVERS
@@ -16975,7 +16974,7 @@ M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 W:	http://www.st.com/
-F:	Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
+F:	Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
 F:	drivers/iio/imu/st_lsm6dsx/
 
 ST MIPID02 CSI-2 TO PARALLEL BRIDGE DRIVER
@@ -17003,7 +17002,7 @@ ST VL53L0X ToF RANGER(I2C) IIO DRIVER
 M:	Song Qiang <songqiang1304521@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
+F:	Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
 F:	drivers/iio/proximity/vl53l0x-i2c.c
 
 STABLE BRANCH
-- 
2.17.1

