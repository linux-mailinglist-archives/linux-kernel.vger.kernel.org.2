Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E21418D24
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 01:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhIZXpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 19:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbhIZXpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 19:45:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B533C06176E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:44:05 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id k26so9543072pfi.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8K0wNqs/UoQMVWcbLzg7zpAq9uT/7eob5sdcWrFFCjE=;
        b=kFD/Z5J2xj2ugTXgq4UIoOmypwygBjvLHOo6K1Tc2eigh5LmmXmw4Zso7FtsJioTot
         NCveaxdSuE0wWDPtgXUB105caBHoki1Ykx3c6yGx1jzhRfbO6iVmun2NDokYZuBown1b
         jrDg1MmxL3N3x8JfVYUi5c5Bn9vT7lxFTM0DMbhZtblAQGV73y2w/ClWXvz/ykQVfJ/3
         rp8weZtfpGoRSnQOOH2wRKK3bliUnB8OUuU/rYZR5mwQyzNYblNCGOLbyOlq1gl9Q6hB
         ApCFinCHC7VktDousGIAl5ap9EPULJ2GijlEFQ6okPzKb+v3evU1HXqnoQiYwu9pZqzA
         wLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8K0wNqs/UoQMVWcbLzg7zpAq9uT/7eob5sdcWrFFCjE=;
        b=3gPplkMFfDbFqOYgLpiTOHuUBKZTZwdUK9Knjg49YBultMfZGdd+uJ3/zS3HzUvg6u
         SVSbk7RK7fs5+aQg9I7VccCZMswXC/5k7EGWtL4CoexmioLKoynCn4+O5Jjr0/5ugNlh
         ls523VfptPFc1J6inf4WxoZAP9ZiSt0h4D1H/60lZ7ivrA+U0bIpoXg+nSwIUCUgg18J
         KSm6ddaa7GewZawc6JuN02KxYZWBCk4ymp1QlBgSrbajg+pj7DokbxS1L7M2c6hl8/zL
         vaIjOwRshYM7hvS2ZNqv4MAj4J3kg0s5ncYoBy1P7gJ3yQuzZG0tZZaMBfKWhlBbmq0/
         YNbw==
X-Gm-Message-State: AOAM533R0YoRLrADcskL0F1pL/5pKPM/JI6bjFQ70f+X56jA1BFxorgH
        2LjKMA0YqjCZ82qlVqWh4Pk=
X-Google-Smtp-Source: ABdhPJzac/DPGQPxntJXg+GNkdPOEat1QboVk7R+cPMmUqJpSRSm0/fyONTMqEx0qTMlguk/EPtXmQ==
X-Received: by 2002:a65:6a4b:: with SMTP id o11mr13448662pgu.278.1632699844886;
        Sun, 26 Sep 2021 16:44:04 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id n22sm16783686pgc.55.2021.09.26.16.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 16:44:04 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>, Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [RFC PATCH 8/8] mm/madvise: process_madvise(MADV_DONTNEED)
Date:   Sun, 26 Sep 2021 09:12:59 -0700
Message-Id: <20210926161259.238054-9-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210926161259.238054-1-namit@vmware.com>
References: <20210926161259.238054-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Userfaultfd users, for the sake of memory management, debugging or other
types of monitoring may wish to use process_madvise(MADV_DONTNEED).

Moreover, since process_madvise() supports vectored operations, and now
supports efficient TLB flushes, existing users of madvise(MADV_DONTNEED)
that wish to perform advices on non-contiguous memory may prefer
the vectored process_madvise() flavor for performance reasons.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Colin Cross <ccross@google.com>
Cc: Suren Baghdasarya <surenb@google.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 mm/madvise.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 9528c38fb6a4..d8f70960680e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -81,6 +81,7 @@ static const struct madvise_info madvise_info[MADV_SOFT_OFFLINE+1] = {
 	},
 	[MADV_DONTNEED] = {
 		.behavior_valid = 1,
+		.process_behavior_valid = 1,
 		.need_mmap_read_only = 1,
 		.tlb_batching = 1,
 	},
-- 
2.25.1

