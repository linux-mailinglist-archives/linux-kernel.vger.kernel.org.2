Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2293C89FF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbhGNRqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:46:36 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:40433 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239907AbhGNRqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:46:35 -0400
Date:   Wed, 14 Jul 2021 17:43:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1626284621;
        bh=0CfrfJC7MVPW/R7Kfn4BUCyLDh2hJ7zuiUVZMyD2X3Y=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=HPYteaf0RHhk8+/UvALC9nYvNe2Oixu6+rSrKzDGzQGxuwMBe6SQjLZaK1nD8myzB
         3GQq99hIVq1IfgvVhxThZgcd2YQKs7EZ4neaqKkchEj0NyydEInFWuBvooSFvSY0A2
         89W0yu4jf7lAVtZ4j79exjSdXo0ZW41UWuLlVsuo=
To:     Michael Auchter <michael.auchter@ni.com>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH 2/2] dt-bindings: extcon: usbc-tusb320: Add TUSB320L compatible string
Message-ID: <V8qR7ITKe7vHKON9lWSnEHZpmCB0ir2RDmvbaENmH4@cp3-web-021.plabs.ch>
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
---
 .../devicetree/bindings/extcon/extcon-usbc-tusb320.yaml       | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.y=
aml b/Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml
index 9875b4d5c356..65fa98bc71fa 100644
--- a/Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml
+++ b/Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml
@@ -11,7 +11,9 @@ maintainers:
=20
 properties:
   compatible:
-    const: ti,tusb320
+    enum:
+     - ti,tusb320
+     - ti,tusb320l
=20
   reg:
     maxItems: 1
--=20
2.32.0


