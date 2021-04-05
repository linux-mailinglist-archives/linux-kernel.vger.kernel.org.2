Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D185354283
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 15:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbhDENzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 09:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235748AbhDENzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 09:55:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3368D613A7;
        Mon,  5 Apr 2021 13:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617630917;
        bh=KNkMGyWyPpAOtKuXWaT3d9ogjtm5L3cHyJ+lHcbdbpM=;
        h=From:To:Cc:Subject:Date:From;
        b=Ojey62DpsTgg3aU+FDHzTpjQWJUIbNEnTmKy7jVSVCdLWmGJbeQ/ji4Dxn6B1xEBg
         3mn8Id1TBEHgoVSmaytU2WLc2cx7jpxNK8gEq8ufJhoMcXny0zyFokMuZOeZKyIPGP
         WImN0MDSzMh+kN3oL/ybEw9E+suFaxWG+A2hVONhteG2nFq8ZKyuzBppZAL0MvKtyO
         zTN3mzTr3IJ9ozy7TNHV07zGETzSCV9HQViLoUyq2v8XPB2Uv8dMGYF6ehi7xSsqFq
         SAC2x67BFh8eU+gsfIzFX9xPnW3oYyKf/AiYsgUpQZq3Gd7rETQDJcRwE5aJLDPXoJ
         lDFRRkvr4HymA==
From:   alexs@kernel.org
Cc:     Alex Shi <alexs@kernel.org>, Nikolay Borisov <nborisov@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib/percpu_counter: tame kernel-doc compile warning
Date:   Mon,  5 Apr 2021 21:55:05 +0800
Message-Id: <20210405135505.132446-1-alexs@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alexs@kernel.org>

commit 3e8f399da490 ("writeback: rework wb_[dec|inc]_stat family of
functions") add some function description of percpu_counter_add_batch.
but the double '*' in comments means a kernel-doc format comment which
isn't right.

Since the whole file of lib/percpu_counter.c has no any other kernel-doc
format comments, we'd better to remove this incomplete one to tame
the kernel-doc warning:

lib/percpu_counter.c:83: warning: Function parameter or member 'fbc' not described in 'percpu_counter_add_batch'
lib/percpu_counter.c:83: warning: Function parameter or member 'amount' not described in 'percpu_counter_add_batch'
lib/percpu_counter.c:83: warning: Function parameter or member 'batch' not described in 'percpu_counter_add_batch'

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Nikolay Borisov <nborisov@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: Stephen Boyd <swboyd@chromium.org> 
Cc: linux-kernel@vger.kernel.org 
---
 lib/percpu_counter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 00f666d94486..ed610b75dc32 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -72,7 +72,7 @@ void percpu_counter_set(struct percpu_counter *fbc, s64 amount)
 }
 EXPORT_SYMBOL(percpu_counter_set);
 
-/**
+/*
  * This function is both preempt and irq safe. The former is due to explicit
  * preemption disable. The latter is guaranteed by the fact that the slow path
  * is explicitly protected by an irq-safe spinlock whereas the fast patch uses
-- 
2.25.1

