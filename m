Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87495312A58
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 07:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhBHGAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 01:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhBHGAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 01:00:24 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1118C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 21:59:44 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id m2so2770372pgq.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 21:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zHwhKwrK4yHVlczB7KVMZv2vVZPTXpdOZqV+ZlINmOU=;
        b=F1nx3PHpCDE+6Yn7i87WqybX0D91c90BwQDtZcxHV+rJ7Mz2JFawdhVIRA+98QaWtd
         zhRZEiJx95fPjn/z467r/B4M/2p418W0bv6bPF/g99Piy+GIDxERzqfjSKmnJ/TcIXwH
         xW6y1ds45ZxtUREhCsSL7QulgNHgS1lBEI0XgRM/pn5C002lrwzjCSW1cTGkyPCmWinq
         RsXzD6e3atIxiUFG46BU3qWaASYgbvdhwS0KVDZpMqxw1F4oX602FJwcnRZFu8th8pXh
         y79CG08r8r3V0HnZIhyiHn4yfp/cwg58XI7x9me+eHfMBh+srWekGd/+j8JxLdYv/Psg
         5tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zHwhKwrK4yHVlczB7KVMZv2vVZPTXpdOZqV+ZlINmOU=;
        b=tsFOGq/uy1LCpgPkYhO/Z1Z/S1DZnd+awoWJ38cN9ZFeoZkeG4D85L3bQ8SzVJPYhL
         46bDWJV/hpJKYgqMUAU0DairHqv1qtC0kgkAoP6LRyUlGQTbLMVoohNceC4K7IKOo5aj
         4wioFvzsQJ5ZFwkfklo0ZZ06UCBtqo58LgZ9yFZuEYjcb0cBYwrmr9r+hHsta3lkEdFb
         pKPr3d9Wug92HbYzE+H6CMKiBAVA4gvpRql3D35lcLr2MgT5TmOBxV67OyTHIhekk2JC
         EYfktHfqLutw8VqILRp36j2mmnUQHLuHO2WQJ3kJmZrho7I/o4iktESbl4ITK64fgX1C
         VGHQ==
X-Gm-Message-State: AOAM531s+pZwTQufWnISVolWh8C9TX+rlAIVPTKzyd0V7gWVWtRE15ww
        JZPpMN+5OFjL03cOc9sWWPU=
X-Google-Smtp-Source: ABdhPJzT6eIqoV2xfoz9CvF7ERIys6iP+GRUv7lSDxpnCY9pmgwJFDA+mtHAvWF0xcSgG0JXDf8e3A==
X-Received: by 2002:a63:2214:: with SMTP id i20mr15198931pgi.189.1612763984374;
        Sun, 07 Feb 2021 21:59:44 -0800 (PST)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id r4sm10730809pgp.16.2021.02.07.21.59.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Feb 2021 21:59:43 -0800 (PST)
From:   jiahao <jiahao243@gmail.com>
X-Google-Original-From: jiahao <jiahao@xiaomi.com>
To:     christian.brauner@ubuntu.com, akpm@linux-foundation.org,
        ebiederm@xmission.com, jiahao@xiaomi.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: exit.c: fix a spacing coding style
Date:   Mon,  8 Feb 2021 13:59:36 +0800
Message-Id: <1612763976-21834-1-git-send-email-jiahao@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some spaces before and after the operator.

Signed-off-by: jiahao <jiahao@xiaomi.com>
---
 kernel/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 04029e3..ffc507e 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -888,7 +888,7 @@ EXPORT_SYMBOL(complete_and_exit);
 
 SYSCALL_DEFINE1(exit, int, error_code)
 {
-	do_exit((error_code&0xff)<<8);
+	do_exit((error_code & 0xff) << 8);
 }
 
 /*
-- 
2.7.4

