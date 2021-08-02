Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893953DE216
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 00:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhHBWFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 18:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhHBWFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 18:05:23 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DABC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 15:05:13 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id t35-20020a05622a1823b02902647b518455so10730294qtc.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 15:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rYxgUvuCCo8HuK1xpUKaxOmM9jxXuFovqhvNZnbwZ3s=;
        b=h6s8AAldMLYZzzD8KjJLdSYTTLzLCZQGxsVCh0ANfT4wtzN8QvZdqkvdilYOdq9lfD
         1OcCVj7q2dbVkgy3vyw3cOW+FTvYR1XxtnTKejH/SPaoSR0GOra5VQxkgQtIJ1WkuzTU
         rv2uQiy8Vayec0DjpiIkJg0heDppDV/CK9ket3xA9fwJubCZFqPmee3LNMPqvs2U4Uhr
         c2eunl7Xg8Ri5z8nayurJlsIZxvsolBk7F8tJr8AU77a0jdjo0KmfyOHA99rnTZhh9Sp
         VWWG45LbWJ5xG1eYOHGi5nz0ACopqgr/ln47zE0GSVxs4zhZ0MoFUa0r8fZrQrOEHnGY
         RTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rYxgUvuCCo8HuK1xpUKaxOmM9jxXuFovqhvNZnbwZ3s=;
        b=TK/vq5srLJhwNTCy5S+0Ye7lG0AK7UxcBC0ZZsOvxMUVqXhYQk/OYxxNG4bh5hGWZo
         Q89RwzfSDNVlluu8ddVdSCtv9e1eKPDxUfe6uP03OoEcxHPhh/0H1k2iGdDqXUm2LZBs
         O9ffOI6GFKgTDKmYtURVRg4KrB/ScFQe4C/6lDkaHBGo85/556fb7O/zCssSSLYILo1A
         2fZe6iBRUSPtYGADmqfFjXDYY8XKA/Rf1q56bG1x08n65zD+QHV/rh4tXUUhziwaeYBb
         z5Wt/MoYF2sejdQHTCZmuS6UK4Q7wUOYdDzUdV5L1xvgCS9NMzRX18/DniYFL9KiHcWe
         cBiw==
X-Gm-Message-State: AOAM533Gg6vvm7a5Hf3/PlNJOgrkExA+02lxk/jVzAXWsgzDKZ3jilUr
        32/dNK2ZZQjEzXswZsUrTAZ40HZ2iiE0rFM=
X-Google-Smtp-Source: ABdhPJw5B66ILekLxj9PNgN/ESeTxD/huUhxoBIoEDPtwvCIqc04knVaxbXvzSFMf5zD00t2J2F1RJ6giICF3YU=
X-Received: from ramjiyani.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edd])
 (user=ramjiyani job=sendgmr) by 2002:a05:6214:1585:: with SMTP id
 m5mr18488661qvw.48.1627941912805; Mon, 02 Aug 2021 15:05:12 -0700 (PDT)
Date:   Mon,  2 Aug 2021 22:04:45 +0000
Message-Id: <20210802220446.1938347-1-ramjiyani@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v2] binder: Add invalid handle info in user error log
From:   Ramji Jiyani <ramjiyani@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Ramji Jiyani <ramjiyani@google.com>, Todd Kjos <tkjos@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of a failed transaction, only the thread and process id are
logged. Add the handle info for the reference to the target node in user
error log to aid debugging.

Signed-off-by: Ramji Jiyani <ramjiyani@google.com>
Acked-by: Todd Kjos <tkjos@google.com>
---
v1 -> v2: Rephrased the commit message as per review comment
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

