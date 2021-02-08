Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4993A313F3A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbhBHTiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbhBHSDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:03:34 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20197C061797
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 10:01:55 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q7so18239453wre.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 10:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=15qU8cK0fgAua4gEd/w/zhOHPh1Gn9liZ7KcNZSIbsw=;
        b=ZtQCs63tKC4YNjAK5YtSkl6sRGMzqMgDk9JBWfHaip5ck0jSZBxtvpIAaRPwa/4Io+
         k4klxIU6HWNuAA8dl5xtXzodHH2zZc8AQ1ya6+D+UEWTgJ1zFvzsn0md+EIMZ2rO/bkC
         Eb7Ec+eDvh3Kz15Q8ihsCelhajfqZzJhsaf1coknsthLTdni8EkTINxV5UQMpmoOuycS
         Ap7BuWa6I/xJ1UrEe55XzHpbhp8AApMKsC6y05LrOwdVM6An8kCcJbIp00GVWf7tGqja
         8o3faYsFFgVANYKB+UOdAZC54tVQWlUWy0yOZ0PHmetW5fcrfPF7sLKZZ+jpEZLaWa/k
         lwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=15qU8cK0fgAua4gEd/w/zhOHPh1Gn9liZ7KcNZSIbsw=;
        b=td9Y5TKGAFPQrQfW1RAc/rPIlSzcn+6vV4Ii/NTf4r0nBZHmVkA3RCJuoCmQu3nJdB
         wIN0OUJNDwpC8pfafpU4LecnTvwadYR/JMEp6sAwDZ0eDbu/VFj2jF80bBdKAuoo906L
         T8d3qVUQrZjjT77j6PPagJd3Cl8uWlVpmkPzTbdp93wRhRZRsfH4CRqJEI5pTwJAt0cx
         EPMA5BI9NPfwM5o5g02iHkxPvDUerqOwlUCD643ALGvExwndbi+HR2/5E/WH4n7wygOC
         DtqwOQW+gPGyL4UlhD17wKFPLHWezOBGJZ+C/mffRBP8YD2egvMQApz5d1NqMuDLfUP8
         NzWg==
X-Gm-Message-State: AOAM5330drB4/+Z0RINjQSyHG07WTDet5DBJrN39bKvXqxfmiQx5HEk9
        TZwpAB2JL8wUqxPh7mX/1DU0SA==
X-Google-Smtp-Source: ABdhPJwrqGjJeWdA+BLfOl3RPdiRzmOJ7nilmxlHvJ0QS3yn9XOx2bYatc29bZoEoaYUpqBYS3z34w==
X-Received: by 2002:adf:bb54:: with SMTP id x20mr13257775wrg.112.1612807313722;
        Mon, 08 Feb 2021 10:01:53 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id l2sm21194937wmq.17.2021.02.08.10.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 10:01:53 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/7] ASoC: codecs: add support for LPASS Codec TX and RX macros
Date:   Mon,  8 Feb 2021 18:01:02 +0000
Message-Id: <20210208180109.518-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing v2, here is v3 patchset addressing comments from v2.

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

Changes since v2:
	- Suffix some of the simple on/off control names with "Switch"

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
 sound/soc/codecs/lpass-rx-macro.c             | 3604 +++++++++++++++++
 sound/soc/codecs/lpass-tx-macro.c             | 1877 +++++++++
 6 files changed, 5624 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
 create mode 100644 sound/soc/codecs/lpass-rx-macro.c
 create mode 100644 sound/soc/codecs/lpass-tx-macro.c

-- 
2.21.0

