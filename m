Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502AB37FB6B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 18:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbhEMQZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 12:25:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:55329 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235110AbhEMQZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 12:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620923047;
        bh=n5VZorDxJ4E3jMomn5t3g5gHnoDeyVEV26lJvjdJRRI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=JDyBIhMtzZgrx25iUSpxUB0z4jz1lgj2+J2cnmtQuakwEuGoyRUj17R9x2PkVtE4U
         iabmZpLOG3Gd9+2LzQdcDY4rJhn6BmrohGJK7usbKagvKPDpVYueSY/Pm2t7E73mbS
         sAE2kn5gEfh9fo51wGZax8yUKV8LthJ3MxL2QDFM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.126]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLi8m-1lyl0x2fi4-00Hel9; Thu, 13
 May 2021 18:24:07 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH RESEND] scripts/jobserver-exec: Fix a typo ("envirnoment")
Date:   Thu, 13 May 2021 18:24:02 +0200
Message-Id: <20210513162403.1726052-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s4PK8UcCSrXKUnihlvfSqrb0O5+JpfBu6lu0D7A51gSnvAjJmHL
 pNBuNRGjnBlUahRZ5E1vyacp1KIQVQvTvCmXA2v4ORgi0nuVh9BBiIL0DISLVar932nYvXu
 KB/JZ9zYbLbF4j/brISIA7FdURr0gcXIEnZTjdANwgvMq9Olx56adtFazk3tq1VRZHNyAbC
 zej8sJ62m04DmFtRQnwNg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mQ24yDbn0As=:YCKXE/IiZLC4l7hDJsLwZW
 GFNcTAJAMtktJqZ4F09au/K1yclZXYywnR5PF3zw2XH2dFDHDz6iZYBwkLR0pxtmEaLHifE2K
 OAtUI4olmvLrcKDrcb8bKXdyxNblkyiXHZl9XqfxWtcmk32My7EupW8u8YjwcQI2GWMYGOKqN
 GBaIyPs6Y6qMIihlaGkZWa7gyrIFLPieI5XXLH6oXMSrpFn9S5/JU2xMgWjh/glSUwyMgitZk
 YcxGnEG1FBCzrtXyO3kfD++e6UrG4L6h0SSwAZECWqFg9T5jWr4FeLTGLnc822BqaG1bhOQuY
 HSiQ1Em7P2j2y6Yzf5d01NniTROjwM9eWKK3J7rCr7QpXVis5nAHGFiHBfIniwhQZWTBmGYZL
 +Xe05Kup+13K/DJ2g9whrg4pFXPOcVfWoQ6N9UYuHZW2oBRmcpwI9gFi6O5XhsOMLoA/dPVEZ
 kkEB+6R4bbgqHecJqL/QmxO9+ilKoV/yCSM1d8vyrvStSTQcBxqLwcKDX/xBkDptXguGw4H1R
 0HugbX/NyLmFuEFKxAKQ6R6VGdWyMJhWOMHzuwQGDMndCLQoW6leGDc+h9oyGGfp7gXA3/RaK
 RGUX6Iep9oEk5STKBTlrMvF82texEdRbiZNxZHhkQJLair8LUIlLOhvGJHuh++tE+rUXgziJm
 2aVVtbLDPit536C/QcgkUq+rOpn0EapswbgosJyMWwU0e1dVMf2di/Gd/DHy6T+cp4Poj7aGL
 nTaORMHKsQszjHt0wy1zunn9CNz5i1R3NRxtkH9vlf/8ypMkXh8jvoA/7FJeDPcVJai84YMJ0
 OReCVzFuJHdYUp7x+c0wuFHExOUuKwfwNGkvcxWEjQfegbqJwedotvpAJZefKKDOChBaz0EeS
 Uj047jad+dBnLZ4trVO/+q1KeK18E1oSxgnB0+L8++Nre47wfWsov6w2eEcBG0djyjM42PbBe
 sVXRyl0Ji3ov/UH7SfR9Pp9SgNCPmD/sx4vUcRq39vJpLYeCIlzK2sIzLULfT10yqbcJ0AX0q
 fXFQMG76DeeGoONctpPEImwipseVoj5rPpmOHgE0i1sUzQAFNuxM1NLww+QIrGdLjO+VaePKR
 zI2cZAit3dI6LnTwP+pnW8A7UqNfO5CgP07QH8p02ULajNtRJA2ueH8tJ5Y/TjO00zZfWFCOL
 MrF59coQuV1yuRvM+QViMdcen9GsdPG8txwaGvguzO8uftlJSkMicJ7Uso041AF07GjeXdb5C
 pCYZxxgB0ow4s8gmF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 scripts/jobserver-exec | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/jobserver-exec b/scripts/jobserver-exec
index 0fdb31a790a81..1c779cd1ccb48 100755
=2D-- a/scripts/jobserver-exec
+++ b/scripts/jobserver-exec
@@ -10,7 +10,7 @@ from __future__ import print_function
 import os, sys, errno
 import subprocess

-# Extract and prepare jobserver file descriptors from envirnoment.
+# Extract and prepare jobserver file descriptors from environment.
 claim =3D 0
 jobs =3D b""
 try:
=2D-
2.29.2

