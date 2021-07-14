Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20433C877B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239637AbhGNPds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239607AbhGNPdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:33:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863B5C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:30:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k4so3715446wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uOmwEo5oUejr01qAQWMT2LxoWt7+2pJPvIbe1Gy7yOc=;
        b=iz3m3LhPwfhlqRbvBVl+FtHrRkQrfCOvyd/ITsmXwpyBTnkYtvjZ1bUHrsOXBwPKPx
         jvkmAHUwJy7nBtsvi3ZNu6cyFwHLukv0rHvRw/NOK4H/UJtCTJeRwGOFYi/f/MSeYzB0
         XUTYZ5/ww0P+VQ0ETiSiDnb3BLdNxBZ+WZuWYYaNnXLm3n5ixOOBHpmEU1vi6My/kY0W
         yrMVhoN2GIHBRd0C6mUFBTxsVmV/mV/MlvZbHed8xpWan9V7JrpvahZOS4qQHPelPqlv
         6RlfXIaTy8JZNaJtkHoqoIulHijJbJGr5x/h57DIyWj6JXnE1M2Z7JsucHw7r/0ITxF1
         1YdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uOmwEo5oUejr01qAQWMT2LxoWt7+2pJPvIbe1Gy7yOc=;
        b=TEXEYJ5oZKo1QGusCUDHwR1addyW/MjijgPWQGzez0WNZakrZZ7yGW2dO7OJGZqStw
         je+9e+ghWRIfODKW5oVZL1/IEnDjSHUmfla2hIzkMgQuAReDJVQOZYHZ3CXwDAC1aQEd
         qUhqneeLaI8UM4w5R2Z/oJK3BSX2cVTysJgSIug4LqOP9xlsi88kjSpxuRZpA2w6ESRI
         s5nySiTQzPVTzK4qJHAZeJxKKFfRyY3N5yQpLUara/EuIjXc1vQ4BETfD1P746AD0EAV
         hYwI390VgetuBrtifL82Yj+JgLp+ADLlpqGRRE9PzFIiTUfmEwL3AKecwrJkeGMbMeY6
         48rQ==
X-Gm-Message-State: AOAM5310TA4di7XSILMeSP3MSHiviAW6f1rp9S5JwcTBasGxGIdNlmtB
        gIufXBOZwsaGMuvNcFjkQfoBJj2JGOabhQ==
X-Google-Smtp-Source: ABdhPJwoazfakKvKUpbSEshE1+1zVuY3kIecRJZhAmC7LiZvjwgBphdFM7WaAEOPCQ/eGIV8qpWgtA==
X-Received: by 2002:a5d:4392:: with SMTP id i18mr13725569wrq.231.1626276654138;
        Wed, 14 Jul 2021 08:30:54 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id y6sm2465174wma.48.2021.07.14.08.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:30:53 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
Cc:     plai@codeaurora.org, tiwai@suse.de, devicetree@vger.kernel.org,
        perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 00/16] ASoC: qcom: Add AudioReach support
Date:   Wed, 14 Jul 2021 16:30:23 +0100
Message-Id: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds ASoC driver support to configure signal processing
framework ("AudioReach") which is integral part of Qualcomm next
generation audio SDK and will be deployed on upcoming Qualcomm chipsets.
It makes use of ASoC Topology to load graphs on to the DSP which is then
managed by APM (Audio Processing Manager) service to prepare/start/stop.

Here is simpified high-level block diagram of AudioReach:

 ___________________________________________________________
|                 CPU (Application Processor)               |
|  +---------+          +---------+         +---------+     |
|  |  q6apm  |          |  q6apm  |         | q6afe   |     |
|  |   dais  | <------> |         | <-----> | bedais  |     |
|  +---------+          +---------+         +---------+     |
|                            ^  ^                           |
|                            |  |           +---------+     |
|  +---------+               v  +---------->|topology |     |
|  | q6prm   |          +---------+         |         |     |
|  |         |<-------->|   GPR   |         +---------+     |
|  +---------+          +---------+                         |
|                            ^                              |
|____________________________|______________________________|
                             |  
                             | RPMSG (IPC over GLINK)              
 ____________________________|______________________________
|                            |                              |
|    +-----------------------+                              |
|    |                       |                              |
|    v                       v              q6 (Audio DSP)  |
|+-----+    +----------------------------------+            |
|| PRM |    | APM (Audio Processing Manager)   |            |
|+-----+    |  . Graph Management              |            |  
|           |  . Command Handing               |            |  
|           |  . Event Management              |            |  
|           |  ...                             |            |  
|           +----------------------------------+            |  
|                            ^                              |
|____________________________|______________________________|
                             |  
                             |   LPASS AIF
 ____________________________|______________________________
|                            |            Audio I/O         |
|                            v                              |
|   +--------------------------------------------------+    |
|    |                Audio devices                     |   |
|    | CODEC | HDMI-TX | PCM  | SLIMBUS | I2S |MI2S |...|   |
|    |                                                  |   |
|    +--------------------------------------------------+   |
|___________________________________________________________|

AudioReach has constructs of sub-graph, container and modules.
Each sub-graph can have N containers and each Container can have N Modules
and connections between them can be linear or non-linear.
An audio function can be realized with one or many connected
sub-graphs. There are also control/event paths between modules that can
be wired up while building graph to achieve various control mechanism
between modules. These concepts of Sub-Graph, Containers and Modules
are represented in ASoC topology.

Here is simple I2S graph with a Write Shared Memory and a
Volume control module within a single Subgraph (1) with one Container (1)
and 5 modules.

  ____________________________________________________________
 |                        Sub-Graph [1]                       |
 |  _______________________________________________________   |
 | |                       Container [1]                   |  |
 | | [WR_SH] -> [PCM DEC] -> [PCM CONV] -> [VOL]-> [I2S-EP]|  |
 | |_______________________________________________________|  |
 |____________________________________________________________|

For now this graph is split into two subgraphs to achieve dpcm like below:
 ________________________________________________    _________________
|                Sub-Graph [1]                   |  |  Sub-Graph [2]  |
|  ____________________________________________  |  |  _____________  |
| |              Container [1]                 | |  | |Container [2]| |
| | [WR_SH] -> [PCM DEC] -> [PCM CONV] -> [VOL]| |  | |   [I2S-EP]  | |
| |____________________________________________| |  | |_____________| |
|________________________________________________|  |_________________|

                                                      _________________
                                                    |  Sub-Graph [3]  |
                                                    |  _____________  |
                                                    | |Container [3]| |
                                                    | |  [DMA-EP]   | |
                                                    | |_____________| |
                                                    |_________________|


This patchset adds very minimal support for AudioReach which includes
supporting sub-graphs containing CODEC DMA ports and simple PCM
Decoder/Encoder and Logger Modules. Additional capabilities will
be built over time to expose features offered by AudioReach. 

This patchset is Tested on SM8250 SoC based Qualcomm Robotics Platform RB5
and SM9250 MTP with WSA881X Smart Speaker Amplifiers, DMICs connected via
VA Macro and WCD938x Codec connected via TX and RX Macro.

Sample WIP ASoC graphs are available at 
https://git.linaro.org/people/srinivas.kandagatla/audioreach-topology.git/

Thanks,
srini

Changes since RFC:
	- moved GPR support into APR driver to avoid code duplication.
	- Fixed various dt-bindings-check warnings and errors.
	- Moved include/dt-bindings headers to dt-bindings patch.
	- added PGA widget support
	- Fixed few ordering issues while testing with ASoC Topology 2.0
	- Removed duplicate defines in various headers

Srinivas Kandagatla (16):
  soc: dt-bindings: qcom: add gpr bindings
  soc: qcom: apr: make code more reuseable
  soc: qcom: apr: Add GPR support
  ASoC: qcom: dt-bindings: add bindings Audio Processing manager
  ASoC: qcom: audioreach: add basic pkt alloc support
  ASoC: qcom: audioreach: add q6apm support
  ASoC: qcom: audioreach: add module configuration command helpers
  ASoC: qcom: audioreach: add topology support
  ASoC: qcom: audioreach: add q6apm-dai support
  ASoC: qcom: audioreach: add bedai support
  ASoC: qcom: dt-bindings: add bindings for Proxy Resource Manager
  ASoC: qcom: audioreach: add q6prm support
  ASoC: qcom: dt-bindings: add audioreach soundcard compatibles
  ASoC: qcom: audioreach: add volume ctrl module support
  ASoC: qcom: audioreach: topology add dapm pga support
  ASoC: qcom: sm8250: Add audioreach support

 .../bindings/soc/qcom/qcom,gpr.yaml           |   83 ++
 .../devicetree/bindings/sound/qcom,q6apm.yaml |   87 ++
 .../devicetree/bindings/sound/qcom,q6prm.yaml |   43 +
 .../bindings/sound/qcom,sm8250.yaml           |   43 +
 drivers/soc/qcom/Kconfig                      |    8 +
 drivers/soc/qcom/apr.c                        |  270 +++-
 include/dt-bindings/soc/qcom,gpr.h            |   18 +
 include/dt-bindings/sound/qcom,q6apm.h        |    8 +
 include/linux/soc/qcom/apr.h                  |   69 +-
 include/uapi/sound/snd_ar_tokens.h            |  198 +++
 sound/soc/qcom/Kconfig                        |   19 +
 sound/soc/qcom/Makefile                       |    1 +
 sound/soc/qcom/audioreach/Makefile            |   12 +
 sound/soc/qcom/audioreach/audioreach.c        | 1162 +++++++++++++++++
 sound/soc/qcom/audioreach/audioreach.h        |  676 ++++++++++
 sound/soc/qcom/audioreach/q6apm-bedai.c       |  323 +++++
 sound/soc/qcom/audioreach/q6apm-dai.c         |  494 +++++++
 sound/soc/qcom/audioreach/q6apm.c             |  963 ++++++++++++++
 sound/soc/qcom/audioreach/q6apm.h             |  174 +++
 sound/soc/qcom/audioreach/q6prm.c             |  414 ++++++
 sound/soc/qcom/audioreach/topology.c          | 1075 +++++++++++++++
 sound/soc/qcom/sm8250.c                       |  144 +-
 22 files changed, 6236 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,gpr.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6prm.yaml
 create mode 100644 include/dt-bindings/soc/qcom,gpr.h
 create mode 100644 include/dt-bindings/sound/qcom,q6apm.h
 create mode 100644 include/uapi/sound/snd_ar_tokens.h
 create mode 100644 sound/soc/qcom/audioreach/Makefile
 create mode 100644 sound/soc/qcom/audioreach/audioreach.c
 create mode 100644 sound/soc/qcom/audioreach/audioreach.h
 create mode 100644 sound/soc/qcom/audioreach/q6apm-bedai.c
 create mode 100644 sound/soc/qcom/audioreach/q6apm-dai.c
 create mode 100644 sound/soc/qcom/audioreach/q6apm.c
 create mode 100644 sound/soc/qcom/audioreach/q6apm.h
 create mode 100644 sound/soc/qcom/audioreach/q6prm.c
 create mode 100644 sound/soc/qcom/audioreach/topology.c

-- 
2.21.0

