Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF7A42665F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhJHJPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:15:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35498 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230228AbhJHJPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633684419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BWLsWfH2JEyNjbtC+2PoK+MShYND9fy9GRvh7JRHRqk=;
        b=Ile9ijDEmBFO6zugzB3AV+ObwxIJHm7kUWpbDZt9E+KxgVQQAJt2kBDuOWounnCoZl0H2p
        9ILK7BASG2yQFTqxVlGsmxNccdLjF2oDR/eVICBZlBNSAe7e3I5pMqxj4F7wCxM+F3ro/b
        nUa6tb3Y53x7BiNI5kHeF6sCWU0wgbs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-6FGvNyoIPnWSWxbU6rGOLQ-1; Fri, 08 Oct 2021 05:13:39 -0400
X-MC-Unique: 6FGvNyoIPnWSWxbU6rGOLQ-1
Received: by mail-wr1-f72.google.com with SMTP id p12-20020adfc38c000000b00160d6a7e293so4314446wrf.18
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 02:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BWLsWfH2JEyNjbtC+2PoK+MShYND9fy9GRvh7JRHRqk=;
        b=WCYu4MmQxEiaaT8IYhvFloJstkdiAygZ9V5PEjHKVnSrN123jMEmteR2xTfheZplP5
         pNkPA8mzF8ul1/hAP2Y+KyVAu6kaC6kJ3khTok7EeNRu8sH/P0L7kHCPB8nFJlUyJNdU
         Sgk6tX0XEX5aDx/4ChoFaP1rmM/zIFJ5YkIzt4SOfT9YA2Ty0jygTS0d+ptTGYQybdx0
         DyTFUvcikt8Iyw7owpa36QopPXa+/IIAv3gcCrhIFUFMFD4A90NdxYyZAx8Q6mQ2NDBo
         PxcwTgYsbWzFUqepvXr9M77OkziLh7L5x8ZdCYHc4CV4gcjXd7slyQ220LfIcTqN4Nkp
         wd8w==
X-Gm-Message-State: AOAM5318XWNhy6g/nDGQ35ck/ANcKsSkAJ4Z/LuL9VHJk1v4pmutgonC
        S/+I2bJdtlx5vE1V5wXLi+ON8gvssxtsmtppsPPcE/p5UfDdjc2LHUec5ncX5sDvMB9CSUB/sg4
        p9yJgfGerd7Wwd2y22JZCeA5E
X-Received: by 2002:adf:aad7:: with SMTP id i23mr2465631wrc.209.1633684417893;
        Fri, 08 Oct 2021 02:13:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuiMCcZOeyZMSLntyh7cBGuXHI088A/avMoZ7Y/sQl/GVYDmFrp8EahVJLgIj1BR72iJKxqg==
X-Received: by 2002:adf:aad7:: with SMTP id i23mr2465615wrc.209.1633684417713;
        Fri, 08 Oct 2021 02:13:37 -0700 (PDT)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id c5sm11385326wml.9.2021.10.08.02.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 02:13:37 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCHv2 0/8] x86/ftrace: Add direct batch interface
Date:   Fri,  8 Oct 2021 11:13:28 +0200
Message-Id: <20211008091336.33616-1-jolsa@kernel.org>
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

v2 changes:
  - added comments to API functions
  - move common cleanup code to new remove_direct_functions_hash
    function
  - added addr argument to unregister_ftrace_direct_multi API,
    to properly cleanup direct_functions hash
  - added missing unregister_ftrace_direct call to trampoline/graph
    selftest
  - added comment to modify_ftrace_direct_multi about non-callback
    gap between ftrace_shutdown and ftrace_startup

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

 arch/x86/include/asm/ftrace.h        |   9 +++-
 arch/x86/kernel/ftrace.c             |  71 +++++++++++++++---------------
 arch/x86/kernel/ftrace_64.S          |  30 +------------
 include/linux/ftrace.h               |  26 +++++++++++
 kernel/trace/fgraph.c                |   6 ++-
 kernel/trace/ftrace.c                | 268 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 kernel/trace/trace_selftest.c        |  54 ++++++++++++++++++++++-
 samples/ftrace/Makefile              |   1 +
 samples/ftrace/ftrace-direct-multi.c |  52 ++++++++++++++++++++++
 9 files changed, 420 insertions(+), 97 deletions(-)
 create mode 100644 samples/ftrace/ftrace-direct-multi.c

