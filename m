Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7AC3F1B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 16:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbhHSOLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 10:11:01 -0400
Received: from mout.perfora.net ([74.208.4.196]:55197 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240434AbhHSOK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 10:10:58 -0400
Received: from toolbox.cardiotech.int ([81.221.236.183]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M7IS8-1n1Y6Y0Kxy-00x57Z;
 Thu, 19 Aug 2021 16:04:00 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/7] ARM: imx_v6_v7_defconfig: enable mtd physmap
Date:   Thu, 19 Aug 2021 16:03:39 +0200
Message-Id: <20210819140345.357167-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210819140345.357167-1-marcel@ziswiler.com>
References: <20210819140345.357167-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CC9ywXW29C6OdHxwLPF892isLfNEJAO1sXkDalM4HPxySBCDob8
 9WGuVzdpK20Na1+IrRXQQLN1G+k+P+CrrwFYAPcH6h3vUTSlLnuEk7Hc5qRN3LLtrWu4TZo
 iYedAJq+bnYzN/fBS8LdUDvdzGYzbCxLXwFvbfEMEKMdEw5s4WvAqwKklX5SxT/7oA70XGv
 HE/jDT9YnQkMzoF97J5lQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jG2VYNc/DW8=:P6D9lfo9O9vny04GaloBoZ
 e2EOr640nW2/NuMMnN4aWRbp2gnZi6nVEeJblkWWOqx52KPVfZPn3t/n/NG2viLGOtTdGCHqX
 o84TrOFR9u1N4oVuo57IwxZqGOGaMwkEKzTT1fg8pVoEyBXOpUGN7Q/LBzJnbrMqnhKEnLEql
 nTDV0raN+5Gu5VinHIWgN4JWVXMIiykP1LfwzijAYLwfbjlRzIihlauwpUNu4y0zCdTWqw6mZ
 3nApsPIB+LjU/oJVBM1PoQ322XeEaV9lxoirYoz3fCQi5fhCHSrOQdN4zmdJ2UTYzpKpglsYF
 41YxNODUacpfbtsultQAq/wq/YSIBzUe3OxuWiqqyds/cBDq9qPsBh726gjNkdGuAMN6+R9Yt
 eXlZvjGHe3qHoKB1UyHRQOrN1NnzNM+hWCQU09UpvB4r8HYjzw2BgdxGGQTDh6EwVIplwfSHB
 PahLe0SaOa7cyhkGM+xTlmVve9vvUa7gSLZP217fSsId8LTZZ6AfPyTJEi8EUihTnANAXwWVS
 DPG17UXmQBlvZ+M2CmmFUtXMH57HIdZ1Op0JF9S6jnztZx9dNAnhrXC082YW+CRxSQQOWujXM
 IahpopjNYDauW6iit9nqtLj09WC4d8MPqJMq+YYwnb8nUSInW9j2Y8gUuB6Y12zFbsk66gBfo
 r75JsvAwWbGUwnyYxtCy3+WuOIJ6RWNbGXfS3jLoD8k3BOASsdQ00YsvYRO8owOzC37kZEPKu
 1bgMQfZegVkVGkxus5pLZwEU/TKqm0kSh9OY32YlXnu3fRW5y8sLCeAVQYQ+Czcf8OchTsjDY
 n/DhRWP/J4PEPmxzWJDXZp5m2eGvtuT3W+jVuj5kYSYtHUVf59NJOzk70AykvceQLT7+Mem
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable CONFIG_MTD_PHYSMAP which is nowadays required for CONFIG_MTD_PHYSMAP_OF.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

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

