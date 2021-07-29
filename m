Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25F83DA138
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 12:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbhG2Kkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 06:40:41 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:47704
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235755AbhG2Kki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 06:40:38 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 4E0413F238
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627555235;
        bh=2+MASfDeMXItUy0KRRU6qIh2N4zib4Lrz4DxPbXJr60=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=A8W42v4KoNY2p8NkFhp0mtMxil1RQC4pu9cte5lTrt1XD0539BEgQB7PK6aN6ZYP6
         uKH8w+ZyweDyj5M0Wz1AUqw8IX+K1BzCHq/7c4ze53HhMYT9RsFxw9PhD5FpXzdMbI
         FEQUyRRrCvYY2fBUtUsebDMlFPly9E7A/WFVUZSrgmrm/It0TKIg95gRzdkdgAy2+e
         ThACAkGKQCGNhA1TuHUlZvOmM30cYPz/Tj97HxxLkuK2q79DuGYTg74wdFS+Lz+etD
         S9yfErz6RP/RmowefzlgXKlnIgtpVqjW9Z3AVnkzUAYQ+VNLOHqFzwq2Noyapq9aX5
         IsuZ4qUNPbY4g==
Received: by mail-ej1-f72.google.com with SMTP id ci25-20020a1709072679b029058e79f6c38aso1518586ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 03:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+MASfDeMXItUy0KRRU6qIh2N4zib4Lrz4DxPbXJr60=;
        b=dfP2qi+bY3kZ20hXcRHiJsHz8YbXFhcwZpadqMS1SxU2QbQCbpU+wFEEM7hD4dus+w
         WKcJVp3vlzao6ux9kgKQpl9mRmSlHO+zyMnBZf4SAr5e33+jteEsQzKvP8rvCznNqBqa
         dZa1r2hrIc91cnMrjl6/RC2EMbyHtvyl7K48HzyYUUNNOKyWEEn4P4rUaXdsFRz1hh/Q
         LALB7KuFKSHuMImeDEM1MWApb/W3pXDZADjbgYOSBX328AbU1bgqRiXa1j27ojuaA5RX
         ONEQpgJLmI298LJtguSYRjrqkPpDGfaBibrDPSOIUN3vSbXdoMb9OYqFkT37V3FvL2/2
         kQAg==
X-Gm-Message-State: AOAM530TBx6mRpJkqBb00sROLvSvc8AknGxH3kxDctZrybaIMkr/j5Sz
        RK+YAr7BIz3uuNx2axH9+guTlDGKFV9tkVHLHo8Uyu5Xy0SPyhYxacrWnuNuBp+n8Q/b/UCIx7+
        NYAgTOhtxQzJ0q1rnzQuzrk52mfShXTJdh57HGfeSDQ==
X-Received: by 2002:a05:6402:b83:: with SMTP id cf3mr5240271edb.12.1627555235093;
        Thu, 29 Jul 2021 03:40:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwJDOdp8Ic5sbEoP+ybcJEGMi8R0A1BITHI63lRz6KY4s1GLDvMBVi9ewCQtp/6p2bmUkfPA==
X-Received: by 2002:a05:6402:b83:: with SMTP id cf3mr5240255edb.12.1627555234989;
        Thu, 29 Jul 2021 03:40:34 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id c14sm824475ejb.78.2021.07.29.03.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 03:40:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 01/12] nfc: constify passed nfc_dev
Date:   Thu, 29 Jul 2021 12:40:11 +0200
Message-Id: <20210729104022.47761-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
References: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct nfc_dev is not modified by nfc_get_drvdata() and
nfc_device_name() so it can be made a const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 include/net/nfc/nfc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/nfc/nfc.h b/include/net/nfc/nfc.h
index c9ff341d57e4..5dee575fbe86 100644
--- a/include/net/nfc/nfc.h
+++ b/include/net/nfc/nfc.h
@@ -245,7 +245,7 @@ static inline void nfc_set_drvdata(struct nfc_dev *dev, void *data)
  *
  * @dev: The nfc device
  */
-static inline void *nfc_get_drvdata(struct nfc_dev *dev)
+static inline void *nfc_get_drvdata(const struct nfc_dev *dev)
 {
 	return dev_get_drvdata(&dev->dev);
 }
@@ -255,7 +255,7 @@ static inline void *nfc_get_drvdata(struct nfc_dev *dev)
  *
  * @dev: The nfc device whose name to return
  */
-static inline const char *nfc_device_name(struct nfc_dev *dev)
+static inline const char *nfc_device_name(const struct nfc_dev *dev)
 {
 	return dev_name(&dev->dev);
 }
-- 
2.27.0

