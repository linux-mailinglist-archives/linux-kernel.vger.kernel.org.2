Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A9134E99A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhC3NtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbhC3Nsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:48:31 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66727C061574;
        Tue, 30 Mar 2021 06:48:31 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l4so24923781ejc.10;
        Tue, 30 Mar 2021 06:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LdL5XlxYWxpDfNRxdalRm8+rcDf8yZwWqVC79NXR8GY=;
        b=G/YsmB23LwlRUN3lSxBjOUdw7qUhNnE8+HOpLduAJRqkqfJgfEKbhNDxCAGEtkc/MH
         yKqr09pltvnwLuFAf+y4UPuebhVKIuKTThb42aEfsjjTNupHP+xh9pJh/jAcL5kUytuM
         kDa+NQ4tpr34fASwPU1BN3UgAHUGJjYgdVYBrW+uQzLWN5ZZArMm6fVYtGW0aM+OvlE6
         B6dEYY2T7Am9/YHKHksvOKJZGWRfWXU8s1iCjLq524/cXhLknVsCqsfBkI2+UZ7Qyoac
         DcWLBGpZ4kJjJPPyn5Gwm0S6poj2Um9Lm6Co6THkI/w7Bv8hT56jhK+B4YBe4vod0vC8
         RDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LdL5XlxYWxpDfNRxdalRm8+rcDf8yZwWqVC79NXR8GY=;
        b=dksOwYPu5+42jsSsyaNPI7Hg/t8lnl1UD/c7HsDiD4F7FSJZ4CVwrK4cG11YnDzTJc
         STTFzytzj3w2LRxZ69KTy3A87D3JyQpBSFgjJL4NpQHAhsmIOBl5Ou/0sSRlpLQrfh9n
         BCz3jPqRGQuSQu815m9CAwp4LbSwXdNGUEXeXGXN24YVMgKLT1sPY/9wmZKFuAF63Ay9
         DND62GSMr5e9qLZhidBZZSjenWA+LmDj8U1UeCY9t3QscY7m2b4P4gP2u99Hi4YzJQF8
         hlTgZ6OmWGG+G7PTrSSj6YY9Gga1bhHYWAq8EsqLkzwHpbLMkmEyV77NmBaw2VfSFvDU
         nxWA==
X-Gm-Message-State: AOAM5310nNZja0DatW0jQPxYfNKm8lS5kkLDmbk9j2nQYIwlKYejgadj
        I3N+abRjmXx+0SMqGqfw7EE=
X-Google-Smtp-Source: ABdhPJzVwuy0uYusPIuWycdOep3TxQo16xZ57nyawnMVLZH6CoFPs465a/8+CMEue/J5Wz8oe4yFvQ==
X-Received: by 2002:a17:906:4dce:: with SMTP id f14mr32781924ejw.349.1617112110171;
        Tue, 30 Mar 2021 06:48:30 -0700 (PDT)
Received: from localhost.localdomain ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id l12sm11114681edb.39.2021.03.30.06.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:48:29 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] arm: dts: owl-s500: Add socinfo support
Date:   Tue, 30 Mar 2021 16:48:20 +0300
Message-Id: <10538a2155313a6f7a848e42021aacfa9bdf5cdb.1617110420.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update soc node compatible property to enable support for the Actions
Semi Owl soc info driver.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index e4c61a9c6e39..a8eb276e5ac1 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -91,7 +91,7 @@ losc: losc {
 	};
 
 	soc {
-		compatible = "simple-bus";
+		compatible = "actions,s500-soc", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
-- 
2.31.1

