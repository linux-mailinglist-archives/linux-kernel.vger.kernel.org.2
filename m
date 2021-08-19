Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792663F194B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 14:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbhHSMbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 08:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239566AbhHSMbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 08:31:20 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F35AC061757
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 05:30:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j12-20020a05600c1c0c00b002e6d80c902dso3935812wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 05:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=thNi9bubmA4Tx9D8MJEICSqpjS4wd2YINGUxGWioadI=;
        b=E7npIvUfVTRCT96ITsr1YFQtm98XRcMqj4nRGFn2dOmRKAfQoVDp7wFZn4rq8S63n7
         CxsIASdUvnrkgNZd0PLo5TJVEyWpDYgJvesvuoklOVgLcC73/cBswqQw9SMJD9MzlltN
         HGUistDWMMAGMseixDku3FT1fdGgnTxBAarmNWCsXoclNY3kfrlITg0hTeT+ZcSj33I1
         5Lcw2oqoHjR89RcgojPTm7c5mJvGs2b1aWpWFJ8mkxrJKx+HTN3QEYUE6ouT+VDC41v/
         8vgrTTS1dGX21Uk2vSphSBuZvbolHMr3Un52a14PbmU37UVdnM70E8fiOG98MUzp+v4L
         se2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=thNi9bubmA4Tx9D8MJEICSqpjS4wd2YINGUxGWioadI=;
        b=t4JIpew5dr3Gwxjk6DF5OWbnK7qreBztd1hsxj1Pax9KFpHey49QiM3BJpKmPMzwz8
         Ql71L36K8rbJI7Cm1JVKD5Rew/9Fp0a28rVnt+ssAOXymrxlNSeY8oViXStQxah5NO63
         haLCJkYy3Y+sOJYLY2HzCAyEYzJuPxqmukqDyFd37g2WgRB4IlyFmbjrpqBSf4rt8CkZ
         OiUV11qgTzAP1Ca0wRApMpTLp1snir5f/mIWkI5RdOzkTHC71jMA20gJFdE7YNNwYYJf
         LoVUfaJBOoIdwxzxqq5RHhPwPQ1iFSeePCHIhHXvl8S1Go/CsQVdaewGU3ip5tHnq3e1
         WtIw==
X-Gm-Message-State: AOAM533/npxqeu7/oDLV/mPJsuff/1XRCpVNmy+o76f0cEZy/dFaHlFa
        xDCU5r3VDz7dsXaapjy+dT9IYg==
X-Google-Smtp-Source: ABdhPJz5Ivt/+oK4goCKkQL7X+EOwdGHIC0Um5Sg7X/mwq6m73vLSx76Mo5Zi9lnKINWcEr7ieP/sQ==
X-Received: by 2002:a05:600c:3ba9:: with SMTP id n41mr13082704wms.111.1629376242901;
        Thu, 19 Aug 2021 05:30:42 -0700 (PDT)
Received: from alex-xps13.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y10sm8146814wmo.18.2021.08.19.05.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 05:30:42 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [RFC PATCH 0/2] Add a generic virtual thermal sensor
Date:   Thu, 19 Aug 2021 14:32:13 +0200
Message-Id: <20210819123215.591593-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add a virtual thermal sensor that uses the hardware thermal sensors,
aggregate them to return a temperature.

My first aptempt was to do the aggregation in the thermal zone but it was not
that easy to do, and, there were some case that would have been conflictual
such as setting differents trip for a regular zone and a multisensor zone.

Instead, I made a virtual thermal sensor that could registered in a thermal
zone, and have its own properties.
It could be added in the device tree, with the list of sensors to aggregate,
and the type of aggregation to be done.

As example:
  soc_max_sensor: soc_max_sensor {
    compatible = "generic,thermal-aggregator";
    #thermal-sensor-cells = <1>;
    type = "max";
    thermal-sensors = <&lvts 0>, <&lvts 1>, <&lvts 2>, <&lvts 3>,
          <&lvts 4>, <&lvts 5>, <&lvts 6>, <&lvts 7>,
          <&lvts 8>, <&lvts 9>, <&lvts 10>, <&lvts 11>,
          <&lvts 12>, <&lvts 13>, <&lvts 14>, <&lvts 15>,
          <&lvts 16>;
  };

The current series build and work but it would require to be completed
aswell a lot of cleanup.
Before working on it, I would like to get some feedback and I know if that
would an acceptable solution and continue that way.

Follows the following discussion:
https://patchwork.kernel.org/project/linux-mediatek/patch/20210617114707.10618-3-ben.tseng@mediatek.com/

Alexandre Bailon (2):
  thermal: provide a way to get thermal sensor from a device tree node
  thermal: add a virtual sensor to aggregate temperatures

 drivers/thermal/Kconfig              |   8 ++
 drivers/thermal/Makefile             |   1 +
 drivers/thermal/thermal_aggregator.c | 134 +++++++++++++++++++++++++++
 drivers/thermal/thermal_of.c         |  43 +++++++++
 include/linux/thermal.h              |  12 +++
 5 files changed, 198 insertions(+)
 create mode 100644 drivers/thermal/thermal_aggregator.c

-- 
2.31.1

