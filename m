Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F5541B1B5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbhI1OLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 10:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240761AbhI1OLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:11:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166C1C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:09:44 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id w14so19067430pfu.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QdobZRR9LM4JvQt4h1L3fA1KeD3BEmaOGRH5grGNDTA=;
        b=ZYi2VdjiapeQm0kwRhWUhOjFjX/+KetbMx22CstT413xRI8FkGRc0/bNSqU3aEIoGQ
         MWB+9XVHjFAmt3IELAfr3HKfzpKGnaJSauKk/tvSA2Dq8Npcvn8SKCGFKCojymaVjbfp
         bbuvhIQyVeJSLeE9mEPenknd465INmBlzYKnhJWu/zQD4KRRc9Dw0MIgdZ5TcAqHG1cQ
         d5CBTIbN25fmV/27bXFYV2g00HLl578yXLP+Fv910NkKNEu8piS4kG0VhCoTVKPHC+qj
         bUmnPpIgOsxXhXtw09clkM1NI/7/76d9XqL9FpzrS160tfs/auWVffJC62KcuinvUq7r
         Jdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QdobZRR9LM4JvQt4h1L3fA1KeD3BEmaOGRH5grGNDTA=;
        b=zDbSEj1BP/PNp19Ea/OLsDGNvOYfH2kSdGKrd8dH6ed3R4m+pC+DWonmlGTDdf6tIJ
         N7WKA0mUJ3rjdXejhVLzlRG/mWUmpEea06dSPehwOyrX4VHRIxsaAy+UNzo4/5Zj7XWV
         rKDc8HbQmOW+NrYyF/NkyKyaNXPb8ZIMZ+Qaoqv/Pb+3qI7+kHaLXHgyIooD5dCDceqT
         aUDKkTvCWSTjl/o1a+jIBoyTV9hYCarw8ef1eRym2mKKphk/cN2pJhqHACBqHfWvDDjm
         ktWWo4v8fknop3VWPMTRDWEDiJcU4s7VCvybWcDV++AlGYXdlugftOVymldKTATmuieR
         lSkQ==
X-Gm-Message-State: AOAM530HWt1krvKqWvfLpNnxD89O27WgXH13LHNCaF/HOEGpSijPmuN8
        UXufnPD33kMLu0p+oGEkaCgzUA==
X-Google-Smtp-Source: ABdhPJwyPxFvS2OADp043eeVxAhkNdzr8Fx6G5dn/m65ZINPUpD5tzs21DLdAz1n9SxdS3Fa5ZYymA==
X-Received: by 2002:aa7:991b:0:b0:447:bf92:b94d with SMTP id z27-20020aa7991b000000b00447bf92b94dmr5811872pff.76.1632838183430;
        Tue, 28 Sep 2021 07:09:43 -0700 (PDT)
Received: from localhost.localdomain.name ([122.161.49.251])
        by smtp.gmail.com with ESMTPSA id ch7sm2704578pjb.44.2021.09.28.07.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 07:09:43 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        vkoul@kernel.org, robh+dt@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 0/2] arm64: dts: sa8155p-adp / sm8150: Enable remoteproc and fastproc capabilities
Date:   Tue, 28 Sep 2021 19:39:27 +0530
Message-Id: <20210928140929.2549459-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables:
- fastrpc nodes for sDSP, cDSP, and aDSP (sm8150). 
- Enable two remoteprocs found on SA8155p ADP
  platform - 'audio and compute'. 

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>

Bhupesh Sharma (2):
  arm64: dts: qcom: sm8150: Add fastproc nodes
  arm64: dts: qcom: sa8155p-adp: Enable remoteproc capabilities

 arch/arm64/boot/dts/qcom/sa8155p-adp.dts |  10 ++
 arch/arm64/boot/dts/qcom/sm8150.dtsi     | 119 +++++++++++++++++++++++
 2 files changed, 129 insertions(+)

-- 
2.31.1

