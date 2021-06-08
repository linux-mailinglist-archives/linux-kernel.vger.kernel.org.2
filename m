Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BB33A06C9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 00:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhFHWbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 18:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbhFHWbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 18:31:32 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB1DC061789
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 15:29:28 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id l7so16562977qtk.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 15:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tzGX9fCwBa/GCHza5uoWn4deXxt6OaL//ssg+qUDOEo=;
        b=D7PNmOWjCmF8+3mFiGGTqNTIUWlfHeFkDtHsNekzwL+AYtd5b2C2igUsryUEAOK1uz
         /JkNiwMvs0RT/HznC/08bGC4/0QWrjnzDZtaT1wceonkgDm25xnmPduKvzo9PMrqa1sA
         tVt2H1hyEYltb+45GCQlcp7hWTOz3iunBd7RTBRUemLpLzsA4HmiNalUeBXkPtzZ4DsP
         NQ43JWRhW1CPoLF79KpXhoYgKqevlKoBLYB1noUAyH16aeVs2QlLeL08Hcu/HIM8+q+W
         ACtgWEfXJb97oOkVdO2SxfQTX8U1qBZ1/2XF6rzvUaohMLSXrD91LcALk8HgNnNPS4eD
         Oz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tzGX9fCwBa/GCHza5uoWn4deXxt6OaL//ssg+qUDOEo=;
        b=HqrkGILe33UD6zrl1cNEQtDanHXWziYFa0zeBZGPsrwdc2HxVScNj7s0x4po5tc/GT
         UIYrREvEAufJSxwiHrKesl3SLeHmrS/sV1y61Citq+aIhE+QkSywyBEohgkwN2U/D04u
         7C8csXEN/RJVD0mjEB7SdAVbICkzx1JWIgrRnB5VeNKZk53r/T/a+VpJvfl0nirgKGBm
         DykAeENvafw+LLXa5FrPBhbAN9SJfB4zxUPTCcrWYgP+p1PLf4Vk/MfZJ8LHhaKOwDG3
         0QQnZAWNM5KwSY6zGCtr7pEPFCSXeuDMPj2wttDA6MQKFmiUlSv3o73I94NwqPjX7+Ex
         QW+g==
X-Gm-Message-State: AOAM532tT/xdFqL3Gl9l09jqmoEpsqb766F22lCNy7jEyUVWcrPQIdaq
        y/+J+/5+M9m1y07qXW16ncinMA==
X-Google-Smtp-Source: ABdhPJxbwnFt1DfjxCZC3qMn+TbSldnacV1TMWu10I0frpYsRYfLipKNMEXkMuMjDsR8xulCl6pjxg==
X-Received: by 2002:ac8:1286:: with SMTP id y6mr4073535qti.58.1623191367897;
        Tue, 08 Jun 2021 15:29:27 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id h19sm10450736qtq.5.2021.06.08.15.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 15:29:27 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/5] Introduce LMh driver for Qualcomm SoCs
Date:   Tue,  8 Jun 2021 18:29:21 -0400
Message-Id: <20210608222926.2707768-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Limits Management Hardware(LMh) is a hardware infrastructure on some
Qualcomm SoCs that can enforce temperature and current limits as programmed
by software for certain IPs like CPU. On many newer SoCs LMh is configured
by firmware/TZ and no programming is needed from the kernel side. But on
certain SoCs like sdm845 the firmware does not do a complete programming of
the h/w block. On such SoCs kernel software has to explicitly set up the
temperature limits and turn on various monitoring and enforcing algorithms
on the hardware.

Introduce support for enabling and programming various limit settings and
monitoring capabilities of Limits Management Hardware(LMh) associated with
cpu clusters. Also introduce support in cpufreq hardware driver to monitor
the interrupt associated with cpu frequency throttling so that this
information can be conveyed to the schdeuler via thermal pressure
interface.

With this patch series following cpu performance improvement(30-70%) is
observed on sdm845. The reasoning here is that without LMh being programmed
properly from the kernel, the default settings were enabling thermal
mitigation for CPUs at too low a temperature (around 70-75 degree C).  This
in turn meant that many a time CPUs were never actually allowed to hit the
maximum possible/required frequencies.

UnixBench whets and dhry (./Run whets dhry)
System Benchmarks Index Score

		Without LMh Support		With LMh Support
1 copy test	1353.7				1773.2

8 copy tests	4473.6				7402.3

Sysbench cpu 
sysbench cpu --threads=8 --time=60 --cpu-max-prime=100000 run

		Without LMh Support		With LMh Support
Events per
second			355				614

Avg Latency(ms)		21.84				13.02

Thara Gopinath (5):
  firmware: qcom_scm: Introduce SCM calls to access LMh
  thermal: qcom: Add support for LMh driver
  cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support
  arm64: boot: dts: sdm45: Add support for LMh node
  arm64: boot: dts: qcom: sdm845: Remove passive trip points for thermal
    zones 0-7

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 246 +++------------------------
 drivers/cpufreq/qcom-cpufreq-hw.c    | 100 +++++++++++
 drivers/firmware/qcom_scm.c          |  47 +++++
 drivers/firmware/qcom_scm.h          |   4 +
 drivers/thermal/qcom/Kconfig         |  10 ++
 drivers/thermal/qcom/Makefile        |   1 +
 drivers/thermal/qcom/lmh.c           | 244 ++++++++++++++++++++++++++
 include/linux/qcom_scm.h             |  13 ++
 8 files changed, 440 insertions(+), 225 deletions(-)
 create mode 100644 drivers/thermal/qcom/lmh.c

-- 
2.25.1

