Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB80443A2A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhKBX6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:58:00 -0400
Received: from smtpcmd13151.aruba.it ([62.149.156.151]:37246 "EHLO
        smtpcmd13151.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhKBX5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:57:39 -0400
Received: from ubuntu.localdomain ([146.241.216.221])
        by Aruba Outgoing Smtp  with ESMTPSA
        id i3cHmA3UmueW5i3cMmi7qk; Wed, 03 Nov 2021 00:55:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1635897302; bh=uEmAMAGs4vUbQ1vkWnqilm8FyrWQhxYkvOIUp+u0ruY=;
        h=From:To:Subject:Date:MIME-Version;
        b=YryxOMiDDeljOR6UTjDkBSqbWtAD2rNIXhzUJISndDV3KrgezwECBo2hG/NEJdg8c
         UcEWi/2kASSBtC/zy3upNPeQA3lDlpKhtYC7+LcWrlzh2PQ1CPLjHXIGj4fpcjevyu
         FR4/SZqG8gu/LnZ19Z0NCdAWxyzbAbnP+z+7UpmfnY+IXjH7dYDk4WAHBkHIC/Cwjb
         MUR6BZfsqVgAfc3fPDl+SyBPFFc8xgjeJUl72IkrgSTppXRztEMBIT2SRRFuqpxDTo
         JLGZ2nUEO9ByQSCr9sfudAiHSgNbQpsF94/dChwntAmM2UvICEmYX0WFQVWZkWR/2f
         fUruoR4Xpd61w==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Rob Herring <robh+dt@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] ARM: pxa910: update pxa910_defconfig to fix wrong static ip autoconf
Date:   Wed,  3 Nov 2021 00:54:56 +0100
Message-Id: <20211102235456.710617-8-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211102235456.710617-1-giulio.benetti@benettiengineering.com>
References: <20211102235456.710617-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBeQFITUefc5p0YRpGdN1pihTrXklNwZgSko7+yR4yXBPuiEG8B2bMMsjBFVAmB4oh6rHv0c1hIIFJvLXsxSU6si7mv/2Hm1WcI5GUmxDgJmmZEBljMr
 xy84rxfnFxsCHKrOmYyFiN6Qa98tfabuS4s+cH3lqtjnnjBgSWS9g/qloC80P6VJ7Ly24epkv8yXpjlldI0kX6u3ugDHeZyBy0IuBXet+Fe3X2RYIoUFhgUs
 yKQHI4X96RNTksVLZI7vJiFLJXruo9VnUejW0pIIiibHavu1XD42ZxnSfbGim7FocYR3GmDwe6o5dqZUQv/eU7PHpRxsIGXdAkxo/Hdu5VMvb4g0Uw5b9qZr
 zf6as/zTaVM9/8t+pbfT2OYPe2jkSt6cjMCX8ZQ2Wg+CA5zn/R5WS0KuXUGY76w7I5Xa3LDElMr5uh7blA6+rs6jQIWsH1rJFBnflWNbCnUz10mCGua2ZsqZ
 PHgCE1Qg3bcK6/j7lWOJxNRZem16tPN7cwjNv8tceHRd3/J2zPhny5RFVCgPBVrGROL35S+v5OCQaGT91PbhSay1GzPv45Sz+EK0/aDcFX2jeQb2VaeTZB6L
 H4UeG3pO5phNDf3lIVQCjrJWMep/DLUqgwW1D4e088IzP73s55WE/uzM3btloUQoiZIH91CqQX1aOP2XGZ1cf3r5fmCV4qNDuCLgM3f8/zGxPQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment <autoconf> field is set to 'on' but judging from the static
ip setting it should be set to 'off', since in [1] states:
```
<autoconf>
off or none: don't use autoconfiguration (do static IP assignment instead)
on or any: use any protocol available in the kernel (default)
```

So let's substitute <autoconf> 'on' with 'off'.

[1]: https://www.kernel.org/doc/Documentation/filesystems/nfs/nfsroot.txt

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 arch/arm/configs/pxa910_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/pxa910_defconfig b/arch/arm/configs/pxa910_defconfig
index b21196372158..36ced16095c8 100644
--- a/arch/arm/configs/pxa910_defconfig
+++ b/arch/arm/configs/pxa910_defconfig
@@ -16,7 +16,7 @@ CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.2.100:/nfsroot/ ip=192.168.2.101:192.168.2.100::255.255.255.0::eth0:on console=ttyS0,115200 mem=128M earlyprintk"
+CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.2.100:/nfsroot/ ip=192.168.2.101:192.168.2.100::255.255.255.0::eth0:off console=ttyS0,115200 mem=128M earlyprintk"
 CONFIG_FPE_NWFPE=y
 CONFIG_NET=y
 CONFIG_PACKET=y
-- 
2.25.1

