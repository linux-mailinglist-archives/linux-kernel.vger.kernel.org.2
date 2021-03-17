Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE5833F238
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhCQOFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhCQOFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:05:13 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C494C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 07:05:12 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id dc12so495038qvb.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 07:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PWoltp9WmwyO3d7XhliVywf9i2GXKDnsLpbRrO2NbGI=;
        b=WsRpNG8sX0PGjK+pfA+SQ3Bb3jhflsFaBhjj63LbczCkJ+7RcnSs60BJC1XVRTzffh
         ROYiVgrbr2NmfFs/FGJdGvIW460RaXjSJ7qb5vOugINIc9EiS1DXbtJFe0WYDSAPHGlA
         HQ4SiZdhN07sZRsTsJtQi+VtW6bA1Cr6v/QjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PWoltp9WmwyO3d7XhliVywf9i2GXKDnsLpbRrO2NbGI=;
        b=ijOwIDMVDPlFAv21u7IxmoHsByym9P5TFBTo4PSQb6ax6WXonr2M3lYIizdNTLMcyp
         r5cEmJqsZTGrW6f0rzzMNnoKQvMTE4EZv/B7GcDJBz8XLMfzF7r/zo24VOaNalmUvo+v
         SjRPGVbnsL2gei0tC36h5RCYiPF7K+SzSTldFktTrsIfZkmphZ5Y/0PTEl54t3o8kJE5
         5/ArBU8u9u6NRPT2p3fu03+FJCZHTadNZiqOfyNNNqr+5/u53QcP/tHd1XcKb8EGDQo8
         KxaBJd5X745DT4oxP3MJu/ItiTC2nUm43IZMutg6kL7whf4lESZjleJ8ImcR+gWyw7lU
         WC3A==
X-Gm-Message-State: AOAM532/6JE20t9ys2q/L3CaaEioqw+kJkzYJElouRrKgsbwClYhJLAJ
        jXtL12jo2ugOxXFth/r8dNE+fg==
X-Google-Smtp-Source: ABdhPJyuvoed78WS6+HdEBNB7QZ/3oGdsTqI0V2wAYQM4QWLyFqID+v4ui/DHHggT9LydDHCzeR7Ng==
X-Received: by 2002:a0c:a909:: with SMTP id y9mr5600566qva.20.1615989911862;
        Wed, 17 Mar 2021 07:05:11 -0700 (PDT)
Received: from tuna.fritz.box ([2a02:8070:87b9:f700:d43d:6bf:d9e5:58a3])
        by smtp.gmail.com with ESMTPSA id e3sm17864791qkn.39.2021.03.17.07.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 07:05:11 -0700 (PDT)
From:   Jan Glauber <jglauber@digitalocean.com>
To:     linux-raid@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
        Jan Glauber <jglauber@digitalocean.com>
Subject: [PATCH] md: Fix missing unused status line of /proc/mdstat
Date:   Wed, 17 Mar 2021 15:04:39 +0100
Message-Id: <20210317140439.9499-1-jglauber@digitalocean.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading /proc/mdstat with a read buffer size that would not
fit the unused status line in the first read will skip this
line from the output.

So 'dd if=/proc/mdstat bs=64 2>/dev/null' will not print something
like: unused devices: <none>

Don't return NULL immediately in start() for v=2 but call
show() once to print the status line also for multiple reads.

Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
Signed-off-by: Jan Glauber <jglauber@digitalocean.com>
---
 drivers/md/md.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 21da0c48f6c2..cb19d50fa672 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8153,7 +8153,11 @@ static void *md_seq_start(struct seq_file *seq, loff_t *pos)
 	loff_t l = *pos;
 	struct mddev *mddev;
 
-	if (l >= 0x10000)
+	if (l == 0x10000) {
+		++*pos;
+		return (void *)2;
+	}
+	if (l > 0x10000)
 		return NULL;
 	if (!l--)
 		/* header */
-- 
2.17.1

