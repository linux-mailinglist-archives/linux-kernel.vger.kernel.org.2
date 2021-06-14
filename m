Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7FD3A6955
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 16:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhFNOxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 10:53:06 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:35766 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbhFNOxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 10:53:03 -0400
Received: by mail-il1-f169.google.com with SMTP id b9so12458574ilr.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 07:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pni7rpqE1FW1FClvYjK9AqvghJIehVdwsak3wJBmgPw=;
        b=bo9RQZsNAa/GVIeY30oYVrU2GmVtxNak/a4vZqYWkxATL4xndb50CFec+e/znw5Y+w
         sWc+v4MBG6tR126o+/p+7i/nZ33casQEX5Tn8rAKe+qGHBjXg6PKZvcbhZ9so4P7dxQ5
         6Yo2Oy+ri5Cp2hN3cJNTIheNabYh/2aPfLkL9GGttmXI0pDaKBHLot+cv8FfXpWpBxzG
         kTyf+WyJy9WU3biufpKa9ozkfPjnN+nIbTXU/4JKh3Bvv+PgC1k72tCYRqv9aA/Rq5vU
         aieqGLA71P94uF++xCzs2LN5gH0s34FlO4AJBNyz8H9Tk3Q+mb+t65XldqY/Bb9Mx3sr
         Eu/g==
X-Gm-Message-State: AOAM530d6X00qk9S/xMKbYjTTdZRsrq7nF+lezYhoPVfQh4Gk73ILUb+
        k0XkPHcmbDAF9Bulc9SkW4E=
X-Google-Smtp-Source: ABdhPJyYTZCCa5KdLDhWat+CcyfLYG0jp/N4a8MKcpG+27+jQXlzKazy+lyYCyayxvxQWQDNQhFdqg==
X-Received: by 2002:a05:6e02:cc5:: with SMTP id c5mr14366617ilj.152.1623682258502;
        Mon, 14 Jun 2021 07:50:58 -0700 (PDT)
Received: from abasin.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id u18sm8350925ilb.51.2021.06.14.07.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 07:50:57 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>, Tom Rix <trix@redhat.com>
Subject: [PATCH 1/1] percpu: initialize best_upa variable
Date:   Mon, 14 Jun 2021 14:50:49 +0000
Message-Id: <20210614145049.1585477-1-dennis@kernel.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom reported this finding from clang 10's static analysis [1].

Due to the way the code is written, it will always see a successful loop
iteration. Instead of setting an initial value, check that it was set
instead with BUG_ON() because 0 units per allocation is bogus.

[1] https://lore.kernel.org/lkml/20210515180817.1751084-1-trix@redhat.com/

Reported-by: Tom Rix <trix@redhat.com>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
Sorry this hasn't been my highest priority. I'll apply this shortly to
for-5.14.

 mm/percpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/percpu.c b/mm/percpu.c
index e7b9ca82e9aa..6667dfa0fcec 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2888,6 +2888,7 @@ static struct pcpu_alloc_info * __init __flatten pcpu_build_alloc_info(
 	 * Related to atom_size, which could be much larger than the unit_size.
 	 */
 	last_allocs = INT_MAX;
+	best_upa = 0;
 	for (upa = max_upa; upa; upa--) {
 		int allocs = 0, wasted = 0;
 
@@ -2914,6 +2915,7 @@ static struct pcpu_alloc_info * __init __flatten pcpu_build_alloc_info(
 		last_allocs = allocs;
 		best_upa = upa;
 	}
+	BUG_ON(!best_upa);
 	upa = best_upa;
 
 	/* allocate and fill alloc_info */
-- 
2.32.0.272.g935e593368-goog

