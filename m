Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D952135532D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343723AbhDFMJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:09:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:57681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238224AbhDFMJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617710975;
        bh=zBnK+44syl2uM55jlmjjhLfGyr8wgn/qMopLwX5egrE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=j5k0R4DQ1kRBLqfA+046ax+BoSURWxsp2AaWWDFK2O8gXmyMcWEBn5fLM6sOODC0m
         bCTprcavOvyYgsQ9xHx8CWPDiLb0nrtS78dKv+tto3xcajc0DJdKp8ppXS+BCLpt9y
         mheezDBTpSVVpnmZDyK/HDUabIQ6F/Xa/Z5PDgqk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuDc7-1liNWc0LEL-00uazz; Tue, 06
 Apr 2021 14:09:35 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     Tomer Maimon <tmaimon77@gmail.com>, Joel Stanley <joel@jms.id.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v2 00/10] Initial support for Nuvoton WPCM450 BMC SoC
Date:   Tue,  6 Apr 2021 14:09:11 +0200
Message-Id: <20210406120921.2484986-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n2PD0E0/Wi/cSfWgAnOHj8Pd6UsuT4wLld5XbnNo0UwDKU4q0+W
 I+BMIjHcMr8I1g5i39X3dK8Je1qhvLbD3LqaiJLEXLVhlMJSOjvXncxF6KjrHI1PPJhjUXf
 oh6bzrIEBxR+JLbNlKVI/kJz02DYCpzoVkNrO6rvv7Xf4IUZlXpEAq8RG25ZitCENpFZl5a
 qb9IhMnuXr0I0dz/FHXIA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:deAxC+E8twU=:7cGBMKnUUtXQ/AXZvLd9Y5
 MQfjBJMKk2gowyxOI4HoOnN5wlZZ00IdG+VwUq1fzWbz6yL/c3gNeighkENwrcQ8A2TNQ30IA
 rFQj1QYYSE8VbAINcwM4h0088hIC+qs+vZ7ZsDleuLXTF1txDreNx0bfRw1wX7pcnTnNm405J
 +FX6gQptSgEWJpMUOofPOd4IIEM0ULRZNjQGHT4n9xzuyslL/jFqvjvG/VGtCo+FJ9rGxF6nO
 NlIu2vTlurUJG94kQzCx5pImBeoKVV33MP3b08FVxisxMcDAW8Ds8U+WeVFsaQYxwC5F+TnY1
 E6TY9VL5Q57GKXOriBAvdaT7D7qZsw51tJzIkCxLik8LrUcjM1x/PAJ/7ul9FgVu3GnXHVvD4
 hNmiRwThC6GyUf+P5lhL34VWVPFqYH6KzaxgMh1ujoarRCEtdNZx3KKsvd88QEbKL++l1ERVi
 FJ2eIzIFGKkzU9iYlEUHW7b9RvZsgdHpSLFESogYkUqZRmYt5OrAKZqFStzpB4tGKO78bPRzQ
 CIyVKUbOmrzrKU5RqYxStoM6RdvS39so4lVX9mvG34DlqHOtpHvpKHpsi3/8Up+qYbGvtAC7h
 2vG95DjNkOygQajEm3UEA77+2FvY9co6kWYT9dIehael6dvq1D6iTCiZAKCH7slgIYMXyz8tn
 MTeN2vscmQcJk7pTq7RseLHR1CkI+bTZgNWEYipxEe3IP0/8aVnN0aFDo4Y/2rVmVIchSkbTc
 CmzR+9Wp96neuLBHghmEKFt2ypZfLJ/Hpki2afx74rY1RnGWBjysZ/gtNlBAf884SARYUh7ZJ
 0JremgqlxDx9bdo7+viAlIzjx0ZZr5ywt7d1aeNm72prdjfqGO5OaMU1qhtesw4CoYr5NHIv+
 jls8X1YinaC/9wGg28WI/tFHp6+7DSMbVIKHym7omwRdjAkoSagjCt/Ii2X8HIOdAatZT1//2
 Uvz1cFI9vA13ozw4moAiXAdYkAxmc8tD9qvAyNOxAGQlKA9Zvp7rJFJeLTGachaqcTt67QJ5G
 C3unwo71JCtr9y1vlBwi/978TD42H15BS8lSCtSVzaUH05hwjS7Qu/H6VbSAapCDogUmGTaow
 oxUEWvQZtvXZKp/LqMHKV8Y4jFR/nWrQHO6R9SIBQmPXCgaAXgYUdlPxM4ic2h7uCY1UEJrPb
 b2SVuMH1sKpcxcbl57H5E7aLuqnEIOHm0U5wogk3Yd2CSTehxHoOO63eYCybd0C+UIzodHZI9
 YBSuY6C7yeVfLFror
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic support for the Nuvoton WPCM450 BMC SoC. It's an ol=
der
SoC but still commonly found on eBay, mostly in Supermicro X9 server board=
s.

Third-party documentation is available at: https://github.com/neuschaefer/=
wpcm450/wiki

Patches 1-4 add devicetree bindings for the WPCM450 SoC and its various pa=
rts.
Patches 5-7 add arch and driver support. Patches 8 and 9 add a devicetree =
for
the SoC and a board based on it. Patch 10 finally updates the MAINTAINERS =
file.

Patch 2 requires "dt-bindings: arm: Convert nuvoton,npcm750 binding to YAM=
L"
(https://lore.kernel.org/lkml/20210320164023.614059-1-j.neuschaefer@gmx.ne=
t/)


v2:
- Various improvements to the AIC irqchip driver, thanks to Marc Zyngier's=
 review
- I dropped the timer patches, which have been applied by Daniel Lezcano
- I dropped the serial patches, which have been applied to tty-next by Gre=
g KH

v1:
- https://lore.kernel.org/lkml/20210320181610.680870-1-j.neuschaefer@gmx.n=
et/

Jonathan Neusch=C3=A4fer (10):
  dt-bindings: vendor-prefixes: Add Supermicro
  dt-bindings: arm: npcm: Add nuvoton,wpcm450 compatible string
  dt-bindings: interrupt-controller: Add nuvoton,wpcm450-aic
  dt-bindings: watchdog: npcm: Add nuvoton,wpcm450-wdt
  ARM: npcm: Introduce Nuvoton WPCM450 SoC
  irqchip: Add driver for WPCM450 interrupt controller
  watchdog: npcm: Add support for WPCM450
  ARM: dts: Add devicetree for Nuvoton WPCM450 BMC chip
  ARM: dts: Add devicetree for Supermicro X9SCi-LN4F based on WPCM450
  MAINTAINERS: Add entry for Nuvoton WPCM450

 .../devicetree/bindings/arm/npcm/npcm.yaml    |   6 +
 .../nuvoton,wpcm450-aic.yaml                  |  39 +++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 .../bindings/watchdog/nuvoton,npcm-wdt.txt    |   3 +-
 MAINTAINERS                                   |   9 +
 arch/arm/boot/dts/Makefile                    |   2 +
 .../nuvoton-wpcm450-supermicro-x9sci-ln4f.dts |  40 +++++
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi        |  76 +++++++++
 arch/arm/mach-npcm/Kconfig                    |  13 +-
 arch/arm/mach-npcm/Makefile                   |   1 +
 arch/arm/mach-npcm/wpcm450.c                  |  13 ++
 drivers/irqchip/Kconfig                       |   6 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-wpcm450-aic.c             | 161 ++++++++++++++++++
 drivers/watchdog/npcm_wdt.c                   |   1 +
 15 files changed, 371 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller=
/nuvoton,wpcm450-aic.yaml
 create mode 100644 arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4=
f.dts
 create mode 100644 arch/arm/boot/dts/nuvoton-wpcm450.dtsi
 create mode 100644 arch/arm/mach-npcm/wpcm450.c
 create mode 100644 drivers/irqchip/irq-wpcm450-aic.c

=2D-
2.30.2

