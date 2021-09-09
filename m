Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013CC405905
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346163AbhIIO3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344325AbhIIO3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:29:35 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63DEC014D56;
        Thu,  9 Sep 2021 06:16:27 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y6so2959004lje.2;
        Thu, 09 Sep 2021 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0CDO+tNDKR7sAS9E0dGNVhCsigTKCV2xMySlatffqaM=;
        b=KFmFzX85xkkXJWCuj3RMXSrO8cwW6IYyEktcfF672pWiA5Zc4VCmmYr0vvafjoJBFe
         syvkIikNKLmFTmHWzY5PZXQurs7kV9NfFuLLkwr89nk3csP6PkZILkopZVK8RfRsXQ32
         OA0S63l2F/Dp7gVPQpRkUhWrMEPPC1/CHtOCmOfnLEZSVevJr3iDoslq14CJGO/oSCPn
         LToPo6wDP59IpcUPjUx29c/RDTVa6V6gXCAetyycXOFYuOVCrank1K+xlFRStbdBDtn+
         HyAAvVdfWJ/v3qXLiGqna5WrcHP1OHprVGiOJk4dOKQC+vT/Y+2NjFo1CTJ+gcRZf/oX
         lQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0CDO+tNDKR7sAS9E0dGNVhCsigTKCV2xMySlatffqaM=;
        b=XGCoySQsWLMdpsUDfC/boH+7H6pCvrXsDbslw3+POifz6D0Kmo9TRbjuQVkzNjYqfX
         +KrCeyRjVDPBZJ47eOCd/PStogMZP1Nux6S6OpsrX2Mv1CQemYFeHSZpCVn4ZmvppVP0
         Q8v6C/r4PKHHa1A5NhrghnwJ9Dm2yFWhZy7wRfbROMf+xAVgdAbOfUZnWYv6Kwr9QhmO
         IEbbCX/YXZLl0ulW5+4iUKtox23R4fXxwfnzUZTBz6hI2EOdwceh47eSrrINTk12Y7sD
         FueruuLCsNfcOYC/FuXjj0r6GBj0xKlnwlrpf04qga+WS/0+B+p5EI5FTSkOvuq2yMT8
         9yuQ==
X-Gm-Message-State: AOAM531ie/yKzHNNMpp+nSXwNQTl6fNGu7yLKftbeik+OYgWVR5X6rc/
        IU1bvI/oQ9UvNEbTWaBmm6s=
X-Google-Smtp-Source: ABdhPJyoKYKHyicTn1KjyPbjopD1FldRscDaiSzCwaDkeHsqC7bzAvGyGYwQbNQkf9/a6Oac55Cl0Q==
X-Received: by 2002:a2e:91d0:: with SMTP id u16mr2238411ljg.324.1631193386103;
        Thu, 09 Sep 2021 06:16:26 -0700 (PDT)
Received: from PC10319.67 ([82.97.198.254])
        by smtp.googlemail.com with ESMTPSA id p5sm197745lfu.272.2021.09.09.06.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 06:16:25 -0700 (PDT)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     supreeth.venkatesh@amd.com, aladyshev22@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: aspeed: amd-ethanolx: Add FRU EEPROM
Date:   Thu,  9 Sep 2021 16:20:48 +0300
Message-Id: <20210909132053.3919-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD EthanolX CRB uses 24LC128 EEPROM chip to store its FRU information.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index 79d17841b3d7..6406a0f080ee 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -159,6 +159,11 @@ &i2c2 {
 //24LC128 EEPROM
 &i2c3 {
 	status = "okay";
+	eeprom@50 {
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+		pagesize = <64>;
+	};
 };
 
 //P0 Power regulators
-- 
2.25.1

