Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60CF37017F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhD3Txf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:53:35 -0400
Received: from server.lespinasse.org ([63.205.204.226]:60983 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbhD3TxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:22 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=dcNLsbG8ESP+Ilb2xQiBJzAJk+o/uP7LiOGbYa0CH8k=;
 b=iJHs7S2FhfzxsM5ZRN/CH8+fjzCuZRuo/hgPczw1mcsHrnYWGrcytzQk4NwGC92fRXUCU
 uiSidepjrq/aPuGBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=dcNLsbG8ESP+Ilb2xQiBJzAJk+o/uP7LiOGbYa0CH8k=;
 b=sqVkVXJ54YWrcpEgKimcRpZ3iFRXUGqdiCVvBF7rKz+gE60KC7qjif9ujbBFpfoVFiQD9
 nkrCNg1nPyBt6kLu5GjQhXzrZYswefKB5kwcfLnqoKD6JeXsBBhz4m++FtCPxxbXt2MkB0B
 H4vAE8H4X/yUazmvbq5X5t1k6OSMDnyzb+Qn0GTQqojPRFSwAOfsi7ZRbNQwbQ1rAURWhT2
 Wt37f3z59KF3ATgtogcYZt6dQ9JZbsxo8rikFyYLuDzhTSDiAr0jOu1WhRdu6LPgSDLcKqo
 3KEYNVWT76EXbKMvU6p1Qalm4p/j7DCJh1E+8KrDqNbbC/+f2cVLunOLzknA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 1F95B16030B;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 0036A19F520; Fri, 30 Apr 2021 12:52:32 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH 01/29] mm: export dump_mm
Date:   Fri, 30 Apr 2021 12:52:02 -0700
Message-Id: <20210430195232.30491-2-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is necessary in order to allow VM_BUG_ON_MM to be used in modules
(I encountered the issue when adding VM_BUG_ON_MM in mmap locking functions).

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/debug.c b/mm/debug.c
index 0bdda8407f71..979d505e2c6d 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -275,6 +275,7 @@ void dump_mm(const struct mm_struct *mm)
 		mm->def_flags, &mm->def_flags
 	);
 }
+EXPORT_SYMBOL(dump_mm);
 
 static bool page_init_poisoning __read_mostly = true;
 
-- 
2.20.1

