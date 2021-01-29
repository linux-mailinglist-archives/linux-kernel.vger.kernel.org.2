Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29BF308B46
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhA2RRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhA2RPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:15:24 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55DCC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:14:43 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c4so6886869wru.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8lEYyicSfcCqNl1lJ65tkJzksO8EMghkrf+QO4axj4Q=;
        b=z1O5+PvJ65OjxsTgt035Sw/hyWgCr8YGJEOYpP13GtuLcPCWt8iQHPnkcQX3aIZFMc
         4JBhNZQ/wRZcTAW0xOAMhv0SJvFQ55BWDHB2Dzz/SqXamO6IuI5A55UKxNQdTP/Lp58S
         VVkKstQYDDRpdHjy9jf3vJGXJaW3VpGWyPi2x4qBcjQfjKOIca3qGB2EsZxFnbW7l1wR
         Yz2iEnKZBg7E6oADxamkQEHivv0UdcY/r9XloZpkANxGsu3SIKQDjDnKVs3MFurLKt6/
         TSN18FnDxyvxmDVPoPnnTxArwPwKZ7OivEJ/Vg1+drjTXSwzyZooXhcDfPsmCyHPFPH3
         DFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8lEYyicSfcCqNl1lJ65tkJzksO8EMghkrf+QO4axj4Q=;
        b=ZTnZ0mHbnRxTkpfTGt1RORtOnyu3P8qh3/+TNfZNsSNQ2szSWho2UWQVwhr2PmkKfG
         N81Sw7ZU3Q1eHquCXGSrWXfRjjMjVMx6ai+lXF4wlwYTrpgQVojplOaiP0zuwSrGzIim
         usNHvZaeW+NcYyo8uhv0vn9ONBkdDV2qMHYOBHENsOGhaipvXZpwquQchKLe37Eej/gz
         PaoSvTyPmw/SZ07+k4TVVOltRTY4bNAnVYd9tn7d6dsn8i7kDjmUtBdXWRnVr80OHbbf
         TDwf/8KkBVrltu+sEQrEyGU3CrA1DLuH/zseEPbQxDhcDe5Vn/MnMI97BEcCSd6Y7r6M
         1bvg==
X-Gm-Message-State: AOAM5302ZK5ebcjpSBApn1F55klQcjDeMpEDVzRGoPTpcUXkwpeoZzUG
        g6uEeRRqw7ZTOv5c64RFHmyXbA==
X-Google-Smtp-Source: ABdhPJzVPdaTet7GMwQtSncQQEco5jbpfgLTQVt2JUjWY61es5LqMtj+ia6YUHWxHQfm2fvilsNfLA==
X-Received: by 2002:a05:6000:12c7:: with SMTP id l7mr5650786wrx.103.1611940482691;
        Fri, 29 Jan 2021 09:14:42 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n15sm12952487wrx.2.2021.01.29.09.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 09:14:41 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/5] nvmem: patches (set 1) for 5.12
Date:   Fri, 29 Jan 2021 17:14:25 +0000
Message-Id: <20210129171430.11328-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches for 5.12 which includes
- adding support to new rmem nvmem provider
- a improvement in core to skip invalid node and a fix a leak
- patch in imx driver to use of_device_get_match_data

Can you please queue them up for 5.12.

thanks for you help,
srini

Ahmad Fatoum (1):
  nvmem: core: skip child nodes not matching binding

Dan Carpenter (1):
  nvmem: core: Fix a resource leak on error in nvmem_add_cells_from_of()

Fabio Estevam (1):
  nvmem: imx-iim: Use of_device_get_match_data()

Nicolas Saenz Julienne (2):
  dt-bindings: nvmem: Add bindings for rmem driver
  nvmem: Add driver to expose reserved memory as nvmem

 .../devicetree/bindings/nvmem/rmem.yaml       | 49 ++++++++++
 drivers/nvmem/Kconfig                         |  8 ++
 drivers/nvmem/Makefile                        |  2 +
 drivers/nvmem/core.c                          |  5 +-
 drivers/nvmem/imx-iim.c                       |  7 +-
 drivers/nvmem/rmem.c                          | 97 +++++++++++++++++++
 drivers/of/platform.c                         |  1 +
 7 files changed, 162 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/rmem.yaml
 create mode 100644 drivers/nvmem/rmem.c

-- 
2.21.0

