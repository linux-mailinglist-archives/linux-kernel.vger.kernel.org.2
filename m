Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45235418887
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 14:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhIZMHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 08:07:21 -0400
Received: from mout.web.de ([212.227.17.11]:50387 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231349AbhIZMHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 08:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
        s=dbaedf251592; t=1632657927;
        bh=UwZB5p+aswQCHV5PRna/g5xryO8PKdHK/H/+WUl4CH4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lvsfcJ2VmSBUSTPLD0fj2O8fTTnjViAuf3AsSpO4ueybTOUhi2RnW1TooBJiQDfnU
         pRSLN535Q2CDrD/wGDB/L7vu0G65eLWYGvHEmuG5hWx6pVmiHRuAFZRuxRjjlWuxbN
         MMD5IHHvWod0c42YWH8PXTuPfRn82koMaD5kKzLc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from md1f2u6c.fritz.box ([94.217.148.121]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQ6PP-1mQuH61WuB-005JBJ; Sun, 26
 Sep 2021 14:05:27 +0200
From:   Jan Kiszka <jan.kiszka@web.de>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 4/6] dt-bindings: arm: ti: Add bindings for Siemens IOT2050 PG2 boards
Date:   Sun, 26 Sep 2021 14:05:15 +0200
Message-Id: <5d99e69ff1e2fb78f51f03c351eff1fe1f6c3a71.1632657917.git.jan.kiszka@web.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632657916.git.jan.kiszka@web.de>
References: <cover.1632657916.git.jan.kiszka@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cuCn6QPm+/uJ0FLCIAOg3wk98JpE3ypSUngzzKYTxIXMoSVvbI/
 GeszvJbU6RrMUNio42uU2FV5x33Nzadz6W+2MIUlUWTKsTAdnEaSXr9uaLZ7V4IzUddnnTr
 UyA1GQoeVPxFG5+44vA2+MnRWfXlNYSvPBcDDsLKdKXR0hilxe2R4JvDZkkVSRBk6PUKZmL
 oPLjxqsW1nDU6xePpCQrg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cwm/netLSGg=:xPVhfSSUJx76indgMWYh4t
 SZZ6zjk8VKtS4r63BU/1fNaGyjatb7ohbch9OT9ESi9QE/VQvz5xCgsR+BFXSMZ/OclJo2BTP
 iNF4cmUkwGdByKiVZvZ3fxzLJuFVOySWS8qbHU5ZxlY/3/vmvzXU0SBkHpjX1yIgN9D/AusDt
 wKnxvFbCtvJUcOTn9B+U7NrpD3eL8Cqvpyo3oLWi9gGMKHgzwlx2ZN6bQHNwAOqMwDR2e5TLC
 g0iCRqmJfvKFDwmvG+8pTBBiZagHvbUbCT6qV6Bx/70KPUhhQRdpWGvN6fBDTBCSqXmW0Mb3+
 OXKS0RLQQyJMLsOfs+eSJDU/IYxypZbgxAtJlZpqwAudP96mWUnzUguaFxqnNQ2KTCRDWEgJB
 jENGCu/vbhgRDkWxcSZCl2ULAUc307mv8EkdQs9uVXPcHNIspv/zpGdp2kPwUvRtwcdHlWYxS
 iAHCqUW3fXgMnZoIwhbVx+LfPsmcfTQzppTgRW/L+4GqvsLeFS4wb4BTYsWdbFlJOVM4aYDka
 W5Vf2xZmwn26hBFclY4oFPgHXn1IpyIqxtgR8VxZ61mYz9NhkoJ7uxBv/gQkBQrIrTiZlJG6s
 TiFqnelqB8O1TnW96peDpK1pPMkkfeAdWb1j8XubLgaK0Ep4G18PnY5V1qmYQb95xYS7M93PU
 FlZZRzxXPCY7wFYuxmh/TH14V45+dpsD4ZjRkkpKrIt6Ill5OadyPsnTTbv50jUzlldXaXdVz
 qdXtL+AhN/auVmoTDSX/xngBADmuF9pZBY/CpzIvTlKWKyi0PGEXNgq701BLgtpmrQyhTNFkv
 GvutkTxqsuz0SWE5zgInKlEdc9kOJWDlRAZO1eNCBgUWWXHytC4xS0WV23Vpmklimva4bfbeT
 a1vXnc6MjmMqbxU3WipSCTCba76GTb0L9RhzF/sJFyuVq9JWoZ1Z0jrlh0CtaLHSD0Aim9JG0
 bK+giE5R9uYe69S44k8I/3/3c2I8LKkJ4n9MzE4ytkBd8p0pravKn79G5xJtlyoAnJQ3t67Q1
 f6n9lKaa962oj5pFwOQ7WjHv8Nx4Fkg503gtqZ02o3225cZRgLeOVK8PgN2/Evoed0kLH8flI
 ZM9uLjmo8XZo00=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Product Generation 2 (PG2) boards are based on SR2.x SoCs and will be
released soon.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Rob Herring <robh@kernel.org>
=2D--
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentat=
ion/devicetree/bindings/arm/ti/k3.yaml
index c5aa362e4026..ccde4a0d7b46 100644
=2D-- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -24,7 +24,9 @@ properties:
           - enum:
               - ti,am654-evm
               - siemens,iot2050-basic
+              - siemens,iot2050-basic-pg2
               - siemens,iot2050-advanced
+              - siemens,iot2050-advanced-pg2
           - const: ti,am654

       - description: K3 J721E SoC
=2D-
2.31.1

