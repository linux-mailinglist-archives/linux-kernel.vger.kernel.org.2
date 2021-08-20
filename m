Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69523F34B8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 21:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbhHTTmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 15:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhHTTmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 15:42:14 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EEBC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 12:41:35 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l24-20020a05600c089800b002e71a10130eso3476923wmp.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 12:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=5RznWGqXj/jBPtTT+YN2wnmJwMRQxuCrDJhua5Qhrk0=;
        b=dhDMqRu8MUMOI0sBiF9hBkUvWbqIgZqpZA1uvxRGpHpbgAjwDLleAPXEYezh0xvPK1
         orV+Pzy9oRlXSV+M5LIOvkHWWT11fsgvfDdEsm5QI97Tls2uWEBiVw+3xI0LjnF/K6k8
         BbuYFrl+m8H33HRM/CBq9dGdDmlT4UeI6H61aHT1Uc6LuKRrntiGJBGRGFV4Bg+vjD+V
         peFtKKcLMnD7e/XG+L2Ky2Ai8ORCBNnJ0MhCqsOLe/gDbsMhV/EsvT5cWVOYhdcDEOy3
         j8xZSfO2OnyVYKzti13owKeSO0dcW0OJjebkCvqfINvfoksmMlqfTaVoQ+RMpCqBdrfV
         kMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=5RznWGqXj/jBPtTT+YN2wnmJwMRQxuCrDJhua5Qhrk0=;
        b=EetKqRoTtsanxwDf0y5KPG07HPTqYO9z7Laa3I4B+c0HVhLG20Ji1QlUky7Bn3fniP
         X7qT3CdhiUopPnvoYTJIdZiM5Up7MRdVmbZZSSS4ao8Lvla+5vDF6n39sHECSsN0QwuB
         D57oxQfAUkh4ItmJd/42tkkgFrGiSNxdm4xcdUmYtLcyQv/aEsgv/T+ndj9yNDCvTINJ
         lz4seVPfMINn157EzF3sKFcfsGj8DwJyBkwzbHiA7GC3gL8B6ohPf7VP+QXJgRtGiL59
         xeIcojlfsYmPXCWGzHtZH+x4C1yZ/QBRBWo+743JUSz4MWS4PHPEDemLZLctV+jlJr15
         87tw==
X-Gm-Message-State: AOAM530hyofOG6BASIAH503Sj/v8eWQDYd115e9OOwZ+yRiW3ZE/qDaH
        ZJ/BizvK7d0nIepafJmTwR9Bng==
X-Google-Smtp-Source: ABdhPJz9y3EnsFfpk1lS9RUQFVG30gKlg+W7DOyUTRc9FRPOoLFRrba1V09A7Nc8OKBL8LJw8gos7g==
X-Received: by 2002:a1c:440a:: with SMTP id r10mr5493478wma.8.1629488494476;
        Fri, 20 Aug 2021 12:41:34 -0700 (PDT)
Received: from localhost.localdomain (p200300d9970474004f5b41e5800b75c6.dip0.t-ipconnect.de. [2003:d9:9704:7400:4f5b:41e5:800b:75c6])
        by smtp.googlemail.com with ESMTPSA id b12sm8337490wrx.72.2021.08.20.12.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 12:41:33 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] ipc: replace costly bailout check in sysvipc_find_ipc()
To:     Rafael Aquini <aquini@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Waiman Long <llong@redhat.com>, 1vier1@web.de
References: <20210809203554.1562989-1-aquini@redhat.com>
Message-ID: <127e0132-50b7-9759-722c-3dea079877e5@colorfullife.com>
Date:   Fri, 20 Aug 2021 21:41:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809203554.1562989-1-aquini@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------0AF222D5CF767A68B5C29B90"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0AF222D5CF767A68B5C29B90
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 8/9/21 10:35 PM, Rafael Aquini wrote:
> sysvipc_find_ipc() was left with a costly way to check if the offset
> position fed to it is bigger than the total number of IPC IDs in use.
> So much so that the time it takes to iterate over /proc/sysvipc/* files
> grows exponentially for a custom benchmark that creates "N" SYSV shm
> segments and then times the read of /proc/sysvipc/shm (milliseconds):
>
>      12 msecs to read   1024 segs from /proc/sysvipc/shm
>      18 msecs to read   2048 segs from /proc/sysvipc/shm
>      65 msecs to read   4096 segs from /proc/sysvipc/shm
>     325 msecs to read   8192 segs from /proc/sysvipc/shm
>    1303 msecs to read  16384 segs from /proc/sysvipc/shm
>    5182 msecs to read  32768 segs from /proc/sysvipc/shm
>
> The root problem lies with the loop that computes the total amount of ids
> in use to check if the "pos" feeded to sysvipc_find_ipc() grew bigger than
> "ids->in_use". That is a quite inneficient way to get to the maximum index
> in the id lookup table, specially when that value is already provided by
> struct ipc_ids.max_idx.
>
> This patch follows up on the optimization introduced via commit 15df03c879836
> ("sysvipc: make get_maxid O(1) again") and gets rid of the aforementioned
> costly loop replacing it by a simpler checkpoint based on ipc_get_maxidx()
> returned value, which allows for a smooth linear increase in time complexity
> for the same custom benchmark:
>
>       2 msecs to read   1024 segs from /proc/sysvipc/shm
>       2 msecs to read   2048 segs from /proc/sysvipc/shm
>       4 msecs to read   4096 segs from /proc/sysvipc/shm
>       9 msecs to read   8192 segs from /proc/sysvipc/shm
>      19 msecs to read  16384 segs from /proc/sysvipc/shm
>      39 msecs to read  32768 segs from /proc/sysvipc/shm

Could you run your test with the attached patch?

The patch switches the code to idr_get_next(), and I see a speedup of 
factor 400 for this test:

- boot with ipcmni_extend

- create ipc object

- echo 16000000 > /proc/sys/kernel/msg_next_id

- create ipc object

- time cat /proc/sysvipc/msg

with current mainline: 8.65 seconds

with the patch: 0.02 seconds


If there are no gaps, then I would assume there is no speed-up compared 
to your patch, but it would be create if you could check

[and check that there is no slow-down]


Thanks,

--

     Manfred


--------------0AF222D5CF767A68B5C29B90
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-PATCH-Improve-sysvipc_find_ipc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-PATCH-Improve-sysvipc_find_ipc.patch"

From 4b7975d712db27c3d08731e0ebe4efd684256ca4 Mon Sep 17 00:00:00 2001
From: Manfred Spraul <manfred@colorfullife.com>
Date: Fri, 20 Aug 2021 21:08:12 +0200
Subject: [PATCH] [PATCH] Improve sysvipc_find_ipc()

Initially noticed by Rafael Aquini, see
https://lore.kernel.org/lkml/20210809203554.1562989-1-aquini@redhat.com/

The algorithm used in sysvipc_find_ipc() is highly inefficient.
It actually needs to find the next used index in an idr, and it uses
a for loop to locate that entry.

But: The IDR API contains idr_get_next(), thus switch the code to use
idr_get_next().

In addition: Update a few comments.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 ipc/util.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index 0027e47626b7..083fd6dba1a1 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -783,35 +783,32 @@ struct pid_namespace *ipc_seq_pid_ns(struct seq_file *s)
 }
 
 /*
- * This routine locks the ipc structure found at least at position pos.
+ * This routine locks the ipc structure found at least at index pos.
  */
 static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
 					      loff_t *new_pos)
 {
+	int tmpidx;
 	struct kern_ipc_perm *ipc;
-	int total, id;
-
-	total = 0;
-	for (id = 0; id < pos && total < ids->in_use; id++) {
-		ipc = idr_find(&ids->ipcs_idr, id);
-		if (ipc != NULL)
-			total++;
-	}
 
-	ipc = NULL;
-	if (total >= ids->in_use)
-		goto out;
+	tmpidx = pos;
 
-	for (; pos < ipc_mni; pos++) {
-		ipc = idr_find(&ids->ipcs_idr, pos);
-		if (ipc != NULL) {
-			rcu_read_lock();
-			ipc_lock_object(ipc);
-			break;
-		}
+	ipc = idr_get_next(&ids->ipcs_idr, &tmpidx);
+	if (ipc != NULL) {
+		rcu_read_lock();
+		ipc_lock_object(ipc);
+		/*
+		 * We found the object with the index tmpidx.
+		 * For next search, start with tmpidx+1
+		 */
+		*new_pos = tmpidx + 1;
+	} else {
+		/*
+		 * EOF. seq_file can't notice that, thus
+		 * move the offset by one.
+		 */
+		*new_pos = pos + 1;
 	}
-out:
-	*new_pos = pos + 1;
 	return ipc;
 }
 
@@ -829,7 +826,7 @@ static void *sysvipc_proc_next(struct seq_file *s, void *it, loff_t *pos)
 }
 
 /*
- * File positions: pos 0 -> header, pos n -> ipc id = n - 1.
+ * File positions: pos 0 -> header, pos n -> ipc idx = n - 1.
  * SeqFile iterator: iterator value locked ipc pointer or SEQ_TOKEN_START.
  */
 static void *sysvipc_proc_start(struct seq_file *s, loff_t *pos)
@@ -854,7 +851,7 @@ static void *sysvipc_proc_start(struct seq_file *s, loff_t *pos)
 	if (*pos == 0)
 		return SEQ_START_TOKEN;
 
-	/* Find the (pos-1)th ipc */
+	/* Find the ipc object with the index >= (pos-1) */
 	return sysvipc_find_ipc(ids, *pos - 1, pos);
 }
 
-- 
2.31.1



--------------0AF222D5CF767A68B5C29B90--
