Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938DD3DCA8D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 09:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhHAHik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 03:38:40 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:60414 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhHAHih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 03:38:37 -0400
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 29841F40868; Sun,  1 Aug 2021 09:38:25 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Ash Logan <ash@heyquark.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] nvmem: nintendo-otp: Add new driver for the Wii and Wii U OTP
Date:   Sun,  1 Aug 2021 09:38:17 +0200
Message-Id: <20210801073822.12452-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210701225743.14631-1-linkmauve@linkmauve.fr>
References: <20210701225743.14631-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OTP is a read-only memory area which contains various keys and
signatures used to decrypt, encrypt or verify various pieces of storage.

Its size depends on the console, it is 128 bytes on the Wii and
1024 bytes on the Wii U (split into eight 128 bytes banks).

It can be used directly by writing into one register and reading from
the other one, without any additional synchronisation.

This series has been tested on both the Wii U (using my downstream
master-wiiu branch[1]), as well as on the Wii on mainline.

[1] https://gitlab.com/linkmauve/linux-wiiu/-/commits/master-wiiu

Changes since v1:
- Fixed the commit messages so they can be accepted by other email
  servers, sorry about that.

Changes since v2:
- Switched the dt binding documentation to YAML.
- Used more obvious register arithmetic, and tested that gcc (at -O1 and
  above) outputs the exact same rlwinm instructions for them.
- Use more #defines to make the code easier to read.
- Include some links to the reversed documentation.
- Avoid overlapping dt regions by changing the existing control@d800100
  node to end before the OTP registers, with some bigger dt refactoring
  left for a future series.

Changes since v3:
- Relicense the dt-binding documentation under GPLv2-only or
  BSD-2-clauses.

Emmanuel Gil Peyrot (5):
  nvmem: nintendo-otp: Add new driver for the Wii and Wii U OTP
  dt-bindings: nintendo-otp: Document the Wii and Wii U OTP support
  powerpc: wii.dts: Reduce the size of the control area
  powerpc: wii.dts: Expose the OTP on this platform
  powerpc: wii_defconfig: Enable OTP by default

 .../bindings/nvmem/nintendo-otp.yaml          |  44 +++++++
 arch/powerpc/boot/dts/wii.dts                 |  13 +-
 arch/powerpc/configs/wii_defconfig            |   1 +
 drivers/nvmem/Kconfig                         |  11 ++
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/nintendo-otp.c                  | 124 ++++++++++++++++++
 6 files changed, 194 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
 create mode 100644 drivers/nvmem/nintendo-otp.c

-- 
2.32.0

