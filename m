Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D14A41CEAA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 00:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346989AbhI2WEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 18:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346779AbhI2WEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 18:04:04 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E85C06176C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 15:02:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id il14-20020a17090b164e00b0019c7a7c362dso606917pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 15:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OxkIE1dbu6FoNq0lx2wamoNyrHmjGGBioMknIpC/Pfk=;
        b=V+arDGBSMCYnOlJ9cGqWq7uJwBxhZ/0YQnZokdnUjRkbI1HlwQcNlU7Kmm5w+GsfmZ
         y+g5aGDNyzIJqq+syuJesVShiCe43oS0TQBSwPyoqkAQzuTEY0nvF4QU8tEURa9Ug6Dh
         1dV3JzZ2LQdrRHv0SnZq+FvnPChmDpkbt+gfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OxkIE1dbu6FoNq0lx2wamoNyrHmjGGBioMknIpC/Pfk=;
        b=eSQlyvh9p3xxsNijvmmyWdesTPSamDcsIsT93dWKEoHmXbIdlIOdBYxgVRmDfzROGF
         Lig2LcJHbWrdtpZ5aS8juq4kGXwR4Y9l7bb7cyvGKZPagNL9SQ1VFbzXX3j5A0EXA1K0
         Ep19YKx4bLSFcTV53mYBqn1HEFmfh12xY9M7nJCl1wBtbQnkpu3aCpCJyDtOFwTy7WKV
         2d65Y5XY6T2L7+aVp0zQSLxJScVlIgR7HTKEwGJKN+7COKWFdTHhfEGKsv0WA8qkgGoD
         D1qoiNmhIl2xV7zGgMDzYHfyUSqa0G3UFifqo6YQk9aguHUegFoHtEoOyO996d7Y/nqY
         KceQ==
X-Gm-Message-State: AOAM533a2XDmXnXsBw8tD454GGmANa7HihPWHIUKrCRnTyl4vFzJndon
        JJ1LeSqLQZtWEjtJCWjutoy/aA==
X-Google-Smtp-Source: ABdhPJx6xx4h5SqMrKVFRjG28rHb+fGL260+7K8N196bFcr4W0jkT5QBchA3MbvlkGVh8gUH8330IQ==
X-Received: by 2002:a17:903:1247:b0:139:f1af:c044 with SMTP id u7-20020a170903124700b00139f1afc044mr901411plh.23.1632952941659;
        Wed, 29 Sep 2021 15:02:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n66sm691562pfd.21.2021.09.29.15.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 15:02:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <oliver.sang@intel.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Anand K Mistry <amistry@google.com>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Alexey Gladkov <legion@kernel.org>,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Tycho Andersen <tycho@tycho.pizza>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Stefan Metzmacher <metze@samba.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 0/6] wchan: Fix ORC support and leaky fallback
Date:   Wed, 29 Sep 2021 15:02:12 -0700
Message-Id: <20210929220218.691419-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1594; h=from:subject; bh=ZGofaDaQvv5swu66diz0HTx6vEYZe6JmeIR1+gjHjAE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhVOJo1GLdlU2wxkAyCO58Imlf3QXU2yR9lYPTGObd B1gwkK2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYVTiaAAKCRCJcvTf3G3AJkleEA C0CHxTyWL3o4ju8S4mS9f2AUVg0IGoeGrnoCfHhQRxAxIW1aguw87G6ss3RL56+eH9u4UWUxvnvxrp a8dN51L2JlYGFFU5m4QKwSEDqT0pwh+qhQUXA6vaqv2oisGZPls0qTbR6bHgsolBGj2eaFz0Gt4uGz UE/6clm4Hk01DWh/gAlZ91rnHsQT9Usv1vfD2Bhf7Lj+HC3aPk3b+WqrcxlYtBsHTr3moWKa3KnPa2 JigHBaawSMxjPz55TZBhQzEzMy6JwmnS2hOC8k4tsHGcW0htmLtghiUlWj7iSIJzrZFJwDygh/V7pX 2G3g2MZXghopkJiWsgrXdQBvMRi0/ukQHAlmI/Z6itjuPzInhOPwreJPF3wbUJQdi9pPy2rXUs3g3k XNFHXk9vlS2Xusv+s86tDIPkS5d+KeGKMQrdhTJp86TPOB224lqi/o2AMBUgA0iWiUNxjv+ncJL172 ktkh/fb4iOxZ3LRikVcAcIT8q+N13AkmGUzEtl+58FCxVJcMoOtz8hbWSTv1C1QRxFh7J1d2YJFfhf 4ATybEIql+XRoZIvUhDoz1v/eAnPMGS6sDIQIe9Ut4nOa5tQsdfF+J80Amvb6CvXTvx6Rf3UiZn7An +NKUct15CkPL9HTjmln4ayi4ElZQBaXNMHuNfbOFNPTOUtqnPThcyxgqIKCA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This attempts to solve the issues from the discussion here[1]. Specifically:

1) wchan leaking raw addresses since 152c432b128c (v5.12).

patch 1 fixes this with a revert.

2) wchan has been broken under ORC, seen as a failure to stack walk
   resulting in _usually_ a 0 value, since ee9f8fce9964 (v4.14).

patches 2-5 fixes this with Qi Zheng's new get_wchan() and changes to
the /proc code to use the new helper suggested by Peter to do the stack
walk only if the process can be kept blocked:
https://lore.kernel.org/lkml/20210929194026.GA4323@worktop.programming.kicks-ass.net/

Peter, can you take this via -tip?

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20210924054647.v6x6risoa4jhuu6s@shells.gnugeneration.com/

v1: https://lore.kernel.org/lkml/20210924062006.231699-3-keescook@chromium.org/

Kees Cook (5):
  Revert "proc/wchan: use printk format instead of lookup_symbol_name()"
  sched: Add wrapper for get_wchan() to keep task blocked
  proc: Use task_is_running() for wchan in /proc/$pid/stat
  proc: Only report /proc/$pid/wchan when process is blocked
  leaking_addresses: Always print a trailing newline

Qi Zheng (1):
  x86: Fix get_wchan() to support the ORC unwinder

 arch/x86/kernel/process.c    | 51 +++---------------------------------
 fs/proc/array.c              |  7 ++---
 fs/proc/base.c               | 20 ++++++++------
 include/linux/sched.h        |  1 +
 kernel/sched/core.c          | 16 +++++++++++
 scripts/leaking_addresses.pl |  3 ++-
 6 files changed, 36 insertions(+), 62 deletions(-)

-- 
2.30.2

