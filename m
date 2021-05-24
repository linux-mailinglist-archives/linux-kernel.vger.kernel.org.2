Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73A338E2A0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 10:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhEXIuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 04:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbhEXIuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 04:50:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDFEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 01:48:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x7so8048399wrt.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 01:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0Klvg/FSrb8SCc53K65JSRhutNFINCGv3YACvznWOY=;
        b=h8z0eUTGOInpV5Ca67KyakhslJZT0QJQ5BZP6cvAmlwttykRnVKloIXoqpQjQbs+Xr
         poV0N6H//49KgGH9WIx90WwtlI6pP+mqcZq4yYlTvrb5HlnJpa47/EqVnd1YjgaOOctv
         ygr738zsR54dyRezCJsw17zqZ1Du0rSY6lZvCkthefn8t2jOy6nCK6NfKgN3gpndTGNS
         drqzD2bBBfzuPPJHoNQf145KzhEa/IYd4QKf/iJX+TU21LwbHb6utsK9e5+QLJbNaTUR
         X8y2yLeZ/7shLB9rJKGXKU/+2ERN4JFlAnQ8Z/IXcoYEOOU22agfWXSsy0iOjO4xQc0a
         HweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0Klvg/FSrb8SCc53K65JSRhutNFINCGv3YACvznWOY=;
        b=cOjhjwFl+n8zXn+ImMBplY4HveUGQO47feDLF6yUsQTlXgAXmxzbROhVaoob1kieVM
         elkvnFfsK5CJglv7NE8RYtIYFPaA2a4Tqd5N7FekyRoGcqoVCV2Q8gLX/AF7LM2M5EoC
         j5aTH3Rfb9i2z0FY3h+hjrrtaM3b0sXbYY1FDNeZ9k3HjGiB/n2dSVoLva/cyyQF4zHv
         kr6wTIFJnkzHAdQLLOLv4/zc+3G9xMmU9zh/P7lUvP2EwGVy549psDqUihZ9PjyrAUM8
         Ue4fl1kONA8ew9SPJl0HUkYl4JkafkPlDGrKPp7/nj2va0fUvYjlwCeOwACimwc3xA1B
         PbBA==
X-Gm-Message-State: AOAM530ZTLfJSSr1y2nO8YgiSmOS/VyujoXItxVNk5zjEgNFpESgqj/T
        Wf1iIoBMAGZPFF2KE1Gy5twq6g==
X-Google-Smtp-Source: ABdhPJyJ2gcNefbeLfe6t0ysjHd+wh6CTcXC/KA3fGUGoIQTUXLgQAZD7vZaO+Dm42N/DOGJcaqHFw==
X-Received: by 2002:a5d:45c6:: with SMTP id b6mr20964972wrs.333.1621846121134;
        Mon, 24 May 2021 01:48:41 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x206sm4034548wmx.47.2021.05.24.01.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 01:48:40 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v7 0/9] ASoC: codecs: add wcd938x support
Date:   Mon, 24 May 2021 09:48:19 +0100
Message-Id: <20210524084828.12787-1-srinivas.kandagatla@linaro.org>
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

Changes since v6:
- Removed unnecessary maxItems from qcom,tx/rx-device property as suggested by RobH.


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
 sound/soc/codecs/wcd938x-sdw.c                |  298 ++
 sound/soc/codecs/wcd938x.c                    | 3753 +++++++++++++++++
 sound/soc/codecs/wcd938x.h                    |  705 ++++
 9 files changed, 5343 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
 create mode 100644 sound/soc/codecs/wcd938x-sdw.c
 create mode 100644 sound/soc/codecs/wcd938x.c
 create mode 100644 sound/soc/codecs/wcd938x.h

-- 
2.21.0

