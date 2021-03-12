Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B9B338BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhCLLjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhCLLjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:39:35 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EEBC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:39:35 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id y124-20020a1c32820000b029010c93864955so15599675wmy.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Evn/zUZLGvYBTlWu7fdQZVd0huhV0HPNs5LNi3oCJDE=;
        b=IU5JejxRgCWP9izx2NuQNMXjFon/e1zPNBGN9b6gcsUixMjAhZCKhgiXRvLqqq21RB
         nmV4BqsTIEpwGmZSIkOveN2+DyafiH//ykz+GrsRR4DDYbqQVF10LGFPXG3QEVM4J6lL
         hk/y1BCPWQxjzUj/UdgctueDtHpCyy5NgtUZ3Ism/eG1b6A9ZVMe33qV5iL0+wtea9Pj
         BeqdLPg4qu96Ldya2fZ7sMrEbrZDsgiFbOfTC/mg/oRNd7JYSXd6SJk1u88WEp6xDsaO
         S9PsW1LpgLbiLkiI+H4MpLAgHIFGhReibpRQVes5D6Hv+yN1oOgy0iQrGexywRzgcqA/
         1clQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Evn/zUZLGvYBTlWu7fdQZVd0huhV0HPNs5LNi3oCJDE=;
        b=DAJ9ItzrnC4faRfutSgaiarGd+IlKf44BEmJTSYHG8+hyM8hvlqYbzWp042KNJh1X/
         d0GZ9fcjUWE4PLzcqP40fyusSJQ1n8yuNQ8JRCuIeNfvshIfZW+Q0jV98oObrtfbqvzX
         qXJuFzXCeE+lc/nyhbFZpjSTcAEsK/rCXnuHEnnydQwZfWZEcKg0KFdh0F+8692K/uaU
         2h+kp/f9fhBIWw4e40n5T5PhV3n00geLzTwpVrzh/tUZgo2XfTSSmyt/LPqf9aqpGCVZ
         q7iXznZJFmBWlHKK4GbGlKwL5RpsqXbGxRv4miFjGjRzAmh0D/aNMCoQDbzURHdK175p
         rSAg==
X-Gm-Message-State: AOAM532TJpIbGqZAdlM46d5HMORK7K/PCxozIwU4Nl33ux8R/gn4rWIH
        IZwT+TDx+XcaNK3NxW4f30I1pebsa0UZNw==
X-Google-Smtp-Source: ABdhPJzV8wjTRuHIFcun07Ew5LkjH6JjzByKgvZiYHIGpZ3HeFPCjuZKjFKK4qcTtalJtn6n05n2FA==
X-Received: by 2002:a7b:c186:: with SMTP id y6mr13038265wmi.84.1615549173996;
        Fri, 12 Mar 2021 03:39:33 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id z1sm7412458wru.95.2021.03.12.03.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:39:33 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/5] soundwire: add static port map support
Date:   Fri, 12 Mar 2021 11:39:24 +0000
Message-Id: <20210312113929.17512-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

