Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377A43B9A95
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 03:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhGBBpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 21:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbhGBBpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 21:45:30 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C82C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 18:42:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id nd37so13614795ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 18:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YN8QMqY6nuPqSy+BeTIOgqLLYEAihS/aZ1GgCgQxQkQ=;
        b=Ru7hvdSR1G/gzTTJsUgdGfRUYeROFjnSSrjGQ0bXTIzciq0URxGBaKsl4Kj9zsTOo+
         KOzYtn6PcccY8ITw0lj7OlM0O8r9eCaImkoCuHI8jUv1TxMF8Xm38R1z7QaAns8X7o+1
         eBHC5R/alXUPU2W1fQ0Ij92NKhfaDjjgO58N/+XO/WmN8/1As7iKGmGgzP/Dv2OJYpXa
         O3hCAX+h4126C531rr8Eoie9uJU9dTFUwVv6JZ1yuhSN7cxj6rZxOQ6gqCR4LgnJ/C8K
         OROd3TAAsvKw+89nuklqG1vp+VBgzARcXwbunvTfktngShG4WWMK1RufoUFzwpqiCFAh
         9PqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YN8QMqY6nuPqSy+BeTIOgqLLYEAihS/aZ1GgCgQxQkQ=;
        b=C7tG0Vv0dNPRBJEN3PBsSdWTKN6YRGo82r58ByEY4p32ow8zdIUt0ZM+vh9M53XrpA
         Bs6/SZPvmsRo062xdbamBfEXAOH+JD89CcVLBo4etN6MFPFyo7A+4G0VQkO6Z2a3AnLx
         TRiV2wuJttHsCE5yGSXzDqm6u+Y49j/DxjsQPWVe53KqmTy3T450iySZz9yjCxAngXV9
         sKmJIAp+ThXx6Sfp4XR3ibuSwWkhGLnZadeaY1hPlHI4UgSBYxlyZiifPBRZ2m/CIzwr
         h5XUr36vZ+VuWbImiHTA8jCoXaNYapCZOlFynRq8ZDuSTgCHi+yxSqTxh3zgQW0xKKE1
         ViNg==
X-Gm-Message-State: AOAM530NZ8ISEEfbepWT/NrZsY1bp7qNMRpcu4El8zdDSJ9uAWVJXuyQ
        +ttGeojK8nNc6Wq0T4Cf2y0=
X-Google-Smtp-Source: ABdhPJw7Kk9hHdtZlK2Lm1G2lI85s6S0MYbgSAlnkV/0nDEg/EWFCLtBj2xtpyuDj+9QSEofjSMVTg==
X-Received: by 2002:a17:907:980c:: with SMTP id ji12mr2891038ejc.122.1625190178084;
        Thu, 01 Jul 2021 18:42:58 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (ec2-44-242-66-180.us-west-2.compute.amazonaws.com. [44.242.66.180])
        by smtp.gmail.com with ESMTPSA id j19sm629580edw.43.2021.07.01.18.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 18:42:57 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Bin Meng <bin.meng@windriver.com>
Subject: [PATCH 2/2] riscv: dts: microchip: Add ethernet0 to the aliases node
Date:   Fri,  2 Jul 2021 09:43:19 +0800
Message-Id: <20210702014319.1265766-2-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210702014319.1265766-1-bmeng.cn@gmail.com>
References: <20210702014319.1265766-1-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Meng <bin.meng@windriver.com>

U-Boot expects this alias to be in place in order to fix up the mac
address of the ethernet node.

Note on the Icicle Kit board, currently only emac1 is enabled so it
becomes the 'ethernet0'.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index a9c558366d61..16cc6573107b 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -9,6 +9,10 @@ / {
 	model = "Microchip MPFS Icicle Kit";
 	compatible = "microchip,mpfs-icicle-kit";
 
+	aliases {
+		ethernet0 = &emac1;
+	};
+
 	chosen {
 	};
 
-- 
2.25.1

