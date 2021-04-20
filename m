Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DF6365C57
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbhDTPkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:40:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232174AbhDTPkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618933177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v0hTcWbX3BCC9ZUFjKu3oL9Qk+b2NyA6y6oL3gT9PjE=;
        b=i9+BoiwH/zxsQGCCi0ZLVeTk4bMJIdRqPxfQq4GMt9LTENnSgixcvSBle8H45U8FrThuNf
        6SDJ9ywnN2EsVk/Rlyye1wul6TCNWhk6m61AUrofYfF6OXXrs9klz63c1XXFNE9g6M0U/y
        aJkAFQZaF1wsh3GfwfWl7gK3xJb58+g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-EXBTrGR5O9erS5ZO7dFgVQ-1; Tue, 20 Apr 2021 11:39:35 -0400
X-MC-Unique: EXBTrGR5O9erS5ZO7dFgVQ-1
Received: by mail-qk1-f198.google.com with SMTP id n18-20020a05620a1532b02902e4141f2fd8so781037qkk.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 08:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v0hTcWbX3BCC9ZUFjKu3oL9Qk+b2NyA6y6oL3gT9PjE=;
        b=RB2U+42uSKtUwSce0zdgUfWuCt80YklP8/ttQelprwyIGJHNXASyWioXNE97oA0gyd
         eHIHdpgF5x4a+r2Qyp+3K3ZyzgZE7gIlb4lyaqSZmjOjsdHVU3kFIsrYcZrOUA4eetsS
         wUCWmyzWqhUnkHCqxhIQUqxpzwv9QKueN4QuPvfyu9eGRmCexsYKvdpQ5rvgVgwJENXG
         kJWNEc+Ig+1Lau7Pt5DYSNlVnSk1kZlbYXux/WAXgU9wrfKmVZdhothscUIxl9IgMsUW
         IdGAi7PqUL8MhTbjQRXYlZX8Bl/MF5eNAucU+BXu51lIeM1s8a+aU2qBNQtGK2vGSzEV
         xlvA==
X-Gm-Message-State: AOAM531u5LBj71Dijg9OhLJMCensAuVNCWeJeKoSxI7WRIVAbj701sSG
        djP9ZwHn4cZoQoOcLoYcIyOyLbnlyxARX7JCqQ4214hCitGkda8CFX2r3p57kt/W64f4fSG+l+L
        tSXEDR1krETkrfUaLKunt71nr
X-Received: by 2002:ac8:6703:: with SMTP id e3mr2290916qtp.247.1618933174875;
        Tue, 20 Apr 2021 08:39:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyn0RU8rrRtvS0aT44DO1pxylQ0/+NBEAMy1jGC/Bhuc46/VKsZuFkoMeQ5x5S9cCioVtWTXw==
X-Received: by 2002:ac8:6703:: with SMTP id e3mr2290900qtp.247.1618933174663;
        Tue, 20 Apr 2021 08:39:34 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id f12sm11633325qtq.84.2021.04.20.08.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 08:39:34 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
        Sean Christopherson <seanjc@google.com>,
        Andrew Jones <drjones@redhat.com>
Subject: [PATCH v4 2/2] KVM: selftests: Wait for vcpu thread before signal setup
Date:   Tue, 20 Apr 2021 11:39:29 -0400
Message-Id: <20210420153929.482810-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210420153929.482810-1-peterx@redhat.com>
References: <20210420153929.482810-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main thread could start to send SIG_IPI at any time, even before signal
blocked on vcpu thread.  Reuse the sem_vcpu_stop to sync on that, so when
SIG_IPI is sent the signal will always land correctly as an -EINTR.

Without this patch, on very busy cores the dirty_log_test could fail directly
on receiving a SIG_USR1 without a handler (when vcpu runs far slower than main).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index fc87e2f11d3d..d3050d1c2cd0 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -534,6 +534,12 @@ static void *vcpu_worker(void *data)
 	sigemptyset(sigset);
 	sigaddset(sigset, SIG_IPI);
 
+	/*
+	 * Tell the main thread that signals are setup already; let's borrow
+	 * sem_vcpu_stop even if it's not for it.
+	 */
+	sem_post(&sem_vcpu_stop);
+
 	guest_array = addr_gva2hva(vm, (vm_vaddr_t)random_array);
 
 	while (!READ_ONCE(host_quit)) {
@@ -785,6 +791,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	pthread_create(&vcpu_thread, NULL, vcpu_worker, vm);
 
+	sem_wait_until(&sem_vcpu_stop);
+
 	while (iteration < p->iterations) {
 		/* Give the vcpu thread some time to dirty some pages */
 		usleep(p->interval * 1000);
-- 
2.26.2

