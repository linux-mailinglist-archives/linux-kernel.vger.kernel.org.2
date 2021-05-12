Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A6737BF8B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhELOOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:14:45 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:36021 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhELOOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:14:15 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D713E2224E;
        Wed, 12 May 2021 16:13:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620828785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0IUiD20jWaXc9GDvz9cnvvt/m2/qUjY9WWIGbn040jA=;
        b=sNM47TXy9w4/dt702d5w3yhYARqcBbkczYui3gcSieYdlHhgJc3sUL2N4TilpkC/lNFfa3
        fCioKMeCo+IPpZR87pFNHRaCvSjU0qeqRAdX2I7iftayyMqjrs6EfbHFXTdVhGK5TT/Bk1
        lQPyCK+O4u+ljRS0agkA1EH2VWr6AOg=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Johan Hovold <johan@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 0/9] serial: fsl_lpuart: sysrq, loopback support and fixes
Date:   Wed, 12 May 2021 16:12:46 +0200
Message-Id: <20210512141255.18277-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Give fsl_lpuart some love and add break, loopback and sysrq support. While
at it, some errors were noticed, which are also fixed in this series.

The sysrq support was tested on both interrupt driven and DMA based
transfers on the 32bit LPUART.

Changes since v1:
 - rephrased commit message of
     serial: fsl_lpuart: don't restore interrupt state in ISR
   Sorry again, I didn't want to take credit of that sentence.
 - rephrased commit message and split into two patches:
     serial: fsl_lpuart: handle break and make sysrq work
   Esp. drop the mention of a possible deadlock as it turns out
   it isn't one.
 - remove the spin_trylock_irqsave() special case for sysrq handling

Michael Walle (9):
  serial: fsl_lpuart: don't modify arbitrary data on lpuart32
  serial: fsl_lpuart: use UARTDATA_MASK macro
  serial: fsl_lpuart: don't restore interrupt state in ISR
  serial: fsl_lpuart: split sysrq handling
  serial: fsl_lpuart: handle break and make sysrq work
  serial: fsl_lpuart: remove RTSCTS handling from get_mctrl()
  serial: fsl_lpuart: remove manual RTSCTS control from 8-bit LPUART
  serial: fsl_lpuart: add loopback support
  serial: fsl_lpuart: disable DMA for console and fix sysrq

 drivers/tty/serial/fsl_lpuart.c | 132 +++++++++++++++++---------------
 1 file changed, 72 insertions(+), 60 deletions(-)

-- 
2.20.1

