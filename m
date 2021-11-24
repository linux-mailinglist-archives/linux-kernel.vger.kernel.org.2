Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5036C45B6BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 09:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241480AbhKXIp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 03:45:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241501AbhKXIod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 03:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637743283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=u/va+vlehAJlaxnJ1ZxySwl63uZqtCxIq5+CeD0JTug=;
        b=B3zkKhcWjDONF5v00LAQ8W9Z7LGb4kkIXRnHXfthsLJzDwZR9qTScc9XKvJI5BZg6jZnIR
        Vu43Olx/sJXtsz4xd/UtBNnNcwZHfhroFm652OhDflTEq0G2u65en7yKzFyfnEvDGpSivC
        ETMHeG5wXpG5ZM0G713xn3VgkBp7QRc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-68YmdwicN6CaB7_zDXmA5w-1; Wed, 24 Nov 2021 03:41:22 -0500
X-MC-Unique: 68YmdwicN6CaB7_zDXmA5w-1
Received: by mail-wr1-f69.google.com with SMTP id d7-20020a5d6447000000b00186a113463dso289152wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 00:41:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/va+vlehAJlaxnJ1ZxySwl63uZqtCxIq5+CeD0JTug=;
        b=LfY0XGOFP4OtiB3c3KZxtHqCnmzFXipTKwBz0XnXWHqvuZvfxXg8vROl6wBsbQNd1l
         MOAEU8BwzbyZJ/ZMfzaZ5g9rfbYSh4YThOo4JHCLR5RX11SBXWgKY5Iio/bVBunHK8Cg
         z757NhN/+buyonyV1rpshOBi2a/oQVmoKjagwSxvkstB1RSmoLdfYVEUfyrvTNqD7x/d
         bEHEYsFAcm3o9shYmy61evmjhiAwAREjkwK23LGBhCdMW0OFO0JrqIPrdrV+KBD9LExV
         0EGyKCYQ96L27QB/iTKjVm8wKhYybZ2KXnkaAeMMQ1SD4WKM/ZexgBxfrd6YXzceWuDD
         z87g==
X-Gm-Message-State: AOAM5335MAQVCSqJUrzbAMDrpOsYUbx03QeP5MXbWr821k3dMsvLA5hx
        aKXRbLs4Ymz8Gi2tCqd0CBw+yIDysBPUPd1SNKEdIwsUnfy8PYoamENEUNnSJim394j0hmK9Hup
        t7Fa4ePPo8Ku/ibr1xzWafNu5
X-Received: by 2002:a5d:47a1:: with SMTP id 1mr15880046wrb.436.1637743280729;
        Wed, 24 Nov 2021 00:41:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyWGTplK/9gxTkHrPX7ToYBzdn9CjvD6F3A+rSgEpL5LIhBlGtlV2H4nGfmNsCx7aWrxZljvg==
X-Received: by 2002:a5d:47a1:: with SMTP id 1mr15880016wrb.436.1637743280545;
        Wed, 24 Nov 2021 00:41:20 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id bg12sm5272528wmb.5.2021.11.24.00.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 00:41:20 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [RFC 0/8] perf/bpf: Add batch support for [ku]probes attach
Date:   Wed, 24 Nov 2021 09:41:11 +0100
Message-Id: <20211124084119.260239-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
adding support to create multiple kprobes/uprobes within single
perf event. This way we can associate single bpf program with
multiple kprobes.

Sending this as RFC because I'm not completely sure I haven't
missed anything in the trace/events area.

Also it needs following uprobe fix to work properly:
  https://lore.kernel.org/lkml/20211123142801.182530-1-jolsa@kernel.org/

Also available at:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  bpf/kuprobe_batch

thanks,
jirka


---
Jiri Olsa (8):
      perf/kprobe: Add support to create multiple probes
      perf/uprobe: Add support to create multiple probes
      libbpf: Add libbpf__kallsyms_parse function
      libbpf: Add struct perf_event_open_args
      libbpf: Add support to attach multiple [ku]probes
      libbpf: Add support for k[ret]probe.multi program section
      selftest/bpf: Add kprobe multi attach test
      selftest/bpf: Add uprobe multi attach test

 include/uapi/linux/perf_event.h                            |   1 +
 kernel/trace/trace_event_perf.c                            | 214 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 kernel/trace/trace_kprobe.c                                |  47 ++++++++++++++++---
 kernel/trace/trace_probe.c                                 |   2 +-
 kernel/trace/trace_probe.h                                 |   6 ++-
 kernel/trace/trace_uprobe.c                                |  43 +++++++++++++++--
 tools/include/uapi/linux/perf_event.h                      |   1 +
 tools/lib/bpf/libbpf.c                                     | 235 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 tools/lib/bpf/libbpf.h                                     |  25 +++++++++-
 tools/lib/bpf/libbpf_internal.h                            |   5 ++
 tools/testing/selftests/bpf/prog_tests/multi_kprobe_test.c |  83 +++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/multi_uprobe_test.c |  97 ++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/multi_kprobe.c           |  58 +++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/multi_uprobe.c           |  26 +++++++++++
 14 files changed, 765 insertions(+), 78 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/multi_kprobe_test.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/multi_uprobe_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/multi_kprobe.c
 create mode 100644 tools/testing/selftests/bpf/progs/multi_uprobe.c

