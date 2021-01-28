Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A263077D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhA1OUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhA1OUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:20:36 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F25CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 06:19:55 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v15so5587529wrx.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 06:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x0QMpFOalwPklH2KvBPZK8bo2/fUlpNzY2SPfbp4llw=;
        b=Of6VgqVY59Jivj4WC4gyTCCQ3IptSNXlxtDlSFMJ08D9Dj64wv60fy37px1X9F3TTU
         Cf0oKu/J19OKCvtwyFfgzEWVycD5BuAfmFXbhoS2enZjEeL/0cfI6cS2scFbcArjOaVJ
         wwqhx3JIfjCK1TkQFtZum3TbDhfDSVvT/e1zgRqCYgdXnutw9MiHdmZ3WW4z3Q5SFT7A
         t6K3cwA7+zfop7kE8XO43rq8ZyC7EFCmwJJtfZK/QaP2XvdwC3HG1zkmTtB/9cRPOEXq
         jS9xPWcC7E3qiImaC+ZRGnvAgE6iBod6k3c4lD8p6NJfq8eeYP3sfR90pUJut12WjBo1
         klYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x0QMpFOalwPklH2KvBPZK8bo2/fUlpNzY2SPfbp4llw=;
        b=iOqfBYIp97PEw2xszC4nvL1l66PALzunhgW2XJqlQYEk0mVp83E5a9hlA4JN6oGz+A
         VUlMBRrgHmXhC5bfezv/COGlsfjwVHdUY7ZWmzaNg3wyf5DWUu1qMAEi70YPTjbsTq5X
         Cwn/9eLdxGkk8I+SCTQHDzxrGjzOD8jFOTRucVTOuYoJraCvPS2a9hupHuETRWxQW94q
         4SiSfbVDgmp1f5Jyy7o41CqXwJ7n0kK8UILhEFNhn2SMtWJGZhqsydtw0J4aZC0tEJr6
         ytFp+H/omgDm1x7prHQMEc+7Zpbs4yU7o7KVKKDdXz/il2rkj5QaDcpjKLGhG2MRz5jl
         5WmQ==
X-Gm-Message-State: AOAM533TawM7OFwpZsTFEfBe58elIBy8sG/6CgLMWHRuO77ZZ/PR69CV
        RdFtFbrSdUxDEQDFd4aDZtwOpg==
X-Google-Smtp-Source: ABdhPJyGXoeIBnHZriYgJl2y6msMfQCaVd4EFZ0NkDobRVez/+f0p1PIkYV+rZL9pEjvcmJeqbO9Gg==
X-Received: by 2002:a5d:65ca:: with SMTP id e10mr16805260wrw.166.1611843594318;
        Thu, 28 Jan 2021 06:19:54 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id d9sm7257096wrq.74.2021.01.28.06.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 06:19:53 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/7] ASoC: codecs: add support for LPASS Codec TX and RX macros
Date:   Thu, 28 Jan 2021 14:19:22 +0000
Message-Id: <20210128141929.26573-1-srinivas.kandagatla@linaro.org>
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
 sound/soc/codecs/lpass-rx-macro.c             | 3623 +++++++++++++++++
 sound/soc/codecs/lpass-tx-macro.c             | 1881 +++++++++
 6 files changed, 5647 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
 create mode 100644 sound/soc/codecs/lpass-rx-macro.c
 create mode 100644 sound/soc/codecs/lpass-tx-macro.c

-- 
2.21.0

