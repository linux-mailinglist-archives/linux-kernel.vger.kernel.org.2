Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF1C37AFD1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 22:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhEKUDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 16:03:10 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:59297 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhEKUDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 16:03:09 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 356D922259;
        Tue, 11 May 2021 22:02:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620763320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tCAnKmXbjVfFemDXMFG3VRAzPQoqVYwxxbRNsfm3ekU=;
        b=WWdS7cRK0KiGewW1DQX7MnohDVGT+ts3N7p2a+A7+2kADACb567+PvnJYU3aNwDbp0egc/
        PVN01QuMsrcmI/2YhG6nuEj9J9raUrfHbDXjOtirV0RQnol9rfWcQTPqLTa53F3xcVNuxx
        7oZDTVzHrfaFlXXG0Tt4hwFWvlBcDnE=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 0/8] serial: fsl_lpuart: sysrq, loopback support and fixes
Date:   Tue, 11 May 2021 22:01:40 +0200
Message-Id: <20210511200148.11934-1-michael@walle.cc>
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

Michael Walle (8):
  serial: fsl_lpuart: don't modify arbitrary data on lpuart32
  serial: fsl_lpuart: use UARTDATA_MASK macro
  serial: fsl_lpuart: don't restore interrupt state in ISR
  serial: fsl_lpuart: handle break and make sysrq work
  serial: fsl_lpuart: remove RTSCTS handling from get_mctrl()
  serial: fsl_lpuart: remove manual RTSCTS control from 8-bit LPUART
  serial: fsl_lpuart: add loopback support
  serial: fsl_lpuart: disable DMA for console and fix sysrq

 drivers/tty/serial/fsl_lpuart.c | 126 +++++++++++++++++---------------
 1 file changed, 69 insertions(+), 57 deletions(-)

-- 
2.20.1

