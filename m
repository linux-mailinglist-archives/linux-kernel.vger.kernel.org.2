Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E180413706
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbhIUQPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:15:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229804AbhIUQPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632240815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qpu+HTkDrTU2emAVPYaio1EuujPd/r4QIzzzcyyaBgg=;
        b=TkhoJv3S+N9FgvKAQgv269srhFF3NGONY3IruZJpi56O+XEg8aDS+m0GGrjGI8gOq4JavC
        et8jjpI1P7dbyK5YwBdCFKRVMzmIe2FyHsO87IfvavQ2BX/4DuWE2CrZVA7UnP6kuQEc5W
        kQ5UUhg6RtNVNm1GKEPh1PluI2eloHA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-eEH2KyFIOZGl1OvDjlYSrw-1; Tue, 21 Sep 2021 12:13:34 -0400
X-MC-Unique: eEH2KyFIOZGl1OvDjlYSrw-1
Received: by mail-wr1-f69.google.com with SMTP id k2-20020adfc702000000b0016006b2da9bso4200026wrg.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qpu+HTkDrTU2emAVPYaio1EuujPd/r4QIzzzcyyaBgg=;
        b=IdUg+HN+96ofWm0xNCvqbTYxOjKZNyxGLYK4G3Za9xW5PskvviFs98DFGQV2OWgeWs
         yXsdjX4FRRRQF5XjtM3xw4v6WDUrlgzmr41OGggVOLkMkP7eL6XFJiFcy0W4uuEse27Q
         E4qVRwL+93hqFkE3OAb27m+IH//SYIZrOo8ehenqXOMIGqEGPyj7LlaHbcd6vgK8EAZv
         JclIYQTt9AP9VzZQcs16AwUd66MdBZWXPqRpsJbsPTAJz5AGEp04XAfrRK4Zmiy0u3WH
         Bl+U9dZvxucLTXPJUp7mmhKcIXwGGUEhY1ioaBqByWDaBmyJwDL3KwPdVlA1fALScQcy
         Ouog==
X-Gm-Message-State: AOAM5312IlRTrXXc/iS1TtGdkoQKZrz2SYt0+7GicsIPHOIs6TQnAvJH
        fuVsWKS8vL1nxJhOx7rQF3gnulR8uY79z0l9KvP9EMGzLoBqBU8+pEYRohT79b0IKOCPNiWz7h3
        mrMQOOp73jUvP4FIiXROMGLgF
X-Received: by 2002:a5d:6c6e:: with SMTP id r14mr8786531wrz.319.1632240813485;
        Tue, 21 Sep 2021 09:13:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCaTYPwc/9t2AtLYmgJlq3XzRG6bZgmYBolkh1RNI380hxk+8ra/35JT3nNBei0WBHtrFC/g==
X-Received: by 2002:a5d:6c6e:: with SMTP id r14mr8786498wrz.319.1632240813317;
        Tue, 21 Sep 2021 09:13:33 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id t1sm19786477wrz.39.2021.09.21.09.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:13:32 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, cl@linux.com, peterz@infradead.org,
        juri.lelli@redhat.com, mingo@redhat.com, mtosatti@redhat.com,
        nilal@redhat.com, mgorman@suse.de, ppandit@redhat.com,
        williams@redhat.com, bigeasy@linutronix.de,
        anna-maria@linutronix.de, linux-rt-users@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH 0/6] mm: Remote LRU per-cpu pagevec cache/per-cpu page list drain support
Date:   Tue, 21 Sep 2021 18:13:18 +0200
Message-Id: <20210921161323.607817-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces an alternative locking scheme around mm/swap.c's per-cpu
LRU pagevec caches and mm/page_alloc.c's per-cpu page lists which will allow
for remote CPUs to drain them. Currently, only a local CPU is permitted to
change its per-cpu lists, and it's expected to do so, on-demand, whenever a
process demands it (by means of queueing an drain task on the local CPU). Most
systems will handle this promptly, but it'll cause problems for NOHZ_FULL CPUs
that can't take any sort of interruption without breaking their functional
guarantees (latency, bandwidth, etc...). Having a way for these processes to
remotely drain the lists themselves will make co-existing with isolated CPUs
possible, at the cost of more constraining locks.

Fortunately for non-NOHZ_FULL users, the alternative locking scheme and remote
drain code are conditional to a static key which is disabled by default. This
guarantees minimal functional or performance regressions. The feature will only
be enabled if NOHZ_FULL's initialization process was successful.

This work is based on a previous series by Thomas Gleixner, Anna-Maria
Gleixner, and Sebastian Andrzej Siewior[1].

[1] https://patchwork.kernel.org/project/linux-mm/patch/20190424111208.24459-3-bigeasy@linutronix.de/

Nicolas Saenz Julienne (6):
  mm/swap: Introduce lru_cpu_needs_drain()
  mm/swap: Introduce alternative per-cpu LRU cache locking
  mm/swap: Allow remote LRU cache draining
  mm/page_alloc: Introduce alternative per-cpu list locking
  mm/page_alloc: Allow remote per-cpu page list draining
  sched/isolation: Enable 'remote_pcpu_cache_access' on NOHZ_FULL
    systems

 kernel/sched/isolation.c |   9 +-
 mm/internal.h            |   2 +
 mm/page_alloc.c          | 111 ++++++++++++++++-----
 mm/swap.c                | 202 ++++++++++++++++++++++++++++++---------
 4 files changed, 253 insertions(+), 71 deletions(-)

-- 
2.31.1

