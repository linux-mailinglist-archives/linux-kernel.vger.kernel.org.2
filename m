Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A973446663
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 16:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhKEPui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:50:38 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55616
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233638AbhKEPug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:50:36 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7B8804002D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636127276;
        bh=BQNpoEejJgdqfTjT6uEW5F1j+u2r6UT1ueKsgaIRjOY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=PDe44V+uldWUwDxj5FKSTYeboPrVN/w3qkZn49FetUhcf1ox73ih/FqUWEbiSQvBT
         rw6hr/nMKxslz4q2gy1wHYtPReeJhy4NASox9jO0Ybrgae7qoAcpr3WMnNEmB021eg
         M+Qd1Fz8XFyK6duP68DeuOuN0ChuahCM3RZ0PWeFfw4abvuaaKeagC0Xj0UJGFKQjK
         Y1nssZxzMUGdBUyOVWK1iE5jhuf7Ahxi4bFSsBI7JeYhIFjynsQguZBY6fc0VFH0po
         g4rqYZ/wwqdALNk9sQf1y64uol7eBv6BTS2Yd5gfl37l+jAuBMDUULVKbh/YKl0/jX
         CGOBVle3q7uJw==
Received: by mail-wm1-f72.google.com with SMTP id k6-20020a7bc306000000b0030d92a6bdc7so3380069wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 08:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQNpoEejJgdqfTjT6uEW5F1j+u2r6UT1ueKsgaIRjOY=;
        b=RqA2GMNCbdIlucq1qTarOKkPlN0gdqFF8qKhWfR7CVwV9GLXNnxaY2cLOiVvgrwdat
         nNewRa4F0Zy1tjY/c4o7cQROa6Xc1zXXbTHvvNntpt8q+k3F94RwyXFmuKZ+V3P6fzFL
         PHXDVqnL9/GOn+fdvlOQ1lAAQW6qyybTuwbqSfli3lMTJ3PMkwoFgIwvNMCRV7vle7L+
         bdY2mJr1/ily6NhI074eqJFMHcHfy0gSCinGC0mteX09Bw7/FbKyUxkgakFrJk0r7mPQ
         MuaVN579PLw6OjJxYHSM+MwagAxIWik/ZgF9pt47WmX2mBTP3wGiPhN41CQcdql0OKEF
         +2LQ==
X-Gm-Message-State: AOAM5329bMKG4FJGawpp5tMNp7mwOu7F6ZtYpoMcE1up2RwEpwb8F8VH
        h8j5eeR9RAREr2goOYW7RkDyL22uoRbiodcr+UEJEDcSTtKLRtyMhNqxibze8QUPth7jmIFgEdf
        sgaDAjzHA6UqLzoXWyTTRcK5NrgN7jHBpZbN7v3mdcQ==
X-Received: by 2002:a05:600c:430c:: with SMTP id p12mr32522669wme.127.1636127265173;
        Fri, 05 Nov 2021 08:47:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqsDazjeBLc3GzOdhywA22fmz71ZuD2zXBh7/jcJh3Kp1/GITAo9FHVASySm/M442PUPtjWg==
X-Received: by 2002:a05:600c:430c:: with SMTP id p12mr32522621wme.127.1636127264973;
        Fri, 05 Nov 2021 08:47:44 -0700 (PDT)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id o8sm8452479wrm.67.2021.11.05.08.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:47:44 -0700 (PDT)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Steve French <sfrench@samba.org>, Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH 4/7] arch: Remove leftovers from mandatory file locking
Date:   Fri,  5 Nov 2021 16:43:31 +0100
Message-Id: <20211105154334.1841927-5-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211105154334.1841927-1-alexandre.ghiti@canonical.com>
References: <20211105154334.1841927-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This config was removed so remove all references to it.

Fixes: f7e33bdbd6d1 ("fs: remove mandatory file locking support")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/mips/configs/decstation_64_defconfig  | 1 -
 arch/mips/configs/decstation_defconfig     | 1 -
 arch/mips/configs/decstation_r4k_defconfig | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/mips/configs/decstation_64_defconfig b/arch/mips/configs/decstation_64_defconfig
index 85f1955b4b00..e2ed105f8c97 100644
--- a/arch/mips/configs/decstation_64_defconfig
+++ b/arch/mips/configs/decstation_64_defconfig
@@ -144,7 +144,6 @@ CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
-# CONFIG_MANDATORY_FILE_LOCKING is not set
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/mips/configs/decstation_defconfig b/arch/mips/configs/decstation_defconfig
index 30a6eafdb1d0..7e987d6f5e34 100644
--- a/arch/mips/configs/decstation_defconfig
+++ b/arch/mips/configs/decstation_defconfig
@@ -140,7 +140,6 @@ CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
-# CONFIG_MANDATORY_FILE_LOCKING is not set
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/mips/configs/decstation_r4k_defconfig b/arch/mips/configs/decstation_r4k_defconfig
index e2b58dbf4aa9..6df5f6f2ac8e 100644
--- a/arch/mips/configs/decstation_r4k_defconfig
+++ b/arch/mips/configs/decstation_r4k_defconfig
@@ -140,7 +140,6 @@ CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
-# CONFIG_MANDATORY_FILE_LOCKING is not set
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
 CONFIG_PROC_KCORE=y
-- 
2.32.0

