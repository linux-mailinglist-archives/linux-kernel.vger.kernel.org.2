Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1743630AB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 16:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbhDQOgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 10:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24718 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236535AbhDQOgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 10:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618670170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aKAKI7v52vyNqiS4SW9aCQUStioGeZ6CYyWT7sgQ8pM=;
        b=Zn5r590qzJPXLTCPqN6WwHhDb4LhZpZLrZenh8vOeD3/bP9sGkeYcoUQ8JFosAGt7UHszw
        F6RWOq98wsAYiDgDuDY1ty947cZUmQpgnd4V3FQQIuXI+rAiL+vVzHcD58B5xQV1hAIsqM
        VTbLl5r4H14Aoww4PfWyPUJTE4fvz3M=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-Ht6QLJYFNUilM_vfpXOcCw-1; Sat, 17 Apr 2021 10:36:08 -0400
X-MC-Unique: Ht6QLJYFNUilM_vfpXOcCw-1
Received: by mail-qv1-f72.google.com with SMTP id i2-20020ad44cc20000b029019a3866abf5so5703353qvz.8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 07:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aKAKI7v52vyNqiS4SW9aCQUStioGeZ6CYyWT7sgQ8pM=;
        b=KmL+uO+lKSz90p23SC+RMJKagz2f2NuF2sKYfg1MX8Tc75vTqQzSnPsRVqmlXT+8al
         Lsc5v3taJPdBw2aE+gCLqPn9nxpUXv1VUb1mnsyv2gQxvlmRQX+0eKgqUbt6z7O43KQh
         9zAvXriOu8fYxzu2GRJdzI7yu1QtUnSYGpzMsaI8hl284hGH2zqsx0XA9FIwUctNXeMK
         /d02s+9qhWXi4nN2fWDj4jE6v7lcLP5pMMZkHaf5e12reVCoWtasd63JslZilaQk2opA
         R6tiiep8aMINgq1ennPpnAzVkI1sl9nZAWFg6Z3jAF3TcKqlaoaP7Nb1xAvRAQRBO06E
         v3UA==
X-Gm-Message-State: AOAM5320C+HCPKmMM02+jdSAL5ODPfqcU5IRKKmh7HfUrayDeFf3PQD5
        fmJi/1LF/8DAwrX9GbmzKg5gBW+hLxdfRuoXv15MVNQPGduxcsmp350fQRJs8milL9bT6MDUYDd
        cv8K1TwFpLgMe1YsEgAmZyAedTLcqK2ONzX3U362k06nlPnzrfKWkJzcUuYenIUvwha+IcbfTmg
        ==
X-Received: by 2002:a37:9f41:: with SMTP id i62mr4104152qke.36.1618670167791;
        Sat, 17 Apr 2021 07:36:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxa6QLJMIv/tTZgxg6Y43LxC33xHosYTeNLBo4R0maleXRNXWOm9czMRqWhLKT+w4SotmTiBA==
X-Received: by 2002:a37:9f41:: with SMTP id i62mr4104132qke.36.1618670167495;
        Sat, 17 Apr 2021 07:36:07 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id l12sm378159qtq.34.2021.04.17.07.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 07:36:06 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>, peterx@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH v3 2/2] KVM: selftests: Wait for vcpu thread before signal setup
Date:   Sat, 17 Apr 2021 10:36:02 -0400
Message-Id: <20210417143602.215059-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210417143602.215059-1-peterx@redhat.com>
References: <20210417143602.215059-1-peterx@redhat.com>
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
index 510884f0eab8..25230e799bc4 100644
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

