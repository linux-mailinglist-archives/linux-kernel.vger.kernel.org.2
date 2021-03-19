Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6BC3424AB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhCSS2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhCSS2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:28:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D9AC06174A;
        Fri, 19 Mar 2021 11:28:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id jy13so11231589ejc.2;
        Fri, 19 Mar 2021 11:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WbocOIYFKZ4s51qTLHlOis8DS7PgY5j879tJa2zPPWo=;
        b=HuT9ioPgW+mrCx4LICorFZeKwk5nnNLbNvHIFTwP5mnI2d+H9MX+MsxDPknGce0KGZ
         jiWyw07OaHcwdR8rMgv6mKUSYs0Ju+nUJ9xaZI6xmWU9t5TW4I0HyhYzAy1DIMEm6gIC
         Pjx7XqvpbA0VI2sRuGNKoJaYbzG88u9wiAS6Ls8ubDT0eODNb4poWAezuYBzCAiIVXCQ
         bATRqvdNWyyXF40CDxf+k06yoiI+ICVxEHsXnOosyxeDXfeIc5+VVzjDsVE5/97YGlEu
         m2W3sKlQZ2RpfiTXXB9shbN046f8EfSw6UmPwG13BOHv6sxzpsE+c8FH3ejxx+8GlVbp
         dh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WbocOIYFKZ4s51qTLHlOis8DS7PgY5j879tJa2zPPWo=;
        b=bJuUg4ztgfcwjZvBYINaFzSyHEgHIDL+AeUlAzJqyDO5U6AfFCygzs9njgRhlHQIg4
         GYesqq2e26VX+1ciHF//bbIHreBj269RWI6+D9eplb7Qc5WbwPwytk7OZGdMb5AaaDna
         AH3C2KQaXtWA75qDp+2cH7jPeUeF2XR+cntWNW8oF80mWmIT/bQzGvTL2FshgusjVkhk
         sNbSvFXvLd7YpLWk+eUBuiUDYcGmUrizToh3uuw4421w8Ph5RSoM4ZDHJhLDZsZ2JCm5
         GyoZxh6xRGMQPRLR1RbHuZDl8E20vHin20MAwl7yLoqh/YnOLZmQJVTfC7lP7OphKFKo
         iLXw==
X-Gm-Message-State: AOAM532zHuswmDtDkw1+olqLTiKxVYgn3H/wRT9t6q9/Gz0zJZqLL/+i
        XnuZXzQhUGHIOgZ1/xd1l9Q=
X-Google-Smtp-Source: ABdhPJzbjakCSA5i4Y+kAcoVeHb9tjXO4DiiCmwAE/6VREAEIkRlc1hHrj6imR4cgUipXbIiRizfgA==
X-Received: by 2002:a17:906:489:: with SMTP id f9mr5772812eja.428.1616178487869;
        Fri, 19 Mar 2021 11:28:07 -0700 (PDT)
Received: from localhost.localdomain ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id gb22sm3951070ejc.78.2021.03.19.11.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:28:07 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm: dts: owl-s500: Add socinfo support
Date:   Fri, 19 Mar 2021 20:28:01 +0200
Message-Id: <f0d9ba13324c7e64cafe634e40c18155ee0ff470.1616178258.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1616178258.git.cristian.ciocaltea@gmail.com>
References: <cover.1616178258.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update soc node compatible property to enable support for the Actions
Semi Owl soc info driver.

Additionally provide memory addresses where the serial number parts are
accessible.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index 739b4b9cec8c..07a165918de9 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -80,10 +80,12 @@ losc: losc {
 	};
 
 	soc {
-		compatible = "simple-bus";
+		compatible = "actions,s500-soc", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
+		actions,serial-number-addrs = <0x800>, /* S/N Low */
+					      <0x804>; /* S/N High */
 
 		scu: scu@b0020000 {
 			compatible = "arm,cortex-a9-scu";
-- 
2.31.0

