Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F32A44F7FB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 14:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbhKNNIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 08:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhKNNIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 08:08:34 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EDFC061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 05:05:39 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id b17so9464447qvl.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 05:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JS+FiKSeT5f12gRyVzfSR3kPguW23wtXqyvRjIMFpqI=;
        b=Oflq1b4QfmP4yco6/I0/eR5FQ5o1N+XGPd52rf1iUWEAAHAWQQo+abwAkMyTJ3+lPV
         jpuBs0ng6D9Dh8xlaU2d9x/7U+e83pexQMtqlcfixYH2RQzl+Fs9Ezn1+YGYM8ccuSKt
         H5/gt5k9PRVvH6bXgoqfgxhuV4HPTlDvMbDk2A3trBKarZyvK4ELPQ8Qgk2a2HUpMoWP
         yXgP8jwwA/ChsXr2FkPYcqoCuj+EGdVT/fOjZQ4KCrO5VYVHm3ZQOWHS9wGqC+b6v4e5
         ZRRTQMFJGag3KBgDMZEDO3VIWxCnUFoYXuYc5mGbhfhnjcctC/Ys30IPx2sXtbqP5BMf
         kZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JS+FiKSeT5f12gRyVzfSR3kPguW23wtXqyvRjIMFpqI=;
        b=2vrLzCBH0B6/LhvKuqMB/vu5MgPnmeTKJw1f11cNuVozWZEoLelUzFcXb5rR5dKoA1
         pGH+jewfNLYGQJw9EfeS+4kVLQFSrsTF3h7deh0CV8waElqz+01FyrthqrcPhu64135e
         WNQmb+0AC1EISEpEvMrdxncSK5jmPm8toFWohEw/auVoi1tYQ5oeo89dcYjpKkXXhHrQ
         VX6IfjGxvLxVxQ0FOpjwH8sPRh58JeWY8qCuxiS3G/rphfgQnqTsItllg50KyhTee5Dg
         AY5VmwNVaqJCzXpHYecMFVHmE6VddE67OyAFCA57rGYKE1h0uXj5+86Wo17FpwEOx1m7
         EgXA==
X-Gm-Message-State: AOAM5300M6R6n0sFM2lrfOw6svCjv917I0khlNDVu10wGteKQDcEv686
        CUAoelvwhjOW9qNEQP9R8jI=
X-Google-Smtp-Source: ABdhPJwM/qU0jM2z78GbeoxaMOY7JmYlp8HVDHaWPpKHagtwzduHAHn7iSiGOuJPwOff6KzXKKafsQ==
X-Received: by 2002:a05:6214:27ca:: with SMTP id ge10mr29022178qvb.46.1636895138929;
        Sun, 14 Nov 2021 05:05:38 -0800 (PST)
Received: from dan-XPS-15-9570.lan (2603-6080-6a07-6dd1-7d72-c7d3-28b5-a45c.res6.spectrum.com. [2603:6080:6a07:6dd1:7d72:c7d3:28b5:a45c])
        by smtp.gmail.com with ESMTPSA id o190sm5251363qka.16.2021.11.14.05.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 05:05:38 -0800 (PST)
From:   hasheddan <georgedanielmangum@gmail.com>
Cc:     georgedanielmangum@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zihao Yu <yuzihao@ict.ac.cn>, Ard Biesheuvel <ardb@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Andreas Schwab <schwab@suse.de>,
        Atish Patra <atish.patra@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv/entry: fix misspelling of instruction
Date:   Sun, 14 Nov 2021 08:04:39 -0500
Message-Id: <20211114130440.1530498-1-georgedanielmangum@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes spelling from instruciton to instruction in comment in entry.S.

Signed-off-by: hasheddan <georgedanielmangum@gmail.com>
---
 arch/riscv/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index ed29e9c8f660..728c521dcc85 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -568,7 +568,7 @@ ENTRY(excp_vect_table)
 	RISCV_PTR do_trap_ecall_s
 	RISCV_PTR do_trap_unknown
 	RISCV_PTR do_trap_ecall_m
-	/* instruciton page fault */
+	/* instruction page fault */
 	ALT_PAGE_FAULT(RISCV_PTR do_page_fault)
 	RISCV_PTR do_page_fault   /* load page fault */
 	RISCV_PTR do_trap_unknown
-- 
2.25.1

