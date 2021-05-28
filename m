Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9B03944B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 16:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbhE1O7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 10:59:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47227 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbhE1O6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 10:58:43 -0400
Received: from mail-ua1-f69.google.com ([209.85.222.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmdv9-0004Kg-FM
        for linux-kernel@vger.kernel.org; Fri, 28 May 2021 14:57:07 +0000
Received: by mail-ua1-f69.google.com with SMTP id f15-20020a9f2bcf0000b02901f8fe91b89cso2064838uaj.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 07:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=edJlbbhDO28RmalfYtPxF+agVQnBc9uKOzw55MZRkiU=;
        b=K5ppLkeecU0OZTHCLV0b00opErKtJtnHBUXV+qC2l4l7Nt68KQhRQkPN4Jehc4v3Zf
         SU/BDV6euL3KgrQIhpeKFvlDkyvCs9rl7BbAepo/nrLqiljuSGv3VVkYAeWGJnYo30oA
         EwWSdLpSjHPK29D+SJtJFZs1Kc7dOyZWBG5u2ZQS91hOO5aVTlbUYx+pDhSf2+f+8ej/
         R1hMNSvld/oZrvsK+NBHPedvhDNTl14AvkkRUEfdeIZStAl3ZFbzyfd5hKWg0xhjfJ8y
         qctOP5IDUV6hxVcXUUy/yLwa5g34yb7LN3G6BXPCldAtk+k1TqnZ9z+YqZ+w1BkA2BC2
         yQlQ==
X-Gm-Message-State: AOAM532PIFVVIDwcBLZ7u6oY+YAyhSZybzfop/oyIa/EQUvQgiSsDe+s
        7ml9dWeCnDWyTKBr7nEaOnsGhxezlddxcBaEnDzilp+Rd9ukm0pHE3r07TxbPP7Haz2MpLlPxqo
        XLoEbp40a4DBmDonfFckdtSUlouCfFZ/Q6uNCzfpyGg==
X-Received: by 2002:ab0:3482:: with SMTP id c2mr3488393uar.122.1622213826610;
        Fri, 28 May 2021 07:57:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylmdPw48e3WnJvVm8n1XmFKbfo4OOP5M8lb+ZI/nv+T5y9BFhzf21srOlHkwLrsW2LDgEx3w==
X-Received: by 2002:ab0:3482:: with SMTP id c2mr3488375uar.122.1622213826492;
        Fri, 28 May 2021 07:57:06 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id 64sm330505uay.11.2021.05.28.07.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 07:57:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 11/11] nfc: st95hf: fix indentation to tabs
Date:   Fri, 28 May 2021 10:56:51 -0400
Message-Id: <20210528145651.125648-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528145330.125055-1-krzysztof.kozlowski@canonical.com>
References: <20210528145330.125055-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use tabs to indent instead of spaces. No functional change.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/st95hf/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index 0d99181b6ce3..2dc788c363fd 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -1057,8 +1057,8 @@ static const struct spi_device_id st95hf_id[] = {
 MODULE_DEVICE_TABLE(spi, st95hf_id);
 
 static const struct of_device_id st95hf_spi_of_match[] __maybe_unused = {
-        { .compatible = "st,st95hf" },
-        { },
+	{ .compatible = "st,st95hf" },
+	{},
 };
 MODULE_DEVICE_TABLE(of, st95hf_spi_of_match);
 
-- 
2.27.0

