Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742AF3780E7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhEJKNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhEJKNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:13:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D969C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:12:14 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b11-20020a7bc24b0000b0290148da0694ffso10816676wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hku4IdX9XsHriOdVJku9o6pIDQa3wzykYMRftLXwsqA=;
        b=OOjlV0QhNCDkbKahaFUChHiKPQ3Mfv9KIuZb0iUPiJHQZ0KzHHgP/3Qia91d0h2nwP
         t2RzZm7GiXLLrJOCRWT18mL6OrsUP3uqCs3M0dYeipPcjgWRJgnziZ8qa72WP43wLKZ5
         SBVrsP4Sd6WWhY6yGk6IdhbsC2fkNFl2HkoGA8m+dW0jWl57k7lYFvIxvRw2RZYLpjnj
         lp2dLaRQzFWCd9D+CdWeArEUHCKRtbvZ1GH8s3Fy9Ql3zhDaRzGtk7HHuQmr7yE9iqBw
         RcWd6dh0DbvJuyVkt7gQSwcTlD+P9kZF521nJWdAPr420mci8gfgcTfJbyvrdMpRr+u1
         rEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hku4IdX9XsHriOdVJku9o6pIDQa3wzykYMRftLXwsqA=;
        b=Bp8d+Mk9ZDc+8gU4QBIQ3UuYpWiosJeZjCRpazSv/ie6apeQVY4Iu0wVC8CBFHSr+M
         Anckut317EbfT9bukjVmbNLS4A+5wvM1bV/QAZWHeVE+JGqtOwk7VUkofCVafG1vT5Zm
         kCzzRP5fRnk+4rXGUhBAnGfycTdYRBn05p8Y1eaku3zjdPJw4T5IyjLkPxvKkd8n547e
         51sHe3f80zienA1c/I7nd2Gjx4GplR4DcCKtgDy2B2ubBlCOUpfSvxZbmQ+WU1oK6gms
         fwdFVw0SVXOh5dOc3mZvUvKUvBuq2hMoF4GuMIeqZs4BiXUfY6yGef7U6TyqcVchXZwh
         +2kA==
X-Gm-Message-State: AOAM530vKuYULruXlrAYuzK5TZZpLYNBeBIPP4H5hoQXgOHj7fkSjX0l
        uu/vtiVMejevbGlIGX0KwCHeJeejL99vEVmI
X-Google-Smtp-Source: ABdhPJwFfk++/wPHzBoH7orUTH/DOUBPwpgy703BNGlvAsYNjUb5Vcg5xdtGGW7VF+KMhuyBY03cHA==
X-Received: by 2002:a1c:6757:: with SMTP id b84mr25395424wmc.58.1620641532999;
        Mon, 10 May 2021 03:12:12 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id b7sm22072109wri.83.2021.05.10.03.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:12:12 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, lee.jones@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] ASoC: codecs: wcd934x: add Headset and button detection support
Date:   Mon, 10 May 2021 11:11:57 +0100
Message-Id: <20210510101201.7281-1-srinivas.kandagatla@linaro.org>
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

This patchset

thanks,
srini


Srinivas Kandagatla (4):
  ASoC: dt-bindings: wcd934x: add bindings for Headset Button detection
  ASoC: codecs: wcd: add multi button Headset detection support
  ASoC: codecs: wcd934x: add mbhc support
  ASoC: qcom: sdm845: add jack support for WCD934x

 .../bindings/sound/qcom,wcd934x.yaml          |   65 +
 include/linux/mfd/wcd934x/registers.h         |   57 +
 sound/soc/codecs/Kconfig                      |    4 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wcd-mbhc-v2.c                | 1463 +++++++++++++++++
 sound/soc/codecs/wcd-mbhc-v2.h                |  340 ++++
 sound/soc/codecs/wcd934x.c                    |  885 +++++++++-
 sound/soc/qcom/sdm845.c                       |    8 +
 8 files changed, 2809 insertions(+), 15 deletions(-)
 create mode 100644 sound/soc/codecs/wcd-mbhc-v2.c
 create mode 100644 sound/soc/codecs/wcd-mbhc-v2.h

-- 
2.21.0

