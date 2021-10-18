Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7BC432026
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 16:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhJROtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 10:49:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232321AbhJROtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634568451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WmxZEp4yqdNNLlvT7rzDrMmyXp0y31eMUrmrU80g9MI=;
        b=Y+5tjKccC3Al2W5hBQ/efH5An7RBWt1pn7CdlIDlTHEFD+GgbdFP00m+8n87IGX4g7g8tI
        L1/1cbFpRl0AL1MNXrH1qKKH/IDueM38Y8YqhocQgdQe0NkyptP6n9KCI2mD5biBDuGWSu
        kEx57L56KFqDAZ/bVAbKojHdewl3r/4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-WVuqVEODNNubUnDzC4b6Ig-1; Mon, 18 Oct 2021 10:47:30 -0400
X-MC-Unique: WVuqVEODNNubUnDzC4b6Ig-1
Received: by mail-wr1-f72.google.com with SMTP id 10-20020a5d47aa000000b001610cbda93dso8879512wrb.23
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 07:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmxZEp4yqdNNLlvT7rzDrMmyXp0y31eMUrmrU80g9MI=;
        b=TnPHBKt9lbA//L1U/hnPD6zyAsuuKCgp3hGMxtXmvaZmMYsu0/X1lyK8WjkvwSL4sx
         BM31QkiU4FE2Zj9n95Mp1VpmQbQ2tEt6y09dkerO1DrndqNgmsbRGF9xPR/vVuyxFCgA
         AaSjq5zeEPUZ5ssPOjfBdF2qxg8CN5pxM7UeDR+f4jglvJxD/ZhLud0tT1DoxhQZhenO
         jLULCa4UJhE6vouLZmrv2xSNZXvCxrBgCBiQL3RWjDQ0TfkknXFYYGyCR+6ePynS/qNr
         dshHi8pRogwSgE2p4UTu5DV0ZbkQaTc/g55h1RWILxszojEqQGUQ7pfTMa2Se0RdTKxe
         LlqQ==
X-Gm-Message-State: AOAM531KcPgMzGzwlnkFWFUSyJovPNAXU3nkm03+KKSz48HoOjdaDe+3
        7CJvkOu+ZI/R+HOpxcaV53/oOwUqDQeQZWNxFODGd/PHHJwYBSaaSLFfWXf7JWKgHqpERkESPpJ
        PkNQA4V1pAOXoedXc0JOFwQ7G
X-Received: by 2002:a1c:21c3:: with SMTP id h186mr43695348wmh.107.1634568449261;
        Mon, 18 Oct 2021 07:47:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+AfcvS7b8/Ma7cBY7/u+xL2JNBiFSC9ZhyQJEBt99kwlDxDLXwW9fQYNJd2gPRma42OiViA==
X-Received: by 2002:a1c:21c3:: with SMTP id h186mr43695325wmh.107.1634568449085;
        Mon, 18 Oct 2021 07:47:29 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1d03:b900:220f:ce79:c9ab:4686])
        by smtp.gmail.com with ESMTPSA id f3sm17909155wmb.12.2021.10.18.07.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 07:47:28 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH] arm64: Select POSIX_CPU_TIMERS_TASK_WORK
Date:   Mon, 18 Oct 2021 16:47:13 +0200
Message-Id: <20211018144713.873464-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 6caa5812e2d1 ("KVM: arm64: Use generic KVM xfer to guest work
function") all arm64 exit paths are properly equipped to handle the
POSIX timers' task work.

Deferring timer callbacks to thread context, not only limits the amount
of time spent in hard interrupt context, but is a safer
implementation[1], and will allow PREEMPT_RT setups to use KVM[2].

So let's enable POSIX_CPU_TIMERS_TASK_WORK on arm64.

[1] https://lore.kernel.org/all/20200716201923.228696399@linutronix.de/
[2] https://www.spinics.net/lists/linux-rt-users/msg24860.html
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

---

This was tested by running all relevant kernel timer self-tests and
making sure KVM still works as expected.

 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 789036cf74f5..ce0d0d254542 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -191,6 +191,7 @@ config ARM64
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select MMU_GATHER_RCU_TABLE_FREE
-- 
2.32.0

