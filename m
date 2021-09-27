Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7B641A09D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbhI0Uzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbhI0Uze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:55:34 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB28DC061575;
        Mon, 27 Sep 2021 13:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=g4A0NSRi31vvXLwvt3b9nsg1g99lBx3cBcUDT11Y28E=; b=RgFoc+Tl+COUxGSeqeOvUMJV7U
        WFb9SKMJnSmbUgxcmFfPGJcxMGZyGjVUMBenkG6XyARHyQiuTJsIzibPSHNHxoprvJHpbJRQOWw1I
        8Sn5cpd9QnXRZACE5Cz1t6v6pLtMWZheZlwbZV4xWUeFkvCThXax3UE5I5iwjc1RR9/h/gyxVvfFd
        ZyzmtMPHpyp7cIv/c5qZ/Z9b1BbACClO95AYaSvZCZLZ6hF8P/P5/Bdk687rjImYavkp6z8bLE9+/
        AU4Cd3SGmaFcn5CQm38+KkZDXpoCy5HtrSWvUKeaYquOAhSCoAw7AtShx4nR56clRsbmuHZuWFxLK
        YECOuhfQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUxdL-004HJM-7W; Mon, 27 Sep 2021 20:53:55 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Perry Yuan <Perry.Yuan@dell.com>, Dell.Client.Kernel@dell.com,
        platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Subject: [PATCH] platform: dell: all DELL_WMI driver options depend on DELL_WMI
Date:   Mon, 27 Sep 2021 13:53:54 -0700
Message-Id: <20210927205354.19342-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A randconfig or a user can set/enable DELL_WMI_PRIVACY even when
DELL_WMI is not enabled. This leads to a build error in
dell-laptop.o:

ld: drivers/platform/x86/dell/dell-laptop.o: in function `dell_init':
dell-laptop.c:(.init.text+0x719): undefined reference to `dell_privacy_has_mic_mute'

Fix this by enclosing the DELL_WMI driver options inside a
if DELL_WMI / endif bracket.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Perry Yuan <Perry.Yuan@dell.com>
Cc: Dell.Client.Kernel@dell.com
Cc: platform-driver-x86@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <mgross@linux.intel.com>
---
Found in linux-next, applies to mainline.

The last time that I sent a patch to Perry Yuan (about 2 weeks ago),
it bounced...

 drivers/platform/x86/dell/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-next-20210927.orig/drivers/platform/x86/dell/Kconfig
+++ linux-next-20210927/drivers/platform/x86/dell/Kconfig
@@ -164,6 +164,8 @@ config DELL_WMI
 	  To compile this driver as a module, choose M here: the module will
 	  be called dell-wmi.
 
+if DELL_WMI
+
 config DELL_WMI_PRIVACY
 	bool "Dell WMI Hardware Privacy Support"
 	depends on LEDS_TRIGGER_AUDIO = y || DELL_WMI = LEDS_TRIGGER_AUDIO
@@ -198,6 +200,8 @@ config DELL_WMI_LED
 	  This adds support for the Latitude 2100 and similar
 	  notebooks that have an external LED.
 
+endif # DELL_WMI
+
 config DELL_WMI_SYSMAN
 	tristate "Dell WMI-based Systems management driver"
 	default m
