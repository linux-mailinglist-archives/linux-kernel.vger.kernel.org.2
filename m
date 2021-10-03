Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57D241FED9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 02:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhJCAEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 20:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbhJCAEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 20:04:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57843C0613EC;
        Sat,  2 Oct 2021 17:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=omHdQW8RoUi6ifbhhHmVnPn0+e1h6W72GazCfAP8OU0=; b=0ZUD4MHG6qPchZNa8EQnH2kNrY
        lRb31Wc/RnFjAEEgHvsFjYvOHaZPxH2sEMvlNo6EOH6miLAEgpZD8unein9YFR7vk3pzEVjthekMu
        3wSlcvVhwi523wey4lbpohoFUs2+IWeCx5xDCmGjoRAiw3NqEzASlm/1IjLAyLxxmVbWUGmFSos6i
        WRXFy4tZeinPgTWEKex3bfh6CB6jAahc2Jcdp67npYOwFUzJCbc/sN5SQ502DItyMVLWZT+tShMVP
        kCEOf2MYr/j6okRjk6byyWIxnH5MzEPWqmh8qzt+u07LC6NOuDv7HP7sKdOqoIXHw5tqByOzGpYHb
        +ldMYI7g==;
Received: from [2601:1c0:6280:3f0:e65e:37ff:febd:ee53] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWoxU-002vzh-FQ; Sun, 03 Oct 2021 00:02:24 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [RFC PATCH] m68k: set a default value for MEMORY_RESERVE
Date:   Sat,  2 Oct 2021 17:02:23 -0700
Message-Id: <20211003000223.25769-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'make randconfig' can produce a .config file with
"CONFIG_MEMORY_RESERVE=" (no value) since it has no default.
When a subsequent 'make all' is done, kconfig restarts the config
and prompts for a value for MEMORY_RESERVE. This breaks
scripting/automation where there is no interactive user input.

Add a default value for MEMORY_RESERVE. (Any integer value will
work here for kconfig.)

Fixes a kconfig warning:

.config:214:warning: symbol value '' invalid for MEMORY_RESERVE
* Restart config...
Memory reservation (MiB) (MEMORY_RESERVE) [] (NEW)

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2") # from beginning of git history
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
---
 arch/m68k/Kconfig.machine |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20211001.orig/arch/m68k/Kconfig.machine
+++ linux-next-20211001/arch/m68k/Kconfig.machine
@@ -203,6 +203,7 @@ config INIT_LCD
 config MEMORY_RESERVE
 	int "Memory reservation (MiB)"
 	depends on (UCSIMM || UCDIMM)
+	default 0
 	help
 	  Reserve certain memory regions on 68x328 based boards.
 
