Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4FC443A26
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhKBX5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:57:45 -0400
Received: from smtpcmd13146.aruba.it ([62.149.156.146]:55007 "EHLO
        smtpcmd13146.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhKBX5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:57:36 -0400
Received: from ubuntu.localdomain ([146.241.216.221])
        by Aruba Outgoing Smtp  with ESMTPSA
        id i3cHmA3UmueW5i3cJmi7oB; Wed, 03 Nov 2021 00:55:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1635897300; bh=lhiNpRTEG/VNu3i9XvsLI9Q6PVfjYb5hPZrKzrJsi/o=;
        h=From:To:Subject:Date:MIME-Version;
        b=dr4m6/R2eY+Mf9Z36nMaXf9rdUYvj36B/cV+ej+DhMMDtRx8/QjitlXRfSSeFjik5
         nlAxOmVOT+trsLSVKzA3CgD4uPKkYCcaw8ntASzgwdyHY6IlB7STRqbmqY1i9LXu7O
         La58uPoVsL5ntcJZ73zfWYrrrICHowLg8VuulsNUw+ldlZCQHO9C59BBk923wTGlJk
         cB5oDIW3ZC11yJYIJuuH5bmHYDEt3aYmlOagyKIa3WRkeWGFeZi4NBQ4k4ktf+7ar1
         +u+nykhF/bTx7IS5JZDk3AHGGJt7dbMZu3fwV2Gi0smxNCSZc2+OOpyX+MQysc+YhX
         EghkaexqDMKtA==
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
Subject: [PATCH 3/7] ARM: dts: pxa910-dkb: fix wrong static ip autoconf
Date:   Wed,  3 Nov 2021 00:54:52 +0100
Message-Id: <20211102235456.710617-4-giulio.benetti@benettiengineering.com>
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
 arch/arm/boot/dts/pxa910-dkb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/pxa910-dkb.dts b/arch/arm/boot/dts/pxa910-dkb.dts
index ce76158867c7..297a34f2ef2b 100644
--- a/arch/arm/boot/dts/pxa910-dkb.dts
+++ b/arch/arm/boot/dts/pxa910-dkb.dts
@@ -12,7 +12,7 @@ / {
 	compatible = "mrvl,pxa910-dkb", "mrvl,pxa910";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 root=/dev/nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on";
+		bootargs = "console=ttyS0,115200 root=/dev/nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:off";
 	};
 
 	memory {
-- 
2.25.1

