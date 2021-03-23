Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59A93454E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhCWBUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhCWBTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:19:34 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57307C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:19:34 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id y5so11255049qkl.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bKnNu6nAgSuDIETQV6OYH1CeiVlwLsD9IbZb1meaBRs=;
        b=MtmqUOUveNxlsAyFDzBzYSmbZIFghefEbwLh31+O2EdtE+SYqyLQZlZ8T/KWyiJ7BF
         PKVlCol0NJCaf9Py9DTCYuPccCB/cf28ol9TeqMo74aGQZ5S3V6fnZ8Y6TBLJuSO4AjH
         KQtcXfC+G68hrSSROwOF8jBFsMIbMjC4eEnUOZnqz8hf/hm1jfLXI891iipujPl28Fkh
         sD6CDy3puU5f1NmdexNstPkYykSBWtWE3ngpig0ldBOKH0C81h0TK54+BnVhO+WskO5h
         SOXicqRK52PBlMvjocOSqSqIFWwnRckFyqKeqOmJLP83LV8S3k+xJPC2Uu7rWgnqI3aD
         IN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bKnNu6nAgSuDIETQV6OYH1CeiVlwLsD9IbZb1meaBRs=;
        b=nHwF3vpZ43+6fqfqOOBjgLyJwR7E9RQ+X7O0ywygdi92qmVybrvI8B0sL/goiG05Bu
         amzR6FyYOxkBbJIgMazv8tEZYy7q8DglSetaom5SDHAULWS9OzRp7WnIFKU0vxuFcqxD
         GNHzpjld//6U/7VvbNFqUj+F0ngTTZMzdr91fdyfbx28KAM6ujqx9b3EH6rMziy4Cgdz
         vpn0z1MN6OGl0SeUZEBmNKL5E1IrhhRBkTdtVHjH/Kk4oBk8EbjBV/FkFp5OwpY3Zsy1
         5ofnmnjHfa21/93JWwXT+XZ1lDTpreJIKPpPnYch6nZrnomC2RWI8qlSsiSF3ST6swTW
         1o9A==
X-Gm-Message-State: AOAM533rL4yYey5f/E8hg/m9t/wssTVn3v0kSVp1fO81xFQNmU1LSTx3
        46eDkkbogEcVJTiALrrRyuI=
X-Google-Smtp-Source: ABdhPJwxO7ZPvXX9pk4u7XP3RuQ6HpOXsueRITj1YudLV1QkrhkaAn8HZfIJnrptlIYwvDkjqzQwPw==
X-Received: by 2002:a05:620a:135a:: with SMTP id c26mr3056342qkl.110.1616462373651;
        Mon, 22 Mar 2021 18:19:33 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.117])
        by smtp.gmail.com with ESMTPSA id k7sm9931514qtm.10.2021.03.22.18.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 18:19:33 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     christian.brauner@ubuntu.com, akpm@linux-foundation.org,
        thomascedeno@google.com, daniel.m.jordan@oracle.com,
        tglx@linutronix.de, Nicolas.Viennot@twosigma.com,
        walken@google.com, unixbhaskar@gmail.com, viro@zeniv.linux.org.uk,
        krisman@collabora.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] kernel/sys.c: Fix a typo
Date:   Tue, 23 Mar 2021 06:49:09 +0530
Message-Id: <20210323011909.311567-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/concurent/concurrent/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 kernel/sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 2e2e3f378d97..5cb22eba59f6 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2023,7 +2023,7 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
 	}

 	/*
-	 * arg_lock protects concurent updates but we still need mmap_lock for
+	 * arg_lock protects concurrent updates but we still need mmap_lock for
 	 * read to exclude races with sys_brk.
 	 */
 	mmap_read_lock(mm);
--
2.31.0

