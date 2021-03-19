Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED68F3428B8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 23:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhCSWbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 18:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhCSWbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 18:31:09 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2DAC061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 15:31:08 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id t5so5833951qvs.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 15:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KddpZryhMVvzhVIwYfWKLC636YNqdm4/19kIUEAclns=;
        b=Q7HzdPBPeEbRVYC4XtRQJeGSTnHy4ukvIEbr/kSxnYM4IcQ5WUx7weESIt+3mqVTQJ
         S/+RP2YipjePRplqS5SVwZfixn/33ACtQnB6x9iDZWrqmkizu910BFmbh/INWRl//aBh
         BEC9beV/uNHiEODWnNZrVxAnt7Uo6Ys46VJu9l78fY05CBjSLP1Atz5XA7a/IEOFiVw/
         UPyRTE4HXEZSaGpR9Tf+rR60jqeCTaJEo59JEPZRTgPhix5YGLhHBp9OoGUI42UqvJZ7
         lJFSbmsDX+ZkyI15KBwy+w/Pkre8cBenumOrbfj4kYoZq7o6QXf+AUOG7hqNWcI8QjYT
         7Hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KddpZryhMVvzhVIwYfWKLC636YNqdm4/19kIUEAclns=;
        b=k822laeqVK41CX20BGs17dF823dGx2j7pWVlSj/lNS7ZeSwxa80quidr2djKA2DQlO
         iima/SATiQnhT3gbdaG2GKSTzFMt4POGs8JEolX7xdJryH+ef2exlH/DdW5eKrxqsdnr
         7hFdLfmLx5lceO/y95ZrTrUK/1tMgDnBSP9FN9L2HubGL61g+SdIcYl0ypDM/oLfSQNY
         76dy3EiDXNVpjblEATDoLpmWFLXjQ0IaW5MzrJlO5rLPEdmnBZ8+t5vh0xg6z+OyOXXZ
         FJObnOXVxCUXILQfcvM1MqVBX3hIpt+TlaKrzftJZjYA4zEvHQmPYaCyeAO1kNfOD168
         knMA==
X-Gm-Message-State: AOAM5338av2g5o7F1uOUR0cPc9hnA+LHj+wrfmSWPQnXUBNKZoj+VRIe
        hpnMcAnA3LqtIO3aBIPCfHU=
X-Google-Smtp-Source: ABdhPJzgabCRWFkF2CS9u2kCAjnqCvtOCamfp0qEIVgZEbfYR2ujHtxUPGHyNwonubfjoukVRxvW1w==
X-Received: by 2002:a05:6214:1144:: with SMTP id b4mr11570107qvt.12.1616193068189;
        Fri, 19 Mar 2021 15:31:08 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.27])
        by smtp.gmail.com with ESMTPSA id t24sm4691228qto.23.2021.03.19.15.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 15:31:07 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        anshuman.khandual@arm.com, suzuki.poulose@arm.com,
        gustavoars@kernel.org, vincenzo.frascino@arm.com,
        unixbhaskar@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] arm64: cpuinfo: Fix a typo
Date:   Sat, 20 Mar 2021 03:58:48 +0530
Message-Id: <20210319222848.29928-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/acurate/accurate/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/arm64/kernel/cpuinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 77605aec25fe..51fcf99d5351 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -353,7 +353,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	 * with the CLIDR_EL1 fields to avoid triggering false warnings
 	 * when there is a mismatch across the CPUs. Keep track of the
 	 * effective value of the CTR_EL0 in our internal records for
-	 * acurate sanity check and feature enablement.
+	 * accurate sanity check and feature enablement.
 	 */
 	info->reg_ctr = read_cpuid_effective_cachetype();
 	info->reg_dczid = read_cpuid(DCZID_EL0);
--
2.26.2

