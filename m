Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D932236BB91
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 00:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbhDZWSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 18:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbhDZWSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:18:43 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D34C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 15:18:01 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id k127so2587692qkc.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 15:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bdI9uhr9cXjOGYy3VuVnSo/ChCyBPax2jvsgTzvHJJM=;
        b=V0++UC3vnNBx9lVO/e6Ad8Cck2hsUg1zV/3TX6K8HIxuDKAgXNhfexK9EZCw0dvZVY
         3VgHLhKsYGMJR/dyGUysRJh18lFnznpCv/bLz0WIF9Xn8Gw2AwiKNSmA78Kn3vTtQeIp
         g4qPyCQgrR1YHXptHqCm/MhYl3wzY1ayf8US9EF9r0ONTYHyXtdbKtwv6sTRTEkLo6uX
         v4/FcsV8AeO0BYSCgshEOXpaiVGhXx1bNrwP4eIiyQrt+GeFz21C39YvNt68IehiQYER
         rHyZwsQ+sf3B9ra4eEZbGNVNzCWra5tej3wdfFFe8aixMCFEWoi+a6t0xOzinYc8w7zb
         ixog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bdI9uhr9cXjOGYy3VuVnSo/ChCyBPax2jvsgTzvHJJM=;
        b=oujxgifsil41Wx6fxveWGpJuRcj8Rfl6zd+Pz2OnJ1/LMll40nRvAyNAZ9Ky6i83Ij
         nk0/BKot3m9qiupVxC/O7HkW0rW0+Myt3iFFzG50hwO+nMtszFb/KxtBRJtEVeV8+lie
         4+zMgduzjZBC34zxmlEkAfyPaGT6IUkK3SFDghG8tDmCATFPI46zQ2WplYuRj1g2MAq/
         okVv8b49L9lbBtXo3UzSElZY/lJUV1L7VU2dxU/RG+yv1r0GVW0ct2qWKL+1gho+gwOQ
         3dWgDKdmuzIwdrufnhqHtZJsY8H1B1gJiqgCEB0u53Ii9i6cr9VrB0NZ6xREGmPufMuV
         xslA==
X-Gm-Message-State: AOAM531m4n8Z+RIf20j0WHOMqg0XqCW6g1ZVVv2f3XjvLMmlrtqIyyVn
        Dl6vrtkV6qtnIP/fObWDxeU=
X-Google-Smtp-Source: ABdhPJzGznfrdAXXmT2Bb+4jTk3WU/wVqHxY9UWwmdCxHG0GVJGNAUBmCP162HU2IDam5M5xLvMMjQ==
X-Received: by 2002:a37:8147:: with SMTP id c68mr19703418qkd.302.1619475480858;
        Mon, 26 Apr 2021 15:18:00 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.247])
        by smtp.gmail.com with ESMTPSA id x20sm1374111qkf.42.2021.04.26.15.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 15:18:00 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, nathan@kernel.org, linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 1/3] Removed the oprofiled version option
Date:   Tue, 27 Apr 2021 03:38:45 +0530
Message-Id: <c98fa38b74bdd8ab16d35862895dac5f5a535f94.1619181632.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619181632.git.unixbhaskar@gmail.com>
References: <cover.1619181632.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed the oprofiled version option

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 scripts/ver_linux | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/ver_linux b/scripts/ver_linux
index a92acc703f9b..1a8ee4ff0e32 100755
--- a/scripts/ver_linux
+++ b/scripts/ver_linux
@@ -47,7 +47,6 @@ BEGIN {
 	printversion("Net-tools", version("ifconfig --version"))
 	printversion("Kbd", version("loadkeys -V"))
 	printversion("Console-tools", version("loadkeys -V"))
-	printversion("Oprofile", version("oprofiled --version"))
 	printversion("Sh-utils", version("expr --v"))
 	printversion("Udev", version("udevadm --version"))
 	printversion("Wireless-tools", version("iwconfig --version"))
--
2.26.3

