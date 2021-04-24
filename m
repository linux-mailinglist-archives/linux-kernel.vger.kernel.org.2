Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC31636A12B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 14:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbhDXMiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 08:38:20 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:55062 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhDXMiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 08:38:14 -0400
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id AE45CF4045D; Sat, 24 Apr 2021 14:30:48 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        devicetree@vger.kernel.org
Subject: [PATCH 0/4] eeprom-93xx46: Add support for Atmel AT93C56 and AT93C66
Date:   Sat, 24 Apr 2021 14:30:29 +0200
Message-Id: <20210424123034.11755-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two devices differ from the AT93C46 by their storage size,
respectively 2 Kib and 4 Kib, while the AT93C46 contains 1 Kib.

The driver was currently hardcoding that addrlen == 7 means 8-bit words,
and anything else means 16-bit words.  This is obviously not going to
work with more storage and thus more bits spent on the address (for
instance on the AT93C66 in 8-bit words mode, addrlen == 9 since there
are 512 bytes to address), so I’m now doing those checks based on the
word size specified in the device tree.

It might make sense to rename this driver now that it supports all three
sizes, but I don’t know what would be a good name, eeprom_93xxx6 doesn’t
sound very nice.

I have tested this series on a Nintendo Wii U, on the downstream
linux-wiiu kernel based on 4.19, and thus only with a AT93C66.  You can
find this work here if you want to test it:
https://gitlab.com/linux-wiiu/linux-wiiu/-/merge_requests/16

Emmanuel Gil Peyrot (4):
  misc: eeprom_93xx46: Add new at93c56 and at93c66 compatible strings
  misc: eeprom_93xx46: set size and addrlen according to the dts
  misc: eeprom_93xx46: Compute bits based on addrlen
  misc: eeprom_93xx46: Switch based on word size, not addrlen

 .../bindings/misc/eeprom-93xx46.txt           |  3 +
 drivers/misc/eeprom/eeprom_93xx46.c           | 85 ++++++++++++++-----
 include/linux/eeprom_93xx46.h                 |  3 +
 3 files changed, 68 insertions(+), 23 deletions(-)

-- 
2.31.1

