Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5693F0651
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbhHRORt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239972AbhHROOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:14:49 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881EBC061154
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:13:30 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t1so2375805pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pathpartnertech.com; s=google;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OFpHweS/JQ3nqb6EquukVDDOgXnX34E/VyawLNfBUGQ=;
        b=qIrjgaFUpOYCFS16Znu3m2ffDS9rT4371rnPKMR0z+4yAKGhi6HdGLD0+GQRFuBqBy
         2+COOXDZSTvyO5BoWPqaW+Ozv4cwXwz/ZstzlsgSOn0KWTQVFQIlbFRvB7mkCeQqDQxO
         F9uO5uqZ253MtIjYsl750rSDFVipfayu+8YzHxqjzJCopmrWGdtRk9vx6YM3lrqBgSFO
         ISdI4RsrovhDOkVneIDiS11SOBWAilSPdUu2efruxi9kSYoVhpXd3t6TyeKorTlxpwy+
         EfciVKQt53H6OIBk9Z18l3W1XWo/AZ6y1SU9iozJN0DTBzTFvYVXQi8pAcmyEz69SNi2
         JRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=OFpHweS/JQ3nqb6EquukVDDOgXnX34E/VyawLNfBUGQ=;
        b=rvfENfmxPPclwG8Ei9oATkW+1r6i/a6A9YvPjmZ14nxUcrEBD74T+7EwoO6NYWAcgh
         ujATwuvK3We0gBrDB52+CfFuvHslqDjHx1hgY0zndmAHwzcGAjysHitB1IWdtiLZJkJ7
         tVE4ZkEtBvOUsslgK66TJEH35TVDO00ON54GVtokMgtkfveinJUYh+tGE/upoTR++A0n
         Zt1ZqriUoXJ+nPNXaWOKKwXxgOZA9RdGtiVT/76J18UC+0uxNniXUVQzb6p2TJUpSxe+
         x12IDncuuYAbK08xL6bk63I2gnE91KomZa1oQn0b/GEmuu7Lo6QxqNWe+lJ+BqrPhf93
         3HNw==
MIME-Version: 1.0
X-Gm-Message-State: AOAM531Fz6dbTrXCh5ckF9g0lO0SuCye85tRrQwwFnu9YcsU73h6Y4sB
        qlI0NhmVxPZbF9AR2ullLYTgTw3joteggrxHX+Wp2T6ZbMWhnhTZvLHnJoJTJEo28YhMFLavPAa
        fRY1RwnJIWMYUzXtZ7Q2J0gLEtvKA
X-Google-Smtp-Source: ABdhPJzJFl0khqx5jqtp4TZDJFPqk5KxTnnqJXM3m1MLT0D7usuLVQ1pxYZhnGa0vAXluGhJBOCsow==
X-Received: by 2002:a05:6a00:1583:b0:3e2:2ae3:2ba8 with SMTP id u3-20020a056a00158300b003e22ae32ba8mr9534018pfk.58.1629296010096;
        Wed, 18 Aug 2021 07:13:30 -0700 (PDT)
Received: from localhost.localdomain ([49.207.214.181])
        by smtp.gmail.com with ESMTPSA id e8sm8084343pgg.31.2021.08.18.07.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 07:13:29 -0700 (PDT)
From:   sidraya.bj@pathpartnertech.com
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     prashanth.ka@pathpartnertech.com, praneeth@ti.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        praveen.ap@pathpartnertech.com,
        Sidraya <sidraya.bj@pathpartnertech.com>
Subject: [PATCH 29/30] arm64: dts: dra82: Add v4l2 vxd_dec device node
Date:   Wed, 18 Aug 2021 19:40:36 +0530
Message-Id: <20210818141037.19990-30-sidraya.bj@pathpartnertech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210818141037.19990-1-sidraya.bj@pathpartnertech.com>
References: <20210818141037.19990-1-sidraya.bj@pathpartnertech.com>
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sidraya <sidraya.bj@pathpartnertech.com>

Enable v4l2 vxd_dec on dra82

Signed-off-by: Angela Stegmaier <angelabaker@ti.com>
Signed-off-by: Sidraya <sidraya.bj@pathpartnertech.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index cf3482376c1e..a10eb7bcce74 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -1242,6 +1242,15 @@
 		power-domains = <&k3_pds 193 TI_SCI_PD_EXCLUSIVE>;
 	};
 
+	d5520: video-decoder@4300000 {
+	       /* IMG D5520 driver configuration */
+	       compatible = "img,d5500-vxd";
+	       reg = <0x00 0x04300000>,
+		     <0x00 0x100000>;
+	       power-domains = <&k3_pds 144 TI_SCI_PD_EXCLUSIVE>;
+	       interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	ufs_wrapper: ufs-wrapper@4e80000 {
 		compatible = "ti,j721e-ufs";
 		reg = <0x0 0x4e80000 0x0 0x100>;
-- 
2.17.1


-- 






This
message contains confidential information and is intended only 
for the
individual(s) named. If you are not the intended
recipient, you are 
notified that disclosing, copying, distributing or taking any
action in 
reliance on the contents of this mail and attached file/s is strictly
prohibited. Please notify the
sender immediately and delete this e-mail 
from your system. E-mail transmission
cannot be guaranteed to be secured or 
error-free as information could be
intercepted, corrupted, lost, destroyed, 
arrive late or incomplete, or contain
viruses. The sender therefore does 
not accept liability for any errors or
omissions in the contents of this 
message, which arise as a result of e-mail
transmission.
