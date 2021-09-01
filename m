Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5715B3FDF8C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245139AbhIAQP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:15:28 -0400
Received: from mail-4325.protonmail.ch ([185.70.43.25]:63253 "EHLO
        mail-4325.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245128AbhIAQPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:15:23 -0400
Date:   Wed, 01 Sep 2021 16:14:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630512863;
        bh=C8bhmTg3LtiGmarjie/fRD57ShMGVEYwAFfFm06O7dE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=CmKAeRvzWUCzi28MvzWjHh337eRDZVC3/OZvVG8jKpEWARyYFioCRXkTk+kZgqTEr
         inxC9Jf3BW9eftOi/RpcVgSpej/KL0djzIzV0MrSvFqhVu7pkM+LQH4jS6UBMejweE
         OMuX+khVkSTWFH+Y/wdekfoFyv/ubwBx3fFCeAqU=
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Michael Auchter <michael.auchter@ni.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v4 3/3] dt-bindings: extcon: usbc-tusb320: Add TUSB320L compatible string
Message-ID: <20210901161339.223973-4-y.oudjana@protonmail.com>
In-Reply-To: <20210901161339.223973-1-y.oudjana@protonmail.com>
References: <20210901161339.223973-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for TUSB320L.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes since v1:
 - Fix dt_binding_check warning:
   ../Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml:15:=
6: [warning] wrong indentation: expected 6 but found 5 (indentation)

 .../devicetree/bindings/extcon/extcon-usbc-tusb320.yaml       | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.y=
aml b/Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml
index 9875b4d5c356..71a9f2e5d0dc 100644
--- a/Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml
+++ b/Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml
@@ -11,7 +11,9 @@ maintainers:
=20
 properties:
   compatible:
-    const: ti,tusb320
+    enum:
+      - ti,tusb320
+      - ti,tusb320l
=20
   reg:
     maxItems: 1
--=20
2.33.0


