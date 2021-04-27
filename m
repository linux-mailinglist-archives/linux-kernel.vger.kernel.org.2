Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2D936CA87
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238530AbhD0RoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbhD0RoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:44:04 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B48C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 10:43:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x5so10041575wrv.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 10:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sTVXYIke2mYhPaPQQebsNo0GgJ6tL2u6qjrM5GFCGyE=;
        b=SgDEyqUOq79z0oEavubQe+urM8+uc+iQ68gURUc8gqUQmmXMno35OpYPSWfy5OygSm
         jdmKup8DCZues81DvSAkxE0AXNZDKhStMoMLeIyBf9kGOgscP0yQjYk1BCRQgWO01mRt
         C0qE6aU/juhBV+s/iSgi0oxjaIV7aiTh8z/ZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sTVXYIke2mYhPaPQQebsNo0GgJ6tL2u6qjrM5GFCGyE=;
        b=oOanBupj3WRxLe9bZ8VnqZozmV03WkVINHfeQoZ4UbdWhOz8rNaXg1Th7QKcwOmO1O
         croW6nqVXnKedbXysCx0M5sRIVNsdHe90V5D3RXT/g3fym8rgduoPWzI6tZVUW2gnkSx
         OFvDRkGEXyVxIUOs+ULhwhhwJnGI09pALTENtvUhW42A5a2df3THlSGVnL8Mu4SFtfqX
         m++4oQ033yeAbosAwFUp2P8R3Bgx/iWny172YPUKnysHhOnIkqV2UpadrctzwojD70/c
         55RQ1rOcQoHM6hm8q/hiuojY+rFZHwKP4GAeMzf3Z8FkUC6BgmY4N3Qdx79meYxH4Eid
         oCxA==
X-Gm-Message-State: AOAM532derekw/ATZhkOGn4N3mi0e5kbTY2ChnPdHZa3gXGdF6he+ndA
        A4vc6vVr1iyIF1Jsri7Pzf89FC5yoXFvKA==
X-Google-Smtp-Source: ABdhPJyPyLIg5qhWknNn7WU7xxi+4li4Ym7+YJ12lijz0KXXfEPj9mSQNzgJNAjLQKtF79YXd8bhnA==
X-Received: by 2002:a5d:6352:: with SMTP id b18mr9017312wrw.76.1619545399112;
        Tue, 27 Apr 2021 10:43:19 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:14c3:1569:da7a:4763])
        by smtp.gmail.com with ESMTPSA id h8sm647302wmq.19.2021.04.27.10.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 10:43:18 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com, linux@rasmusvillemoes.dk,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v2 0/2] Implement formatted output helpers with bstr_printf
Date:   Tue, 27 Apr 2021 19:43:11 +0200
Message-Id: <20210427174313.860948-1-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPF's formatted output helpers are currently implemented with
snprintf-like functions which use variadic arguments. The types of all
arguments need to be known at compilation time. BPF_CAST_FMT_ARG casts
all arguments to the size they should be (known at runtime), but the C
type promotion rules cast them back to u64s. On 32 bit architectures,
this can cause misaligned va_lists and generate mangled output.

This series refactors these helpers to avoid variadic arguments. It uses
a "binary printf" instead, where arguments are passed in a buffer
constructed at runtime.

---
Changes in v2:
- Reworded the second patch's description to better describe how
  arguments get mangled on 32 bit architectures

Florent Revest (2):
  seq_file: Add a seq_bprintf function
  bpf: Implement formatted output helpers with bstr_printf

 fs/seq_file.c            |  18 ++++
 include/linux/bpf.h      |  22 +----
 include/linux/seq_file.h |   4 +
 init/Kconfig             |   1 +
 kernel/bpf/helpers.c     | 188 +++++++++++++++++++++------------------
 kernel/bpf/verifier.c    |   2 +-
 kernel/trace/bpf_trace.c |  34 +++----
 7 files changed, 137 insertions(+), 132 deletions(-)

-- 
2.31.1.498.g6c1eba8ee3d-goog

