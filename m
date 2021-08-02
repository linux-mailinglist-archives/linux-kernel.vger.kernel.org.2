Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45F53DDEB1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 19:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhHBRl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 13:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhHBRlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 13:41:55 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0191EC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 10:41:46 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id a2-20020a0562141302b02903303839b843so13460657qvv.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 10:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=quo0TlqFPZ1L0JKUsDFaejm5nVuMMXv+3wqm+ve5NCM=;
        b=hSLZbg3lvjhu7xW3iqgt3CLfGKDqD42KSTjGkNQGNfnYVl8w9bbYrKtef0bgOZviWu
         aZ0ZkoasiFceCln8YaSnQ8mmBLTtT8WIDS0KwqWd98NlJwtJ3e7FST5Do0MhOkG/Rr2J
         MBqKepSDGACupGkdCwJ3DII1UHSWdBzIilYoWR0PP34PDaEfDy8i/5jnjknofYdebjhV
         pvwJuWtOLBSoAw1RU3ZHHZjHd3wafJAjpybm7ELMydjS88Bgy5LgHynocf7n7K4AV1Li
         7+gbNGvt898ZIiQJGT/HoHe6zDTt5YpVUrzyYj9pSY2+ZXpirFyg3ASzkhCMKXu28hHr
         Z/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=quo0TlqFPZ1L0JKUsDFaejm5nVuMMXv+3wqm+ve5NCM=;
        b=PR8YVODpJWq7uSISQIrHf63dJ5iB6vLG9/ilgqDek1uzaBWYJI20CMLL4/fucIj5sU
         V4X0sDmDQKpyw+GZK09brKaUq7FjDihVP9xvAdNtysrbWefyIjT4tsSlwEeJRk0I9HyO
         8H40FTtfuYTh4LVfONeYsjdffWY7uSR71EZU2JhJEKs7cRmUIKYMBe5VKcYJ1xzQ6rZa
         QHcPp35LiAchg22zdIupPiiJqIl/nbOECGl5FKuPiKgJFgxDYKLGUpX4CW9tOOWaqJE8
         mxSYA3kYHLFgz50axg7OiQIqJGBahoJptp4zAv4S56m84nTBVdPM9mRpESRCtKuClDIm
         abmg==
X-Gm-Message-State: AOAM531gu4fD/SsODkwPrDY4bUjmfmudtSnxDW1L+NqyM4XHoC0qpiBM
        s7tgKT58dQDf9CzkPRV9WDIHTHSX99MwV9I=
X-Google-Smtp-Source: ABdhPJx0aU/vM83rywMjheQAD8FFnIlSXA3pukbToYT4rnpWwJ6edIvWuqefs/bXLNOoz0jXoaabzUHbm8ZJ53Q=
X-Received: from ramjiyani.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edd])
 (user=ramjiyani job=sendgmr) by 2002:ad4:5fca:: with SMTP id
 jq10mr17668392qvb.27.1627926105160; Mon, 02 Aug 2021 10:41:45 -0700 (PDT)
Date:   Mon,  2 Aug 2021 17:41:38 +0000
Message-Id: <20210802174139.1908760-1-ramjiyani@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH] binder: Add invalid handle info in user error log
From:   Ramji Jiyani <ramjiyani@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Ramji Jiyani <ramjiyani@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of a fail transaction to the target node; user error log currently
only prints the thread and process id. Add handle info for the reference
to the target node in user error log to aid debugging.

Signed-off-by: Ramji Jiyani <ramjiyani@google.com>
---
 drivers/android/binder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index bcec598b89f2..d9030cb6b1e4 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2547,8 +2547,8 @@ static void binder_transaction(struct binder_proc *proc,
 						ref->node, &target_proc,
 						&return_error);
 			} else {
-				binder_user_error("%d:%d got transaction to invalid handle\n",
-						  proc->pid, thread->pid);
+				binder_user_error("%d:%d got transaction to invalid handle, %u\n",
+						  proc->pid, thread->pid, tr->target.handle);
 				return_error = BR_FAILED_REPLY;
 			}
 			binder_proc_unlock(proc);
-- 
2.32.0.554.ge1b32706d8-goog

