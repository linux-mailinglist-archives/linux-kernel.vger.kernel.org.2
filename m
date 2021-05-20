Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE4C389D44
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 07:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhETFsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 01:48:42 -0400
Received: from router.aksignal.cz ([62.44.4.214]:55444 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETFsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 01:48:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id A20C045C48;
        Thu, 20 May 2021 07:47:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id mfPZ3LPoSi2H; Thu, 20 May 2021 07:47:18 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id 8047145C45;
        Thu, 20 May 2021 07:47:17 +0200 (CEST)
From:   Jiri Prchal <jiri.prchal@aksignal.cz>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v4 0/4] add support for FRAM
Date:   Thu, 20 May 2021 07:47:10 +0200
Message-Id: <20210520054714.8736-1-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for Cypress FRAMs.

Jiri Prchal (4):
  nvmem: eeprom: at25: add support for FRAM
  nvmem: eeprom: at25: add support for FRAM
  nvmem: eeprom: add documentation for FRAM
  nvmem: eeprom: at25: export FRAM serial num

 .../devicetree/bindings/eeprom/at25.yaml      |  31 ++-
 drivers/misc/eeprom/Kconfig                   |   5 +-
 drivers/misc/eeprom/at25.c                    | 177 +++++++++++++++---
 drivers/nvmem/core.c                          |   4 +
 include/linux/nvmem-provider.h                |   1 +
 5 files changed, 180 insertions(+), 38 deletions(-)

--
v2: fixes in some files
v3: resend and added more recipients
v4: resend
---
2.25.1

