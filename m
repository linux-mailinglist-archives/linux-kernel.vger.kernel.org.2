Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E2F417087
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 12:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245688AbhIXK7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 06:59:20 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60412
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244324AbhIXK7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 06:59:16 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AC146402DE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 10:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632481061;
        bh=JVVwsOf7X0M/+qlOsF+1zUq32C7aF6kWbgyKr7RQdek=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=dhLOQ8V7F4wVe75i3PP2WCguFKDr6BjyNVv5ua9EHpsxQ1BlMFCYvRQd3O85uqBUA
         cnb6WqfLCe680LwJR2RFNeUhI1PFNGxQmKWiz3E07Rv4vYMqaNQbmS1BAE3dIKXFJR
         HbRUnLeDviteJ/Ce4NuJh6i9mGan0LOi+wn57RWVfgufBC8sRisGFCqAwn17/FrOyr
         YAv2pXqMWjqJQiXad8KOtHc9l+msV98PkaY9c2bTmS3WvA5iqOZe8bt/6CGdYjt6kr
         eAGxBuEA2tLvsMI216Cn8tt/q0svwZG5o0CDApg8AxRXb46Ps3sk//WrQHcoScIA2G
         CJMF7J18rY6CA==
Received: by mail-wr1-f71.google.com with SMTP id h5-20020a5d6885000000b0015e21e37523so7715242wru.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 03:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JVVwsOf7X0M/+qlOsF+1zUq32C7aF6kWbgyKr7RQdek=;
        b=bB/v8TdsZU+Tl1wjOoE/kelwmbVRYZLWSTinMtwAWJHvg5YvCxMujzwm9q72HkRUDy
         e/7Vonr1GF2oSxPfv6882zxdGJStWfhHcPFo8Z6/v7K8sC1cFLaz3d9An82nFGXc7Q3h
         mEocFQ7HQgwe4dEUU/P8oyAPzfWlqe7DT3GmVRcwChVtL/pEm+sEpkCVrHsLRlrczoSn
         tBNQuX3lsurbdZT9ardTrkJYnMBfjqn5GXqQ1kt+Nip7N5O3SZMvvQQiXYcDCBGttoER
         A5QGRCUTDfvpfyKGBTH2DLXUeX3O37RfBef0rpB0elTa5jRkQfYJhIfzp9sl4ynvp1FG
         s/iw==
X-Gm-Message-State: AOAM533NQstcBBVaKYjqDK37PNm1Y/BtgAb05SIep8ebjgaIEoPGXfer
        TWguNOsjUzEklBPFhcuD75It7H+BDJZ60i8fLUWMBhR/H1LL8lVCPzpp3ejBjSsHcUy5YmMHg+X
        DJ7Jcxwtq5d6TFHkdqk1gTcjfMF3psEDhgDLGUSHnBw==
X-Received: by 2002:a05:6000:1a85:: with SMTP id f5mr10982708wry.25.1632481061421;
        Fri, 24 Sep 2021 03:57:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLYvzxMc9tP9qdmx2NxdiK+8VdwTUT+JMDAWIj2fLS9fniGFXTFwHyxW2JGc/QJ7sNrnQG5A==
X-Received: by 2002:a05:6000:1a85:: with SMTP id f5mr10982699wry.25.1632481061305;
        Fri, 24 Sep 2021 03:57:41 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id x17sm8188836wrc.51.2021.09.24.03.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 03:57:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] powerpc/powermac: constify device_node in of_irq_parse_oldworld()
Date:   Fri, 24 Sep 2021 12:56:53 +0200
Message-Id: <20210924105653.46963-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210924105653.46963-1-krzysztof.kozlowski@canonical.com>
References: <20210924105653.46963-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_irq_parse_oldworld() does not modify passed device_node so make
it a pointer to const for safety.  Drop the extern while modifying the
line.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. Drop extern.
---
 arch/powerpc/platforms/powermac/pic.c | 2 +-
 include/linux/of_irq.h                | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 4921bccf0376..af5ca1f41bb1 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -384,7 +384,7 @@ static void __init pmac_pic_probe_oldstyle(void)
 #endif
 }
 
-int of_irq_parse_oldworld(struct device_node *device, int index,
+int of_irq_parse_oldworld(const struct device_node *device, int index,
 			struct of_phandle_args *out_irq)
 {
 	const u32 *ints = NULL;
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index aaf219bd0354..83fccd0c9bba 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -20,12 +20,12 @@ typedef int (*of_irq_init_cb_t)(struct device_node *, struct device_node *);
 #if defined(CONFIG_PPC32) && defined(CONFIG_PPC_PMAC)
 extern unsigned int of_irq_workarounds;
 extern struct device_node *of_irq_dflt_pic;
-extern int of_irq_parse_oldworld(struct device_node *device, int index,
-			       struct of_phandle_args *out_irq);
+int of_irq_parse_oldworld(const struct device_node *device, int index,
+			  struct of_phandle_args *out_irq);
 #else /* CONFIG_PPC32 && CONFIG_PPC_PMAC */
 #define of_irq_workarounds (0)
 #define of_irq_dflt_pic (NULL)
-static inline int of_irq_parse_oldworld(struct device_node *device, int index,
+static inline int of_irq_parse_oldworld(const struct device_node *device, int index,
 				      struct of_phandle_args *out_irq)
 {
 	return -EINVAL;
-- 
2.30.2

