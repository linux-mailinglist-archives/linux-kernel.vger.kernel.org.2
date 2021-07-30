Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644E93DB416
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237899AbhG3G5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:57:13 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:55306
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237757AbhG3G5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:57:03 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id EE5FF3F0FF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627628218;
        bh=TbQaBsPvgLCz2s8QzntY35xkR7Vmp0dFUIMeahF8LO0=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Svzlvalp5fMFTvdz/7VJISPrg2Z/R2O7p6jsmk0wjz/+i/MSXqJIJzOTjPwD7qy76
         7GwWMgJo0VMEeYZW3V9pzwFhlNExq9MVLXHwNxhOzK5X368Fu67i4ochDVf8N9mtxr
         4E7vJOXbqLFMJ1+jMxsGdhs2aDO98J0hCckdwW7MbI5me9lGYZHwgPLvDj1WDQkaZB
         SsXmVcnP3wS411E4OcrSfCXP7hetphn5oEx0d7QiueN2RNZYw9KJWTl0qj55qOm1Ee
         89vuVkQZMEdZ+3f0FZ/Gl5ID5E4Py8/38/v1sxYfFkLkeNfnrRkt2wmsW5U2Yj80JV
         zTErH6E0++Qsw==
Received: by mail-ej1-f72.google.com with SMTP id kq12-20020a170906abccb0290591922761bdso1483908ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 23:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TbQaBsPvgLCz2s8QzntY35xkR7Vmp0dFUIMeahF8LO0=;
        b=ot5yIYbQn39afeBK5RfjVBBpmm12UNJBfIgtEzfWUzLoKCEHVggr2iUeD0vXtSnB8G
         Y2FBmUffWR/PTrV49kuTzlRp29CYrJTf6+ZNk79i2IbT+Es+/Jw+QZ+2RJjTMsrrZlcp
         iR18831Oom9qSc79sopfg6Mr/nywEkbUG6tHTxPpVRa6MSaGJbNFwBXQGU5Pxdh9Judt
         qxZcj1T1JRZ8umnVjnezs99BHjmRBtDjSZ87Yh027qHKoInX8f5mAhLukUmNwCDVEWqb
         Ut8O0+bxhq5qgy7Ol4b0e5e9NykCqG3ldb83Ti+ggmPr+lzAvJKkcJXr4WOs16Wto4uj
         ZcYA==
X-Gm-Message-State: AOAM533orppR/TebH0X2VMy9bTUHs8mFb3n/7Ggi51SYQkThminVOOr6
        YPdLhlYmcAaOkgfYqPHnN8n2BKVYmJJVuxoNHGkrb8JNeOAe9PepZlcs8Rw7YyuVyZ8sHU+QAYb
        g0H7HnXo9g7QIqdM562Uw6PX7FB1IzpZkXVubAjVJsw==
X-Received: by 2002:a17:906:64a:: with SMTP id t10mr1154569ejb.5.1627628218759;
        Thu, 29 Jul 2021 23:56:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwI5Moy+lzXah0p5kqppWeDxC9Ku21TZrEo9wjHh0ArN5Ek2tQ+rZnuddmWcBRskAlMTzDs9Q==
X-Received: by 2002:a17:906:64a:: with SMTP id t10mr1154557ejb.5.1627628218647;
        Thu, 29 Jul 2021 23:56:58 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id m9sm238518ejn.91.2021.07.29.23.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 23:56:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] nfc: annotate af_nfc_exit() as __exit
Date:   Fri, 30 Jul 2021 08:56:19 +0200
Message-Id: <20210730065625.34010-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210730065625.34010-1-krzysztof.kozlowski@canonical.com>
References: <20210730065625.34010-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The af_nfc_exit() is used only in other __exit annotated context
(nfc_exit()).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 net/nfc/af_nfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/nfc/af_nfc.c b/net/nfc/af_nfc.c
index 4a9e72073564..6024fad905ff 100644
--- a/net/nfc/af_nfc.c
+++ b/net/nfc/af_nfc.c
@@ -79,7 +79,7 @@ int __init af_nfc_init(void)
 	return sock_register(&nfc_sock_family_ops);
 }
 
-void af_nfc_exit(void)
+void __exit af_nfc_exit(void)
 {
 	sock_unregister(PF_NFC);
 }
-- 
2.27.0

