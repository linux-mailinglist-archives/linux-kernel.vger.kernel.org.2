Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC4439C0ED
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 21:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhFDUBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhFDUBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:01:39 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0141DC061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 12:59:37 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id j206-20020a6280d70000b02902e9e02e1654so5921963pfd.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 12:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jBlEUGbY3b8g6dIjXWcbrWjBefIWreF/HXMBvYwoDp0=;
        b=jm8my7TF16J35qoVRbezLA3WooLXFZjasFcGwe7I9POWEyg8Ps/qcqZ2Yo/kVEVBsL
         p0eD8bDMQyqeOLCDxgv+pxoDtS3tSNses9uWQt+gM7oDVKmYBB86WkVjfJCprWJ+BhVj
         IVwCghFtTXluOmuABGDvnPlr5fzxFUchsBtHr2zdBnCB19P9YGaq5PclLTQ/HO3HiX3p
         m7i/9v5ucfa7dotnV/gz/N5cINZ/bi0+xG6g45QuKLDLlYk+/UYMtygawoY4tI5L1KiN
         Lwsdeh5imCR+xDI5XJRQk/S2+VZa5wMa6cHDSh8DiG7TuI+MidIOI9DXDCpNXLdozuis
         0OeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jBlEUGbY3b8g6dIjXWcbrWjBefIWreF/HXMBvYwoDp0=;
        b=VlcDExPkSTaKP2jf4vvF3j13bvSVxyouHoiIg6Gn0j1/2veXYo9nmZYNdMn6Ml0q2Y
         KkiiyY2Y2E2Lg6iYcXHdTfRHzCSHx65Nk/v3siibtgN0jwRvkxlI7gqlaiDvYW1QGIkb
         uZcUfbB7b1uG4LAdkhCn/SuxdzuGUkLQNImjtTDZpgpGJ1BpCcJaLzSSubF+v4vR6SIJ
         nnDVRE1jotERIn1TrDD8eQGvm4TxuCp4oSj0Jtbp2Y5rGCDdLfo4eBcmAk1475fhi6LG
         ag/rN9UOCXF2sMxDPYDmWgPnsBTaVONG+jnCmZWnX/WuH+h2GmP5Cb3Jpu76qC1eF7eG
         wJQg==
X-Gm-Message-State: AOAM530YT0q31AuBEjvX3G7lhYB0QOhFUGPHzfX49jvuUbvGxBAYR/11
        7kX4zVSObwHQl/3+nNyN732eG43BuFw=
X-Google-Smtp-Source: ABdhPJybK+Y+9fdHsla3It3WXjr5AOT/z7ea31AoJVRgzJKgiqpfrCt0fg3QxTSDhnBOdYvRVjuAHbqoA5o=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:aa7:9d92:0:b029:2e9:dcf0:a2ef with SMTP id
 f18-20020aa79d920000b02902e9dcf0a2efmr5949723pfq.46.1622836776394; Fri, 04
 Jun 2021 12:59:36 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:58:58 +0000
In-Reply-To: <20210604195900.2096121-1-satyat@google.com>
Message-Id: <20210604195900.2096121-9-satyat@google.com>
Mime-Version: 1.0
References: <20210604195900.2096121-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 08/10] dm: handle error from blk_ksm_register()
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle any error from blk_ksm_register() in the callers. Previously,
the callers ignored the return value because blk_ksm_register() wouldn't
fail as long as the request_queue didn't have integrity support too, but
as this is no longer the case, it's safer for the callers to just handle
the return value appropriately.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/md/dm-table.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 29cbfc3e3c4b..e44f304b5c1a 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1354,7 +1354,21 @@ static void dm_update_keyslot_manager(struct request_queue *q,
 
 	/* Make the ksm less restrictive */
 	if (!q->ksm) {
-		blk_ksm_register(t->ksm, q);
+		/*
+		 * This WARN_ON should never trigger since t->ksm isn't be
+		 * "empty" (i.e. will support at least 1 crypto capability), the
+		 * request queue doesn't support integrity (since
+		 * dm_table_construct_keyslot_manager() checks that), and
+		 * it also satisfies all the block layer constraints
+		 * "sufficiently" (as in the constraints of the DM device's
+		 * request queue won't preclude any of the intersection of the
+		 * supported capabilities of the underlying devices, since if
+		 * some capability were precluded by the DM device's request
+		 * queue's constraints, that capability would also have been
+		 * precluded by one of the child device's request queues)
+		 */
+		if (WARN_ON(!blk_ksm_register(t->ksm, q)))
+			dm_destroy_keyslot_manager(t->ksm);
 	} else {
 		blk_ksm_update_capabilities(q->ksm, t->ksm);
 		dm_destroy_keyslot_manager(t->ksm);
-- 
2.32.0.rc1.229.g3e70b5a671-goog

