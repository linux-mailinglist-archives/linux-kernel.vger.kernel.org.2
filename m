Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA439368A4C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 03:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240117AbhDWBQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 21:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240006AbhDWBP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 21:15:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DD3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 18:15:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m9so33910679wrx.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 18:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6tnmCzU5o1RaGCQyagi+jERPl52+lDaOeiTTMhHRcJo=;
        b=mulAFomOqY5tyfdHYoYN7oJbb3m5RLiFBL2SUjgQ3wvwi0uvACFvR5Iyesc5OTtfCT
         l2YwGARKcfSHDmaG/gbJLJeRcpgkMMmGnfRghUXaDcPeK99itLC/TdR7rq/51D5kxk2X
         SdoKa5mtk4hqAmamI5XdpmQoeKBvGGlABrLhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6tnmCzU5o1RaGCQyagi+jERPl52+lDaOeiTTMhHRcJo=;
        b=TBgXkRv4huqvmkVtCGjsHJTzWcbJTK3kR/2U2z4DHctRVke22Lny/g8Ihl3TCxI65l
         JvnLMaHeELJc9zN1Pa0M/aUHwQ74TIxBPGr0I3Y1AdX8WbCiwcxYesaFNst3VJEiWF0Y
         GqpYXLSNt79G/DIHoptAKM8xomd9wA2hPUqmATiXSYHcDnUDpln7L12BBPRmWUGrvq4U
         d0Fu12+BwCmRYJa9KV4TFkhYIs1Qq1Xal0TehfpaWxAZveaJaxNEqF+Go+S7ttCSnPHh
         FgoU94QleYQhiP3Kt8mA2mJzazQgJan5hXKnLbu8zGf22L/W3qZ+ELFJDjrxfvX94d9d
         fxwg==
X-Gm-Message-State: AOAM533q7XV+Aamx/jw+7IzjKm+Gi92ql9jaKCoFQSr55X42WUbLFVsa
        9FjRunubxZNSrp//BXGWKM37Vg==
X-Google-Smtp-Source: ABdhPJy33ed/7fcB3eBdze/DWHCU+UMqWFGSs9QaNUuie4uTYVwmdcBwWj9Xc8WZSXE5o4aUjbLzHg==
X-Received: by 2002:a5d:49ca:: with SMTP id t10mr1247357wrs.395.1619140520749;
        Thu, 22 Apr 2021 18:15:20 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:e4b7:67ca:7609:a533])
        by smtp.gmail.com with ESMTPSA id a13sm6709340wrs.78.2021.04.22.18.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 18:15:20 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next 0/2] Implement BPF formatted output helpers with bstr_printf
Date:   Fri, 23 Apr 2021 03:15:15 +0200
Message-Id: <20210423011517.4069221-1-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our formatted output helpers are currently implemented with
snprintf-like functions which take arguments as va_list but the types
stored in a va_list need to be known at compilation time which causes
problems when dealing with arguments from the BPF world that are always
u64 but considered differently depending on the format specifiers they
are associated with at runtime.

This series replaces snprintf usages with bstr_printf calls. This lets
us construct a binary representation of arguments in bpf_printf_prepare
at runtime that matches an ABI that is neither arch nor compiler
specific.

This solves a bug reported by Rasmus Villemoes that would mangle
arguments on 32 bit machines.

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

