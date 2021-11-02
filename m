Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B8A443A1E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhKBX5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:57:37 -0400
Received: from smtpcmd13146.aruba.it ([62.149.156.146]:37329 "EHLO
        smtpcmd13146.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbhKBX5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:57:36 -0400
Received: from ubuntu.localdomain ([146.241.216.221])
        by Aruba Outgoing Smtp  with ESMTPSA
        id i3cHmA3UmueW5i3cHmi7mG; Wed, 03 Nov 2021 00:54:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1635897298; bh=lxKa0R/N2V9lnw8D/qjyjBrgkz3JIBzj+PLVCUDY1VI=;
        h=From:To:Subject:Date:MIME-Version;
        b=IMy/Bd/FiTnSd4HDQScVFOwBJNWWBfrkfl/r7AdI7t/0V+VHJZmnk+IEI345dCC+6
         6icrwwN9DxU3+ge8UHxqnHQYbkr4LFYTHpfCXks4+eZo6Av6Arfl/WKcebFtbKQ+tq
         TzDMm5RzwLfmz6UkKxsRrrUm2Z/iGF3YNRwKnfypgVinwTJnDOfaL4m72+lxXJUbY/
         +aYx2u2fPbdUwV13wcS1x/Us945dyFInRP+/pEYGZLp+np5G8I5jv1VVLPMDAlHEaa
         saPl6QTZk44BiL+owElnw491dmI0dsCf5B9WuT5cLHwquRMV9+vwMpcYHAuprP+z9H
         3S1eXTH0M/6xg==
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
Subject: [PATCH 0/7] Fix wrong static ip autoconf in some dts and defconfig
Date:   Wed,  3 Nov 2021 00:54:49 +0100
Message-Id: <20211102235456.710617-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJoqa7/5X3zvyqu+leAL+qFrlfPpI1qsGjjEgSgJI7xGzotWNX4760UB55nZwU32pdOGecuXpCNjNVua2dhdvxFcQ3LuYmAjNWZCPWTNayyGKZhX12+t
 G0XcBmyTKtSaBgoAZ/k7IyvKACJNqLFSORbnVgPIUJvIjLCR+Pbmo7Eir+0WYVMaYyfDQlWc0EabIk9LKKBq+Yes6vvIG7lY3C4NJZBuZNA25s5QMT3MRNyC
 ec+GZzesrxjQBERJ7RyeSf8QkzTE7tDVtm6xihZeI8KOXM5j1utd+i6SvP56e2/JWxTSYX2GXsAlftAsWLnHtOFehu5AiwiFQxYS8lT2PfqeJE2tTKLmIrct
 6ZQ3yBJe5INbYFYeWq4ySCwCCl8RZ7Qbg5Jf51zi0NXqEdy4M8pm5ImSnvDcuOnf3mn/iDG2Nuy4OPEIU4ByYr9UfRX/YEnH3ufe84yxQtp/p/OOtTJV0MLf
 LArW8jqmpmxnU3SUUFAWzMQvY6vzkyK6Cn8OJpKxBDk4qaFt8U9icaPz5R3XhS/NslNlxGqvoWTOpedyfKc2Zp7NSHu3THdvqv28nB4y3TQcWFgeIvLMslu/
 RaTiUXPJI2yg5Gd3/7s/ffhWVQTia38iVoVZ9T7d3119js/rivwpy3oeWeUOplAPZXnqtx1zgvSMNs2HmukRyXCvPVlNkTs+ekAlmrV8cgC6fA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to have a working nfsroot through RNDIS on sunxi I've found
that in bootargs <autoconf> must be set to 'off' to use a static ip setup,
but I've also found that the following boards have it set to 'on' that is
not the <autoconf> setting for static ip as stated here:
https://www.kernel.org/doc/Documentation/filesystems/nfs/nfsroot.txt

And most of all on sunxi RNDIS it doesn't work as static ip nfsroot.

Unfortunately I don't have such boards to give a build and a test, so if
there is someone who could give a try it would be great.

Best regards
---
Giulio Benetti
Benetti Engineering sas

Giulio Benetti (7):
  ARM: dts: mmp2-brownstone: fix wrong static ip autoconf
  ARM: dts: pxa168-aspenite: fix wrong static ip autoconf
  ARM: dts: pxa910-dkb: fix wrong static ip autoconf
  ARM: mmp2: update mmp2_defconfig to fix wrong static ip autoconf
  ARM: pxa168: update pxa168_defconfig to fix wrong static ip autoconf
  ARM: pxa3xx: update pxa3xx_defconfig to fix wrong static ip autoconf
  ARM: pxa910: update pxa910_defconfig to fix wrong static ip autoconf

 arch/arm/boot/dts/mmp2-brownstone.dts | 2 +-
 arch/arm/boot/dts/pxa168-aspenite.dts | 2 +-
 arch/arm/boot/dts/pxa910-dkb.dts      | 2 +-
 arch/arm/configs/mmp2_defconfig       | 2 +-
 arch/arm/configs/pxa168_defconfig     | 2 +-
 arch/arm/configs/pxa3xx_defconfig     | 2 +-
 arch/arm/configs/pxa910_defconfig     | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.25.1

