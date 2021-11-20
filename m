Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DA4457EB8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 15:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbhKTO3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 09:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbhKTO3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 09:29:49 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8808C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 06:26:45 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id t11so12254342qtw.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 06:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lbPAF5PhHu+WLoLmFEqFobNIzyMMm9A+35j86/BOV54=;
        b=qaGdxAUuWb5wqManVkizNRuXbpsKvEafzYwBa81kC39VUeUZrp0vuoUgC3XQCHrPi9
         8NDHSH31mgCmE8kIA4crTpVqyVY6yWq5vkJLNGphJB/w+c3W6gDF7ZCZYoMYq4U6oMq1
         Rn+ao9gez5ixfTObpJxFLpNMH/q6t+wHk4D6PwW82AoZrfBg0GWxgqyJaIQuIfUlHykp
         SZNzPbSSGsnbm1fsE11enwUwL/cNdpDtD/1XU5DGCYHG4aWqM5Qn7DXgJ76PeT9yiR3H
         6a/ZnF0czFisr/eHBx5aKvxLQ1kAXVKKskasD0UUnPR5zlTjaoXIlbUAi4/K7R3OG9IY
         o2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lbPAF5PhHu+WLoLmFEqFobNIzyMMm9A+35j86/BOV54=;
        b=DP3v0q5noyU/WKO74RJL0HQQPEbC+Ljk0OOuzumXQ7YXi2EQUSwR8xF5iQwXo46Fwz
         a+D8oqGy7WIlwtpz09Sbm0eN1kqUCtAROpAXWnlkFB1zYRG2xkYdh3X1ecSEU/BFoa5R
         baQ4ZYxnEfsMrzdw8CYxddXdZkx5SeGN0YGXFZBnP59gOtZ34rrXWYKthN0vlcKLeX5t
         U/HYOlUx6UXjusnujTzUmXrK55UTBxB8v8dGyQwAwKDAvYUDks5VedPl0sTh6GiKsjQ2
         1fuhKjwkPQG2JD8dzMECm3zwkH8bs9+tPrzZ8UZTzyUsDzidKtacZP8nq5eDeaLkwKpk
         9yxQ==
X-Gm-Message-State: AOAM533egcS7wFeq4hCM30hx2d7Tn937ORDJ3y9y2nruFuToNGm7X2mS
        /22wR9P1qGaiCcC69WmPGCU=
X-Google-Smtp-Source: ABdhPJzrrklHGSaVceaznpMqJR8e7IXo9TD4JQzoMcjj0DKZZtkDQFNo/1M/5HdVSeZkRs8spNAsUw==
X-Received: by 2002:a05:622a:7:: with SMTP id x7mr15210805qtw.68.1637418405151;
        Sat, 20 Nov 2021 06:26:45 -0800 (PST)
Received: from dan-XPS-15-9570.lan (2603-6080-6a07-6dd1-7d72-c7d3-28b5-a45c.res6.spectrum.com. [2603:6080:6a07:6dd1:7d72:c7d3:28b5:a45c])
        by smtp.gmail.com with ESMTPSA id bp38sm1582545qkb.66.2021.11.20.06.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 06:26:44 -0800 (PST)
From:   hasheddan <georgedanielmangum@gmail.com>
Cc:     georgedanielmangum@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Anup Patel <anup.patel@wdc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Chen Lu <181250012@smail.nju.edu.cn>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv/head: fix misspelling of guaranteed
Date:   Sat, 20 Nov 2021 09:26:05 -0500
Message-Id: <20211120142608.2068809-1-georgedanielmangum@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes misspelling of guaranteed in comment describing why fetching fence
is guaranteed to work when switching to kernel page tables.

Signed-off-by: hasheddan <georgedanielmangum@gmail.com>
---
 arch/riscv/kernel/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index f52f01ecbeea..469eccd3780f 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -135,7 +135,7 @@ relocate:
 	/*
 	 * Switch to kernel page tables.  A full fence is necessary in order to
 	 * avoid using the trampoline translations, which are only correct for
-	 * the first superpage.  Fetching the fence is guarnteed to work
+	 * the first superpage.  Fetching the fence is guaranteed to work
 	 * because that first superpage is translated the same way.
 	 */
 	csrw CSR_SATP, a2
-- 
2.25.1

