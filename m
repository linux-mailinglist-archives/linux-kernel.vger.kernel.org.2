Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB78C32A077
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381115AbhCBEVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:21:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31209 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241993AbhCBAJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 19:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614643610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2h8fczQfm9mH8nZ/vqlsLccWggev9tpVaiKuzYD1apQ=;
        b=EmBTzYzn2RFI7IgH/E2vl/NkR/ERly/d8loti6mF+OSVBU/HYKaRM/v50F1/f0gEQ3loEM
        n4KhJUMOttwe0QUfpMTmDF3U47R5H8VfqMicvLhBeU/Es/Rs1T5C1GG9OhITEeUljUb3Ic
        fRB1AiZPMNjcouM10uTriZSz0Q2veIY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-uOFAVcvBNDW4-R1VdIAx6A-1; Mon, 01 Mar 2021 19:06:49 -0500
X-MC-Unique: uOFAVcvBNDW4-R1VdIAx6A-1
Received: by mail-qk1-f197.google.com with SMTP id h20so5012132qkj.18
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 16:06:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2h8fczQfm9mH8nZ/vqlsLccWggev9tpVaiKuzYD1apQ=;
        b=fFV21AChmH0yT5pohEuyfqNkBzpN3FvrGgUA54ynV0BDpJ1KgGtc43vkNe45GRhMA0
         6lUoFRTxjMGYODXh+R633sq97bdxB9jPRLsIRvKLNwbx66FkeHaXAMA+WaS6aGq6+qfA
         b36Qz1rzg4Rsynj1glBqWrEEhzgzSlsP2LsH1gEL6rNqIfUfc/h0phogk/vSleLFV+Rz
         vIVeLSw9s1xpM6x/cQdeTzHCyQud3x9xjhQI3fPPM7MAI6S7u0Kf8UUbGyDgb0Y7SNlk
         oarLyCxML/iw1hTVl4ZBX+UtUEO21mDGsUScxRXYV7Bf2D16aYqhMLcCQWs5MLPtEq68
         6QvQ==
X-Gm-Message-State: AOAM5303/eKOFO/5gQd7vqGXRbUQcSPbf2jAv6NTpCEx4cES7QS14Jx9
        3XNsHM2nJ0y0SoVrDyZVvZugr0X9u5lV0ayq3ZFJRcQ6POCJh2f0X9Y5XayKl6FPYHaJ3bWv9ix
        4zSdNpewk/O/6J6mgqJl8oAQEDTl3BgX1sLlU30LeKqlqwhTJDV/it26akmwA/GDIAEZ82RC5kA
        ==
X-Received: by 2002:a0c:9148:: with SMTP id q66mr17656027qvq.0.1614643608379;
        Mon, 01 Mar 2021 16:06:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZdzAojdTxTmYQ6OCfQ+yoDgTR7v9pWNHGokVEgB0ijEbKL/kmqjoS65g2zxg0LxYQHNcaJw==
X-Received: by 2002:a0c:9148:: with SMTP id q66mr17656006qvq.0.1614643608065;
        Mon, 01 Mar 2021 16:06:48 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id b16sm11533217qtx.85.2021.03.01.16.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 16:06:47 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH v2] docs: filesystem: Update smaps vm flag list to latest
Date:   Mon,  1 Mar 2021 19:06:46 -0500
Message-Id: <20210302000646.432358-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've missed a few documentation when adding new VM_* flags.  Add the missing
pieces so they'll be in sync now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
v2:
- rebase
---
 Documentation/filesystems/proc.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 48fbfc336ebf..81bfe3c800cc 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -540,7 +540,9 @@ encoded manner. The codes are the following:
     ac    area is accountable
     nr    swap space is not reserved for the area
     ht    area uses huge tlb pages
+    sf    synchronous page fault
     ar    architecture specific flag
+    wf    wipe on fork
     dd    do not include area into core dump
     sd    soft dirty flag
     mm    mixed map area
@@ -549,6 +551,8 @@ encoded manner. The codes are the following:
     mg    mergable advise flag
     bt    arm64 BTI guarded page
     mt    arm64 MTE allocation tags are enabled
+    um    userfaultfd missing tracking
+    uw    userfaultfd wr-protect tracking
     ==    =======================================
 
 Note that there is no guarantee that every flag and associated mnemonic will
-- 
2.26.2

