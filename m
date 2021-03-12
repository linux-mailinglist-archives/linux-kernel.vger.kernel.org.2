Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89BA338C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhCLMX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhCLMW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:22:59 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8921EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:22:59 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o26so3688325wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gw1EmCEru4mg3+UNq5mxUL127uGPwQQa9UFbvGW5NTI=;
        b=cuOnInoCzbYXcB1KE5fz2yZHLtqWBz9qh7UG3lXJMeCj+zARTGww+hTmqo5PhiXx97
         UY4064YuVsrxrXIb+OcMhjPO/NY2dmV7Pray+0LDDZ+JulCWwdW86mPXw9W41mxeExYU
         LCCSxP+raDM2LLVKnLFvyhqLxmrVlfjNCy/LAdRao99I7O+X5AHfkcf8gY6minxejmkO
         TtlESx6ZWGcsbiJieSPRPItF2SZ/ZQUIX9iywILHy1Ugs1fNo3mKWhTheBDKMwSfxIQj
         AG4Yp8fis64UejdHnk4rWcFONt3iMHy+BsaLAbC/nw1j3v4GZ4HBbO1s3jBr0urATl/m
         qHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gw1EmCEru4mg3+UNq5mxUL127uGPwQQa9UFbvGW5NTI=;
        b=IB4pJaA6kQh+LyY/GNsul1ULcFLwvT6O1sxyYZs4ZdR44nDtuZ7oZZ/YX+4hmF5cxR
         u7ojEsdFlanI2MHxWO3g+AJ1egAESk/EECJ+0sF3QAF4oOcmo6Sj+fcTL1r7NLF+Pcp8
         qwJg6bYtM00tHT7VcrTED5WkEGcjl66ZlMpcwn3hzfyV05XydZBRxEIsQNlR4sZLGw2M
         GGWRNdkIrb7TmL3akozo7IhpSu8wrE4RhV08UQrwcTig7E/abSQfDb4+40DwjKoB4Q3/
         XWpI2AAbhoG2M1wsIpVQA0LX2O93mO9gVD1kJ7OhVc7ogYzcfrsiNAZ3Lfbln5H7TpqX
         giDA==
X-Gm-Message-State: AOAM53347agFM9sbum9MPq8OVL5QMjsEtFdv8JKaVaxrYltHbylhLIrf
        HbIXKqY9/tulpSoMOimBMNBN21EhFie1cg==
X-Google-Smtp-Source: ABdhPJww7SBBR/wgNWOgTTUZXlxZnzs/4W5fSEWQ/e3ed5u/QFiShUj+guiVKTkM7YlwR7o26udojg==
X-Received: by 2002:a7b:c3c1:: with SMTP id t1mr12734679wmj.47.1615551778173;
        Fri, 12 Mar 2021 04:22:58 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id 3sm8804329wry.72.2021.03.12.04.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 04:22:57 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH v3 0/5] soundwire: add static port map support
Date:   Fri, 12 Mar 2021 12:22:50 +0000
Message-Id: <20210312122255.3143-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending this as I realized that alsa-devel list was missing in cc!

In some cases, SoundWire device ports are statically mapped to Controller
ports during design, however there is no way to expose this information
to the controller. Controllers like Qualcomm ones use this info to setup
static bandwidth parameters for those ports.

A generic port allocation is not possible in this cases!
This patch adds a new member m_port_map to SoundWire device so that
it can populate the static master port map and share it with controller
to be able to setup correct bandwidth parameters.

As a user of this feature this patchset also adds new bindings for
wsa881x smart speaker which has 4 ports which are statically mapped
to the 3 output and 1 input port of the controller.

Tested it on DB845c and SM8250 MTP.

thanks,
srini

Changes since v2:
	- fixed dt_binding_check error and kernel test robot reported errors
	- updated comments as suggested by Pierre
	- updated wsa881x to populate m_ports from valid index.

Srinivas Kandagatla (5):
  soundwire: add static port mapping support
  soundwire: qcom: update port map allocation bit mask
  soundwire: qcom: add static port map support
  ASoC: dt-bindings: wsa881x: add bindings for port mapping
  ASoC: codecs: wsa881x: add static port map support

 .../bindings/sound/qcom,wsa881x.yaml          |  9 ++++++
 drivers/soundwire/qcom.c                      | 31 +++++++++++++++----
 include/linux/soundwire/sdw.h                 |  2 ++
 sound/soc/codecs/wsa881x.c                    |  7 +++++
 4 files changed, 43 insertions(+), 6 deletions(-)

-- 
2.21.0

