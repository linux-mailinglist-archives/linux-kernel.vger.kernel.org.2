Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2F236A12F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 14:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbhDXMkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 08:40:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:54375 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232867AbhDXMkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 08:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619267955;
        bh=bV+9xZT3piUjTvu4p5i4n093wFarffC6liXqI1+7f9s=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=WC0B85sdeUI7PszvE4AGZ2v3sCi+AccSNveKLS7fMqnHl3OaPh96Fih3c1fIm1C3w
         Kc0GZYVrUcW3aZatoVk+D7Tkftz82h4Wya+bh+DwgVuG0Y2h4ChxZollgpr76gmYss
         i4aQZAhEe0UUwgwDCwEB7s9yCAefKFstZBu/LbmU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.179]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MowGU-1lG6UW3TI6-00qSo6; Sat, 24
 Apr 2021 14:39:14 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx: pm-imx5: Fix references to imx5_cpu_suspend_info
Date:   Sat, 24 Apr 2021 14:37:28 +0200
Message-Id: <20210424123729.578295-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QK+ImlwSi20a243SC3MqAia8QzVkuu5sOwRCHVoiew4C4qcQd1g
 luYn7/12S1+kQsk+xD77FFSiMYbja28cDFEzMqZnxuR/x2yijz0UI6yraMUE6KdFrjg5O1t
 o6oqEBMOgGDNiIoISa3TZVYqjAP13uxsfZyHJwO3VKT2Zt34ZFFl7lxbdivEv/HJ2kIMlg3
 ziQfky2/r4k2Zkp3+G6vQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4xFX6+XW610=:fzPzlk8dg2PRRk3ifRNjCQ
 IRuOT5Nu4p4JZuXcCi6aXuD+zVTuE6NdRll9lI9m1C5zx41IVoYKvRP7u63OgbV52wODWJToX
 yqs4c4XI9rIQ/NtzIip2nx0xR9jZyb3K4vWCse1CdcejsTY6us8vl6BaMdcdBIbyRXsmokHec
 ngx04L334A9aZDIHsccvZI2fYOEO9nq5/cPPku44pyYi4I2/G9zMhUeXaIBoYXgVz71Kt9Ekj
 ajjCnWErg511a/EDtjq71llHRL1DpTGuZw12QTPOreETYRRA+emETEoZdChVM9KiihI9NIhlb
 FxavOKSWXb3eP9Ox/n8BGpoCzi6nEnp8xn1ki2R+wCAgEC2h7X0PLVjazJRwzPTRjxBr2LMFe
 WZ7zLEoUkUYxgMOcgFUg3oTyILX/XgVTVirChbR4zPKHvGMUoDdtz7P7jMMXkPsMfcK4Pn5Ds
 RahSHiz4/t0FlMIYOKo2qt17AxgVbFYOaQViy2EUnvm80JMp7z92uoIsoidnrtn2lwkKgyIQL
 1HRXse0KNzgZ3GvpbVIIaV6OHcBVy5HvNSm7Odoz2AZHN+KMG1U1AhkaahRhqmlk19epxriRF
 xZsw22vqF7pVgtSHCDrZ8PFuERd0uHpdDSURrAl7RS4hBYJ1QkZuFgB700kCPqaHs5EzU/TcC
 UnC8qnDWUljZMUNRFjn9r45YScAWSHxZdYlB15Hle0YihRrx2bNvHCLLugMOO3qxdmxfbCOOr
 CUF+qUbLwcdYAyftPal2YmzyJ2UMu35bCVTYJTFF95vdY/NqStnNZppWK//sn+szlwgwdEH5m
 wBey0T129dpyTdvEGs2QkBlqymA6tSIKBU4pO3KbXVpPsh98EdB2KJZ07PUAYCXS/VZ9cU40D
 Ueo59m7ZcqMg0rfQ12lznVqt5khNvGAiiQCgvmziCTmwJw0IrMmLM4kgADvfkYIL2pKXLPx9v
 OlCPw3IxaFiJ2ywkTOJb1w+xk66L2d/F9ByjN+t7S6DXTDxk6Brw5Zal2PnKRXU2mrbUBm8MA
 kS5A2fVPgmzHuG0HvWHiSHFVZbM+mXueQCx3zLFV0QF0BXcywwmVt5j0cAWTKeFtOT+AotxVb
 r4zvwYhMfScP6av00V+dSKgM1LZPD0BLv3WqKZs9tFrFiox2IFQsCK9WVWaVFoHPkARWD2rfz
 tYO5XBu91vgP4mSzbqA/I9GAXm4y7YvXhqgkW7uRwZN7tLIAKzGJlNlrLmo5SpSj7lYSYPOGA
 41ucpbWcYvE40dIEh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the struct, as defined in arch/arm/mach-imx/pm-imx5.c,
is imx5_cpu_suspend_info.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/mach-imx/suspend-imx53.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/suspend-imx53.S b/arch/arm/mach-imx/suspend=
-imx53.S
index 41b8aad653634..46570ec2fbcfe 100644
=2D-- a/arch/arm/mach-imx/suspend-imx53.S
+++ b/arch/arm/mach-imx/suspend-imx53.S
@@ -28,11 +28,11 @@
  *                              ^
  *                              ^
  *                      imx53_suspend code
- *              PM_INFO structure(imx53_suspend_info)
+ *              PM_INFO structure(imx5_cpu_suspend_info)
  * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D low address =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
  */

-/* Offsets of members of struct imx53_suspend_info */
+/* Offsets of members of struct imx5_cpu_suspend_info */
 #define SUSPEND_INFO_MX53_M4IF_V_OFFSET		0x0
 #define SUSPEND_INFO_MX53_IOMUXC_V_OFFSET	0x4
 #define SUSPEND_INFO_MX53_IO_COUNT_OFFSET	0x8
=2D-
2.30.2

