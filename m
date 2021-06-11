Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121583A3B58
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 07:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhFKF26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 01:28:58 -0400
Received: from router.aksignal.cz ([62.44.4.214]:41450 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhFKF24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 01:28:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 7974D44429;
        Fri, 11 Jun 2021 07:26:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id F89H1A2PLSLa; Fri, 11 Jun 2021 07:26:56 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id C82CA4441F;
        Fri, 11 Jun 2021 07:26:55 +0200 (CEST)
From:   Jiri Prchal <jiri.prchal@aksignal.cz>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v9 0/5] add support for FRAM
Date:   Fri, 11 Jun 2021 07:26:47 +0200
Message-Id: <20210611052652.7894-1-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for Cypress FRAMs.

Jiri Prchal (5):
  nvmem: prepare basics for FRAM support
  nvmem: eeprom: at25: add support for FRAM
  dt-bindings: nvmem: at25: add for FRAM support
  nvmem: eeprom: at25: export FRAM serial num
  nvmem: eeprom: add documentation of sysfs fram and sernum file

 .../ABI/testing/sysfs-class-spi-eeprom        |  20 +++
 .../devicetree/bindings/eeprom/at25.yaml      |  31 +++-
 drivers/misc/eeprom/Kconfig                   |   5 +-
 drivers/misc/eeprom/at25.c                    | 161 ++++++++++++++----
 drivers/nvmem/core.c                          |   4 +
 include/linux/nvmem-provider.h                |   1 +
 6 files changed, 184 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-spi-eeprom

-- 
2.25.1

