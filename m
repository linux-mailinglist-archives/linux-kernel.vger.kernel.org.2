Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA90313565
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhBHOko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbhBHOSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:18:06 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C575EC061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 06:17:25 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m13so17267702wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 06:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ya8iJWuhg4IhqG6QI2i041j1f43lZLHUVVMkqQ5O0KQ=;
        b=Q21a4A0/XdtqSgXZ6h+kviUME6/e8+StmW7CHx99+//fC/usypKybHrD1awOqfsLuD
         PLqL1PUwPlKMeYKMN2CJblvOvKZvy78zGYOsEdUBvv/wjJrWPwfJY0G2Tqt/mcqPvzdi
         KeK77CbJ81MzM3tRe4fSS5Fx0uA0yL8f4MG2jQn9TQmf1xGt1nPz6juo84ZiY7yDk+oj
         8s++8S2R6EvZiBTCyxDqcwpLh4HoUjeyoOTi/uAkHlxQjQ6uX26nk6GYwclnkDwPyXvD
         aLH4/Hy3XOBzKBXAioD0N5nufbFw0SJ1UKoArkmmSTkNaCZp6s+kIQqwrZZKbP0G/Vjl
         JD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ya8iJWuhg4IhqG6QI2i041j1f43lZLHUVVMkqQ5O0KQ=;
        b=M8JZVPfPcJebP6IGYk4IPyl8mwqMCQtXFezRIl8hMM+IxZYbymEtsw3xNeWCcKcrQ2
         FXbPQnLV8B0ADj+7c/gWL/MujzO8nyPLs7KdD5eC5VdDAucOaT0gL5eokBwA3QXxNzII
         2kaOet/POBZ2rkd/2GpWA8bHAuP5THCfxHJpxnGoDk/l7G5Rvg/EMUJjPQ8OUmji08r6
         C8J/aM5RauUlWTSCzlJ7lIXw5k6iR5KwLB7HcpKw5f35SK5g1PRuh+R/7F3xj5m8JekS
         /ahYRDO4WTDXHOdde/yzSTWDvix8bQjSKQys7xZKIsjLKN3IvauwDxrc8Cx6EyO6r7xX
         qeTQ==
X-Gm-Message-State: AOAM532nSoZPB/jEZCAOlbQ/tFx9DHYys+PM3UhKDL1cbXJz716wthGQ
        BrETGQjg9HSTdGgGq8PiUzcJQQ==
X-Google-Smtp-Source: ABdhPJxqx+9nN9QwBotSTPZO9uUFtL1+shrog/5niiblYSqSWVqoYihHnSsakt+j55niquCXx0diug==
X-Received: by 2002:adf:de86:: with SMTP id w6mr12633459wrl.32.1612793843544;
        Mon, 08 Feb 2021 06:17:23 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id t18sm27949809wrr.56.2021.02.08.06.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 06:17:22 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/7] ASoC: codecs: add support for LPASS Codec TX and RX macros
Date:   Mon,  8 Feb 2021 14:17:12 +0000
Message-Id: <20210208141719.23305-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing v1, here is v2 patchset addressing comments from v1.

This patchset adds support for two Codec Macro blocks(TX and RX) available in
Qualcomm LPASS (Low Power Audio SubSystem).

There are WSA, VA, TX and RX Macros on LPASS IP, each of the Macro block
has specific connectivity like WSA Macros are intended to connect
to WSA Smart speaker codecs via SoundWire. VA Macro is intended for DMICs,
and TX/RX for Analog codecs via SoundWire like other WCD938x Codecs to provide
headphone/ear/lineout/amic/dmic etc ..

Most of the work is derived from downstream Qualcomm kernels.
Credits to various Qualcomm authors from Patrick Lai's team who have
contributed to this code.

This patchset has been tested on support to SM8250 MTP Development Board.
This board has 2 WSA881X smart speakers with onboard DMIC connected to
internal LPASS codec via WSA  and VA macros respectively and WCD938x
TX and RX connected via Soundwire via TX and RX Macros reseptively.

Thanks,
srini

Changes since v1
	- make copyright header line with C++ one
	- correct usage of regcache!
	- moved ON/OFF enums to proper switch controls
	- Align all the control naming!
	- inline swrm_clock function.

Srinivas Kandagatla (7):
  ASoC: qcom: dt-bindings: add bindings for lpass rx macro codec
  ASoC: codec: lpass-rx-macro: add support for lpass rx macro
  ASoC: codec: lpass-rx-macro: add dapm widgets and route
  ASoC: codec: lpass-rx-macro: add iir widgets
  ASoC: qcom: dt-bindings: add bindings for lpass tx macro codec
  ASoC: codec: lpass-tx-macro: add support for lpass tx macro
  ASoC: codec: lpass-tx-macro: add dapm widgets and route

 .../bindings/sound/qcom,lpass-rx-macro.yaml   |   62 +
 .../bindings/sound/qcom,lpass-tx-macro.yaml   |   67 +
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/lpass-rx-macro.c             | 3604 +++++++++++++++++
 sound/soc/codecs/lpass-tx-macro.c             | 1877 +++++++++
 6 files changed, 5624 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
 create mode 100644 sound/soc/codecs/lpass-rx-macro.c
 create mode 100644 sound/soc/codecs/lpass-tx-macro.c

-- 
2.21.0

