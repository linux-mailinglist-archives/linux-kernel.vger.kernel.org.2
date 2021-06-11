Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C3C3A3F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhFKJsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:48:06 -0400
Received: from router.aksignal.cz ([62.44.4.214]:58798 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhFKJsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:48:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 7B5EA416D4;
        Fri, 11 Jun 2021 11:46:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id kXTd4OXiWUK4; Fri, 11 Jun 2021 11:46:05 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id D755441210;
        Fri, 11 Jun 2021 11:46:04 +0200 (CEST)
From:   Jiri Prchal <jiri.prchal@aksignal.cz>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v10 0/4] add support for FRAM
Date:   Fri, 11 Jun 2021 11:45:57 +0200
Message-Id: <20210611094601.95131-1-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for Cypress FRAMs.

Jiri Prchal (4):
  nvmem: prepare basics for FRAM support
  nvmem: eeprom: at25: add support for FRAM
  dt-bindings: nvmem: at25: add for FRAM support
  nvmem: eeprom: at25: export FRAM serial num

 .../ABI/testing/sysfs-class-spi-eeprom        |  19 +++
 .../devicetree/bindings/eeprom/at25.yaml      |  31 +++-
 drivers/misc/eeprom/Kconfig                   |   5 +-
 drivers/misc/eeprom/at25.c                    | 161 ++++++++++++++----
 drivers/nvmem/core.c                          |   4 +
 include/linux/nvmem-provider.h                |   1 +
 6 files changed, 183 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-spi-eeprom

-- 
2.25.1

