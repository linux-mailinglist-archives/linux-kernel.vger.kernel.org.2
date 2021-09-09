Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0924240469F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhIIH77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 03:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhIIH7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:59:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B930BC061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 00:58:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 83-20020a251956000000b0059948f541cbso1426921ybz.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 00:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VV4e5cXq8IiLf604F5fMr/AHVRLEwRZwQ8HOpIWKAfs=;
        b=W4MpQX2GWybdJ8Z8NEZyUiB6RAhU2gG2auoxVcT6YDOYp7m40/uzxzuSOQS462lre5
         83+7jXv3PMNsdP8eYGyZLtMSNim2qI1ja49CxbwHX+kf8B83cvYYd43g14ihdd4za2Sj
         hw7VVm7SiW088atTWfqDTTH/4OqmJxTfCABdXPtotKcSuNg7ofcRBIgWSOaJnK8SD9cU
         polZFK0EGhw3iHA9mklaKyJeYC+4dTJNuF7u7+UJ05bCxNdInfEmG9MjxlUWlM5HWx8O
         MQSXBAnb0F8O5rGX4mkMHO1Dx/lrdnMwo+lE/3WZeTE1hjPWzwAyL9YDrOsbGSx7v3YJ
         eOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VV4e5cXq8IiLf604F5fMr/AHVRLEwRZwQ8HOpIWKAfs=;
        b=cnXO3Yge3YPcEoZjH827aV1sI55oCshqBDKATrXJaB6YoiCG2ZlJKmo+KSV2Dng9yS
         ygx1oaATAeL5MU+YKZZUfTOSeL2GwZI1QDNnPKiGREAhZwZedAxAhcHS0WER1naFFz06
         q9AGKdWWPQYM7Bsl2X6VnlNeAyct+5k5Z1hjiqHPf+qls5bcOGTbU4XkuHLbottncsuc
         Ss8NpWsWkDwcs6oCUhdg/wf/iJyUlrSptrXHPgdJbNUyV+PJJMP/wE5EwYonpPhb47CQ
         CsftnYwDydUPSwJVYdrvfJ7wS1YbunOqcTyt2g4PgPwYxCsv0TVJQOHSVtgRQN1FNXrN
         WfgQ==
X-Gm-Message-State: AOAM532QfMcoXf6XRhnWA3Ev/t1B1fd9Zj+7mIG4gvSfT1ktruP9DiTl
        QNMyO1LnjeU6q0sIxt22nh7x7g+lyYwco55GKDmSkfQx4ULdkni2s3P1X9FlZb0tFGi/Q4Irttx
        O4iBNNrorTQKdJDsSdz8nCsN48vH6frRPJ9opbV4ajY8FD4c4ZmYAUxEkl9VlmQfgUqv1Gn51
X-Google-Smtp-Source: ABdhPJyfsM8G6IxgW9jWiMYzklpf9GomDXNh81MPwUotWSmry/8uqfsGY56JkcbG0mkFYG03yk/Y3WaHOAz5
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:f950:61f2:f1ec:ae8b])
 (user=eranian job=sendgmr) by 2002:a25:d615:: with SMTP id
 n21mr2692ybg.500.1631174322957; Thu, 09 Sep 2021 00:58:42 -0700 (PDT)
Date:   Thu,  9 Sep 2021 00:56:49 -0700
In-Reply-To: <20210909075700.4025355-1-eranian@google.com>
Message-Id: <20210909075700.4025355-3-eranian@google.com>
Mime-Version: 1.0
References: <20210909075700.4025355-1-eranian@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v1 02/13] x86/cpufeatures: add AMD Fam19h Branch Sampling feature
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a cpu feature for AMD Fam19h Branch Sampling feature as bit 31
of EBX on CPUID leaf function 0x80000008.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d0ce5cfd3ac1..74fd7ab7d74d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -313,6 +313,7 @@
 #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
+#define X86_FEATURE_AMD_BRS		(13*32+31) /* Branch Sampling available */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
-- 
2.33.0.153.gba50c8fa24-goog

