Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFB5397268
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 13:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhFALgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 07:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhFALgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 07:36:19 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABBCC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 04:34:37 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i13so16843375edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 04:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3z4f9OtSIbuNbOfZKzA5/qCGi7jD1UUm7qfZnJAs7+c=;
        b=aBxtyGNNDN2VF/9oG4s3CHhiR1NgayvyPXk61RGSRhhhcL22f9AchZhQKM7LjfQnpr
         ud7eaXUeLcfh3Mp8/XzfAboSobak4+iTzl7xSUjoChJopx0hbEtMBwF29H1CiqzqQH2x
         K+LFcKliXCNxosLn/RKZy9vIh0VzQTZzAhz/mIgPb5WCF7TPg1BIo0ravY9zCKN3I7lp
         1hoGXNJzRy7GJFl4rPRd/LXWxwlZK7FenE329G4ZIakdiOoXImygc3VbioeFdegT0i1W
         KwU1ioC/ldaGl9M0vCwfxdSc+LZIDUCDBlY7f9yOrp9zYMUiGiNYq0yPVnWTrN1eQW8U
         f3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3z4f9OtSIbuNbOfZKzA5/qCGi7jD1UUm7qfZnJAs7+c=;
        b=rMdHf0Or2qx3NdPxD1Hw4qztBKrYN+kKWCadf/zEUNxn/zLqhqANlLEGF6CX0rMa0f
         s3TjGqewM0mni/RCkHt/bjQH0AePJpVUsYCRkR699S0/P/DYKbAKSxPuWsjvLlN/m0Ci
         52t02TVkWElx5RSGTzxcx8VoeDAbAIXvAubSET6jvqI/vbnSGnbfHgJ3my8eG/lUHfHK
         c5SFSMrugyfHTz6W3gvwtxgsUY9Qv0JuZoXNLpG4kQnl1O/G+DZJY4kb5EWe7AHgyCZD
         E1t1b3RVaDvrNH0om2pCTNiV09E7mSsUeDJao0oqzlgsHdbmUaaiaPXq7892mYcg+s1s
         caBQ==
X-Gm-Message-State: AOAM5310Mdq8SRuBwydv2IpZ+V4HxaOphyjO2twDZbSPPWnMuKR046xn
        BjoTTYkBQdsCdNfE6TVniMIN6g==
X-Google-Smtp-Source: ABdhPJzF5pFr9Bwg3mL0v55aEGXnwhGOjgGDv9bgvy6GHV/sknQiN/zVcpPVsS+iskX+kz16xT5RRQ==
X-Received: by 2002:a05:6402:543:: with SMTP id i3mr15827295edx.173.1622547275613;
        Tue, 01 Jun 2021 04:34:35 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id f10sm4729487edx.60.2021.06.01.04.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 04:34:35 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v8 0/9] ASoC: codecs: add wcd938x support
Date:   Tue,  1 Jun 2021 12:31:49 +0100
Message-Id: <20210601113158.16085-1-srinivas.kandagatla@linaro.org>
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

Changes since v7:
- Fixed errors reported by kernel test robot by moving SoundWire specific bits to sdw driver.

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
 .../bindings/sound/qcom,wcd938x.yaml          |  146 +
 sound/soc/codecs/Kconfig                      |   13 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/wcd-clsh-v2.c                |  348 +-
 sound/soc/codecs/wcd-clsh-v2.h                |   16 +
 sound/soc/codecs/wcd938x-sdw.c                |  315 ++
 sound/soc/codecs/wcd938x.c                    | 3743 +++++++++++++++++
 sound/soc/codecs/wcd938x.h                    |  720 ++++
 9 files changed, 5365 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
 create mode 100644 sound/soc/codecs/wcd938x-sdw.c
 create mode 100644 sound/soc/codecs/wcd938x.c
 create mode 100644 sound/soc/codecs/wcd938x.h

-- 
2.21.0

