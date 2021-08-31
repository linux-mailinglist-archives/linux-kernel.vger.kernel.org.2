Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DBA3FC521
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240655AbhHaJvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 05:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233851AbhHaJvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 05:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630403421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jDRR4Gfeq/0Z0bdm9Tr2VtsZ6WrEwR+UZOlpkJZ7nKg=;
        b=Nu9bcis1LqJH5IUjwCgM81uJBkY07GJjJ9APVmMt76/93pHqWpoz9q2YU1LVhfqq8/BaGL
        Y+FaLPUUbn1yggXTqvagLiZQZL3MnKKI9dBEhn2bT+1YMEpC/OS/q8gln7Y13dY77RUKKg
        BUvau475mUJGiUFzZtvtXkifJEvuM0A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-u7auoT-jN8C10_PT2YnF_w-1; Tue, 31 Aug 2021 05:50:19 -0400
X-MC-Unique: u7auoT-jN8C10_PT2YnF_w-1
Received: by mail-wm1-f71.google.com with SMTP id p11-20020a05600c204b00b002f05aff1663so1126165wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 02:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jDRR4Gfeq/0Z0bdm9Tr2VtsZ6WrEwR+UZOlpkJZ7nKg=;
        b=FzHcviKKyvA4d0RisAE4m6fFA+FH9trlwUV7cKKo3b76XmL8sOwQY44IxIBA03JRmA
         0ayQ/ajXrisobb/LVo7rl/ia48jtQG6vkt4riZ9+uQl6iISTXo5+ojFKPIE3HQ/BZWCQ
         K9U60dEGkLc20ewuZLNEx4Zl6FTMN2z/zBE38BUvROaTGY8Z1GISCWx/WU3tLRZH/TM9
         AbcWsKBGvEJe+7zKn343qFVugS26qJMj7HOJ16ltf5fnEipyeTFxxwrWcD/FanFLZ+zE
         SrghFOG7u/0CiWRib9+Qam491j6YbW7h4JgXz2YoetHpfWmHtkhmiXGwAuJaNpa9lRcS
         CSWQ==
X-Gm-Message-State: AOAM5338ZIgc8SCMa5yxMyafK2jRaEnIh2mk0UTto2ddjk7PeMVzeqJH
        V7DA0ZiuxZ87m8np8W6BC36CTzbaPw8x4T20a7wexLEzqyv/idEeVtbhVuHJfsy14gybJFAhAdf
        RjhU2Q+8sDHOn5SWXxt+2pKrU
X-Received: by 2002:adf:db83:: with SMTP id u3mr31058775wri.363.1630403418566;
        Tue, 31 Aug 2021 02:50:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy11hiyXvUZaBhVtba4HRZ9FmZPj0iZsGOk8RZQoo5D9MJBsjSR7eUxt6OaCXO+9Q29XTagVA==
X-Received: by 2002:adf:db83:: with SMTP id u3mr31058760wri.363.1630403418410;
        Tue, 31 Aug 2021 02:50:18 -0700 (PDT)
Received: from krava.redhat.com ([94.113.247.3])
        by smtp.gmail.com with ESMTPSA id d7sm18112990wrs.39.2021.08.31.02.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 02:50:18 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 0/8] x86/ftrace: Add direct batch interface
Date:   Tue, 31 Aug 2021 11:50:09 +0200
Message-Id: <20210831095017.412311-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
adding interface to maintain multiple direct functions
within single calls. It's a base for follow up bpf batch
attach functionality.

New interface:

  int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
  int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
  int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)

that allows to register/unregister/modify direct function 'addr'
with struct ftrace_ops object. The ops filter can be updated
before with ftrace_set_filter_ip calls

  1) patches (1-4) that fix the ftrace graph tracing over the function
     with direct trampolines attached
  2) patches (5-8) that add batch interface for ftrace direct function
     register/unregister/modify

Also available at (based on Steven's ftrace/core branch):
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  ftrace/direct

thanks,
jirka


---
Jiri Olsa (6):
      x86/ftrace: Remove extra orig rax move
      tracing: Add trampoline/graph selftest
      ftrace: Add ftrace_add_rec_direct function
      ftrace: Add multi direct register/unregister interface
      ftrace: Add multi direct modify interface
      ftrace/samples: Add multi direct interface test module

Steven Rostedt (VMware) (2):
      x86/ftrace: Remove fault protection code in prepare_ftrace_return
      x86/ftrace: Make function graph use ftrace directly

 arch/x86/include/asm/ftrace.h        |   9 +++--
 arch/x86/kernel/ftrace.c             |  71 +++++++++++++++++++-------------------
 arch/x86/kernel/ftrace_64.S          |  30 +---------------
 include/linux/ftrace.h               |  26 ++++++++++++++
 kernel/trace/fgraph.c                |   6 ++--
 kernel/trace/ftrace.c                | 214 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 kernel/trace/trace_selftest.c        |  49 +++++++++++++++++++++++++-
 samples/ftrace/Makefile              |   1 +
 samples/ftrace/ftrace-direct-multi.c |  52 ++++++++++++++++++++++++++++
 9 files changed, 364 insertions(+), 94 deletions(-)
 create mode 100644 samples/ftrace/ftrace-direct-multi.c

