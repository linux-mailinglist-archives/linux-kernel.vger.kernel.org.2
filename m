Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7532F4595F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 21:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240376AbhKVURF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 15:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237217AbhKVURD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 15:17:03 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7899DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 12:13:56 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so30431152otj.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 12:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YH8kAQYBMNnEP5TJ/7f0iMbajrYVM/MJL8tkaAu5au0=;
        b=kiBfJe0Sp/7fCUicBIpbzkEOPjjfZpR4p9FbobWCrON11/bEjzmtsvZPcJMhGgVTY2
         LoQkQlCqmfVGW0/woOQpVBOS0rGXYjcaF6CT764Yb28NKqWabJ9JYQTV8ZEOxYOlEVaW
         P5AR+BSFRQg/foOghRwx7Dokjp7RrI6i/raqO5vtjfZmeUcg0Lh7lo5ASP3JRnwphsTf
         bMXrvHiHV0++ABnI2H23EXPOfrW7w81a0JHyv1VU7J3weTk4lSZq9zIK2zG8fyb38Xlj
         fATjXhd1rUSHY9Mvk8BKxpmhGddggEeGqA9yZxqBWqFxPKpoPwQeTIVeUT1A0U6D0OCk
         aAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=YH8kAQYBMNnEP5TJ/7f0iMbajrYVM/MJL8tkaAu5au0=;
        b=EXmXFEXMBqulHzLEQOnam34vOGgKxdF8MbHiyIYnItfOFdUq3+P8pqJ1jtRrIB3F+A
         zJsq8XJLz8q+fl58w4HqmsvsSxPcIMHZ5GTHjRl7sVWnuoFz5yYgdlgv67E3dgTH3gjK
         tOBDOUYUY0It2prRHm4YvXbQR0Z7xP05Hx4wcX/EbgcmczGOeoBxzKjC7kDhzIi6HMfu
         DzdiPHdPYfqWUxtFa4/KG2T1hWA3YIWw+wfD52gd0YJQMVuESwAcFfO9lkFkbPopaClg
         XVpXUdmAPtj4Jbuk08CpkmLuEj+J01QypCilOTjMMf5ogeP2amRj9t7KVIEC/UgvjuKW
         NvoA==
X-Gm-Message-State: AOAM532P/4RGNq79seHdH/hIbK2Dx0Kh4V7vThH4/vhCO/xGNtllLCKU
        sczM2uHm/7jTrlUb2wPlX9k=
X-Google-Smtp-Source: ABdhPJwqz1stO7SbKWI65P+sB5nLu8zupwaD0LmiUxLUxg4JUn5glmM6mbDXWNPuIVDDXBJYp/QT3w==
X-Received: by 2002:a05:6830:44ab:: with SMTP id r43mr27009175otv.251.1637612035909;
        Mon, 22 Nov 2021 12:13:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w71sm2073832oiw.6.2021.11.22.12.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 12:13:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Anton Altaparmakov <anton@tuxera.com>
Cc:     linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] fs: ntfs: Mark NTFS_RW as BROKEN for PPC
Date:   Mon, 22 Nov 2021 12:13:52 -0800
Message-Id: <20211122201352.1754061-1-linux@roeck-us.net>
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
in this code and elsewhere and is therefore not desirable. Mark NTFS_RW
as broken for PPC instead.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
The Kconfig language does not support "depends on XXX if YYY",
so this is the next best choice.

 fs/ntfs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs/Kconfig b/fs/ntfs/Kconfig
index 1667a7e590d8..094ddef6010a 100644
--- a/fs/ntfs/Kconfig
+++ b/fs/ntfs/Kconfig
@@ -51,6 +51,7 @@ config NTFS_DEBUG
 
 config NTFS_RW
 	bool "NTFS write support"
+	depends on BROKEN || !PPC
 	depends on NTFS_FS
 	help
 	  This enables the partial, but safe, write support in the NTFS driver.
-- 
2.33.0

