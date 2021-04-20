Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD7136594D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 14:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhDTMyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 08:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbhDTMyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 08:54:05 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48B3C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 05:53:31 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id x12so37332642ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LFSy6RUpmpxDY/av6j+qBKwzw9xjIiwGKoFPLhg8tus=;
        b=QtTfIVqNetrqW4nTr7FwKTIwm+1OIi3Nra0FiQmuv9hzZKbiw3b37hKwuSh0WN6loT
         odlE76AGfBHPWaVt+36pVZWkF8mcCnBWYqIksPJLIFSR5+TfiRaxKOgV4w2Z0JwqJMFd
         08GEfGNc6ZgWSlhzpyBRDb7cLBWW6RkUKBDQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LFSy6RUpmpxDY/av6j+qBKwzw9xjIiwGKoFPLhg8tus=;
        b=VScU9USElCiXexoOQafgY2jvSK2FVAZ1kUj6EX1boNV+9X1oEWNYVfjBOH1hA7xHZK
         buZiuwOAItsw46en4ON47xJcgrbGyYqUy92aDfGlHCoRyok8mCVlf9ljCFhEu1yulocu
         8akazzBi2FZj4FaKCBqizBb7Unzy7F1QV5VGRuPVCEuRxYh3UdYV1MIyWZh5WDm2G1nv
         mZKenOAsgZ7rFPty3R5BYqzFWInuMiPjMW1yGmij9sHbMdbsuEIrCWnF88BX7GuvE33w
         aQIk5v5hGlHyJqpIt5s1FpQIg54tD3jkS0YRf28YPmyNAVzmU9osvod1J4Zq7m43Z825
         1CRg==
X-Gm-Message-State: AOAM533P91X8N3+dIurfB85Biwfn85GOWbvzeZd0go7gW8nkgZsurFlb
        3CfUr6WYLV3NmgnB09fO+JLB7w==
X-Google-Smtp-Source: ABdhPJywF6by0hgnnggMx0wab/r6dZZPA6xMNsxXYtachGELVYwTG3qr92ipBsA2HjH11SWlnXmqoQ==
X-Received: by 2002:a17:906:1d0e:: with SMTP id n14mr27679497ejh.97.1618923210436;
        Tue, 20 Apr 2021 05:53:30 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id g20sm15836908edb.7.2021.04.20.05.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:53:29 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: admin-guide: update description for kernel.modprobe sysctl
Date:   Tue, 20 Apr 2021 14:53:24 +0200
Message-Id: <20210420125324.1246826-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I added CONFIG_MODPROBE_PATH, I neglected to update
Documentation/. It's still true that this defaults to /sbin/modprobe,
but now via a level of indirection. So document that the kernel might
have been built with something other than /sbin/modprobe as the
initial value.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---

Andrew, this is a followup or a fixup, however you want to handle it,
to "modules: add CONFIG_MODPROBE_PATH" (in next-20210419 known as
8bc50a36278dbf3e14b25236e3acee25f75d5bd8). I.e., please add this as-is
to your patch queue, or fold this into that one.

 Documentation/admin-guide/sysctl/kernel.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 1d56a6b73a4e..7ca8df5451d4 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -483,10 +483,11 @@ modprobe
 ========
 
 The full path to the usermode helper for autoloading kernel modules,
-by default "/sbin/modprobe".  This binary is executed when the kernel
-requests a module.  For example, if userspace passes an unknown
-filesystem type to mount(), then the kernel will automatically request
-the corresponding filesystem module by executing this usermode helper.
+by default ``CONFIG_MODPROBE_PATH``, which in turn defaults to
+"/sbin/modprobe".  This binary is executed when the kernel requests a
+module.  For example, if userspace passes an unknown filesystem type
+to mount(), then the kernel will automatically request the
+corresponding filesystem module by executing this usermode helper.
 This usermode helper should insert the needed module into the kernel.
 
 This sysctl only affects module autoloading.  It has no effect on the
-- 
2.29.2

