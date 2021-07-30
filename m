Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E1A3DBADA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbhG3OmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:42:22 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:60992
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239262AbhG3OmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:42:20 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id C7CE03F10B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 14:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627656134;
        bh=TbQaBsPvgLCz2s8QzntY35xkR7Vmp0dFUIMeahF8LO0=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=CNeFH3vOjV4brfoqHjX2pf+QmrSaMsofYMDWz6YpRSkQUyIynlf+MGvlkCkAFsTn4
         o/OXqYiQarMNUaVq/CuV8yr5KZ38PlThVoEZTkL29bh7NV/r3vT7h3JZlleBc1lbrT
         BD6B7GiAu+JTpn/E6XuXyDQzp3eh1L4v6EkIw8Hu+SOw/2r5/jaDtfy0rP5RKPFTjo
         xSf0k4xiysdQp64q2B4VW9hA7bweRs0gI17h4bISYyo9nM40+ge0nzYfeiuzVOofID
         3w7bjSAEuzZhVgZY/wMLsl2kLfVIK/xgCUIurGFWdDjb4bGi67/OduIkBy5f79dPPi
         ADWS3CKeHZVzA==
Received: by mail-ed1-f72.google.com with SMTP id ay20-20020a0564022034b02903bc515b673dso4727163edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TbQaBsPvgLCz2s8QzntY35xkR7Vmp0dFUIMeahF8LO0=;
        b=tM2UosaUrKNyiqPvsq65aeDjG07vVJs5OIbCiT001VaqoC+c3O6oZJ67zevEem8/hn
         a/NKRW7viNWVNTNti+ouB52bH8E599mFgJRS2GFLMsPbiOLCBffushHma6t+/Ls94yl/
         jplhC+JEnQUAYfrOSlgjSfz5PcWhRM2vteEf3v7ZQZnfXwEYhEsIDxt0hxtChF8Fk74M
         ZOIZLPO+AIzIPI3U9iq1MloaBlBtzxgxBqTX/uFfd+mQjydfywx+tt9/tUd9FbwNyUjS
         FQH3JA5XGNcaisQZAE8KIM82Vdg+8exHSXn67lbfDBfcWkKNUNCifvVsO0qtv5KcAxoS
         O56Q==
X-Gm-Message-State: AOAM530iz8dlWYHm9ZKfd8FfKaZjF08eA2FpIHfZfyvdbIFvv2w0gk7E
        KcrnIBOd+5mvbQ2npIdkKKeDENhQH9fP2OrBtvyzf8/Bo56TvxDZl4Kumij/mOZSGpnVtci3fTg
        Xr+Sl/zBSjOq7NTl1CPDMp0eAk0Jc3wMdCTj6w0zl9g==
X-Received: by 2002:a17:906:86c4:: with SMTP id j4mr2848906ejy.431.1627656134597;
        Fri, 30 Jul 2021 07:42:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8Klnq9CtuMrsD3GihuUGntFuHCAKTpSOD1rOEbMDFczVq69hHakiLNzSMjrVWjMVMmOkKUQ==
X-Received: by 2002:a17:906:86c4:: with SMTP id j4mr2848887ejy.431.1627656134331;
        Fri, 30 Jul 2021 07:42:14 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id z8sm626325ejd.94.2021.07.30.07.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:42:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] nfc: annotate af_nfc_exit() as __exit
Date:   Fri, 30 Jul 2021 16:41:57 +0200
Message-Id: <20210730144202.255890-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210730144202.255890-1-krzysztof.kozlowski@canonical.com>
References: <20210730144202.255890-1-krzysztof.kozlowski@canonical.com>
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

