Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DB0387B48
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhEROj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhEROjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:39:24 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80851C061756
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:38:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o127so5556697wmo.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mE2MENBP8OHhxc2QEqxv5MmkAUk1hcdbV87e9Jg3ziM=;
        b=U9PbCXaPBtKPTQBynkPy5/aESRYE6eNapGtHSu4pYxv5aULFyUWY8AZ7qWFQD5qo/V
         zsGgfz7GoOzcnSB2BS7+2KbhyE5aYi6soJGsGlERG4kfNjJ5RX65tOY2NFJOXxcOepDW
         vsQdpv5l5zcL1HISRFIMmvGlJLIDYvYyzWxS8lR//PgOqdrNpTmJ2aJD75uDfYLxEv34
         9V8wQU5F5jdI3bF9wp0PBJv9yYj7UUGz1/ClQphuMqXbDFNOG02quhAvF7DwbHfFd59l
         0KP7V+vJf53X0ORg7zSz9nIjY2Jq4zy6wJ6sJ6Nh4Bj/pQ1E/qfACEnHVQ8af7XzloFW
         k2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mE2MENBP8OHhxc2QEqxv5MmkAUk1hcdbV87e9Jg3ziM=;
        b=CmqjcNZRfe46oDgisw66jekA5bYT6iSacBh2hisK0JEOQpYulz3xQrxfp1/Pu+AYZP
         N/4pb+ssDON67GzRxIQOm9n8L+yPIXT4IquEyxbOfsWYSNPIxG3DrUIaWgceDH6qUiKF
         QURhrKbIMbiE0/2IMOYza8nivq5tAaGnjubEUsUuirZzJMETACPot+HsIHvt3CKSpjjR
         FjGtHWm+kojh5XW09K7EbWsdR9uQ2mnRTcN5R57FJieHatKg373yA513d8/tubCL8Gu7
         qE6uPwcbvI8qsULTlygXvPrvxmwmMJWP4gk9dFou9Zp+q/gfu/UgdWKGQpFPSbBLE45V
         7uQw==
X-Gm-Message-State: AOAM530wPiO5AwvSAk0A6KrRrQeTzltAiMBmPylU9yod4ZmucAvJrR/2
        wFpd3R584n/94SX3PvFdL/iYmg==
X-Google-Smtp-Source: ABdhPJwhaavdxdJD/EGbuei1v8exFvlpDGMlyeRZHP/pamSqgThe6zrK9mpkaG17vL5EeKmg/5ebtw==
X-Received: by 2002:a1c:b384:: with SMTP id c126mr5889386wmf.110.1621348684125;
        Tue, 18 May 2021 07:38:04 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id m6sm21329087wrp.29.2021.05.18.07.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:38:03 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 0/9] ASoC: codecs: add wcd938x support
Date:   Tue, 18 May 2021 15:37:50 +0100
Message-Id: <20210518143759.16837-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for Qualcomm WCD938X codec.

Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC
connected over SoundWire. This device has two SoundWire devices, RX and
TX respectively supporting 4 x ADCs, ClassH, Ear, Aux PA, 2xHPH,
7 x TX diff inputs, 8 DMICs and MBHC.

Eventhough this device has two SoundWire devices, only tx device has
access to main codec Control/Status Registers!

For codec driver to be functional it would need both tx and rx Soundwire devices
to be up and this is taken care by using device component framework and device-links
are used to ensure proper pm dependencies. Ex tx does not enter suspend
before rx or codec is suspended.

This patchset along with other SoundWire patches on the list
have been tested on SM8250 MTP device.

Thanks,
srini

Changes since v5:
	- removed ref in qcom,mbhc-buttons-vthreshold-microvolt bindings
	 to fix dt_bindings_check warning


Srinivas Kandagatla (9):
  ASoC: dt-bindings: wcd938x: add bindings for wcd938x
  ASoC: codecs: wcd-clsh: add new version support
  ASoC: codecs: wcd938x: add basic driver
  ASoC: dt-bindings: wcd938x-sdw: add bindings for wcd938x-sdw
  ASoC: codecs: wcd938x-sdw: add SoundWire driver
  ASoC: codecs: wcd938x: add basic controls
  ASoC: codecs: wcd938x: add playback dapm widgets
  ASoC: codecs: wcd938x: add capture dapm widgets
  ASoC: codecs: wcd938x: add audio routing

 .../bindings/sound/qcom,wcd938x-sdw.yaml      |   70 +
 .../bindings/sound/qcom,wcd938x.yaml          |  148 +
 sound/soc/codecs/Kconfig                      |   13 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/wcd-clsh-v2.c                |  348 +-
 sound/soc/codecs/wcd-clsh-v2.h                |   16 +
 sound/soc/codecs/wcd938x-sdw.c                |  298 ++
 sound/soc/codecs/wcd938x.c                    | 3753 +++++++++++++++++
 sound/soc/codecs/wcd938x.h                    |  705 ++++
 9 files changed, 5345 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
 create mode 100644 sound/soc/codecs/wcd938x-sdw.c
 create mode 100644 sound/soc/codecs/wcd938x.c
 create mode 100644 sound/soc/codecs/wcd938x.h

-- 
2.21.0

