Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FC33487D3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 05:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCYEJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 00:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhCYEJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 00:09:22 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F05C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 21:09:21 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id q12so529075qvc.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 21:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p5qKmSmnjnYEMAFi1lZ5eGXcL0fBHP5Y9gF/WNSOAn4=;
        b=hv1a4ktEgVB0ADOfTvoFQwyTTYkNHeiCcUHKmzEPusEvWpkmIp6Az+7yk6H/042pzP
         mN9Ez2uyYARnbJ9AOJI44Y5QX2omb/PoUBBBhXp+Og4ykT7drsEtACB9/KSL4FU91eVI
         nIM3WpXzpouu8xfj1zxjvFNQaB5EWO1h9ngteZ6GKNzYF63OyB/7C1YQ9YknViqczuLG
         GU0TAvWP4DeyS9gxzR5BmWYmvGejqfztiHZMkTMXGpXN/o9lIjYmIAcWJWBmqu1ZnKsT
         lQP9lUwKOT28+DXaJ6TSc26crFFrHIJH7TFt3e/etxlY4aHdjXKpAkqY/ukzMMuC8ATz
         +bBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p5qKmSmnjnYEMAFi1lZ5eGXcL0fBHP5Y9gF/WNSOAn4=;
        b=AKJi2jiMN+noc2RM4ZKZAAs7YgrJy12oK92f77mvjlZK3uzFOKLXBOeWrWm62HjAnS
         Pqv1TemhLSxyuqrNxnNK4LdQNIukrMbQj7tA4efbbMGXBNYOm+AXy89oewxq6DfqYoY9
         gfgRvm3TnnTeY+GVfaHRjGaNuA++5nAc5GDLEjj5wnkni/XxIowpfM6knT9vuz/CaI4r
         1Q9W9bjSbwfoyFZekjPeK0DAX8jXBEqifyCk/jBdCliKgB8CI6cUHZV5L//N6f9k6iBc
         rkTl4a5SvjYj8yf1gD2EhryxpJHPN5+G4/+Aok169agJ5hdDq7BmkybydR2OY1c5yVlT
         wNgg==
X-Gm-Message-State: AOAM5312cl2cqpinU88oOQR6lEFRyhuP7g1MZZFUkzEYVLf8lr43ZqdJ
        IAwFGjn7g9HhmSG7ZdpUoA4=
X-Google-Smtp-Source: ABdhPJydxXAlRci9bwpGyybaKNP/EVRWi8pkiORlRWyfTb6eHHhdvWnw/kRSxT5fiS9zEWPNw4GkXw==
X-Received: by 2002:a0c:f890:: with SMTP id u16mr6410479qvn.21.1616645361056;
        Wed, 24 Mar 2021 21:09:21 -0700 (PDT)
Received: from Slackware.localdomain ([156.146.55.176])
        by smtp.gmail.com with ESMTPSA id 17sm3278109qky.7.2021.03.24.21.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 21:09:20 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     chris@zankel.net, jcmvbkbc@gmail.com, unixbhaskar@gmail.com,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] xtensa: Couple of typo fixes
Date:   Thu, 25 Mar 2021 09:38:32 +0530
Message-Id: <20210325040832.26018-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/contans/contains/
s/desination/destination/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/xtensa/kernel/head.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/kernel/head.S b/arch/xtensa/kernel/head.S
index e0c1fac0910f..c74fdaacf4cf 100644
--- a/arch/xtensa/kernel/head.S
+++ b/arch/xtensa/kernel/head.S
@@ -212,7 +212,7 @@ ENTRY(_startup)
 	 *
 	 * The linker script used to build the Linux kernel image
 	 * creates a table located at __boot_reloc_table_start
-	 * that contans the information what data needs to be unpacked.
+	 * that contains the information what data needs to be unpacked.
 	 *
 	 * Uses a2-a7.
 	 */
@@ -222,7 +222,7 @@ ENTRY(_startup)

 1:	beq	a2, a3, 3f	# no more entries?
 	l32i	a4, a2, 0	# start destination (in RAM)
-	l32i	a5, a2, 4	# end desination (in RAM)
+	l32i	a5, a2, 4	# end destination (in RAM)
 	l32i	a6, a2, 8	# start source (in ROM)
 	addi	a2, a2, 12	# next entry
 	beq	a4, a5, 1b	# skip, empty entry
--
2.30.1

