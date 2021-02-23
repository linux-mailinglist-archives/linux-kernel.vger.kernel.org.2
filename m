Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F10A323451
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 00:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbhBWXoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 18:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbhBWXgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:36:01 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEAEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:35:17 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id ba1so22730plb.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SHL5XDAIKj8MSKK6Z+vTePkWS1Indwf4AZBtBlAyi64=;
        b=KBWghAnPjbcmDLzHTQQy4PpOC2g3Spr7nGT1p3HLpvMZVu/ke5G5tEf+tkyMc7Jboo
         ivAxl5EHjttgPBa0UmYIe89AYRDLeNi1P1/6VSDFCe9evBg1cDyxEVPs7emDJyHs6Dhr
         R5dDFRqgP5Nf6mMqpXqi5F4NB5cbmGDJgocrQ2ctRzoZZwV7gVECqgVkygYJRgxfvBce
         1t4RBo86MY51bj/RQMz5FbCfBihWCsacxOEawPxkbsoYWQE25jThNUNPaAZRPwkcWb1a
         JVQ4vTSqwknbEVP5C0U6jz9PRge9UhGF1pUZ7B9R7tu2MR21gF7hPAxRardks5lf7P/w
         9V3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SHL5XDAIKj8MSKK6Z+vTePkWS1Indwf4AZBtBlAyi64=;
        b=Mg/a82WSgvL3qJt5N/4W0gfjIklKHhign1D4v1jDWZTMnCgbFG+UXymJ4jyJwsBhH/
         rTNbSpdg9el/Lxc42aW/jEc0FwIsDxAtcA4mjGh+n1Nk4Komz/naD2yPrg5+kuFfsay4
         ldFY9JUp9Jouv4ZCXipPsliH5/Befnq/Nmb36IFTd/dCr88P95ejcUL9XCq2HDka6KKR
         4GPgzp7msYSd10HeqRgJuS4tFRg7oYu/AObnVs+osOWg7QnHSlkyM4HrQjfpWghbGx0W
         philLDUW1BixBPYCe5gH+Anlbg8wSTJB9T615BOH2JuILuWu6LL7CSHIOritivKYu+dk
         Lx5w==
X-Gm-Message-State: AOAM532Iy7LNMIUaTNdjdQpZECzxttEz4AxJerAp07x3FPNJR039LUDk
        Fpy2thMXLLxEapOmAFcVl54qHq/O2SJI6A==
X-Google-Smtp-Source: ABdhPJwifdDLsrVJqk5R17vjdzA8fqNWlkWyr2tPKLL5zlQQ5O9oaEDIxoxVXdeN+c91+tEOj63K9Q==
X-Received: by 2002:a17:90a:ae14:: with SMTP id t20mr1194420pjq.90.1614123317354;
        Tue, 23 Feb 2021 15:35:17 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c24sm311999pfd.11.2021.02.23.15.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 15:35:16 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        arnaud.pouliquen@st.com
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 00/16] remoteproc: Add support for detaching a remote processor
Date:   Tue, 23 Feb 2021 16:34:59 -0700
Message-Id: <20210223233515.3468677-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the work done here [1], this set provides support for the
remoteproc core to release resources associated with a remote processor
without having to switch it off. That way a platform driver can be removed
or the application processor power cycled while the remote processor is
still operating.

Modifications for this revision are detailed in the changelog of each patch
but the main difference is that going from RPROC_RUNNING -> RPROC_DETACHED
is no longer supported to avoid dealing tricky resource table issues.

Applies cleanly on rproc-next (e8b4e9a21af7).  I will rebase on 5.12-rc1 when it
comes out next week.

Thanks,
Mathieu

Arnaud POULIQUEN (1):
  remoteproc: stm32: Move memory parsing to rproc_ops

Mathieu Poirier (15):
  remoteproc: Remove useless check in rproc_del()
  remoteproc: Rename function rproc_actuate()
  remoteproc: Add new RPROC_ATTACHED state
  remoteproc: Properly represent the attached state
  remoteproc: Add new get_loaded_rsc_table() to rproc_ops
  remoteproc: stm32: Move resource table setup to rproc_ops
  remoteproc: Add new detach() remoteproc operation
  remoteproc: Introduce function __rproc_detach()
  remoteproc: Introduce function rproc_detach()
  remoteproc: Properly deal with the resource table when attached
  remoteproc: Properly deal with a kernel panic when attached
  remoteproc: Properly deal with a start request when attached
  remoteproc: Properly deal with a stop request when attached
  remoteproc: Properly deal with a detach request when attached
  remoteproc: Refactor rproc delete and cdev release path

 drivers/remoteproc/remoteproc_cdev.c     |  21 +-
 drivers/remoteproc/remoteproc_core.c     | 263 ++++++++++++++++++++---
 drivers/remoteproc/remoteproc_internal.h |  10 +
 drivers/remoteproc/remoteproc_sysfs.c    |  17 +-
 drivers/remoteproc/stm32_rproc.c         | 168 +++++++--------
 include/linux/remoteproc.h               |  21 +-
 6 files changed, 362 insertions(+), 138 deletions(-)

-- 
2.25.1

