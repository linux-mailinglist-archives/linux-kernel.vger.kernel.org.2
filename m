Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE750443A27
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhKBX5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:57:54 -0400
Received: from smtpcmd13146.aruba.it ([62.149.156.146]:53923 "EHLO
        smtpcmd13146.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhKBX5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:57:37 -0400
Received: from ubuntu.localdomain ([146.241.216.221])
        by Aruba Outgoing Smtp  with ESMTPSA
        id i3cHmA3UmueW5i3cLmi7pT; Wed, 03 Nov 2021 00:55:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1635897301; bh=ynIO0mTSNG8tw09g0D+x+IDu4qU8epvSNYGB4CRniXw=;
        h=From:To:Subject:Date:MIME-Version;
        b=hrbTXEzDNXQ/8hSrYTtZ0sX7jfA5qPpxF3UsajqBm94KOKQdgubYhQJxmid3X6ysx
         DmpMuswinnhnAxxVh39DQOxdQWobOU6MAq2N3BIaMcJt7WyPU8sp2fQJeNBfdHbBZm
         ijMl/jEtGosjcxfU0dzY9Sm5CiawMZ0Bcje5FNlBaJjIdptWDe9G0fuEkR5tQqD4Jp
         +I05A976mcLY7mclkmNVPhCnj9BzfB8cg5JwL5Bi4Jir6vHyKuwFtbKvhb1ORwoxnG
         9FVtcoWNTeZTqcrzZ8NNdlK4N6AYyS6rd52MZZ/dKSWAGpbT2X4ThuZDuocYPN/uiw
         pMJbNpcikJ2lA==
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
Subject: [PATCH 5/7] ARM: pxa168: update pxa168_defconfig to fix wrong static ip autoconf
Date:   Wed,  3 Nov 2021 00:54:54 +0100
Message-Id: <20211102235456.710617-6-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211102235456.710617-1-giulio.benetti@benettiengineering.com>
References: <20211102235456.710617-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNZBlezE3q4CTdtZBYX3W4QjIdrBUp2QWAGFbYEimtHwREntB47cQyDqOBXrXuxkSA2sc2PnU3jl8Q9Z+LycDtfJKTh9zihgJlCUmUDAcEOYSxWJv3id
 6Jhk2tZ2xsD8KgVTAmkWt5axGzbcgVGbvgHFKpm0Css2PEMdH+bYOVg0mSBzSbgMFDHZdxBTFdFP57a/JIqQEyLfRapKiSWJLBjDyV7LWiaO8w8v3NW+3ss+
 j6XPLdcUb31elwRmSG6zQxGUEHBEJJ6YlZYEjttFbUFxyfHDxDLxq0+Hj47Z5+Gz4yuLm/Ak+jVj41YP9Kbk9d3/bvdtLwvf1SLCmzyentzxWivzi5+3675k
 XFSrBCj1rzpG6jATW1OfnBQas3+Jz87qUVlMYljF7AtmX6tOQq7JSIDCPeGbj/Hl5ikr+Nrw90HXKHqCKOmNfLpwTrOoajfv9fYIL+i5L1wkHIP2NW3j8Xfr
 UUcgBBXkl0P+10ZICPvaDYtNfymOaSFRaPNxFBCOfrmoaXZzl7mN0Znm9TnfW86ihPK6JGNWX0NkKxLdGr5WpfgvwcHU/5iwKolSunea05LL8VyBqoawOcgo
 sOy0zyuJtcH8QKCWMkXap03qj9VOFIhpNQx8P0gD4REfSdS05joJEgmnJALrhZnqw/3UU1KJFgB/yi+10d17Sc3ecL72IzBEAZsR6n5l0UGZYg==
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
 arch/arm/configs/pxa168_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/pxa168_defconfig b/arch/arm/configs/pxa168_defconfig
index 0947f022954d..3a972bae1be3 100644
--- a/arch/arm/configs/pxa168_defconfig
+++ b/arch/arm/configs/pxa168_defconfig
@@ -16,7 +16,7 @@ CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.2.100:/nfsroot/ ip=192.168.2.101:192.168.2.100::255.255.255.0::eth0:on console=ttyS0,115200 mem=128M"
+CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.2.100:/nfsroot/ ip=192.168.2.101:192.168.2.100::255.255.255.0::eth0:off console=ttyS0,115200 mem=128M"
 CONFIG_FPE_NWFPE=y
 CONFIG_NET=y
 CONFIG_PACKET=y
-- 
2.25.1

