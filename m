Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E471459832
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 00:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhKVXKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 18:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhKVXKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 18:10:06 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F9BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 15:06:59 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso10476638ota.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 15:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fNbh4iBAHtA98kCW/4qyB0yZvvbQ/JGxjB2BIT2nPCM=;
        b=SEUjHEAuj1Oke1LXdMd1FEwywDKBRx5VsImHR2as39yZmasjJsfjRyS4nk6gKUOGu1
         hC7LZjm+bydtVUXtsIAjADcwzUjkfVOG+j20a19BJE9IMSyGwLy/DFIWeO9OYRqd8Sxi
         2XlrRW7H7NSlaT/yoSnODNCjEeF9U4IJXEgwfYRSXFa+8wp6stEHKRqCgZ8OjCRNJ8oQ
         Ca1mc9wK0S7OOMfQXOl+FXqK8ySR5XavoiZX/BeL5AuXWUVdY8T54PxD+Ai3S/GGqTJt
         VltHoow615e/meIMMqBhtuQdC/LVDMiLGODUcIzonzMoXcfxAI6WpUwk6hGvzqOmUwrf
         dp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=fNbh4iBAHtA98kCW/4qyB0yZvvbQ/JGxjB2BIT2nPCM=;
        b=MOp3VOjcant8cj3i4ZXAnE70SDDn5nleDVSuz3qr6EG/BCHeJf8FZC4szGVLfjENH9
         wAtVlEWrsYj2nlcKIf+Y/Ot3OwfcSPIH4Ye+sdE6qU04WLLyZmLZnyEA2rTiLuTXEBT6
         gYFkeX0XGawQuItpzjId2fh9sZvvZ0ZzE7Wc6g5Ho9pi/1sIVdbmWdTWY+RQxPZ3Mq8V
         gVTmP17pfOLn2S2C4a1Cwldl1wZAwr/kQyDUgJGHavvMQKzOBoLr2NoRNEnPF3B7YqEJ
         kwY3Psje+k97AosaFLgXL3R7olEeXlJkaTicnK0sEiMWOOMVAt9c/Z+B2W9W2c4mdzOw
         JJsA==
X-Gm-Message-State: AOAM533cK0LkKOsjBm9z1VtjX1d4n/BCG8dhsIsBt0Bc7iGPNpuNOX22
        wtfmiggGyuD5OphDvdd1E2U=
X-Google-Smtp-Source: ABdhPJw7FwHd8+4Op4c6sBQCv1y8vRlTt/cK4rS3BYcjRarllz9egCpeccQl8HEkvID7eGtpIL3GYQ==
X-Received: by 2002:a9d:4702:: with SMTP id a2mr13348otf.262.1637622418769;
        Mon, 22 Nov 2021 15:06:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bi20sm2379591oib.29.2021.11.22.15.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 15:06:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Anton Altaparmakov <anton@tuxera.com>
Cc:     linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2] fs: ntfs: Disable NTFS_RW for PPC
Date:   Mon, 22 Nov 2021 15:06:53 -0800
Message-Id: <20211122230653.1779162-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS_RW code allocates page size dependent arrays on the stack. This
results in build failures if the page size is 64k, which is now the
default for PPC.

fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
fs/ntfs/aops.c:1311:1: error:
	the frame size of 2240 bytes is larger than 2048 bytes

Increasing the maximum frame size for PPC just to silence this error does
not really help. It would have to be set to a really large value for 256k
pages. Such a large frame size could potentially result in stack overruns
in this code and elsewhere and is therefore not desirable. Disable NTFS_RW
for PPC instead.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Introduce new configuration flag DISABLE_NTFS_RW and use it to disable NTFS_RW
    for PPC

 fs/ntfs/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ntfs/Kconfig b/fs/ntfs/Kconfig
index 1667a7e590d8..324224febb6a 100644
--- a/fs/ntfs/Kconfig
+++ b/fs/ntfs/Kconfig
@@ -49,8 +49,13 @@ config NTFS_DEBUG
 	  When reporting bugs, please try to have available a full dump of
 	  debugging messages while the misbehaviour was occurring.
 
+config DISABLE_NTFS_RW
+	bool
+	default y if PPC
+
 config NTFS_RW
 	bool "NTFS write support"
+	depends on !DISABLE_NTFS_RW
 	depends on NTFS_FS
 	help
 	  This enables the partial, but safe, write support in the NTFS driver.
-- 
2.33.0

