Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872CD355350
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343826AbhDFMMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:12:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:48641 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232690AbhDFMMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617711120;
        bh=PGxh9D7zcvvJfUqYSQVc04GxFHyRLS1XqsJU+VlT6BU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bKBYLMBDeSCxAcVIW5xE2Jue2hoG9IDD1piz3qC8oXu+gpG/LlmYEG/USqJH1+Ruy
         0cnoa4SC222UNAOlXewZANqwkKg4omW4QxtNXrxVhY/oYTMmQknC+nBT/u/K8ON8GT
         SkOhuQrDradd8FA28Tj0hA/ZyljMP1ZIJQYQV3RE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbox-1lF6OK3aG3-00P4HB; Tue, 06
 Apr 2021 14:11:59 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     Tomer Maimon <tmaimon77@gmail.com>, Joel Stanley <joel@jms.id.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v2 10/10] MAINTAINERS: Add entry for Nuvoton WPCM450
Date:   Tue,  6 Apr 2021 14:09:21 +0200
Message-Id: <20210406120921.2484986-11-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406120921.2484986-1-j.neuschaefer@gmx.net>
References: <20210406120921.2484986-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z2EhOb9FQX5ezyiU0ShDDMZpCUtQItPMmkySsL3c4jvAh0iqe1i
 VRxIGpT+4knpL0z6HdEIqplXq5YVeI37Bdd5v32NJj/g4rsyIcQpumSoatW3iycfCmfoMt2
 S33LW+m8ELPFpycVzmS5gRrnl2cRVAhfWBUUsnOHuNv0nJy/YpAcM/rHkdTzlv5xZJqYmr+
 d+FXrAzfNRnRVt7RX7vdw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:v2DQm/L9XBw=:MYUuXxFKuLsUJKbs5nuwnO
 ozET949FjArxYHoyZOx3v0V48yhi1G3AnnpVcycuIfaItz1ZuqLhSZu2i2IwOAgWgpPLpqCnP
 OJf+22P1GfiiBCz6/ANtmG3gfd7xpvUIkYC+AushY8UCMIrtCGd1JK/b/eKpl4xPvWRDTniTd
 pqDbMb7G/Ksf5sN6id7BTuhwO3v9VSVWxosHr6tAOQCEQ9ITn98UUD1y0INIjjZf7qV2rERum
 7/8G2Q/Cyccpk/2mis5LOIwG/K6eK3oKONZNA/obyV/oi9dGh0JBQqr26C32TupIoaMTdYFQC
 nTy47+jzifSKGI62t9r2bbIftyjJgCcweF5FFlkiYsMLQLy2WfmEu31xlert+Tof6Jx1oyC/w
 vVyBjCR3mNe2JAeUNny0/a1tLODxkJonw9piVjdgfBIocxMVX+fzBNWjGJQbjfsFahsgKV6pC
 0yPjLbuhFnlJBfnetKWoCowZnrHBO9fsFECfFWNQod9OZqwe2qzIAagsAGL9R6VEBl26UBjfT
 fblRlvqwEhPNRmjrRLSAJ575NyZvg0wreccCfP9BVlxZ4yKxFFcEYujqLkl7Yy2zK/2kZeWVL
 PokvXkgkoMf8S7u9003114caGRPY0fO+x2qObzYQYvTVRA+MEsUX14zpmmFBCVXFbydHA3CdK
 xbg6C7h386DrBwTpvse4N4Z4CSd0VTrFEI/ukevAjt2XczE7504uR83M4ym0zJ6cU/FOaVi1z
 L1Tk6RcDfcazkfEaT/OaVME68HP42S5ZoOBzom6YlyOpj6HXf1FFEaoKHRYLOE++SixFZh956
 fWnMk6KGfGTMiDHgOEXjOOBVXTkBj70KHXkYMlvQwG17dE4ePOY+jcx7ZWYVEsZDNbnzAEw7z
 VALr1xI+2UuHyZzzgmt0OCCa6YNEWKjr2jwmEi3q1QZP/FIrG8UfATEhoT9+3h3uwITm1zqH+
 reC1UH8SJyufzAQ7VewHPLTKqSH/DKCqaq9fJcxBpUi08+jJLRo4JqUJruU2GZ77Zm60TtSSI
 FHlFsKeS9hzelOOqk5Sk6AZfL0sdXRzGeJiuhAw9Tg7kwdu3fO/cPFM6nZwgG2h6VSrN85GfH
 5JWNUwoGl9hAHZE+brc2tYAWWkoon3XpieOb5ZiD3QDBrBxCeXf21tKzSucn48B/2VkLxPgWk
 WEh2yYB1GmgWvbJXTFWWebrLXIrpRzXlO55a4/RqA7S9rF7F5NGQiN31ZYkLfWLZq5G1gr/TS
 f1AzD5stV750d0N7e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am adding myself as the maintainer of WPCM450-related code.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- Instead of expanding the NPCM entry, I'm adding a new one only for
  WPCM450.
=2D--
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d3..661770e8e6fc1 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2194,6 +2194,15 @@ F:	drivers/*/*npcm*
 F:	drivers/*/*/*npcm*
 F:	include/dt-bindings/clock/nuvoton,npcm7xx-clock.h

+ARM/NUVOTON WPCM450 ARCHITECTURE
+M:	Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/*/*wpcm*
+F:	arch/arm/boot/dts/nuvoton-wpcm450*
+F:	arch/arm/mach-npcm/wpcm450.c
+F:	drivers/*/*wpcm*
+
 ARM/OPENMOKO NEO FREERUNNER (GTA02) MACHINE SUPPORT
 L:	openmoko-kernel@lists.openmoko.org (subscribers-only)
 S:	Orphan
=2D-
2.30.2

