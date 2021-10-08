Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140C34262D5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 05:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhJHDWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 23:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhJHDWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 23:22:05 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C8CC061570;
        Thu,  7 Oct 2021 20:20:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ls18so6491304pjb.3;
        Thu, 07 Oct 2021 20:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zVTSAl6LZtzKmggtyfDtdu7T8Rzv0p9J9tbrf+mG8Kc=;
        b=BKlPbYXJaCs/xFNopSiyb+ee96SGWK7ykvOVihDcVUGMZTTvdiATq9R5BwJv/zfqBo
         /4zRMccDziBKvDxbWuWgMsWFdgjmgOWxHtrrCydpa5n7bt3GADjVXtwPVOqC+ZVcSH5g
         CjtDc1TOLkq7SA4/KGdDKDuReQpyUabL6+E1ZR1Zxk/egazoUSQjdTZJiATfxxAnt96P
         3ri8Deq1yprqsNFIjp0IIrKCsq8x9Mtx8KWvbGngSre+ejBXRua+o/GpCWEswrtExc9w
         X3UBvtTA+YTUIDI1dzqYEYwNWNKHO7D/3MlNmoVVW+H1kt5mQnxfUZBAA5/adZOQGe9R
         /o0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zVTSAl6LZtzKmggtyfDtdu7T8Rzv0p9J9tbrf+mG8Kc=;
        b=cbQ+yX+5nNX83klGkEU7IA1oL1hR7BA7UcNkD2zaSPqiWe0ORIP1w5VMGd2mk3ZIcd
         WvfgkI3ZFI5YyjM6FfqiV4gX29k3u9xIosVB+atJhzjzCnbsItxsrvDEBI82CJpo/oc4
         sLStvCQrtWbb8mUPEN0f83vorA89OPcPEYUcmvnEHPXj360FWFL55Nav1I/576u0nZZO
         p5g3BQQD34v/DWK7luo+sZfWsjlt4hTx1xTp2mxVu67BPiNI0/0rI5vKl2KXUijd2YlN
         ZfP5rpefUz0yltEyiiBdosjvDfLsRz02n/P/RYaHZpERE3nEqwWzBPNlNElgJhEvRoen
         LbyA==
X-Gm-Message-State: AOAM531gNT8ZIEAxzNo934L9s8il8coK9XwMM2m1GBLBUr8xx5g1YjQo
        sJP4num7Zg+2RQ5YZlsQtxQ=
X-Google-Smtp-Source: ABdhPJz5Q1rQEGAiHqo/yCyOB1rtEECuMA0ka2Ln8ZWdaSIsbSmiiPUGvr0H0jrg2CmEf8BZV/V0hw==
X-Received: by 2002:a17:90a:345:: with SMTP id 5mr9442835pjf.189.1633663210526;
        Thu, 07 Oct 2021 20:20:10 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j198sm713943pgc.4.2021.10.07.20.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 20:20:09 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Add Unisoc's SC2730 regulator support
Date:   Fri,  8 Oct 2021 11:19:51 +0800
Message-Id: <20211008031953.339461-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Changes since v1:
* Addressed Mark's comments:
- Removed debugfs things from SC2730 driver and deleted sc2730_regulator_remove() which deal with debugfs only;
- Changed to use C++ style comments on the head of driver.
* Added Rob's Reviewed-by for bindings changes.

Chunyan Zhang (1):
  dt-bindings: regulator: Add bindings for Unisoc's SC2730 regulator

Zhongfa Wang (1):
  regulator: Add Unisoc's SC2730 regulator driver

 .../regulator/sprd,sc2730-regulator.yaml      |  61 +++
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/sc2730-regulator.c          | 404 ++++++++++++++++++
 4 files changed, 476 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/sprd,sc2730-regulator.yaml
 create mode 100644 drivers/regulator/sc2730-regulator.c

-- 
2.25.1

