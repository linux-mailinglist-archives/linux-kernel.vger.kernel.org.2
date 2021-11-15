Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E0A4505F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhKONxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:53:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231845AbhKONxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636984208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wKxkeDUfwxQx13XQZaRduws4du0bmSnfXtJrXN7mSsk=;
        b=DQwHYX37Z7ra1UUZ/d7zGZ20phDEdo7Exkc8K9iYCveNlARwBfDza+Cr/JSPAsvlGZuyu9
        MFaeNMMORNDEigcxXDh6f85v9fVtTN3sXawKifEsPHHrkK/Jm7vjKnCs/HXgEsbu5Ftv88
        vFBz0GRNClHerYbc3Qj/AfsI8DtsHc0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-4juYTEd4OdWI5cQOI4NbnQ-1; Mon, 15 Nov 2021 08:50:07 -0500
X-MC-Unique: 4juYTEd4OdWI5cQOI4NbnQ-1
Received: by mail-pg1-f197.google.com with SMTP id q29-20020a631f5d000000b002dfcc4e0201so7264772pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 05:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wKxkeDUfwxQx13XQZaRduws4du0bmSnfXtJrXN7mSsk=;
        b=H2CxIgMREzP10TuZyNfsoXwG2f1dmxCnRB97HOgG5syvnlb/Och5cHKApw2QGcb1Un
         S5sTrcvUD8bTrVX5tsSLhJdyQ29DDJs4k++8nIqXADyxr6i4GJ4lfq6uBKzs30IoWUWk
         Xcaga2XJGqoNjsvT3RkNYWZ4aGqkynQPm4w2esW7bjjcQyKEKDXNUQreXbCHVoIwk7wX
         O5R2xAocUKSRIIQNpHEs38YhBVFNSq9gHfYXA94uQUcOZ844YP8FWLCXU5/oib2/WB7k
         1JfW172HQau2462bXXEilcwzagNNhNRHTt0h3v8D2KzvotZDFIneivqTXm69qNsDZN22
         XGTg==
X-Gm-Message-State: AOAM530odftumlKLeRof2DwyUbZh1cPlFAKjWaWh6Fru4gcpXIzCo8RI
        oDCffPBnCsygXbjQPsvgZVuj7iUFWEi6O7Yo0zLnPCWMSe5hXbgS6suZMjAb62C18ol0ObTDyKF
        KvdM0X2fhs+1d8hdo1iP2IBc//PY2Sy1xg0m7AJrfkdOzdwwSPnsCvn3txXaM7indnx470USKNA
        ==
X-Received: by 2002:a62:924e:0:b0:4a2:82d7:1244 with SMTP id o75-20020a62924e000000b004a282d71244mr20563380pfd.50.1636984205568;
        Mon, 15 Nov 2021 05:50:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyv8re2/SMpKzf1Sj2CYlrHxo4P3jy1/NtL8XAykTmE1/FiqOAdQnhgBIVZTtdsbZov0yW7MA==
X-Received: by 2002:a62:924e:0:b0:4a2:82d7:1244 with SMTP id o75-20020a62924e000000b004a282d71244mr20563328pfd.50.1636984205148;
        Mon, 15 Nov 2021 05:50:05 -0800 (PST)
Received: from localhost.localdomain ([191.101.132.72])
        by smtp.gmail.com with ESMTPSA id p188sm15499471pfg.102.2021.11.15.05.49.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 05:50:04 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH RFC v2 0/2] mm: Rework zap ptes on swap entries
Date:   Mon, 15 Nov 2021 21:49:49 +0800
Message-Id: <20211115134951.85286-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- Resend to rebase to tag v5.16-rc1 (fa55b7dcdc43)

The goal of this small series is to replace the previous patch (which is the
5th patch of the series):

https://lore.kernel.org/linux-mm/20210908163628.215052-1-peterx@redhat.com/

This patch used a more aggresive (but IMHO cleaner and correct..) approach by
removing that trick to skip swap entries, then we handle swap entries always.

The behavior of "skipping swap entries" existed starting from the initial git
commit that we'll try to skip swap entries when zapping ptes if zap_detail
pointer specified.

I found that it's probably broken because of the introduction of page migration
mechanism that does not exist yet in the world of 1st git commit, then we could
errornously skip scanning the swap entries for file-backed memory, like shmem,
while we should.  I'm afraid we'll have RSS accounting wrong for those shmem
pages during migration so there could have leftover SHMEM RSS accounts.

Patch 1 did that removal of the trick, details in the commit message.

Patch 2 is a further cleanup for zap pte swap handling that can be done after
patch 1, in which there's no functional change intended.

The change should be on the slow path for zapping swap entries (e.g., we handle
none/present ptes in early code path always, so they're totally not affected),
but if anyone worries about specific workload that may be affected by this
patchset, please let me know and I'll be happy to run some more tests.  I could
also overlook something that was buried in history, in that case please kindly
point that out.  Marking the patchset RFC for this.

Smoke tested only.  Please review, thanks.

Peter Xu (2):
  mm: Don't skip swap entry even if zap_details specified
  mm: Rework swap handling of zap_pte_range

 mm/memory.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

-- 
2.32.0

