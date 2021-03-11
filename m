Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C6B337AF1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhCKRfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhCKRfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:35:01 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3562C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:35:00 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a18so2948455wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=66tTTfF5r6oUktX13OauExH1HuAm+OFPdK/+vXqQOQY=;
        b=zkwOxIEa6c8D5QbUHxY1j0HRCVQu5oihUH8Z5p4P9vA5q/nURFNx/VXJBhk+jMxhrB
         BnUB1j7sErY/oomCD9yoDNRxxAHWiMeAep5pOmErv+VLZ16gyxDaO2gK98wsVprHY5p/
         R6Cjo/07TSvdQxmVTu+1AQ+cvYcgC2JxwQ/iPb3aOQACTGk+fQytpBTobXrqimNUspVn
         G9XXgiwJIb+rS17XoYnRO1wgTvY/ITX30t+HBsVix+4P9d1TyiZ/sX20sFa7qmi+r5dM
         WXNUtHW5bekn+SpbokTeb6oWkGevg8pxzcqYqYI3EcVAzRDjiUL8C4Ku19bo6/3tfZTX
         kuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=66tTTfF5r6oUktX13OauExH1HuAm+OFPdK/+vXqQOQY=;
        b=dQKkL9f7TvoVmOlDmLW5pYJP2cS3jo+vZKajr5CNZQj/H3uQRFJDbx4sAYkF3/6RSo
         IEf952hC5vPFDId6EJMnpZ2jUWoQN9cIgkCv89sYxQYzhhkoGqpM8cZpARzghZ2AJ4zr
         pBun1Al/1mosVm0CB8uPYq3KqqQLUKyJQkNCDq6DLQGNYAg2tUCAAhtmAO6FqSzqF7h3
         Aw498wXcOI3Q+ZeoTYCbezCXpjf3Z4e7IkDkvkV1NqUXtFGYs0KyTVi8e4KTRM5HnoNR
         l1wsi9a0qWElAjqZmWcFByY7bQpXZC5ksCzBvyDvoT9dAQy7lIwbN6bnW51IGGrb9Xvh
         2GVw==
X-Gm-Message-State: AOAM531VEiCF4LtlwgTZEunM+lbkScSVvApvLJIWpUh4O1tAluHlKpHx
        ywL4BSmMd+O1Ud+zIThDXy0Eng==
X-Google-Smtp-Source: ABdhPJwcthG3QwbLdp+pL70hoWTIadW9sUoXZnpm6KSu0v13JgxV+GMEkj8ootJFcGASY5/YXirevw==
X-Received: by 2002:adf:fa41:: with SMTP id y1mr9713611wrr.256.1615484099379;
        Thu, 11 Mar 2021 09:34:59 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id 36sm5221152wrh.94.2021.03.11.09.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:34:58 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/7] ASoC: codecs: add wcd938x support
Date:   Thu, 11 Mar 2021 17:34:09 +0000
Message-Id: <20210311173416.25219-1-srinivas.kandagatla@linaro.org>
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
 sound/soc/codecs/wcd938x-sdw.c                |  294 ++
 sound/soc/codecs/wcd938x.c                    | 3688 +++++++++++++++++
 sound/soc/codecs/wcd938x.h                    |  675 +++
 8 files changed, 5151 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
 create mode 100644 sound/soc/codecs/wcd938x-sdw.c
 create mode 100644 sound/soc/codecs/wcd938x.c
 create mode 100644 sound/soc/codecs/wcd938x.h

-- 
2.21.0

