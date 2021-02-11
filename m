Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AC1318B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 13:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhBKMp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 07:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhBKM20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 07:28:26 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBABDC061756
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 04:27:45 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v15so3995079wrx.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 04:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcVy2hhO5lDAWG0A6BnQz5rAwn+vZs+FFC39Fm9Ww1o=;
        b=I9mSBvY7RXW4LEA30FsIfm6l9OmFw8BV5mszH1j2qz7Q9xDosqu7Ej5vHgf5/p50LY
         GEKqChEshCwOyOIMrg4kB5WfZToSFT/9FO3fAVqaC3L2+/xhc1dg0u0N1f3X6Gd7THgf
         sNiz/p5X6IECP1oIx2XXnp1kdomULAyTocQw45yq3hrvVqL/fLBAVLMqyECTqYimOi0b
         xHFTJw7Nz2fjXEFs53IkNFyvljL3SvW4lCkBMazNJ0cZQwNGSCUaPFU+OKAjlwN9Zb6O
         QFvHs2D5adRijSqp8PIHki2rGMHyLyWyjQfDuTwLk2+wNAa+joqzE1h+criO1aF3BLR7
         KRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcVy2hhO5lDAWG0A6BnQz5rAwn+vZs+FFC39Fm9Ww1o=;
        b=o9YprFnl1SjWbj/7Lm8WSKfK6+C3oO54cLdTFXZlqc+1WdWVe9OD6/blPuYt9aQ8ir
         0++0Qv4y3Z7a6Eg+HkuRYLJ8RTi/bnW6nimtu3Ygn1l6QZKsejbHV7SVdVPXLx7DW+FN
         R+WrUvpyA+reIc3h2+jwZ/jM8JhEuodmGOFfkjRxFiwP4bSOuRr/LtLL/WWvcZOHadz4
         2G/8ikH9TZkbfilMIpjH8bKTGMKvlsrNoM6Fvsa8ORl6WIgZ55evREsLNnhfVJkio7R1
         XO+2mBBKy920vXhVSa0vMECyo+IoI4oAyeP6cLqVtw49VfOTRRuFK29Afd27N0G5XJ1R
         v0WA==
X-Gm-Message-State: AOAM5320AXIGywOB68QjglSewNh+nDEFMdZ4P23Jb8T9hZuOK9SXpNc+
        8LbQ2S5jZM6XXXl9Tt5MwboZyQ==
X-Google-Smtp-Source: ABdhPJy3KCGT43Q6w5VStd69GdPzuKwYkvZ0X9RuaIbErPiw89BI08DD7DOP6E9w6RMQnRe/8LxXyg==
X-Received: by 2002:a05:6000:1546:: with SMTP id 6mr5447616wry.398.1613046464646;
        Thu, 11 Feb 2021 04:27:44 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id d20sm4026477wrc.12.2021.02.11.04.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 04:27:44 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 0/7] ASoC: codecs: add support for LPASS Codec TX and RX macros
Date:   Thu, 11 Feb 2021 12:27:28 +0000
Message-Id: <20210211122735.5691-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Changes since v4:
	- One more ktest fix for unused-but-set-variable warning 
	 and a fix for W=2 warning and removed unused macros
	- added bindings ack from Rob

Srinivas Kandagatla (7):
  ASoC: qcom: dt-bindings: add bindings for lpass rx macro codec
  ASoC: codecs: lpass-rx-macro: add support for lpass rx macro
  ASoC: codecs: lpass-rx-macro: add dapm widgets and route
  ASoC: codecs: lpass-rx-macro: add iir widgets
  ASoC: qcom: dt-bindings: add bindings for lpass tx macro codec
  ASoC: codecs: lpass-tx-macro: add support for lpass tx macro
  ASoC: codecs: lpass-tx-macro: add dapm widgets and route

 .../bindings/sound/qcom,lpass-rx-macro.yaml   |   62 +
 .../bindings/sound/qcom,lpass-tx-macro.yaml   |   67 +
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/lpass-rx-macro.c             | 3599 +++++++++++++++++
 sound/soc/codecs/lpass-tx-macro.c             | 1862 +++++++++
 6 files changed, 5604 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
 create mode 100644 sound/soc/codecs/lpass-rx-macro.c
 create mode 100644 sound/soc/codecs/lpass-tx-macro.c

-- 
2.21.0

