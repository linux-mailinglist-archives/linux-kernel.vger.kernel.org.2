Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE288388B18
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346393AbhESJwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:52:22 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:41936 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241573AbhESJwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:52:11 -0400
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 3896BF40627; Wed, 19 May 2021 11:50:46 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Ash Logan <ash@heyquark.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] nvmem: nintendo-otp: Add new driver for the Wii and Wii U OTP
Date:   Wed, 19 May 2021 11:50:40 +0200
Message-Id: <20210519095044.4109-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.31.1
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

This series has only been tested on the Wii U so far, using the
downstream 4.19 branch from linux-wiiu[1], but it should also work on
the Wii on mainline.

[1] https://gitlab.com/linux-wiiu/linux-wiiu

Changes since v1:
- Fixed the commit messages so they can be accepted by other email
  servers, sorry about that.

Emmanuel Gil Peyrot (4):
  nvmem: nintendo-otp: Add new driver for the Wii and Wii U OTP
  dt-bindings: nintendo-otp: Document the Wii and Wii U OTP support
  powerpc: wii.dts: Expose the OTP on this platform
  powerpc: wii_defconfig: Enable OTP by default

 .../bindings/nvmem/nintendo-otp.txt           |  14 +++
 arch/powerpc/boot/dts/wii.dts                 |   5 +
 arch/powerpc/configs/wii_defconfig            |   1 +
 drivers/nvmem/Kconfig                         |  11 ++
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/nintendo-otp.c                  | 115 ++++++++++++++++++
 6 files changed, 148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/nintendo-otp.txt
 create mode 100644 drivers/nvmem/nintendo-otp.c

-- 
2.31.1

