Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A91410B9B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 14:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhISM5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 08:57:50 -0400
Received: from mout.perfora.net ([74.208.4.196]:45023 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhISM5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 08:57:49 -0400
Received: from localhost.localdomain ([81.221.236.183]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N9dHN-1mvWP61sXd-015d6U;
 Sun, 19 Sep 2021 14:55:53 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/9] ARM: imx_v6_v7_defconfig: enable mtd physmap
Date:   Sun, 19 Sep 2021 14:55:28 +0200
Message-Id: <20210919125536.117743-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210919125536.117743-1-marcel@ziswiler.com>
References: <20210919125536.117743-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:y642/nBqY3pC1I+kugNc57TNtyPMSmqFpUVSKBQPoj3kIEULV4s
 EWBH7N3HmBiaWWiTeKePakdP/NKFf02yy2IVExQtHCujEwm45ASZPF8f6sOEqnFHQoqr5ua
 YVnmNDrYYhL866ozcydWjz7wWM7owSM9eEB10C/ZgWnwVqvOC5ReUucG31D9SpQEFGuiUus
 katN0+XjMk0/mVvUPExOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ehkZhQTah8Q=:6VF20kGW2CnK6h9tQeUQOP
 GZ/MI1XoD5SQH4etJNbjnqIa61ridyRTvQLP4bmUBsMdvppG0IOLhFuhmxmMbIM7GniopiQwo
 Rn4p/aAtiRaEGmgS8ue9PpXyCPvrD1oSaED8pN3fOsSBLSUX/iHCL92RIgl35ravFf4k8aK4i
 +Xcp61FOLfd9XagfSZ/Y1Oj5ORUw6lvM89Ypdevjx4D7kdJ32+0Ry4KlbqIl0oHJtXwELh9Mi
 s+NqdzXaKzElxvaGDt0ZQVEVu/pPUfzHzFNWU2XY47jwCXlgpLwaliLAo1PqVAncjqnEumh9n
 bc2ahrGF5bx/n9A4HcM+W1vDaPKSaom3ASu1G61JAVuH14u6khSZiXliQE/ApfnMJCTMt4h3s
 ZDXth8Ks+ulZ91eR1iPx4etICWeAjaOHQr/HfrP/NmhMGNWPCCTi69GQlqsZ5G/N9XUoAHYgr
 a2V54S1rQ9G8NFwZhhDv2KMZ92Qb7ckHWzmJWwqeUeNLcjqQvvgrf23yk86TCVV+2PQIjhOAH
 yT+9rZP5oppJwCo5LUB3e3U3R7v3bg5ZQzwtE0cjB6lEypffQ4EgN4X7hr/cRcfDVsZ5flXdk
 5A/Q1PAzDe8K9/BaQPxwV0rVsUMFnBrlqLFBjaONYhNJFX76u4wr8AdN3//ekGyeMqThamNnK
 Jj0keQ3zbSNyYtCQ6w5J+CHMlC7CrJ9ewY2n/c+bYA+AqkSPK3Q31CdXH3mwBqu942Q5G9FuU
 PfUesft6Ustx5UZopy5IfNGPN0SIrqvI6MfZHA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable CONFIG_MTD_PHYSMAP which is nowadays required for
CONFIG_MTD_PHYSMAP_OF.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

---

Changes in v3:
- Add Fabio's reviewed-by. Thanks!

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index ccee86d0045dd..70b3c377c4302 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -97,6 +97,7 @@ CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
+CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_DATAFLASH=y
 CONFIG_MTD_M25P80=y
-- 
2.26.2

