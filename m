Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9734B341848
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhCSJa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhCSJaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:30:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58478C061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:30:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so4863084wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h7Hm+ghwkLRDBAXMVNnrJw9KnhlIxQw5KKOJ32yVNwQ=;
        b=B91xc1g1F0dratEusEbJbkRCwWFgBHj6CI00wIY1FiNueZeWwbhdDux76Y05VbhH34
         6HANw5RONyLoVtsA7hFSiOpX8ncK/aJW0rfvVSsaZK0fBb1x21Nnk5ykZIbWGQiztLIF
         jZBcMME2jGhhv1LfeOept+9NYEKRGx471crt8i8/lozGOLQvX9UDom3UXlFCpKYNQZHo
         6Vv7PaMDOtX78JxdmUj2LIPmWydkwIJ3OXO1XrGaE2Ul4tHILN9J+JEQ1vZ6PVvep9o4
         mI+w/RyooZB523RBlknIrcOCWK+K/qvrx75BDZh27bKEEJkRnKEk3BvhRKOV9aQVs7St
         TU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h7Hm+ghwkLRDBAXMVNnrJw9KnhlIxQw5KKOJ32yVNwQ=;
        b=cElxjLOOlOs2bc2Ef9Hb4ZEx1M63fliuq1Szd2IQjeGgx8R/hzTE/OUdPu5mqngNUw
         cAbmo0ppMpkcJCRifNOT/zXAD8DHDvjiH5nUF8MVxACs4cZMtu6RGoiMDWZfIy5LBzpY
         3RDUrd8eBB7anYCD1KN7D1cknLxtyKWrKkzVyvFjZxf0yo8YYb7UMgI2UrWXLgDCFB7f
         PrX6hHILyX3MjFjQlMM2G2AjDjbmuL+41Zyzj96yl5e6N5CeUl9+kt5+2S2MEPqsIL2M
         Z/swv2tKDN85cX33dvOpAZ4BGT6WvpVec3WFdcbVW6z05mz3NMGZG4yX7ZnO5wo6s0ZF
         NwqA==
X-Gm-Message-State: AOAM532/XOfUwP1ONxF8mG4uXm6JEOos8FaAsxG822LPVpSrhdTAMF8P
        cwNWWLBq9DZaeH399A7nVqJaRQ==
X-Google-Smtp-Source: ABdhPJwuN6X1S9bPZn0gh5KHG32FcDe6PvNMjiCNqgkQ05fhB+gQUu/EBFvYfuhbNDlPrgEME0nJhA==
X-Received: by 2002:a05:600c:198d:: with SMTP id t13mr2888475wmq.73.1616146203868;
        Fri, 19 Mar 2021 02:30:03 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id p6sm6779058wru.2.2021.03.19.02.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 02:30:03 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/7] ASoC: codecs: add wcd938x support
Date:   Fri, 19 Mar 2021 09:29:12 +0000
Message-Id: <20210319092919.21218-1-srinivas.kandagatla@linaro.org>
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

Even though this device has two SoundWire devices, only tx device has
access to main codec Control/Status Registers!

This patchset along with other SoundWire patches on the list
have been tested on SM8250 MTP device.

Am planning to send support for MBHC once this driver gets accepted!

Thanks,
srini

Many thanks for reviewing v2.


Changes since v2:
	- fixed dt_binding_check error


Srinivas Kandagatla (7):
  ASoC: dt-bindings: wcd938x: add bindings for wcd938x
  ASoC: codecs: wcd-clsh: add new version support
  ASoC: codecs: wcd938x: add basic driver
  ASoC: codecs: wcd938x: add basic controls
  ASoC: codecs: wcd938x: add playback dapm widgets
  ASoC: codecs: wcd938x: add capture dapm widgets
  ASoC: codecs: wcd938x: add audio routing

 .../bindings/sound/qcom,wcd938x.yaml          |  165 +
 sound/soc/codecs/Kconfig                      |    9 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wcd-clsh-v2.c                |  350 +-
 sound/soc/codecs/wcd-clsh-v2.h                |   16 +
 sound/soc/codecs/wcd938x-sdw.c                |  291 ++
 sound/soc/codecs/wcd938x.c                    | 3623 +++++++++++++++++
 sound/soc/codecs/wcd938x.h                    |  676 +++
 8 files changed, 5122 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
 create mode 100644 sound/soc/codecs/wcd938x-sdw.c
 create mode 100644 sound/soc/codecs/wcd938x.c
 create mode 100644 sound/soc/codecs/wcd938x.h

-- 
2.21.0

