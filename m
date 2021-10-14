Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C07742D648
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 11:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhJNJn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 05:43:28 -0400
Received: from mo-csw-fb1115.securemx.jp ([210.130.202.174]:51388 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhJNJn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 05:43:27 -0400
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1115) id 19E9WXxZ007612; Thu, 14 Oct 2021 18:32:34 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 19E9WNMO020167; Thu, 14 Oct 2021 18:32:23 +0900
X-Iguazu-Qid: 2wGrZzhrw7YZz77Y4h
X-Iguazu-QSIG: v=2; s=0; t=1634203942; q=2wGrZzhrw7YZz77Y4h; m=pbtOhYC+vB3c7EwQspa4nOAhmlBbj1HcnwfZKZOfN6I=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1111) id 19E9WMZO013690
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Oct 2021 18:32:22 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 3863610013B;
        Thu, 14 Oct 2021 18:32:22 +0900 (JST)
Received: from enc02.toshiba.co.jp (localhost.localdomain [127.0.0.1])
        by enc02.toshiba.co.jp  with ESMTP id 19E9WLOb007776;
        Thu, 14 Oct 2021 18:32:21 +0900
Received: from enc02.toshiba.co.jp.mid_26071069 (localhost.localdomain [127.0.0.1])
        by enc02.toshiba.co.jp  with ESMTP id 19E9RKW3004268;
        Thu, 14 Oct 2021 18:27:20 +0900
X-SA-MID: 26071069
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>, nobuhiro1.iwamatsu@toshiba.co.jp
Cc:     punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: arm: toshiba: Add the TMPV7708 VisROBO VRB board
Date:   Thu, 14 Oct 2021 18:27:02 +0900
X-TSB-HOP: ON
Message-Id: <20211014092703.15251-3-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211014092703.15251-1-yuji2.ishikawa@toshiba.co.jp>
References: <20211014092703.15251-1-yuji2.ishikawa@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the Toshiba Visconti TMPV7708 VisROBO VRB board
(tmpv7708-visrobo-vrb) to the board/SoC bindings.

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
---
 Documentation/devicetree/bindings/arm/toshiba.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/toshiba.yaml b/Documentation/devicetree/bindings/arm/toshiba.yaml
index 001bbbcd1432..9c1cacbdc916 100644
--- a/Documentation/devicetree/bindings/arm/toshiba.yaml
+++ b/Documentation/devicetree/bindings/arm/toshiba.yaml
@@ -18,6 +18,7 @@ properties:
         items:
           - enum:
               - toshiba,tmpv7708-rm-mbrc  # TMPV7708 RM main board
+              - toshiba,tmpv7708-visrobo-vrb  # TMPV7708 VisROBO VRB board
           - const: toshiba,tmpv7708
 
 additionalProperties: true
-- 
2.17.1


