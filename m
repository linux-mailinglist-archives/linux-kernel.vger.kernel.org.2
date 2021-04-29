Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E810136E7ED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 11:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbhD2J02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 05:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhD2J00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:26:26 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C69C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:25:40 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h20so34437304plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=cUg5gt9a0rGTskMR4pfWJTFpTqoL0BNI5KgJEe9TUYQ=;
        b=AqjoPuz0Do8XdqjGTs1PDYYb/vAkMxQxlgzA8eI1Qq1Dv3hON6HPdxWzCKbW0D2SO+
         f6lKhCtK4nkgctmIAwANsjanx1oX14o9N5pC2jVTQcH2AzCu9h/LD7V3gvq9LKR1EYsb
         +Qs4Szb1payI8tppzDDg1CfoWDbXSt4X+kSfq8eQuJXjKj9kFgNSAyD0Ot3e1OyRmFu/
         NTnqbUDX4IEtfLwz7qtn06SQyZ0vJqO/gClc+Xv6w4rKVSY2wJKvjxiItokssdpgTAke
         qjK/ckaUj15yFSIaX6tVbkOcGQkkk3Fc2EgMW0LDKXq+DQbUh7DbaJI47XkL6HgZr8MS
         2TYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cUg5gt9a0rGTskMR4pfWJTFpTqoL0BNI5KgJEe9TUYQ=;
        b=hzWVF8nUQKoglj1WtsrWbImaAX2Kcf1m284a1d7AT8ASjb60vw5I2CX1bQ8VNficif
         4DvqnmEgvy06bnxoonLs7Mr03BzVIPGPulmej7ERrJSMwZm9XXdu8jdoa3MCn+J5Ug/T
         yYumZBqc66qavhEIbrWaalUCIbGtVWOYSbzCPCg5ap7WTC2qwzqsthGy26GLCaa1a+cr
         h/kIlXOT/4U2ifxKXPjlQs46jiDnQY75YI2bB1AQ8VUK8jgV1hLRwBm5KP8Ly5WmFiXq
         Nniu6Skk8gfv/IWizJbNeuSqh//w2TEkqfBWdt/pW6OhX+xEumZLOtYHA6pOLRiaK/Em
         uxvA==
X-Gm-Message-State: AOAM533ZhHmiDkJ1JelDMvC8FgdUWRMFPtHgjFjzX2RbCX8APPJXjHfO
        YOqHNFLhQWlz9nncb4M8Wt/hANwVgP2HQbY/
X-Google-Smtp-Source: ABdhPJyoWZVw3X44LypmlITfuvXw9XL2mXu0HzUuX47+Uegrj/vLe+l/NsJSqh+6FVo/OZd0WJ+40Q==
X-Received: by 2002:a17:902:be02:b029:ec:af1f:5337 with SMTP id r2-20020a170902be02b02900ecaf1f5337mr30518198pls.35.1619688339458;
        Thu, 29 Apr 2021 02:25:39 -0700 (PDT)
Received: from localhost ([115.99.169.0])
        by smtp.gmail.com with ESMTPSA id b21sm1850058pfl.82.2021.04.29.02.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 02:25:39 -0700 (PDT)
Date:   Thu, 29 Apr 2021 14:55:29 +0530
From:   Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
To:     linux@dominikbrodowski.net, bhelgaas@google.com, kw@linux.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Add blank line after declarations
Message-ID: <20210429092529.7zks3uk4yh6ttpux@sanjana-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Blank line is added after declarations to maintain code uniformity.

Signed-off-by: Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
---
 drivers/pcmcia/yenta_socket.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index e9da9c197ff1..c47158abf1d3 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -84,6 +84,7 @@ MODULE_PARM_DESC(override_bios, "yenta ignore bios resource allocation");
 static inline u32 cb_readl(struct yenta_socket *socket, unsigned reg)
 {
 	u32 val = readl(socket->base + reg);
+
 	debug("%04x %08x\n", socket, reg, val);
 	return val;
 }
@@ -98,6 +99,7 @@ static inline void cb_writel(struct yenta_socket *socket, unsigned reg, u32 val)
 static inline u8 config_readb(struct yenta_socket *socket, unsigned offset)
 {
 	u8 val;
+
 	pci_read_config_byte(socket->dev, offset, &val);
 	debug("%04x %02x\n", socket, offset, val);
 	return val;
@@ -106,6 +108,7 @@ static inline u8 config_readb(struct yenta_socket *socket, unsigned offset)
 static inline u16 config_readw(struct yenta_socket *socket, unsigned offset)
 {
 	u16 val;
+
 	pci_read_config_word(socket->dev, offset, &val);
 	debug("%04x %04x\n", socket, offset, val);
 	return val;
@@ -114,6 +117,7 @@ static inline u16 config_readw(struct yenta_socket *socket, unsigned offset)
 static inline u32 config_readl(struct yenta_socket *socket, unsigned offset)
 {
 	u32 val;
+
 	pci_read_config_dword(socket->dev, offset, &val);
 	debug("%04x %08x\n", socket, offset, val);
 	return val;
@@ -140,6 +144,7 @@ static inline void config_writel(struct yenta_socket *socket, unsigned offset, u
 static inline u8 exca_readb(struct yenta_socket *socket, unsigned reg)
 {
 	u8 val = readb(socket->base + 0x800 + reg);
+
 	debug("%04x %02x\n", socket, reg, val);
 	return val;
 }
@@ -147,6 +152,7 @@ static inline u8 exca_readb(struct yenta_socket *socket, unsigned reg)
 static inline u8 exca_readw(struct yenta_socket *socket, unsigned reg)
 {
 	u16 val;
+
 	val = readb(socket->base + 0x800 + reg);
 	val |= readb(socket->base + 0x800 + reg + 1) << 8;
 	debug("%04x %04x\n", socket, reg, val);
@@ -179,6 +185,7 @@ static ssize_t show_yenta_registers(struct device *yentadev, struct device_attri
 	offset = snprintf(buf, PAGE_SIZE, "CB registers:");
 	for (i = 0; i < 0x24; i += 4) {
 		unsigned val;
+
 		if (!(i & 15))
 			offset += scnprintf(buf + offset, PAGE_SIZE - offset, "\n%02x:", i);
 		val = cb_readl(socket, i);
@@ -188,6 +195,7 @@ static ssize_t show_yenta_registers(struct device *yentadev, struct device_attri
 	offset += scnprintf(buf + offset, PAGE_SIZE - offset, "\n\nExCA registers:");
 	for (i = 0; i < 0x45; i++) {
 		unsigned char val;
+
 		if (!(i & 7)) {
 			if (i & 8) {
 				memcpy(buf + offset, " -", 2);
@@ -227,6 +235,7 @@ static int yenta_get_status(struct pcmcia_socket *sock, unsigned int *value)
 		val |= (state & CB_PWRCYCLE) ? SS_POWERON | SS_READY : 0;
 	} else if (state & CB_16BITCARD) {
 		u8 status = exca_readb(socket, I365_STATUS);
+
 		val |= ((status & I365_CS_DETECT) == I365_CS_DETECT) ? SS_DETECT : 0;
 		if (exca_readb(socket, I365_INTCTL) & I365_PC_IOCARD) {
 			val |= (status & I365_CS_STSCHG) ? 0 : SS_STSCHG;
@@ -249,6 +258,7 @@ static void yenta_set_power(struct yenta_socket *socket, socket_state_t *state)
 	if (!(cb_readl(socket, CB_SOCKET_STATE) & CB_CBCARD) &&
 	    (socket->flags & YENTA_16BIT_POWER_EXCA)) {
 		u8 reg, old;
+
 		reg = old = exca_readb(socket, I365_POWER);
 		reg &= ~(I365_VCC_MASK | I365_VPP1_MASK | I365_VPP2_MASK);
 
@@ -297,7 +307,9 @@ static void yenta_set_power(struct yenta_socket *socket, socket_state_t *state)
 		if (reg != old)
 			exca_writeb(socket, I365_POWER, reg);
 	} else {
-		u32 reg = 0;	/* CB_SC_STPCLK? */
+		u32 reg = 0;
+
+		/* CB_SC_STPCLK? */
 		switch (state->Vcc) {
 		case 33:
 			reg = CB_SC_VCC_3V;
@@ -338,6 +350,7 @@ static int yenta_set_socket(struct pcmcia_socket *sock, socket_state_t *state)
 	bridge = config_readw(socket, CB_BRIDGE_CONTROL) & ~(CB_BRIDGE_CRST | CB_BRIDGE_INTR);
 	if (cb_readl(socket, CB_SOCKET_STATE) & CB_CBCARD) {
 		u8 intr;
+
 		bridge |= (state->flags & SS_RESET) ? CB_BRIDGE_CRST : 0;
 
 		/* ISA interrupt control? */
@@ -638,6 +651,7 @@ static int yenta_search_one_res(struct resource *root, struct resource *res,
 	} else {
 		unsigned long avail = root->end - root->start;
 		int i;
+
 		size = BRIDGE_MEM_MAX;
 		if (size > avail/8) {
 			size = (avail+1)/8;
@@ -763,6 +777,7 @@ static void yenta_free_res(struct yenta_socket *socket, int nr)
 static void yenta_allocate_resources(struct yenta_socket *socket)
 {
 	int program = 0;
+
 	program += yenta_allocate_res(socket, PCI_CB_BRIDGE_IO_0_WINDOW,
 			   IORESOURCE_IO,
 			   PCI_CB_IO_BASE_0, PCI_CB_IO_LIMIT_0);
-- 
2.25.1

