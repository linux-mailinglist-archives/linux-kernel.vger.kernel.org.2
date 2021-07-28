Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3AE3D8DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 14:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhG1M0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 08:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbhG1M0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:26:21 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F6DC061757;
        Wed, 28 Jul 2021 05:26:19 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id w10so1172330qtj.3;
        Wed, 28 Jul 2021 05:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cqVElBTymsj42U9y84VWCRYbnR5OUCvocbx2B46HwA4=;
        b=lfHZWifbnkRx73BjJ2DdNFoh76LTI/lR/JlGRqXWxJb8VDd5lGQmojCJBJ0S2JOHQA
         DUrgcauL4hNPhsLLPxolrKmT3lZ2aVwln3R6WyPmgqw3ADU2hx6Ie0q1F8vjs47yUUIx
         U6erLvl4z6Wc/te6l/4qlmIkyN7Hn9T26/D6XnHbwHTItUxU5wdQX9cVtf7YVBGGy0WI
         DkXEdn2ucXcIEAVN/POOmw2ylW8NEiqKfjboJwmFtpSBjhf2cHF+hmz8ijGA9fM2Ckrb
         lKB+if/AzXsndXcz9hWPyi95hUu6AkT0VA0gP9gaHifrZhz+mErtN5m81PTSDmk011uw
         W4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqVElBTymsj42U9y84VWCRYbnR5OUCvocbx2B46HwA4=;
        b=IiGPI4wFlgId/miFMcG4/w99r5JnxFeXi0/AEPYlUqkrQCIgIoahzIpPNbYmfCZT2s
         T6pMgaPgRmpWVPumBxVLiLkFrf4C5pLZifM8CiLkY0DuicvhRbpIR0k31AllgNF8FO+n
         tDYeR+6uW0WXoqa6TJG1cnULcE6OUBqXvDu7hpx7Wz63iFVsfH5M+dup8RsVeRMltv1I
         gvhtYmFQDokjSG4yauEKKHRPtRrFaj9j0oRZHvjJ+6K9u70HxoRhOiXVNv8GvjkLCpTD
         M+esUqxvZjU+7cK1COyY9qzMzICvZE41gx2ppLrNegp44h3iiq/FpWmv39FoWPgLWZHs
         ugkA==
X-Gm-Message-State: AOAM532FgcU4b3PTQSOaX4mGDmbsW7uHLC3RhSFwUdNNUmgR2GCaPyK+
        Acc10idilpHJsyVnheE6yM4=
X-Google-Smtp-Source: ABdhPJxg8GxOcLAwV95w2hX1hG2TcoDsu76sI3iNr3XLbBM4hoL0FeYRELgeOO/MKNl97IqbmxiNgg==
X-Received: by 2002:a05:622a:50:: with SMTP id y16mr24452703qtw.322.1627475178609;
        Wed, 28 Jul 2021 05:26:18 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:b58:2ae8:d75f:660a])
        by smtp.gmail.com with ESMTPSA id z9sm2842972qtn.54.2021.07.28.05.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 05:26:18 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Peter Geis <pgwipeout@gmail.com>
Subject: [RFC PATCH 1/9] dt-bindings: soc: rockchip: add rk3568-usb2phy-grf
Date:   Wed, 28 Jul 2021 08:25:58 -0400
Message-Id: <20210728122606.697619-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728122606.697619-1-pgwipeout@gmail.com>
References: <20210728122606.697619-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the documentation for the rk3568-usb2phy-grf node, which is separate
from the usb2phy node on this chip.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index fa010df51a5c..3b0e06b6ea61 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -16,6 +16,7 @@ properties:
           - enum:
               - rockchip,rk3288-sgrf
               - rockchip,rv1108-usbgrf
+              - rockchip,rk3568-usb2phy-grf
           - const: syscon
       - items:
           - enum:
-- 
2.25.1

