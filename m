Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0FC413CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 23:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhIUVlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 17:41:18 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:33938 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbhIUVlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:41:16 -0400
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 88C64F40B68; Tue, 21 Sep 2021 23:39:43 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     linux-crypto@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Ash Logan <ash@heyquark.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/4] crypto: nintendo-aes - add a new AES driver
Date:   Tue, 21 Sep 2021 23:39:26 +0200
Message-Id: <20210921213930.10366-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This engine implements AES in CBC mode, using 128-bit keys only.  It is
present on both the Wii and the Wii U, and is apparently identical in
both consoles.

The hardware is capable of firing an interrupt when the operation is
done, but this driver currently uses a busy loop, I’m not too sure
whether it would be preferable to switch, nor how to achieve that.

It also supports a mode where no operation is done, and thus could be
used as a DMA copy engine, but I don’t know how to expose that to the
kernel or whether it would even be useful.

In my testing, on a Wii U, this driver reaches 80.7 MiB/s, while the
aes-generic driver only reaches 30.9 MiB/s, so it is a quite welcome
speedup.

This driver was written based on reversed documentation, see:
https://wiibrew.org/wiki/Hardware/AES

Emmanuel Gil Peyrot (4):
  crypto: nintendo-aes - add a new AES driver
  dt-bindings: nintendo-aes: Document the Wii and Wii U AES support
  powerpc: wii.dts: Expose the AES engine on this platform
  powerpc: wii_defconfig: Enable AES by default

 .../bindings/crypto/nintendo-aes.yaml         |  34 +++
 arch/powerpc/boot/dts/wii.dts                 |   7 +
 arch/powerpc/configs/wii_defconfig            |   4 +-
 drivers/crypto/Kconfig                        |  11 +
 drivers/crypto/Makefile                       |   1 +
 drivers/crypto/nintendo-aes.c                 | 273 ++++++++++++++++++
 6 files changed, 329 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/nintendo-aes.yaml
 create mode 100644 drivers/crypto/nintendo-aes.c

-- 
2.33.0

