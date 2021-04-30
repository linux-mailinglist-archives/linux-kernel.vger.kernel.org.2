Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB2936FE0E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhD3Pv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 11:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229532AbhD3Pv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619797838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uV43EBRZ2ykE5yi+yXyntKcpN1XX0WQ6gyOJNYB5ePU=;
        b=BRL5LLiAx+piG6oV9gGCx2zYyg11sJTBVTER/EQ1Xt6mjOnCc5fQ/yXZrT2m4CGkzsryWS
        oIsfzTwmiRLJAH5VuW0uc8j+hZgLpS8uBKN4f/SnvgsCECIq1DUnoMkIbEak1NZwm63gq6
        lY0qoHTDb3dFQgGZj2fHLOtqaXAfUbs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-2IE3NeENPWSfV7P2YzyM1A-1; Fri, 30 Apr 2021 11:50:36 -0400
X-MC-Unique: 2IE3NeENPWSfV7P2YzyM1A-1
Received: by mail-qk1-f200.google.com with SMTP id h15-20020a37de0f0000b029029a8ada2e18so30597535qkj.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 08:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uV43EBRZ2ykE5yi+yXyntKcpN1XX0WQ6gyOJNYB5ePU=;
        b=q9jAfR8dLUKoEy2wFZHZt5bCpFQBVk29CfJEGcE1u3Sztg/EYdyptyK/FBVVzjzKLy
         6IFet0Ja6YY/u7RCIXIVajtyVYAWsUDirg17zslT/Oidi40DWZta+SuUEL4Wojz5VI5m
         n9WNdP+CmJ8ImlQFHn4KZEc0WDpuQPoxLMiZ3e/vIEUD9sFn5yF4V8AKhC2E6fnvpmZb
         XDyE6pjI6aPeyl3tmPVU0CTx1LFmwaYIQRTdqFKnsAu0G6x87eWi+tEOiNyd7wJfK0pE
         N/YGlccH28LkevAC7RR4tCOmbzT8zTnaFN5V14lr8q6Wm1kT4NrqCp7dk8neI0IfDx+J
         +wyQ==
X-Gm-Message-State: AOAM530z8h7u8agy6muqJTfEHX07QtcYv3XG9mX5b0Q3b1MVTdHjQtzk
        l4fJqc264dghxFGQwQTkwX4Yv8Twjhg8jS1Leukb1q13FxlJjREMj+mz1gMWg6cbRLelEHO+GGp
        kneiAKnuQXpZmKrS7g8r8IuDk
X-Received: by 2002:a37:e111:: with SMTP id c17mr6035624qkm.6.1619797836084;
        Fri, 30 Apr 2021 08:50:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxez1wHa5PDbJqV5wGDz1j6ec/qHjRWaLA9fSHzpvNytW3E51OG67uqrnscVtYxpkEq3DKFOA==
X-Received: by 2002:a37:e111:: with SMTP id c17mr6035614qkm.6.1619797835910;
        Fri, 30 Apr 2021 08:50:35 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q67sm1740642qkb.89.2021.04.30.08.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:50:35 -0700 (PDT)
From:   trix@redhat.com
To:     dhowells@redhat.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] afs: check function return
Date:   Fri, 30 Apr 2021 08:50:31 -0700
Message-Id: <20210430155031.3287870-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this problem

write.c:773:29: warning: Assigned value is garbage or undefined
  mapping->writeback_index = next;
                           ^ ~~~~
The call to afs_writepages_region() can return without setting
next.  So check the function return before using next.

Fixes: e87b03f5830e ("afs: Prepare for use of THPs")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/afs/write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index dc66ff15dd16..cabacb6b59da 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -769,7 +769,7 @@ int afs_writepages(struct address_space *mapping,
 		mapping->writeback_index = next / PAGE_SIZE;
 	} else if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX) {
 		ret = afs_writepages_region(mapping, wbc, 0, LLONG_MAX, &next);
-		if (wbc->nr_to_write > 0)
+		if (wbc->nr_to_write > 0 && ret == 0)
 			mapping->writeback_index = next;
 	} else {
 		ret = afs_writepages_region(mapping, wbc,
-- 
2.26.3

