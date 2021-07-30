Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D85F3DBAD4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbhG3OmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:42:20 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:60976
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239198AbhG3OmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:42:18 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 04FC33F10B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 14:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627656133;
        bh=lpVZTJlpKGPodj4MHtc+rObtHPXyuiLkFrg5L18y8PI=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Um8cfwRwb4P7eWhWO7sYFJU1UF3AvYuziymLzZnEJH9xCvBXURp1bm8yzELOgGESC
         6ybjUD4sWcfWYXAZfeBF2+WwrXOITZ+c0AoI4mZX6IiFApe+K7EvcqTZDXcInNodxe
         oTj2UVEf7rTsYdxb38RJ+YSgroqATHC/qzZEErA4RYPLBtY8E5TBETKNTKB2uf+9nx
         f8nFQa/wjEiuX6ZzQ2lJmnQp739DSQNHFuAOOJ0s38+UMBSiz6oI3BVecVO9qry6gX
         1Skl22Ytejcsbm0xDdSFqzdqCLHtWmv+v5rnIsMwDHa32VW0SOA6HtMe5WkeMLK8HV
         XbgtE4W5hYgVg==
Received: by mail-ej1-f71.google.com with SMTP id ju25-20020a17090798b9b029058c24b55273so3205672ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lpVZTJlpKGPodj4MHtc+rObtHPXyuiLkFrg5L18y8PI=;
        b=KU5n0MWALmr8zF+OITa5roWt3kFBRL+1HVE9sSv6xwNjP96RnduMkCz3eIoRO4EhKX
         KlxrcnfSxZ/ldKVKfL4LKaQG5rtbp+S0wgJROMpK7XL2WICULuP6C+ta0lSrcNCHQgvs
         6auT/cffn9PLqovodTzAaFvnzuHf5K9k8Zr7wkt7Onlw+Co1h34oePYBwTfKhfF45ISl
         X8qCQ2U5zVllGP0nKEgQ4OWjiS3S84EBl7tLMpZnsxHmKelYVwF5ortbekjAvvEO98qE
         5Oc08klO5+dWTQLdfaOK3Hl1uBU9pb7U4+SKLBn9nJMJi9Pi2519SucMSblufVWpxj1I
         loGQ==
X-Gm-Message-State: AOAM533dxsg5rRLvVM8c9SmLwoELUK1CpSiWV8zfF6E3NJoMg3hPfnyL
        iYuA6ZXZoTszJkRJxbj0SPsFbHhgkvwkxfXgkFDltggAYEN9OoXhf7wAqqxUY6Opnk4TKAWdybC
        H1RvXp20wJnRHENaz6iWyQ4ahloJc93TKom1OgxAWkQ==
X-Received: by 2002:a05:6402:1c19:: with SMTP id ck25mr3395016edb.128.1627656132803;
        Fri, 30 Jul 2021 07:42:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEYNd2rGK8vmEVNFNmAp5fQBjwS6feWC8FOd6wG1bhDOFk//GYqhLi16ea5fwlunfc1R0zxw==
X-Received: by 2002:a05:6402:1c19:: with SMTP id ck25mr3395003edb.128.1627656132665;
        Fri, 30 Jul 2021 07:42:12 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id z8sm626325ejd.94.2021.07.30.07.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:42:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] nfc: mrvl: correct nfcmrvl_spi_parse_dt() device_node argument
Date:   Fri, 30 Jul 2021 16:41:56 +0200
Message-Id: <20210730144202.255890-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210730144202.255890-1-krzysztof.kozlowski@canonical.com>
References: <20210730144202.255890-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_node in nfcmrvl_spi_parse_dt() cannot be const as it is
passed to OF functions which modify it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/nfcmrvl/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/nfcmrvl/spi.c b/drivers/nfc/nfcmrvl/spi.c
index d64abd0c4df3..b182ab2e03c0 100644
--- a/drivers/nfc/nfcmrvl/spi.c
+++ b/drivers/nfc/nfcmrvl/spi.c
@@ -106,7 +106,7 @@ static const struct nfcmrvl_if_ops spi_ops = {
 	.nci_update_config = nfcmrvl_spi_nci_update_config,
 };
 
-static int nfcmrvl_spi_parse_dt(const struct device_node *node,
+static int nfcmrvl_spi_parse_dt(struct device_node *node,
 				struct nfcmrvl_platform_data *pdata)
 {
 	int ret;
-- 
2.27.0

