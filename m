Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6954143FD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 10:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhIVIq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 04:46:26 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48096
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234017AbhIVIqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 04:46:22 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 511AB3F048
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 08:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632300291;
        bh=uiMxeL0gXr2dTqfDCAVU08QHmTYD3WPNowiXOrxuH3E=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=CXkHPD764IYmuAL2vO4sv/f7MV8ZmfEaRpKD9SZFid0nmfO16vrFxeTJvEF/U3MHn
         t1IdXNCDmFk7oQX0NREXTwXGmKccQUg/qVoW8rHim1mrVosTxfPmLyOrqvbiISK1y4
         EGtLUF7o5oxd5QkwIAy1R1IRmfFyul2BKR7qRpP9/Sz/P//6G9gKS+IIg6MbgDw3Pm
         k8FupMp7JZ/17DWL8c6kN75XXKrFaQEH9l52mZqMDQhUcm7w0fVCFyVLgX+JymGx69
         /S4sfjug/DIazjK6beKGG8YflHkhgK1+V3DyXn68APY/mNU1zLye3am/aWTvyrURKT
         dJUPPVJR7HwvQ==
Received: by mail-wr1-f70.google.com with SMTP id x2-20020a5d54c2000000b0015dfd2b4e34so1483174wrv.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 01:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uiMxeL0gXr2dTqfDCAVU08QHmTYD3WPNowiXOrxuH3E=;
        b=QCXdq5MnGit1HjBQlKfZAXpD/vrs6KkXKK481/CNzgQDGhfbUMFW4zipTsLOBZl0I4
         7tu0njnaE1JbowZhqSS+5ankypKIkYuSuEwwy+vbzeINOevxSvNkeAacJiJui/x5+Z3e
         0aj++tZTSDIenI5beXbpVpzSWvy9qCMO69OeZLQ75KgBCKcvoCoLtg7v44V5CEyqB4Rr
         /i1/zBUeobEMYlgOK5ATmaFsCfgVY9TSzlO0sT5Rzk78fX6YNPt+S8IpfCPwDlzRupcf
         44fB9VMAVzaaGVmn1/R3nP40ZHFNV8vFPon7+MYKwtSgX2MotRNPWtXm5DZKMmorJSID
         6E8Q==
X-Gm-Message-State: AOAM530eK0s9u/TjOTJg4xb7RmuJwiGymzLozOBtgwMgpH0L308h4BwL
        1NGY6JYxt1k5pq9YYLR+LdQHzb0N3qNps6E4wI1/qGjVGYVFKI4gKrnTFUnEW26vYuVggsUJ7u5
        BIQlzycPH97nvNSg0zqdcO+UfAiunBVEQ4pNV7iROiw==
X-Received: by 2002:a05:600c:35d0:: with SMTP id r16mr9039082wmq.26.1632300290703;
        Wed, 22 Sep 2021 01:44:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyC680U0RwyaOjK1SOsZp30UKUvzdNakgqk61+QjWsbjiDhpXDKy1rZwHZZ9P4p0zlY3hcaFA==
X-Received: by 2002:a05:600c:35d0:: with SMTP id r16mr9039063wmq.26.1632300290511;
        Wed, 22 Sep 2021 01:44:50 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id o7sm1851490wro.45.2021.09.22.01.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 01:44:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RESEND PATCH 1/2] powerpc/powermac: add missing g5_phy_disable_cpu1() declaration
Date:   Wed, 22 Sep 2021 10:44:14 +0200
Message-Id: <20210922084415.18269-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

g5_phy_disable_cpu1() is used outside of platforms/powermac/feature.c,
so it should have a declaration to fix W=1 warning:

  arch/powerpc/platforms/powermac/feature.c:1533:6:
    error: no previous prototype for ‘g5_phy_disable_cpu1’ [-Werror=missing-prototypes]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/powerpc/include/asm/pmac_feature.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/pmac_feature.h b/arch/powerpc/include/asm/pmac_feature.h
index e08e829261b6..7703e5bf1203 100644
--- a/arch/powerpc/include/asm/pmac_feature.h
+++ b/arch/powerpc/include/asm/pmac_feature.h
@@ -143,6 +143,10 @@
  */
 struct device_node;
 
+#ifdef CONFIG_PPC64
+void g5_phy_disable_cpu1(void);
+#endif /* CONFIG_PPC64 */
+
 static inline long pmac_call_feature(int selector, struct device_node* node,
 					long param, long value)
 {
-- 
2.30.2

