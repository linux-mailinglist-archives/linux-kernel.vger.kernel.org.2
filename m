Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B7333D240
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbhCPK6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236966AbhCPK6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:58:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2EAC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 03:58:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l12so10212015wry.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 03:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=24QvwXRXNZBG8P5bI9Ru0zkrD3yT3FL6QtFP4Z/IiLg=;
        b=bLShwwE2NNGgKecTuPnOEQwa/JauHpEAfqfy2ZM1Qkjybrhf7KA6DZ1eciByTBzc34
         uXddZ2OaEUUJfFfQowlOBZ8yju2NoronQ6HbS0zQFcFfrpsx+Qo/yLFH6ilPTxvXuOD6
         I/iCo8CdZpsPr+pdTPIT77rmC72aZCg3WlCTLAfZN+z9mA350isfWQe3imjRjP3+p4We
         4FBk6ucOLUKHAdZyeVh8N2+TEp298+MJrMRQ2t4sgUnAbgqtA1Jt3/ts+eeQblhc2mDK
         7SmPEbZKdYv0XO22UNG+PKwS3MmYPG9DfmOP+Ilv0x3mrDJ+yvdp4Gulv3DZW4izpBm4
         zcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=24QvwXRXNZBG8P5bI9Ru0zkrD3yT3FL6QtFP4Z/IiLg=;
        b=F1e38kiH5J0i0GvxZnxG8YOsr5/Qv5bkWzJ0Jp4h6s7Jv6KE4leL0QoSCLdoWafDW3
         WJMmp19v774Go8atE98nzF+JBmod2Mqv2UjI6ghqqTAsXGjkU4BgLhcqGOs4s5O7rfbP
         uhtCsh1/VTTTsusWR4W0YyHaolxv5hSQZ3uPgQkGHYBYwtfQSV1L10q4ZtugNeY4iDRZ
         fXJNvD31qqJX4mn0MSuC/gzxGVt5iaUK9+tHxCwofvtz8vgFrpZ6qeSsU23Gi8u7FJqk
         cXqRZe2XvQrm9IGQTPigGffFn+fNg8Yl5ZrN+b6dmS6+rwmJFh7Stwrqz+DzrbU8buHQ
         FT7g==
X-Gm-Message-State: AOAM532dbDjwdAKYq4RkwRtekDpAu8Ljwmk4igYXLKPbIANepRoqyI60
        pUUi6J4VOfx8ZY24mqzpSD+XdQ==
X-Google-Smtp-Source: ABdhPJxm0K26B9PRpTF/GyU9+eLdOkYWg6nG0DU3mf7ffrr63yrtk8DEOp/feUcRNxXbo7S4Ki2ZtQ==
X-Received: by 2002:a05:6000:10c5:: with SMTP id b5mr4148284wrx.347.1615892316414;
        Tue, 16 Mar 2021 03:58:36 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id t8sm21465956wrr.10.2021.03.16.03.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 03:58:35 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/7] ASoC: codecs: add wcd938x support
Date:   Tue, 16 Mar 2021 10:58:21 +0000
Message-Id: <20210316105828.16436-1-srinivas.kandagatla@linaro.org>
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

Many thanks for reviewing v1.

Changes since v1:
	- updated PA gain to a proper TLV control
	- move various if else checks to switch case.
	- return error on check failure rather than fallback to default
	- cleaned up micbias pull up control
	- fixed all the gain tlvs correctly
	- update dt-bindings to use microvolt for button thresholds
	- removed unnecessary debug at various places.

Srinivas Kandagatla (7):
  ASoC: dt-bindings: wcd938x: add bindings for wcd938x
  ASoC: codecs: wcd-clsh: add new version support
  ASoC: codecs: wcd938x: add basic driver
  ASoC: codecs: wcd938x: add basic controls
  ASoC: codecs: wcd938x: add playback dapm widgets
  ASoC: codecs: wcd938x: add capture dapm widgets
  ASoC: codecs: wcd938x: add audio routing

 .../bindings/sound/qcom,wcd938x.yaml          |  127 +
 sound/soc/codecs/Kconfig                      |    9 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wcd-clsh-v2.c                |  350 +-
 sound/soc/codecs/wcd-clsh-v2.h                |   16 +
 sound/soc/codecs/wcd938x-sdw.c                |  291 ++
 sound/soc/codecs/wcd938x.c                    | 3623 +++++++++++++++++
 sound/soc/codecs/wcd938x.h                    |  676 +++
 8 files changed, 5084 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
 create mode 100644 sound/soc/codecs/wcd938x-sdw.c
 create mode 100644 sound/soc/codecs/wcd938x.c
 create mode 100644 sound/soc/codecs/wcd938x.h

-- 
2.21.0

