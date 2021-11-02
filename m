Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2390E443A28
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhKBX54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:57:56 -0400
Received: from smtpcmd13146.aruba.it ([62.149.156.146]:57186 "EHLO
        smtpcmd13146.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbhKBX5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:57:38 -0400
Received: from ubuntu.localdomain ([146.241.216.221])
        by Aruba Outgoing Smtp  with ESMTPSA
        id i3cHmA3UmueW5i3cKmi7os; Wed, 03 Nov 2021 00:55:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1635897300; bh=6FTXldqIVH49mQUDD490TOZJdcoOZM40XWjBAPwXklk=;
        h=From:To:Subject:Date:MIME-Version;
        b=GZiq9e7PMSL3t7hacCqipd3C/4fcEMAGc7t3v32zakKO7XjLIg1dsnVgEo0iICE4g
         fOf9TYkyRLrh7ngK3kQF1QBh8OKz7+ESqbB30HR6QKI62nPLIKPzL4v7YGvzm07fn/
         uvPZaAOVANAVqi8FI4Sm28D+SbFoK59aHvGsjIJNU5rAC2uTrewOy5asSCY1Zdiit6
         46+sExK4eA8RlV9Ynv/HHRJNQsxqvl8FCl1lQyP3It2twGAsWSocfgURFgIKSHpbH/
         O1E5lj0qZjc9NzlVNU/qHh9o97oFiPvv2iWuUppQy3vmyJswiXP3HIfNpXBFjPimTa
         3Mns4TmSbQ0nA==
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
Subject: [PATCH 4/7] ARM: mmp2: update mmp2_defconfig to fix wrong static ip autoconf
Date:   Wed,  3 Nov 2021 00:54:53 +0100
Message-Id: <20211102235456.710617-5-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211102235456.710617-1-giulio.benetti@benettiengineering.com>
References: <20211102235456.710617-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPR7dtRy+oTng6wIOuL14h9LZlrRhFGTbjFKLk34jhtYslotalJmOQ++yRHs+iQ+oyuRgL8s+5+bcu7TSkl16EQH/DCFwmPwgRGqW0YJ2kcURtPueKzq
 OgAIEphyfNz0Sfg1/jDKGYBHX1dyxbQiCki5dS9SxyzOlMnHDfU5Wsh3KNu8rportRAhqDhhrM0/TOWnXNk2gBD6O/jkhgXi2E6d2+70dsrYu+KHyFkohueS
 Aosmnz6Be3IfdE3jBUPm1suyFWHU/CJMPBi8EJkG52MqN441ZNZ5US3V4eUDTMQrV2SpPtDkUED81pCMAxjI9hS1ypoIswOlBZ1BOqwUvfeS1Jt60+l3rx0I
 FBLWWOZcj6Wc52uVSxRJ90Ef5mT0Oyo6cQWAThDpSXIaDwowZxYdxHx2PnqZVgMFqXjEPH/rprdS4OVeWkfvxPhMZJ7Mu5ifA+/3O+TYFOgvvXe+7MxVG6gu
 4+d8IBOZP7Apnmhi+p8EKeB/1p28yj93x4TbVh6yP/wsUHnGuDGb6TZgsc4bw3oc82wnohY5x188ZY2AROLwVkvYqKD/8S9ogeGf2Bdx7q7OQs4Wi9Dirbk0
 RxbsvE7mi3/IFZJphCb5hZc2Ww9AB7yY2LibfHWSZDEP8BKcANxlRmGV/+x5lxaEhtsXj0fo8TWiayx4FkJMaB3ixNiJ/6lfoNZmWJH/DqYW0Q==
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
 arch/arm/configs/mmp2_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/mmp2_defconfig b/arch/arm/configs/mmp2_defconfig
index a5e8d2235a1a..231971ee0c8b 100644
--- a/arch/arm/configs/mmp2_defconfig
+++ b/arch/arm/configs/mmp2_defconfig
@@ -15,7 +15,7 @@ CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on console=ttyS2,38400 mem=128M user_debug=255 earlyprintk"
+CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:off console=ttyS2,38400 mem=128M user_debug=255 earlyprintk"
 CONFIG_VFP=y
 CONFIG_NET=y
 CONFIG_PACKET=y
-- 
2.25.1

