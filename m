Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F11380742
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 12:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhENKfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 06:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhENKfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 06:35:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676BFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:34:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so1201911wmk.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cxFsMw/ASck33U7Mqk3LoU2yKCnAFtEobb/NZjQDAzg=;
        b=HCH05kXusEupK+2z01YypSWqf1XAM3/UEcHjRE30Rtf9PGVfhguIgLfaHK2R9z3gte
         Bjkpgp4fbKH6FPZp8glUZk5npkxGdPyNBoPBnl0h+spYsdjOYSDS8wny9edEG2zTPkZm
         Jeev3GRTV21oJ8PHJOmh4G1Ejoqv74sGgH2o8432uSGBXy2LN72lnM1PZyhI+0wFhVrI
         NhNSPxK478e70u5q0zLwJQr/yckz9E7xNe9fC4j0cmybJuF9k4nqoLRbgtdM7mtz3dFe
         rL9MU4BTu3j4uBxoJ+lBDSLu7IoDOzJXtYFZo8t4A0eec1+kk4XOCkfV4gcGT+FDa/sF
         BYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cxFsMw/ASck33U7Mqk3LoU2yKCnAFtEobb/NZjQDAzg=;
        b=jeoBpdlwoM24VM6zos4Ywa604EOnwz6PJ1VVx3bTBKZ6VdRPtgdTttMOx2rlrKr6UM
         2l8lDc238TRSICzqxBfScivASHkVf5gzdkbd53CnKxkYlhHO/4S4As98n+EvBaZcTURm
         uAuqvdMw/c8vdR/F1iC+ldscDJrg6zIABhFtY46OpQmrdJTdnzupp6ZjFUsRi5u1BCcN
         y5p4l7HSiCgRigFq39Cwznb5fNcLKdUGG+HPi+Is7JIr0NBkslyJw9HL3zwOpt7TSEN2
         EsPmAfnk7rRQZ/BIkN9ZRVOodkqhSw6ETQ1ePjdXShkni3v9aUt5fupmrCslwfXS6D6j
         EK8w==
X-Gm-Message-State: AOAM533J6UP/2yV15ERbJyLEbMrFqF6DOdhk6UMBh6splaAAaXUoMomZ
        lyICDkwuTV88IiwVZlHYVfe6Fg==
X-Google-Smtp-Source: ABdhPJw3PZi7Kk90pacZhiEh2rY6D9unoLQP2qXm9HOpxu03dxLTtfCVZt956NwC36DOpUCB1R1Dvw==
X-Received: by 2002:a05:600c:4150:: with SMTP id h16mr9081252wmm.45.1620988469093;
        Fri, 14 May 2021 03:34:29 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id k16sm5015498wmi.44.2021.05.14.03.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 03:34:28 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 0/9] ASoC: codecs: add wcd938x support
Date:   Fri, 14 May 2021 11:33:56 +0100
Message-Id: <20210514103405.29927-1-srinivas.kandagatla@linaro.org>
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

Changes since v4:
	- updated dt-bindings and example as suggested by RobH
	- moved SoundWire specific functions to sdw driver.
	- fixed wrong indentation reported by kernel test robot

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
 .../bindings/sound/qcom,wcd938x.yaml          |  149 +
 sound/soc/codecs/Kconfig                      |   13 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/wcd-clsh-v2.c                |  348 +-
 sound/soc/codecs/wcd-clsh-v2.h                |   16 +
 sound/soc/codecs/wcd938x-sdw.c                |  298 ++
 sound/soc/codecs/wcd938x.c                    | 3753 +++++++++++++++++
 sound/soc/codecs/wcd938x.h                    |  705 ++++
 9 files changed, 5346 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
 create mode 100644 sound/soc/codecs/wcd938x-sdw.c
 create mode 100644 sound/soc/codecs/wcd938x.c
 create mode 100644 sound/soc/codecs/wcd938x.h

-- 
2.21.0

