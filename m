Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722DE39B85A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhFDLyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhFDLyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:54:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA58C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 04:52:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a11so13355760ejf.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 04:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SPjeFhzMyUmAM1Nea2hQ46d2ZnRzhfJiBQSpu2RFObo=;
        b=fXd5Y1hUr4hLV6bBzFtyvxRyyOjdjd5kkSkjkcsFJ+J5Xx+xC2JKJqYuNz1sNNnpg6
         w6cX/KXLzVoDUJQ6cd9xFwUJt6WUevaH+/AA2zbMsFbYYMzMZiYPxfihVg1/X1WUiPhT
         RsNFlAWCYIyNW24oUbriszit4G3lDOrxMfhDS1eM1WxEMYEge7gaC0svVwa96ut9z7Zc
         DO6UtXoRAceRYCtjfyiSfYx36AdZKo1OYnS72wiuwX267GYy5ktb0+M1jJJ3KQl3L14F
         v7qOfuMHWllIkVrvFfRIz8pJVyEI8gMRRVEwFRdGdorvsOkc/VBlKucgVClOqNnbucKz
         B9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SPjeFhzMyUmAM1Nea2hQ46d2ZnRzhfJiBQSpu2RFObo=;
        b=T7nx1P9mZFfrHACDxyCyTkQLxB6Pp5MICohO4uqeW1Hs7kqnOg9+bXLeWubSEB6mS9
         Ou0f+VvQ4INZ/ukEiY3kLCIbMLzy3V9oK7B9H3vbxNT+X+TPn/xfLJncul3SpxQX3vmN
         CLq6fr5o5KDqIXqoxTLomFR4NZ7bjRUrtxC9glo5zWoHCjYWZdX5QZEWzTCqDB6vUDvt
         mFYhe0cPQcOo2MjIT2pGwrzWuO8rvc8lJqvDU3Ds0VWCqddb3sdZab3xIw7ZRoFULjbY
         oj3x6TO1q1C/jsZp2lgPM5+DLi8DjAZs3JhLwJcECFjQcYDZLdL/ZUVAeV4U2yA8r7mF
         jOTQ==
X-Gm-Message-State: AOAM5335kgiy6MOql2UShkcIRRelaQSnB+EoO8k7JlPoqBEGw+3ENmQw
        77tTIoxf6idQW0qezlyTPfhjlQ==
X-Google-Smtp-Source: ABdhPJwFZiuFGPt59sSw/mqaiwnlJug7UBVio3Kww9j06BRd94gIbIgZdypZr+1i1GYFkzzB7POFsg==
X-Received: by 2002:a17:906:1986:: with SMTP id g6mr3751164ejd.265.1622807556621;
        Fri, 04 Jun 2021 04:52:36 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x9sm2805527eje.64.2021.06.04.04.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 04:52:36 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/4] ASoC: codecs: wcd934x: add Headset and button detection support
Date:   Fri,  4 Jun 2021 12:52:26 +0100
Message-Id: <20210604115230.23259-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support to MBHC(Multi Button Headset Control) block found in
Qualcomm WCD codecs. MBHC support headset type detection, both Mechanical and
electrical insert/removal detection along with 8 buttons detection,
Over current interrupts on HPHL/R, Impedance Measurements on HPHL/R.

Eventhough MBHC block supports things like OverCurrent detection, Currently its
reported as a kernel debug message. Should this be reported as an uevent to
userspace? like the way USB reports? 
Any suggestions?

First patch adds a common mbhc driver and the second one wcd934x specific driver
changes along with sdm845 soundcard related changes.

Common wcd-mbhc-v2 driver should be reusable across multiple codecs like
WCD9335, WCD934x, WCD937x and WCD938x.

Most of the work is derived from downstream Qualcomm kernels.
Credits to various Qualcomm authors from Patrick Lai's team who have
contributed to this code.

Changes since v2:
- switched to EXPORT_SYMBOL_GPL from EXPORT_SYMBOL 
- converted one of the if else to switch case.

Srinivas Kandagatla (4):
  ASoC: dt-bindings: wcd934x: add bindings for Headset Button detection
  ASoC: codecs: wcd: add multi button Headset detection support
  ASoC: codecs: wcd934x: add mbhc support
  ASoC: qcom: sdm845: add jack support for WCD934x

 .../bindings/sound/qcom,wcd934x.yaml          |   30 +
 include/linux/mfd/wcd934x/registers.h         |   57 +
 sound/soc/codecs/Kconfig                      |    4 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wcd-mbhc-v2.c                | 1475 +++++++++++++++++
 sound/soc/codecs/wcd-mbhc-v2.h                |  340 ++++
 sound/soc/codecs/wcd934x.c                    |  884 +++++++++-
 sound/soc/qcom/sdm845.c                       |    8 +
 8 files changed, 2785 insertions(+), 15 deletions(-)
 create mode 100644 sound/soc/codecs/wcd-mbhc-v2.c
 create mode 100644 sound/soc/codecs/wcd-mbhc-v2.h

-- 
2.21.0

