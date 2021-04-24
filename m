Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD9736A215
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 18:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhDXQZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 12:25:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:50073 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232051AbhDXQZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 12:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619281452;
        bh=9YgyoONvVXEooC+qoFrTDEtEi/Z90uUO1lgp3U/cgpI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=QH6PsWZU45X5LqzVp6bli6OdEdOAWBbb1Jsqw5e/RJPLtdl30NJfzlZ36vh2EA91Y
         MSrY93zOnYU9xZrP4ckBwcFZsxvxcP2Vd3L5TKIGX/SA169/SDh+HNiTQpIW8ABaxc
         vkKuox69k1teliJlHXO4xwEwpr9rIDnmhj1Nf8IM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.179]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDou-1lPR242lg0-00xeMC; Sat, 24
 Apr 2021 18:24:12 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx: Initialize SoC ID on i.MX50
Date:   Sat, 24 Apr 2021 18:21:27 +0200
Message-Id: <20210424162133.680213-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eZ2t3utlUfuvWD5sJyGBN+Y0h9lNn/XrU+4hK8fiici5cy6Gucp
 WBXTdChxkTnX93kVJHELcBgLUSU2njP15ZcxnBA2DK3TpY8EeeqEHWhgnXO/dzUYwupntfw
 0KKRaZRBjQVM0b6IT3RLYajZfNTV8OvYeG9NCsUokfqz+bG5tmFtk0kSY3G3OVnzTuZfeVr
 lZT4sKO6evoAov0W/W3fw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nClRWV3Fsp8=:A2LFoCsvzx1MkXiS8oYyKQ
 BakTy136XevuUuqNpQnJ3YjeOo6VIqQaMj6XO7jturyVonHLlkUuHnJ2PO6OLgktYZFbU3UNN
 RfgiPWmMisEYr6XbTKrVFiptP6reEOikckHlJObc9iEedC8/+gL0QlAlwp/fLg6z7J1LQqShB
 g7bQ/4XYvILOmsMC9jbYoiGzM2qDFm24Vweudp1RlxD1rnGKKK0NYUCj3QXtW2PvQ8TfUn6ni
 wBwGIAEPSns51THHy6NuxsFnh8jN2eKjHyeksNnVZdT97TXzocYrG6ri9VlmfzLiloeePa0wV
 akZayp/K1Gp6i2w1IMgjLzJ/03hzVhVCskdqNGDjeWWdN5dr64am3AVJpkfZnrH2Q5Z0nJYvs
 IyYk7cze1GXRSKUpsqy2YPsIUNYdWX51qEdkyslGswTo/I7HiCXlwHhR/va3nj58wv8i3tNU4
 79edgzf8VZ7e5jXGwXg6i/d3AVuX6CiEVY6wovKei2qfX98zMaTIZPtHrN+VdXpnEceV5qloQ
 yg/lQyeyXHv/DEaQqHzCtpKNluVIpOrH20ehpz6Qwb3mID6RPwr9njosQ74CBTSVb9tPIUriG
 re91ADJ/ZwXE0qmqHs9qLZcEZdx5JGxBF3oDnuyFGhgl/vEx17adVCeSyydweWXOOvnzW6dU6
 s3ndAkI5P9bWvTMeUgTertNbT4VondIoi0hKsKkMc0bd0peu4D4pYBQzZocDKA2WFdiuuDuHM
 tnQ5CXsVK29tpDE0lR96H3EMwX5X5WBLcik35e/CUc9uy2yJ11Ywf4PIRnDtgRpntZ0GV3glQ
 JTXzhkMdzamJiyZyYgYdnwbMLFln870c1Gc9u73Xf4XTItH35XeGrvx/hJsi1RvF+ft9UhJ+J
 lrrpudgdsyjDdP6WdEOzQ74ByTKDJCakjjib35I9phGukANH0c5JG91TCDeZndfeqXXn9W1Av
 2CeV8+65IBGxPt/5nz9KsaA+/2DLdo/8sY/hD0vK3ezJ5nhgxGSh4dgGGQbO6sNzeCRrFitVK
 MNjpbjrr58AuH866KZLHmiX+kwUdJyIMvq56maz2nQcGzYCAryOKFaIZ5egRXWc0ynGqu2qrj
 ko0P6AgUl/OdBKy02mg3CVifOr+/oHAV0y+D3xaiBBJzZ8LvsdYa9L1sz21COz2Mu/mweUADb
 CnLG4xyi3kZiDPiDvF59sYJivKsB+cbqUWO/R9WSYKtJrSyGZnfzizM76ut47v84ekPCwLfCv
 h0NuN+RNFLIoSyuY4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As on i.MX51 and i.MX53, initialize the SoC ID based on the SoC
compatible string of the board.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/mach-imx/mach-imx50.c | 7 +++++++
 drivers/soc/imx/soc-imx.c      | 3 +++
 include/soc/imx/cpu.h          | 1 +
 3 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx50.c b/arch/arm/mach-imx/mach-imx50=
.c
index f4da205f57db9..a2d35f9ba474a 100644
=2D-- a/arch/arm/mach-imx/mach-imx50.c
+++ b/arch/arm/mach-imx/mach-imx50.c
@@ -9,6 +9,12 @@
 #include <asm/mach/arch.h>

 #include "common.h"
+#include "hardware.h"
+
+static void __init imx50_init_early(void)
+{
+	mxc_set_cpu_type(MXC_CPU_MX50);
+}

 static const char * const imx50_dt_board_compat[] __initconst =3D {
 	"fsl,imx50",
@@ -16,5 +22,6 @@ static const char * const imx50_dt_board_compat[] __init=
const =3D {
 };

 DT_MACHINE_START(IMX50_DT, "Freescale i.MX50 (Device Tree Support)")
+	.init_early	=3D imx50_init_early,
 	.dt_compat	=3D imx50_dt_board_compat,
 MACHINE_END
diff --git a/drivers/soc/imx/soc-imx.c b/drivers/soc/imx/soc-imx.c
index 01bfea1cb64a8..e11d237b883a9 100644
=2D-- a/drivers/soc/imx/soc-imx.c
+++ b/drivers/soc/imx/soc-imx.c
@@ -67,6 +67,9 @@ static int __init imx_soc_device_init(void)
 	case MXC_CPU_MX35:
 		soc_id =3D "i.MX35";
 		break;
+	case MXC_CPU_MX50:
+		soc_id =3D "i.MX50";
+		break;
 	case MXC_CPU_MX51:
 		soc_id =3D "i.MX51";
 		break;
diff --git a/include/soc/imx/cpu.h b/include/soc/imx/cpu.h
index 42d6aeb951fa6..0bf610acafd06 100644
=2D-- a/include/soc/imx/cpu.h
+++ b/include/soc/imx/cpu.h
@@ -9,6 +9,7 @@
 #define MXC_CPU_MX27		27
 #define MXC_CPU_MX31		31
 #define MXC_CPU_MX35		35
+#define MXC_CPU_MX50		50
 #define MXC_CPU_MX51		51
 #define MXC_CPU_MX53		53
 #define MXC_CPU_IMX6SL		0x60
=2D-
2.30.2

