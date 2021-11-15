Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19046450616
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhKON4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:56:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55407 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232000AbhKONz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636984352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=G6mvg61YlD7IhRhajTmh6Jvh8tR/o7YtVU1973fVaBU=;
        b=Hnibuxl+/zthYG673w/kly344TjhhKadyapDW3sYCS/B+IzktyIVjsIPJfKAh/MEEC5CdA
        4iJ1Z0ZV/Oqyo2GJrT+CEc8GfInRJClxMQeYNBy+VeYG+qvooWF9mIws4VuXKlACJkuUTM
        dn88fEfxdFkRDiGQZ4gZdBA2Cambhug=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-rvd-mbHUOxuMiEynHJBmBg-1; Mon, 15 Nov 2021 08:52:31 -0500
X-MC-Unique: rvd-mbHUOxuMiEynHJBmBg-1
Received: by mail-pj1-f71.google.com with SMTP id iq9-20020a17090afb4900b001a54412feb0so9028038pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 05:52:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G6mvg61YlD7IhRhajTmh6Jvh8tR/o7YtVU1973fVaBU=;
        b=8Izrne9MEuYbGH6IyAu5dOhv/HzXMBYqvIo/uUhjLNOQWlxOyGflNVqH2o3JaKPX6t
         em1SmDhsNB4EampBS0ad7uDHHYypmZevaDJAI/xYV0ICuU/3+FV9tHlA++uMSbJu0fHN
         Uls0qfZLcd0SM+PH6QwA5ijyeb87Jsfta4flYIWMlNwfOCHFQToTvwK4F5r20T7qg142
         FqiWjk7y7iZF9mliu3UZmuHqDsdYfqCh8mqjq8QZhVp331xd+UmcQ9W7Lf9MlULOk5QH
         iNuMXXJdOuQSfdZqTWSCah5gZoRN1Km6Yo7ZX+U7OKQ+mhdZb24Fhdh+fJP3Xya/d29E
         c4pw==
X-Gm-Message-State: AOAM532IlwYnll3tHR+8UvxECam0DaOZF8RZfw9nd/EjB/S9GqZ5KPxd
        KETK2ATaiojwFTH3aPxA+CTVgLR5v1CQLKvtDcUGUBdKQTvezLhVJxb0ZO26HnKGuOybC58Myb0
        LB/phkVvD+l6NrotDTn1wd166
X-Received: by 2002:a63:920b:: with SMTP id o11mr24351508pgd.314.1636984350161;
        Mon, 15 Nov 2021 05:52:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRqq3KS/bKMPGca2vbO5WJgqxcSez+txIiLTkNRoYDGbLnhbV4nn5jzGtrTi7bNuQ50/XpYA==
X-Received: by 2002:a63:920b:: with SMTP id o11mr24351487pgd.314.1636984349943;
        Mon, 15 Nov 2021 05:52:29 -0800 (PST)
Received: from localhost.localdomain ([191.101.132.72])
        by smtp.gmail.com with ESMTPSA id u11sm16149464pfk.152.2021.11.15.05.52.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 05:52:29 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH] selftests/uffd: Allow EINTR/EAGAIN
Date:   Mon, 15 Nov 2021 21:52:19 +0800
Message-Id: <20211115135219.85881-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allow test to continue with interruptions like gdb.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 8a09057d2f22..64845be3971d 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -644,7 +644,7 @@ static int uffd_read_msg(int ufd, struct uffd_msg *msg)
 
 	if (ret != sizeof(*msg)) {
 		if (ret < 0) {
-			if (errno == EAGAIN)
+			if (errno == EAGAIN || errno == EINTR)
 				return 1;
 			err("blocking read error");
 		} else {
@@ -720,8 +720,11 @@ static void *uffd_poll_thread(void *arg)
 
 	for (;;) {
 		ret = poll(pollfd, 2, -1);
-		if (ret <= 0)
+		if (ret <= 0) {
+			if (errno == EINTR || errno == EAGAIN)
+				continue;
 			err("poll error: %d", ret);
+		}
 		if (pollfd[1].revents & POLLIN) {
 			if (read(pollfd[1].fd, &tmp_chr, 1) != 1)
 				err("read pipefd error");
-- 
2.32.0

