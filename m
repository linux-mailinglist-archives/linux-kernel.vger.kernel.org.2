Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41A941152E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238795AbhITNEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:04:25 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37494
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239152AbhITNEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:04:23 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B9EC640261
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632142975;
        bh=j2CmHETEfQosnB82At+fI6P+jueRuH10iqGIAMLDsaM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=a/XsqKISwnWuOZddIhwBuGGvUE0Y1HzYT/qgunsgIVBpcBVWt/kefgBOtpsAbW3le
         1Ow+Vk7OFa11Dqh2uYJKf079nCFsHBFA5h6vK2VyyZdEHnlnLkztmtnvaUyeQE0kBk
         +SKXVPzaAWlLpmg4u8pMF2Z3mMWj2jrAICPAqz/MMSFxb7wOub3IptAIg4sx2DftZd
         VAVE2VqjpzW4JPF4aivCI2ub/Lr7nXL6GxbjCumj7YC4DLeP16Oz+bhuFX60qmeuM6
         LHPd85CGY5CNeNpx5CKGz7G5/RpzpRRmu9UNV1+9nxZeXkZBOxjZSccuE3GbqIY3lh
         NHmncnI+w1i6Q==
Received: by mail-wr1-f69.google.com with SMTP id c15-20020a5d4ccf000000b0015dff622f39so6002472wrt.21
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j2CmHETEfQosnB82At+fI6P+jueRuH10iqGIAMLDsaM=;
        b=LRA1vPYserHupP3yT7oFmVNa+Ig62NSJqA931/TIENgGoBXew5UPeDnDMJ3uNp4wYB
         dxux0FwvGx2SVW1K4xi2o5oyfMSihpEef6j9YIyu60dGRU0TBnzB0eDAViGpa8o3ZKH0
         HZy1jdi/EdDeIOf6V0QmO8SgBQl049uYUtSoQU1QXK6YTf9xaCybvNzwhCQLpineJxDk
         n99Q1Oez+6VW6beSCYyYBAQvia8doCN4KlUWocSDqhNNqyI1LZ+pfIAOFP54yg1gCfdH
         K//AsK27uCuGfN1cn7I1mGWWj798++knOjLLZgbH3zOwzShFpQzRX+gLOmgjwbNJxaBG
         57iQ==
X-Gm-Message-State: AOAM531NLe5Vh9tEJb6PKvRc2k9vMAMtqAm2GS0lTQf0qCPrKmPhyWVi
        +QAe4c3yw4liEkIBdDkKuvx6MUlXdv4R2JD1/BaFbkhK05IqeypRM7FyF8uHRV25p4xYdElPTr6
        eBCJvjLTStIIkVvV0icYdH8aryg/Z4hmzJNgeW1OW4w==
X-Received: by 2002:adf:e404:: with SMTP id g4mr28306943wrm.143.1632142975479;
        Mon, 20 Sep 2021 06:02:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiTYrdDxqiub2KOyQQ42IZNZvciO4cl4vo+1KIELCKpL+m93BjlF0l1Kc9M07XcebqlLriAQ==
X-Received: by 2002:adf:e404:: with SMTP id g4mr28306924wrm.143.1632142975272;
        Mon, 20 Sep 2021 06:02:55 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id g22sm18015331wmp.39.2021.09.20.06.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 06:02:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 2/5] riscv: dts: sifive: fix Unleashed board compatible
Date:   Mon, 20 Sep 2021 15:02:45 +0200
Message-Id: <20210920130248.145058-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920130248.145058-1-krzysztof.kozlowski@canonical.com>
References: <20210920130248.145058-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing sifive,fu540 compatible to fix dtbs_check warnings:

  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml: /: compatible: 'oneOf' conditional failed, one must be fixed:
  ['sifive,hifive-unleashed-a00', 'sifive,fu540-c000'] is too short
  'sifive,hifive-unleashed-a00' is not one of ['sifive,hifive-unmatched-a00']
  'sifive,fu740-c000' was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. None
---
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 633b31b6e25c..2b4af7b4cc2f 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -11,7 +11,8 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 	model = "SiFive HiFive Unleashed A00";
-	compatible = "sifive,hifive-unleashed-a00", "sifive,fu540-c000";
+	compatible = "sifive,hifive-unleashed-a00", "sifive,fu540-c000",
+		     "sifive,fu540";
 
 	chosen {
 		stdout-path = "serial0";
-- 
2.30.2

