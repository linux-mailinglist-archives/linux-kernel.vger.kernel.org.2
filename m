Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0CE34E62D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhC3LN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhC3LNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:13:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3472C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:38 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id j3so17680402edp.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TAaY2A0/mCi9VOST9TZhrIfnS/oSHi7K/wEizWqlU8E=;
        b=ANEyfxRkBhoJ/3g33/L4M607hEMiy4qCAuPIkS1yjpeb/1cAwXCSrQF7UL5l0zRhhO
         PeirrxeOGHLyc0msRykiHQjY9jwgcWw8lGF4y0/V6Jg93fNTRTObb5Meg/Zwsh19zDnQ
         C7t7D1ZGHcM5E9YHiMqSc+3MpAywy7uxiz2U/n1FyVgqXIHqskZ1O5RIpid/HsIUD2fM
         DyOY9ZeC/ABUQN8R5heHh08QaXEPL4imeZOGNx91Vit/dHv8UrGoQqfOnakfbWoNyL7d
         nzq+J9lm4cge6LEtAXftskZ8/cCfoW4LmEi1nN7i8j19OF0eBu4VWIIeqnh4v/nKp7aO
         twCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TAaY2A0/mCi9VOST9TZhrIfnS/oSHi7K/wEizWqlU8E=;
        b=Vo+D1IU312AI6cE7CuppPTpDyGvHKimWz/TDdjxIoyYrTEEP+m2lSdd3xTeSUC6rJi
         GUpQk6DA9Ls/4VG97zvPOSqs0NwoJFPLMEUHCxCy/JcQkEL5FcC2N/ViWMHrr6hiyWo8
         drmOwQMBTGpBUs7vKRLO7oseGR1Jv+923PyMd9U2khg8GR/CVnmmq5e4ncDN2lPfX+oe
         UQU2f8irgERXSCVlCkr25Y2l6Ag8OpH57RNlHoT9C6D3AW2Zgc1KKlXp5e8JrRE4OsdJ
         CXghVmXhr1clVqJbez7rAsquypRKyr/1zsSWExEjeqCkve2bSX3zBy3Hd4x4gqeQvOL1
         sc3g==
X-Gm-Message-State: AOAM532fYOq8FqkZFDUOsAOpnUeG1qvZhaALaCf5tZWO4o2U/AZmZO+m
        mZWWev16JwyMwVJp8+4I9xT5yg==
X-Google-Smtp-Source: ABdhPJytqipTL9/SvBarg6HlfOpZsCGgI2fXl7ZS3MsB+jFR4wzwMf41bGnfZdA3yQD4S+5zQrgt7g==
X-Received: by 2002:a05:6402:34c8:: with SMTP id w8mr34452394edc.235.1617102816399;
        Tue, 30 Mar 2021 04:13:36 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id r19sm10961308edp.52.2021.03.30.04.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 04:13:35 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/10] nvmem: patches (set 1) for 5.13
Date:   Tue, 30 Mar 2021 12:12:31 +0100
Message-Id: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches for 5.13 which includes
- adding support to new Broadcom NVRAM, MediaTek mt8192,
 Qualcomm sc7280 nvmem provider
- Add new function to make numbers reading easy
- Update qfprom to support fuse blowing!
- few minor fixes.

Can you please queue them up for 5.13.

thanks for you help,
srini

Colin Ian King (1):
  nvmem: core: Fix unintentional sign extension issue

Douglas Anderson (1):
  nvmem: core: Add functions to make number reading easy

Rafał Miłecki (2):
  dt-bindings: nvmem: add Broadcom's NVRAM
  nvmem: brcm_nvram: new driver exposing Broadcom's NVRAM

Rajendra Nayak (2):
  dt-bindings: nvmem: Add SoC compatible for sc7280
  nvmem: qfprom: Add support for fuse blowing on sc7280

Ravi Kumar Bokka (1):
  drivers: nvmem: Fix voltage settings for QTI qfprom-efuse

Ryan Wu (1):
  dt-bindings: nvmem: mediatek: add support for MediaTek mt8192 SoC

Srinivas Kandagatla (1):
  nvmem: rmem: fix undefined reference to memremap

Zheng Yongjun (1):
  nvmem: convert comma to semicolon

 .../devicetree/bindings/nvmem/brcm,nvram.yaml | 34 +++++++
 .../devicetree/bindings/nvmem/mtk-efuse.txt   |  1 +
 .../bindings/nvmem/qcom,qfprom.yaml           |  1 +
 drivers/nvmem/Kconfig                         | 10 ++
 drivers/nvmem/Makefile                        |  2 +
 drivers/nvmem/brcm_nvram.c                    | 78 +++++++++++++++
 drivers/nvmem/core.c                          | 95 +++++++++++++++++++
 drivers/nvmem/qcom-spmi-sdam.c                |  2 +-
 drivers/nvmem/qfprom.c                        | 44 +++++++++
 drivers/nvmem/snvs_lpgpr.c                    |  2 +-
 include/linux/nvmem-consumer.h                |  4 +
 11 files changed, 271 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
 create mode 100644 drivers/nvmem/brcm_nvram.c

-- 
2.21.0

