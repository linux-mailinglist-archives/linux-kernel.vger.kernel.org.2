Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6C8449AE2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 18:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240815AbhKHRlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 12:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238664AbhKHRlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 12:41:20 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AFDC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 09:38:35 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id q33-20020a056830442100b0055abeab1e9aso26727781otv.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 09:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lxm3jAYijsSsedMOXvI3eMNQNTFEfHshbgKBd3LRS8Y=;
        b=c0W1msibqQs94O7yl8/OGoVUALRP6xTAjXN4YyUZ3X/g1s43H4McMNJ0NGkjGpcMgR
         /G75qm0NW0kEEZ5ZtyFpBnBSAnMhb4AjWsTUDD9GO4EVTBJdpSutwLVs4sBw6G00wnlg
         1tiejQAIa7Enljngr6V1K0VZwFYF5PrTDIpy/26r9szuEbN8av7NvLvrGvWXZlTo1YMp
         SA77fqvOceGf4rSJN/tolFgxD5Uo1xhSBd1UB958AU/OG2Y+NULSdfFHULXH/CjMN0F0
         gUN+pRRLCVMW1BGvv1w+/HeOUvI9Ek9jadpPw1wTh2KN0ezQe+W6+0CsbNcRquZB038c
         0IxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lxm3jAYijsSsedMOXvI3eMNQNTFEfHshbgKBd3LRS8Y=;
        b=wzZ+GEzgnVJxW09bhRZO914ec14+AqWMZlKXSm84fUx+9sCVeS+0MDwl2bCsQvlKNQ
         1RZVlmmnGEQg+VAvXBrIH8c7xqarSG/GfjfuIGQMk3LZvGWc+DRv6przzxzEiFN38b/y
         fFtmuJDv7zJH6dJViAV4Y+DjMhxj2lXydveAEw3sa+R1MFH7N1U13aVbm+tVWTDbn0Vb
         hnmCdsYPVhKjU+tBzeozTzrclMaspDPxs1GBZT43q0e+azyAmuNTYaY2Mqkj2z/dWXf6
         Bj7hNMkG8seFn077Vqlo1+B7I0NFg19v86/piSg3vKOaeGqh0iGJUp25U90mWwyTJnv3
         BLWQ==
X-Gm-Message-State: AOAM532ft5zLSc1cgSSKjn0YvnmfFzqFsN1z5vladeVEQYhcjFm+y23h
        c7p5fSJ/noaRaiVkU5xE0YsjGg==
X-Google-Smtp-Source: ABdhPJwv+UYovloxLa6QwRS74MiCHV41LFecv0FfkVg4jOVy9Y/kJ19a/Add01pGEFuFYq5q3yo2XQ==
X-Received: by 2002:a05:6830:2053:: with SMTP id f19mr554691otp.295.1636393114966;
        Mon, 08 Nov 2021 09:38:34 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q15sm6468950otk.81.2021.11.08.09.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 09:38:34 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sinthu Raja <sinthu.raja@ti.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Deepak Kumar Singh <deesin@codeaurora.org>,
        Peng Fan <peng.fan@nxp.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        zhaoxiao <long870912@gmail.com>
Subject: [GIT PULL] remoteproc updates for v5.16
Date:   Mon,  8 Nov 2021 11:38:30 -0600
Message-Id: <20211108173830.2478246-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v5.16

for you to fetch changes up to 9955548919c47a6987b40d90a30fd56bbc043e7b:

  remoteproc: Remove vdev_to_rvdev and vdev_to_rproc from remoteproc API (2021-10-15 09:49:55 -0500)

----------------------------------------------------------------
remoteproc updates for v5.16

The remoteproc repo is moved to a new path on git.kernel.org, to allow
Mathieu push access to the branches.

Support for the Mediatek MT8195 SCP was added, the related DeviceTree
binding was converted to YAML and MT8192 SCP was documented as well.

Amlogic Meson6, Meson8, Meson8b and Meson8m2 has an ARC core to aid in
resuming the system after suspend, a new remoteproc driver for booting
this core is introduced.

A new driver to support the DSP processor found on NXP i.MX8QM,
i.MX8QXP, i.MX8MP and i.MX8ULP is added.

The Qualcomm modem and TrustZone based remoteproc drivers gains support
for the modem in SC7280 and MSM8996 gains support for a missing
power-domain.

Throughout the Qualcomm drivers, the support for informing the always-on
power coprocessor about the state of each remoteproc is reworked to
avoid complications related to our use of genpd and the system suspend
state.

Lastly a number of small fixes are found throughout the drivers and
framework.

----------------------------------------------------------------
Arnaud Pouliquen (2):
      rpmsg: char: Remove useless include
      remoteproc: Remove vdev_to_rvdev and vdev_to_rproc from remoteproc API

Arnd Bergmann (1):
      remoteproc: imx_dsp_rproc: mark PM functions as __maybe_unused

Bjorn Andersson (1):
      MAINTAINERS: Update remoteproc repo url

Christophe JAILLET (1):
      remoteproc: Fix a memory leak in an error handling path in 'rproc_handle_vdev()'

Colin Ian King (1):
      remoteproc: Fix spelling mistake "atleast" -> "at least"

Dan Carpenter (1):
      remoteproc: meson-mx-ao-arc: fix a bit test

Deepak Kumar Singh (1):
      soc: qcom: aoss: Expose send for generic usecase

Dong Aisheng (5):
      remoteproc: Fix the wrong default value of is_iomem
      remoteproc: imx_rproc: Fix TCM io memory type
      remoteproc: imx_rproc: Fix ignoring mapping vdev regions
      remoteproc: imx_rproc: Fix rsc-table name
      remoteproc: imx_rproc: Change to ioremap_wc for dram

Martin Blumenstingl (2):
      dt-bindings: remoteproc: Add the documentation for Meson AO ARC rproc
      remoteproc: meson-mx-ao-arc: Add a driver for the AO ARC remote procesor

Peng Fan (1):
      remoteproc: elf_loader: Fix loading segment when is_iomem true

Shengjiu Wang (5):
      remoteproc: imx_rproc: Move common structure to header file
      remoteproc: imx_rproc: Add IMX_RPROC_SCU_API method
      remoteproc: imx_dsp_rproc: Add remoteproc driver for DSP on i.MX
      dt-bindings: dsp: fsl: Update binding document for remote proc driver
      remoteproc: imx_dsp_rproc: Correct the comment style of copyright

Sibi Sankar (7):
      dt-bindings: remoteproc: qcom: pas: Add QMP property
      dt-bindings: remoteproc: qcom: Add QMP property
      remoteproc: qcom: q6v5: Use qmp_send to update co-processor load state
      dt-bindings: remoteproc: qcom: pas: Add SC7280 MPSS support
      remoteproc: qcom: pas: Add SC7280 Modem support
      dt-bindings: remoteproc: qcom: Update Q6V5 Modem PIL binding
      remoteproc: mss: q6v5-mss: Add modem support on SC7280

Sinthu Raja (2):
      dt-bindings: remoteproc: k3-r5f: Cleanup SoC compatible from DT example
      dt-bindings: remoteproc: k3-dsp: Cleanup SoC compatible from DT example

Stephen Boyd (2):
      remoteproc: qcom: wcnss: Drop unused smd include
      remoteproc: qcom: Loosen dependency on RPMSG_QCOM_SMD

Tinghan Shen (4):
      dt-bindings: remoteproc: mediatek: Add binding for mt8195 scp
      dt-bindings: remoteproc: mediatek: Add binding for mt8192 scp
      dt-bindings: remoteproc: mediatek: Convert mtk,scp to json-schema
      remoteproc: mediatek: Support mt8195 scp

Wolfram Sang (1):
      remoteproc: omap_remoteproc: simplify getting .driver_data

Yassine Oudjana (1):
      remoteproc: qcom: pas: Use the same init resources for MSM8996 and MSM8998

zhaoxiao (1):
      remoteproc: qcom_q6v5_mss: Use devm_platform_ioremap_resource_byname() to simplify code

 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml |  123 +-
 .../remoteproc/amlogic,meson-mx-ao-arc.yaml        |   87 ++
 .../devicetree/bindings/remoteproc/mtk,scp.txt     |   36 -
 .../devicetree/bindings/remoteproc/mtk,scp.yaml    |   92 ++
 .../devicetree/bindings/remoteproc/qcom,adsp.yaml  |   59 +-
 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |   39 +-
 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml       |    4 +-
 .../bindings/remoteproc/ti,k3-r5f-rproc.yaml       |    4 +-
 MAINTAINERS                                        |    4 +-
 drivers/remoteproc/Kconfig                         |   32 +-
 drivers/remoteproc/Makefile                        |    2 +
 drivers/remoteproc/imx_dsp_rproc.c                 | 1206 ++++++++++++++++++++
 drivers/remoteproc/imx_rproc.c                     |   71 +-
 drivers/remoteproc/imx_rproc.h                     |   39 +
 drivers/remoteproc/meson_mx_ao_arc.c               |  261 +++++
 drivers/remoteproc/mtk_common.h                    |    1 +
 drivers/remoteproc/mtk_scp.c                       |   48 +-
 drivers/remoteproc/omap_remoteproc.c               |    6 +-
 drivers/remoteproc/qcom_q6v5.c                     |   57 +-
 drivers/remoteproc/qcom_q6v5.h                     |    7 +-
 drivers/remoteproc/qcom_q6v5_adsp.c                |    7 +-
 drivers/remoteproc/qcom_q6v5_mss.c                 |  304 ++++-
 drivers/remoteproc/qcom_q6v5_pas.c                 |  141 +--
 drivers/remoteproc/qcom_q6v5_wcss.c                |    5 +-
 drivers/remoteproc/qcom_wcnss.c                    |    1 -
 drivers/remoteproc/remoteproc_core.c               |    8 +-
 drivers/remoteproc/remoteproc_coredump.c           |    2 +-
 drivers/remoteproc/remoteproc_elf_loader.c         |    4 +-
 drivers/remoteproc/remoteproc_virtio.c             |   12 +
 drivers/remoteproc/ti_k3_dsp_remoteproc.c          |    2 +-
 drivers/remoteproc/ti_k3_r5_remoteproc.c           |    2 +-
 drivers/rpmsg/rpmsg_char.c                         |    2 -
 drivers/soc/qcom/qcom_aoss.c                       |   54 +-
 include/linux/remoteproc.h                         |   12 -
 include/linux/soc/qcom/qcom_aoss.h                 |   38 +
 35 files changed, 2468 insertions(+), 304 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/amlogic,meson-mx-ao-arc.yaml
 delete mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
 create mode 100644 drivers/remoteproc/imx_dsp_rproc.c
 create mode 100644 drivers/remoteproc/imx_rproc.h
 create mode 100644 drivers/remoteproc/meson_mx_ao_arc.c
 create mode 100644 include/linux/soc/qcom/qcom_aoss.h
