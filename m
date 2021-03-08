Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7177330F60
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhCHNfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:35:39 -0500
Received: from inva020.nxp.com ([92.121.34.13]:34904 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhCHNfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:35:34 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 15F401A0BBF;
        Mon,  8 Mar 2021 14:35:33 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 75F1E1A0BB7;
        Mon,  8 Mar 2021 14:35:26 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C25084024E;
        Mon,  8 Mar 2021 14:35:17 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 0/6] Add audio driver base on rpmsg on i.MX platform
Date:   Mon,  8 Mar 2021 21:22:24 +0800
Message-Id: <1615209750-2357-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Asymmetric multiprocessor, there is Cortex-A core and Cortex-M core,
Linux is running on A core, RTOS is running on M core.
The audio hardware device can be controlled by Cortex-M device,
So audio playback/capture can be handled by M core.

Rpmsg is the interface for sending and receiving msg to and from M
core, that we can create a virtual sound on Cortex-A core side.

A core will tell the Cortex-M core sound format/rate/channel,
where is the data buffer, what is the period size, when to start,
when to stop and when suspend or resume happen, each of this behavior
there is defined rpmsg command.

Especially we designed the low power audio case, that is to
allocate a large buffer and fill the data, then Cortex-A core can go
to sleep mode, Cortex-M core continue to play the sound, when the
buffer is consumed, Cortex-M core will trigger the Cortex-A core to
wakeup to fill data.

changes in v4:
- remove the sound card node, merge the property to cpu dai node
  according to Rob's comments.
- sound card device will be registered by cpu dai driver.
- Fix do_div issue reported by kernel test robot

changes in v3:
- add local refcount for clk enablement in hw_params()
- update the document according Rob's comments

changes in v2:
- update codes and comments according to Mark's comments

Shengjiu Wang (6):
  ASoC: soc-component: Add snd_soc_pcm_component_ack
  ASoC: fsl_rpmsg: Add CPU DAI driver for audio base on rpmsg
  ASoC: dt-bindings: fsl_rpmsg: Add binding doc for rpmsg cpu dai driver
  ASoC: imx-audio-rpmsg: Add rpmsg_driver for audio channel
  ASoC: imx-pcm-rpmsg: Add platform driver for audio base on rpmsg
  ASoC: imx-rpmsg: Add machine driver for audio base on rpmsg

 .../devicetree/bindings/sound/fsl,rpmsg.yaml  | 118 +++
 include/sound/soc-component.h                 |   3 +
 sound/soc/fsl/Kconfig                         |  28 +
 sound/soc/fsl/Makefile                        |   6 +
 sound/soc/fsl/fsl_rpmsg.c                     | 283 ++++++
 sound/soc/fsl/fsl_rpmsg.h                     |  42 +
 sound/soc/fsl/imx-audio-rpmsg.c               | 151 +++
 sound/soc/fsl/imx-pcm-rpmsg.c                 | 919 ++++++++++++++++++
 sound/soc/fsl/imx-pcm-rpmsg.h                 | 512 ++++++++++
 sound/soc/fsl/imx-rpmsg.c                     | 127 +++
 sound/soc/soc-component.c                     |  14 +
 sound/soc/soc-pcm.c                           |   2 +
 12 files changed, 2205 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
 create mode 100644 sound/soc/fsl/fsl_rpmsg.c
 create mode 100644 sound/soc/fsl/fsl_rpmsg.h
 create mode 100644 sound/soc/fsl/imx-audio-rpmsg.c
 create mode 100644 sound/soc/fsl/imx-pcm-rpmsg.c
 create mode 100644 sound/soc/fsl/imx-pcm-rpmsg.h
 create mode 100644 sound/soc/fsl/imx-rpmsg.c

-- 
2.27.0

