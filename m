Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE51634E999
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhC3NtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbhC3Nsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:48:30 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40818C061574;
        Tue, 30 Mar 2021 06:48:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u9so24921741ejj.7;
        Tue, 30 Mar 2021 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8bDcTQk8kDiNTIshlRPvPaxQcZWXJmMzlWejJX8r1Mo=;
        b=d/gDycgct5/uXWJpP9Lz8c0FuUhiemM1bGchkyGTEIGEofIatjKhtC6b8ViBLhWQTO
         fyhJcW6OFOQLSGlY6TZ1d2qyW+/gKSM7YCzmR/uzjZxsacljZzIcaKyR2HYpgMlt9aVA
         MXqbT0GkHKvTQepXruSWGHGEgo9BZyvP/hqdOC5zaRK9Tk28C6//kNvkwo9m+aLra/Xt
         XQUbs7r/BEHia0UawVbZnPKnAWbJUlgoAE6IDW6+5mUh5M0q2UPEjgh1wJpskEbY4trp
         gdRC6hmnNjkr9zcYauecsCbZi6a07Rwpf2ThPV4NtN1jIExFZssNCRvhS7/cnyp/wcwK
         A/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8bDcTQk8kDiNTIshlRPvPaxQcZWXJmMzlWejJX8r1Mo=;
        b=GjMvGR37Fs5VnB3BCnl5FSssHtrKBhBwf0lyJ84dj6iKEHNieJ4xPrljVJ6v7tlm6f
         20Hgp4iN7+W6mk5+4R1AzzBTQekXUX49j47wwXNqn4wFg17OYQZgGKqdXtOpP7sQ5JaH
         skVKhdhTiC5jSHrwZB4ICTxtMXKC+HvkLM228JMCq5FuaUWysJ9h9dorgAk2tWM/PFSL
         xvby/dXGiP065wUaOtLSD1+s8kPgl5MvPBq9IXlKzM9JQl4boQZmKcpFGTv98tAH0v1J
         +qVb8OdVS87oWebiV5FunL8HtqFFAoZlOuVh2zSVr/i8ls6XdtL2DSMtRpbausgBu6z/
         iXdw==
X-Gm-Message-State: AOAM531HEUCC26ARYDBlvfNTsKHq3U4rgNTTZbB6tyXW0jmODOpuoCmp
        pUNjU0FEBbZTcBIor+IrxvXOvUnvQYw=
X-Google-Smtp-Source: ABdhPJyKwZ+JC7bBHbXUpv8bclhUGoHeaAQ9WYSiLzOblk1Ni24Vjx2yYXbmc0oNMp8a+ry1V8FpiQ==
X-Received: by 2002:a17:906:9515:: with SMTP id u21mr34055517ejx.86.1617112109016;
        Tue, 30 Mar 2021 06:48:29 -0700 (PDT)
Received: from localhost.localdomain ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id l12sm11114681edb.39.2021.03.30.06.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:48:28 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] arm: dts: owl-s500: Add reserved-memory range for Owl SoC serial number
Date:   Tue, 30 Mar 2021 16:48:19 +0300
Message-Id: <ae989198c92939716e46fa2753d614af3a906a0b.1617110420.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide access to the reserved memory region where the Actions Semi Owl
S500 SoC serial number can be read from.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index 739b4b9cec8c..e4c61a9c6e39 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -23,6 +23,17 @@ aliases {
 	chosen {
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		soc_serial: soc-serial@800 {
+			compatible = "actions,s500-soc-serial", "actions,owl-soc-serial";
+			reg = <0x800 0x8>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.31.1

