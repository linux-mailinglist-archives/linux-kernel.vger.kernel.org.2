Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E1C39777A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhFAQH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:07:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49035 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFAQH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:07:56 -0400
Received: from mail-ej1-f69.google.com ([209.85.218.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lo6uD-0006de-MN
        for linux-kernel@vger.kernel.org; Tue, 01 Jun 2021 16:06:13 +0000
Received: by mail-ej1-f69.google.com with SMTP id am5-20020a1709065685b02903eef334e563so1890574ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 09:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6tK28DHlF433gC7eHpjC7ln+09qz6YWy16G/aZ1ahb8=;
        b=raXxyu6aOvTEK3F1fGw1EIQ650BMzOt5EbihY22gHRCfUP3/NgmCeyMhVwSfJQlNZw
         WkLurNbINi5caMSq4JO+v1E0ksCXrwEKlG4+LQ471C/q5qiSscIsO8oU4/k/mkqpK3TX
         wmka16U9U/reYiB2Z8uMKr0btsRDEd9KAAGmwGTHX3cCDaqdhOfotQNA6FyXg1Ion+Og
         HajpWUvN4v9yImxJWJD8/AnCzCVwGzPKciFgBSW1rgwTSJOW96pr8ZyC8byC/P/Oc0Zx
         Z/T9I/7uD1jnDMYRUxjgihGn51ItQPRVCeNmiPzojlYfz+fe9FD2JaEUgHEgPeFB7oca
         7zyQ==
X-Gm-Message-State: AOAM532RIlnjcQ8p/S6TYukbSF72AhdDMln+lAjoF+PJp6CyvuZ+BnBx
        ehNxmtdTuxBnyad6pV0OVCNqixHXxp6rZeF23u5LEwU3r6oAGe9rguK9ZSCkvC9eaIyLdetD/0c
        KxhwM4oWn3mhaRyS9bpMcUCVFI2j5zHAiBznBRwxCoQ==
X-Received: by 2002:aa7:d4c2:: with SMTP id t2mr16718933edr.144.1622563573394;
        Tue, 01 Jun 2021 09:06:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ+6AZRRvS/8V0pcanphbq9o92308JzlvEVmeRaJiTUTCi57rBEw7yiXQpvaXfZ7a2ZJqWog==
X-Received: by 2002:aa7:d4c2:: with SMTP id t2mr16718916edr.144.1622563573204;
        Tue, 01 Jun 2021 09:06:13 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id n15sm1523708eds.28.2021.06.01.09.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 09:06:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] memory: renesas-rpc-if: correct whitespace
Date:   Tue,  1 Jun 2021 18:06:07 +0200
Message-Id: <20210601160608.312446-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use spaces instead of tabs as word separator.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 include/memory/renesas-rpc-if.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/memory/renesas-rpc-if.h b/include/memory/renesas-rpc-if.h
index 14cfd036268a..e3e770f76f34 100644
--- a/include/memory/renesas-rpc-if.h
+++ b/include/memory/renesas-rpc-if.h
@@ -19,7 +19,7 @@ enum rpcif_data_dir {
 	RPCIF_DATA_OUT,
 };
 
-struct	rpcif_op {
+struct rpcif_op {
 	struct {
 		u8 buswidth;
 		u8 opcode;
@@ -57,7 +57,7 @@ struct	rpcif_op {
 	} data;
 };
 
-struct	rpcif {
+struct rpcif {
 	struct device *dev;
 	void __iomem *dirmap;
 	struct regmap *regmap;
@@ -76,7 +76,7 @@ struct	rpcif {
 	u32 ddr;		/* DRDRENR or SMDRENR */
 };
 
-int  rpcif_sw_init(struct rpcif *rpc, struct device *dev);
+int rpcif_sw_init(struct rpcif *rpc, struct device *dev);
 void rpcif_hw_init(struct rpcif *rpc, bool hyperflash);
 void rpcif_prepare(struct rpcif *rpc, const struct rpcif_op *op, u64 *offs,
 		   size_t *len);
-- 
2.27.0

