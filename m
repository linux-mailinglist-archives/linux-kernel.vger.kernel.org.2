Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D58435A264
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhDIPyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:54:17 -0400
Received: from router.aksignal.cz ([62.44.4.214]:36868 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhDIPyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:54:16 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Apr 2021 11:54:15 EDT
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 59F4A41211;
        Fri,  9 Apr 2021 17:47:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id EDYXkwSrg_ZP; Fri,  9 Apr 2021 17:47:25 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id B4DB64120E;
        Fri,  9 Apr 2021 17:47:24 +0200 (CEST)
From:   Jiri Prchal <jiri.prchal@aksignal.cz>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH 0/3] nvmem: eeprom: add support for FRAM
Date:   Fri,  9 Apr 2021 17:47:17 +0200
Message-Id: <20210409154720.130902-1-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds sopport for Cypress FRAMs.

Jiri Prchal (3):
  nvmem: eeprom: at25: add support for FRAM
  nvmem: eeprom: at25: add support for FRAM
  nvmem: eeprom: add documentation for FRAM

 .../devicetree/bindings/eeprom/at25.yaml      |  12 +-
 drivers/misc/eeprom/Kconfig                   |   5 +-
 drivers/misc/eeprom/at25.c                    | 151 ++++++++++++++----
 drivers/nvmem/core.c                          |   4 +
 include/linux/nvmem-provider.h                |   1 +
 5 files changed, 139 insertions(+), 34 deletions(-)

-- 
2.25.1

