Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268B736A32A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 23:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhDXV0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 17:26:30 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:32848 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhDXV03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 17:26:29 -0400
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 77F15F4043B; Sat, 24 Apr 2021 23:25:49 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        linux-kernel@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/3] eeprom-93xx46: Add support for Atmel AT93C56 and AT93C66
Date:   Sat, 24 Apr 2021 23:25:40 +0200
Message-Id: <20210424212543.13929-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210424123034.11755-1-linkmauve@linkmauve.fr>
References: <20210424123034.11755-1-linkmauve@linkmauve.fr>
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

Changes since v1:
- Reordered and squashed patches.
- Split out the dts addition.
- Removed a bogus goto.
- Improved commit messages to make what they do more explicit.

Emmanuel Gil Peyrot (3):
  misc: eeprom_93xx46: Remove hardcoded bit lengths
  misc: eeprom_93xx46: Add new 93c56 and 93c66 compatible strings
  dts: eeprom-93xx46: Add support for 93C46, 93C56 and 93C66

 .../bindings/misc/eeprom-93xx46.txt           |  3 +
 drivers/misc/eeprom/eeprom_93xx46.c           | 90 +++++++++++++------
 include/linux/eeprom_93xx46.h                 |  3 +
 3 files changed, 69 insertions(+), 27 deletions(-)

-- 
2.31.1

