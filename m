Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5153A0F5D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 11:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbhFIJNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 05:13:15 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:56093 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237923AbhFIJNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 05:13:07 -0400
Received: by mail-wm1-f44.google.com with SMTP id g204so3528612wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 02:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0qa4D2spX1g8yj7RaDUoK2ZQ8yrlEpkE/9jNnX7bJv8=;
        b=RPMbGrQTNf9/hpcQ8pAfoLnXzdUeu9Cvzr5SYmrRvOXTMg2nxNR0w9SY0Mtjih1MYR
         521dJKRT3tmj3U4POI1m6TKDX6KxpmwhJ3U0EbQbqNffKriWuuS4BoQUqxp9saLqnifi
         3OhSrkx0bpKB/GG/fylfKzRR//vyZdPHkXBcGMbditW8UYywUdPwgy7Bx95u4dt7Qs58
         ihSpisFvuRQowRNQvDB158Bezlm8C44vqnFsR6IDi/x87+gXTu25bk8Bgr0jfkkeDTvQ
         gpSkY84jsFFooxjs1Bd626gcIDaFLbJXeoaaNTrL8mjcKWP23iAccN1DI/tYGpiuG1D4
         a1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0qa4D2spX1g8yj7RaDUoK2ZQ8yrlEpkE/9jNnX7bJv8=;
        b=FDNsFDm2zlKTAB7b0v/tJvMa6Rm9Zfwpu2zyZYXC9qdHQcxJepA7ReCyTbOjzuFgUm
         x5k2GlJibG/r04y+Tr5ai/xjW3Qvgxeax9ZUUWc1tE9rXAE2wbEyCfgD3oUZFyTlLdhO
         mIrP85xPzr5VgfiJC5JyyOvWL7iU6gQZJJE0oDWXPuR7jrucevoxJ+AdCrsvHbdFptwO
         YRiz6l38IR4XJSQPz8V4Wzc5zlM4n7UCohZ57ivT2PIhtXVyPLfy+sAcHOHdOoXKt3W1
         z11LAbfG2g7kKIaM+c/JamQG7yM6+d2T/9HTNKFovV2NXgHz0OZp6mw+0T4GbOOOlGRW
         bk0Q==
X-Gm-Message-State: AOAM53164NCQVgGRiQxl7XhD20eMQ/yKIXHxRKs0unHN+K1OxioGLMgV
        U8AjntlgI6GMf7l8ZGY4tb/S6Q==
X-Google-Smtp-Source: ABdhPJxnMhTgiSNU0jqqgT3HWW8u0CAb9KIqI1fqxlM27NQcORb/mbfA939gSZqzPyfVeRIcc6L1vg==
X-Received: by 2002:a05:600c:4e89:: with SMTP id f9mr6571431wmq.140.1623229799177;
        Wed, 09 Jun 2021 02:09:59 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id v18sm25165385wrb.10.2021.06.09.02.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 02:09:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v9 0/9] ASoC: codecs: add wcd938x support
Date:   Wed,  9 Jun 2021 10:09:34 +0100
Message-Id: <20210609090943.7896-1-srinivas.kandagatla@linaro.org>
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

Changes since v8:
 - moved Kconfig and Makefile changes to last patch as suggested by Mark
 - removed array of enums and used static entries instead. Suggested by Mark
 - return true if put succeeds, Suggested by Mark
 - removed some unneeded semi-colons in switch

Srinivas Kandagatla (9):
  ASoC: dt-bindings: wcd938x: add bindings for wcd938x
  ASoC: codecs: wcd-clsh: add new version support
  ASoC: codecs: wcd938x: add basic driver
  ASoC: dt-bindings: wcd938x-sdw: add bindings for wcd938x-sdw
  ASoC: codecs: wcd938x-sdw: add SoundWire driver
  ASoC: codecs: wcd938x: add basic controls
  ASoC: codecs: wcd938x: add playback dapm widgets
  ASoC: codecs: wcd938x: add capture dapm widgets
  ASoC: codecs: wcd938x: add audio routing and Kconfig

 .../bindings/sound/qcom,wcd938x-sdw.yaml      |   70 +
 .../bindings/sound/qcom,wcd938x.yaml          |  146 +
 sound/soc/codecs/Kconfig                      |   14 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/wcd-clsh-v2.c                |  348 +-
 sound/soc/codecs/wcd-clsh-v2.h                |   16 +
 sound/soc/codecs/wcd938x-sdw.c                |  315 ++
 sound/soc/codecs/wcd938x.c                    | 3753 +++++++++++++++++
 sound/soc/codecs/wcd938x.h                    |  720 ++++
 9 files changed, 5376 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
 create mode 100644 sound/soc/codecs/wcd938x-sdw.c
 create mode 100644 sound/soc/codecs/wcd938x.c
 create mode 100644 sound/soc/codecs/wcd938x.h

-- 
2.21.0

