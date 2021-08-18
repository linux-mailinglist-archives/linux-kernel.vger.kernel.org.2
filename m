Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07F63EF955
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 06:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbhHREbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 00:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbhHREbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 00:31:13 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D7FC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 21:30:39 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s11so936272pgr.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 21:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V2X/mxX2JsXaFx3uHx7XfXuFDu4h8hiqjhXj9NlMMhk=;
        b=ibL5UnsQt1SYxsp2yAMnW/YdrE++qVDdbpFlPIR6K3BB3E/EL9QLtKLHVpv/sb+A2I
         QqVNtNDjg0FxDzj3EGuspL3soU04SueY6DrCrix/Qoqq8dTCQLyXVmYf6RNjWzO42bit
         gKD2wuDNIoCJ39WY5UdovaLbVACpnXVsYjpOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V2X/mxX2JsXaFx3uHx7XfXuFDu4h8hiqjhXj9NlMMhk=;
        b=UnS604PDQUe6W2jrsRMchQQYLMgf9rcfEwgdUDPURL5da/OFF5iqq+9V92qm9ra73m
         kAGreBpl4tOxUf11FHYlSQwna940RNc3cdbMqbcp59Hl/J/mtmyFg9HGXYmGM/x1Obcq
         Nk+sAxkYoHT52GZoC9TGPGKaLlVr9LTW0xUg1FAxJjdMqrxKKVKR0ReNZ8xc1yIndOGE
         uysd5k2EPa45dTy6lGmwPJiGWyWOh5/Ka0v8R8cXkRyivMgJBba5UdwDW9iwxG/3IcF8
         +QPkCT6iKVdre8aRgpn6IaSZ8fZlJzSEOMhyFeR/mG0a2j3KE6F5kwe1OsKCZAldNDe0
         GRPg==
X-Gm-Message-State: AOAM531HzrFA1XZ4+TNGoXV/2Sptg2jdKNSBCCuTna0Hzdcpko+EV1FZ
        g3A6HiUeg/cnr2o/dTOe4aNwSA==
X-Google-Smtp-Source: ABdhPJw1ksquoom3IZ39xMEuJgVWQ1Q6NY25QexNmmpWeR1q+Q+a1R2JE3N7ucasubJfjonP0rUhJw==
X-Received: by 2002:a65:6454:: with SMTP id s20mr6888248pgv.18.1629261038655;
        Tue, 17 Aug 2021 21:30:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d15sm4164692pfd.115.2021.08.17.21.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 21:30:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 2/2] USB: EHCI: Add alias for Broadcom INSNREG
Date:   Tue, 17 Aug 2021 21:30:34 -0700
Message-Id: <20210818043035.1308062-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818043035.1308062-1-keescook@chromium.org>
References: <20210818043035.1308062-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4103; h=from:subject; bh=dbE9XtQqA1foyjO9XHfNdBcom5iwk3VUrY6aFfs8pzE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHIzqWW4Dnh2cHuYYKw2gyNoMoIme6IWK0iCv0MPN OeoYX/qJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyM6gAKCRCJcvTf3G3AJrzhD/ wNbeAOjAr4lW8fDMrecWwpHX2eXvTr+XMm96DimUg6tIH97iX+zEiP/9LjKFgvWIhwHvSugqbqLoHa eUmVDy+RkwFaLrCMkHxelC1gbzIvhbXP7he27rf8K9ui3oZPgesGPUMlJ8UnD7BiZ0DADVCLb8fJU9 jCvr35gJxbNf181nJ/gfvBF/u7C7ttBEUwRmaRqwa9kkfLjtYUchTJnbG7Su+UEZGfBBBWUPu98t5I n2oswPAhqcZaz+x/+iCXv47PJLxV2dcnGjgo3s5tdvFnd3YXUcK/5HKvCJDHXF/3E601O2H4Rq6Ra4 7ey2FrXPEzrIlWqn+NoxdDzd2dy2+kgiQmMzmyvVA4VWcjctVybZ7TXnpIHztvAz8sqxG2OQkXdrpJ s23ivnmbQwqHZfH1B8KnDVmxbyA5nGGTSZeHENa9SeEMYUwTufITBXjLsczZN7cvQMNH5EbE8zzFgx 12JdzIB8Du2HLuMKXNGmdTQI/yRCqOYwrdIfmG1U20A4X300ZqJ59DBzopOAwdVGwska3cInzLVvSA 5eNRr0ne5IpWzUISrAp/BiD/vZ/Rszu2ihREt62Kqx2PsCS/wSQy7XR9v7AkgF1uDbKEVAVxsn9ZD1 yHngqYzMN0HRFHb+yHnU5mVeMfHrIlOZ+T6Zrd2lAnucoWpkmIMH6sttrNcw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor struct ehci_regs to avoid accessing beyond the end of
port_status. This change results in no difference in the resulting
object code.

Avoids several warnings when building with -Warray-bounds:

drivers/usb/host/ehci-brcm.c: In function 'ehci_brcm_reset':
drivers/usb/host/ehci-brcm.c:113:32: warning: array subscript 16 is above array bounds of 'u32[15]' {aka 'unsigned int[15]'} [-Warray-bounds]
  113 |  ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/usb/host/ehci.h:274,
                 from drivers/usb/host/ehci-brcm.c:15:
./include/linux/usb/ehci_def.h:132:7: note: while referencing 'port_status'
  132 |   u32 port_status[HCS_N_PORTS_MAX];
      |       ^~~~~~~~~~~

Note that the documentation around this proprietary register is
confusing. If "USB_EHCI_INSNREG00" is at port_status[0x0f], its offset
would be 0x80 (not 0x90). The code uses port_status[0x10], so is that
not using "USB_EHCI_INSNREG00"?

Perhaps port_status[0x10] is USB_EHCI_INSNREG01 and port_status[0x12]
is USB_EHCI_INSNREG03? If so, the union could be adjusted to better
represent the layout.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Al Cooper <alcooperx@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 9df231511bd6 ("usb: ehci: Add new EHCI driver for Broadcom STB SoC's")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/usb/host/ehci-brcm.c | 11 +++++------
 include/linux/usb/ehci_def.h | 16 ++++++++++++++--
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/ehci-brcm.c b/drivers/usb/host/ehci-brcm.c
index 3e0ebe8cc649..5d232d3701f9 100644
--- a/drivers/usb/host/ehci-brcm.c
+++ b/drivers/usb/host/ehci-brcm.c
@@ -110,8 +110,8 @@ static int ehci_brcm_reset(struct usb_hcd *hcd)
 	 *   bus usage
 	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x90
 	 */
-	ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
-	ehci_writel(ehci, 0x00000001, &ehci->regs->port_status[0x12]);
+	ehci_writel(ehci, 0x00800040, &ehci->regs->brcm_insnreg[0]);
+	ehci_writel(ehci, 0x00000001, &ehci->regs->brcm_insnreg[2]);
 
 	return ehci_setup(hcd);
 }
@@ -223,11 +223,10 @@ static int __maybe_unused ehci_brcm_resume(struct device *dev)
 	/*
 	 * SWLINUX-1705: Avoid OUT packet underflows during high memory
 	 *   bus usage
-	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00
-	 * @ 0x90
+	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x90
 	 */
-	ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
-	ehci_writel(ehci, 0x00000001, &ehci->regs->port_status[0x12]);
+	ehci_writel(ehci, 0x00800040, &ehci->regs->brcm_insnreg[0]);
+	ehci_writel(ehci, 0x00000001, &ehci->regs->brcm_insnreg[2]);
 
 	ehci_resume(hcd, false);
 
diff --git a/include/linux/usb/ehci_def.h b/include/linux/usb/ehci_def.h
index 5398f571113b..86f0909cab99 100644
--- a/include/linux/usb/ehci_def.h
+++ b/include/linux/usb/ehci_def.h
@@ -182,11 +182,23 @@ struct ehci_regs {
  * its EHCI controller has both TT and LPM support. HOSTPCx are extensions to
  * PORTSCx
  */
-	/* HOSTPC: offset 0x84 */
-	u32		hostpc[HCS_N_PORTS_MAX];
+	union {
+		/* HOSTPC: offset 0x84 */
+		u32	hostpc[HCS_N_PORTS_MAX];
 #define HOSTPC_PHCD	(1<<22)		/* Phy clock disable */
 #define HOSTPC_PSPD	(3<<25)		/* Port speed detection */
 
+		/*
+		 * This was originally documented as:
+		 * "port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x90"
+		 * but this doesn't make sense: the code was using
+		 * port_status[0x10]. port_status[0x0f] would be reserved4.
+		 * Also, none of these are near 0x90. port_status[0x10] is
+		 * offset 0x84, and port_status[0x0f] would be 0x80.
+		 */
+		u32	brcm_insnreg[3];
+	};
+
 	u32		reserved5[2];
 
 	/* USBMODE_EX: offset 0xc8 */
-- 
2.30.2

