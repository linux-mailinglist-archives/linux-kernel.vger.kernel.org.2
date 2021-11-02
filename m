Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B656443831
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 23:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhKBWFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 18:05:15 -0400
Received: from ms.lwn.net ([45.79.88.28]:53374 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231435AbhKBWE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:04:56 -0400
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 4349A5ED5;
        Tue,  2 Nov 2021 22:02:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4349A5ED5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1635890541; bh=sOvuzkedV2G+rjKxMbKHFtNpi+hURuSCtmrA/GWze3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EhLhQ3kSwz+nPj9l9U8CZkxYEltLWloHnoPepCpl67dWam1/lKdAZrAj+20mFz1LR
         9yJ/gpvxqFrkOXvhOlEL5ymx69t7eKVriPbWwShnN5iR7eBuK2qYNJAV0IOlQikc7x
         Br3zkDV8ES+hMwdxsLACp6Z3LA2T/V0hcIZid9EDe7jd6Y/sIq1i6X+3VgDmh4uk2X
         DQtI6yc8/AEcIbaDrYi8Cm5QRELGoJTLZFSwkzvq6C4uTq+SKgNMV+b/4WaTY+YI+a
         hXPIqOi3QyvSpddEBu6rlTEn8ox+bev3rDhV+x1RmYW97LLg8wVuHhJfwmb3wKCpCl
         70fMhH2k5KDeA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Marek Vasut <marex@denx.de>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 9/9] net: remove unused header file <linux/ks8851_mll.h>
Date:   Tue,  2 Nov 2021 16:02:03 -0600
Message-Id: <20211102220203.940290-10-corbet@lwn.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211102220203.940290-1-corbet@lwn.net>
References: <20211102220203.940290-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 72628da6d634 ("net: ks8851: Remove ks8851_mll.c") removed the only
use of <linux/ks8851_mll.h>, but left the header file in place.  Nothing
uses that file, delete it now.

Cc: Marek Vasut <marex@denx.de>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 include/linux/ks8851_mll.h | 21 ---------------------
 1 file changed, 21 deletions(-)
 delete mode 100644 include/linux/ks8851_mll.h

diff --git a/include/linux/ks8851_mll.h b/include/linux/ks8851_mll.h
deleted file mode 100644
index 57c0a39ed796..000000000000
--- a/include/linux/ks8851_mll.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * ks8861_mll platform data struct definition
- * Copyright (c) 2012 BTicino S.p.A.
- */
-
-#ifndef _LINUX_KS8851_MLL_H
-#define _LINUX_KS8851_MLL_H
-
-#include <linux/if_ether.h>
-
-/**
- * struct ks8851_mll_platform_data - Platform data of the KS8851_MLL network driver
- * @macaddr:	The MAC address of the device, set to all 0:s to use the on in
- *		the chip.
- */
-struct ks8851_mll_platform_data {
-	u8 mac_addr[ETH_ALEN];
-};
-
-#endif
-- 
2.31.1

