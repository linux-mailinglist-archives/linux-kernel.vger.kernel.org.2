Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70043A1367
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239637AbhFILul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:50:41 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:54981 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239652AbhFILtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:49:17 -0400
Received: by mail-wm1-f45.google.com with SMTP id o127so3805964wmo.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fh8Ijkb1J1EQRbMUlgIiVh7lHaVO6VD8BKhO7+YIbyY=;
        b=D/VNpJ3Luz2OD+p1JYllXDKuVZsLfQlJjEIoHdNrJKGh7AcbH+KHixYNJeuWORUqJy
         ulPePsO/kin9INWcNraTBSAf0IyO7tKfQMnQtCLaWTt8s6iF5AmihmJl8Dte1rDnGyEL
         HrdlLzdvk9hFz+WEMrBxnCQ6ieR+OITGstd8OdeISS0XrbAAq66RvZ3nlQwYDw0S6feA
         hdEgB7nAl+yNNOxz3UVjxvouSRl7UdguUroxoUMRN7Sc3/ZStvQgrSYlnlyTMBL/hinN
         cRpDF4tsidc5MoHTgbu01ByMW1RFnGa363MxpZOb0RKd9U2DGTYNzGG9XjFPk598Nt1L
         106g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fh8Ijkb1J1EQRbMUlgIiVh7lHaVO6VD8BKhO7+YIbyY=;
        b=TooZYaGQXtywxQwQgt8kfYnz6Bmc1vRtNv3dCSmVyV5reqIuyKsCwz6fHGmJhKCgqg
         f1DVip7v2ovEOjZaFs55u2KPqfr9M+5vNcORAlNw7ekkbG5Io80MfNOgTzpUYqiiRLsT
         +FrpuUXELjHsIZTEmZAnfQHMP2E4okbDWJS5/Xyn0ZMdS/Um3Z/0BqolqJ67m6krCq7L
         3MNEe9yh+ACoWbGkw9M0BF9n277omeY0NLQ1jYnrv3sXMZ64oskKlBwpesDysBVdp5Rw
         oUMorcKJhA2BQYPSWZ70P7ij8A6/h/M4hxdQVJLJpm0LKaeZA0P+nmoLuks9NQWFTCeB
         cWSw==
X-Gm-Message-State: AOAM5319Kw4EgGAVzxpCRi95AqwHblUsDMWc/6bMLuxnOAn2bfDbJA/J
        VBwpUVE9wIztICGgsEIsh8sJHv+EWqBgsK22
X-Google-Smtp-Source: ABdhPJycDus8GKbp8t7/Pd8ttcToS1P6blHP7sMp1XcpcIJ2J7Ay0cG4bN89bUuVpSkKiQHZbuDkDA==
X-Received: by 2002:a05:600c:2059:: with SMTP id p25mr26372912wmg.56.1623239167529;
        Wed, 09 Jun 2021 04:46:07 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id n12sm8065135wrw.83.2021.06.09.04.46.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:46:07 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 27/31] arm64: zynqmp: Add reset description for sata
Date:   Wed,  9 Jun 2021 13:45:03 +0200
Message-Id: <95ef94aafc4abb374900b4e97d99f95eb22c342e.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sata needs to get reset before configuration that's why add property for it
there.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index da54a2d35552..6f0fcec28ae2 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -673,6 +673,7 @@ sata: ahci@fd0c0000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 133 4>;
 			power-domains = <&zynqmp_firmware PD_SATA>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
 			#stream-id-cells = <4>;
 			iommus = <&smmu 0x4c0>, <&smmu 0x4c1>,
 				 <&smmu 0x4c2>, <&smmu 0x4c3>;
-- 
2.31.1

