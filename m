Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EEC416FB7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 11:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245490AbhIXJ6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 05:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245381AbhIXJ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:57:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983E1C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 02:56:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g16so25672702wrb.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 02:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RRur22NBusGD90t4t5587ekzz3x5I1RHcVLT1FRWOPw=;
        b=ZD42DmzkPW2U+A4iJpC8iU2XyYMHKk9YKg9uFkDAbWvXW801p2Hu5cLrfTaUg4kAw2
         2eQlDVG0jhv5r8Ceccp0DheyAO7BDxLhXFyhblIdL/rlTOph12MkI0OX9YB8TTHyGQ8A
         hFCiE7a6ev7YHx/N8MaLkClcCasu5gAUyu0bY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRur22NBusGD90t4t5587ekzz3x5I1RHcVLT1FRWOPw=;
        b=YItAfzq5pfsW4uUYvldk+kpO9usWCGrvxWa9cEwzmhxs6ETEw0GehLw37TMKTni9Yt
         /c0U35nxQYxC7LR8rBeJLlRNU5QERh25fyxwwxmK8hSEdNA8dw3r5EVFnL8bWLCRoWDE
         7k3kLRvL70DWOjoJE6egZfGHnCd8bjInX/1sSypx5oDeuGspzgClvGWdOwrlJSAI5Y2m
         5CuggzeoVyRlcax5/xCQ0GWowFRO+IumHYk2K3V2KfN6w7APHUnNLZyvP1BLap6wH3Rz
         KFFW08NB6kr2LySB79ruS2UtKgozXE1SF46mIFoXpWzYruP32/GHRu0wdu3OXK2Jn/9L
         7Oxg==
X-Gm-Message-State: AOAM532B92pchpNIB8LyXqcBI0xH6EBsBzX13q+pO9pMHIYgzA/6bLpG
        /ixNVnnJR1HH0d6EeMqHqLoVYg==
X-Google-Smtp-Source: ABdhPJx7VqwMpBrGIroLZOsmZihp8ru4ncEtHJRlD9vTSP+bvxaBPO1HLlFCNTEK2gcCOmKarG7JZw==
X-Received: by 2002:a1c:a713:: with SMTP id q19mr1109287wme.42.1632477378193;
        Fri, 24 Sep 2021 02:56:18 -0700 (PDT)
Received: from antares.. (1.8.8.f.e.b.b.b.5.6.9.e.c.8.5.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:58c:e965:bbbe:f881])
        by smtp.gmail.com with ESMTPSA id v20sm7871106wra.73.2021.09.24.02.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 02:56:17 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/4] bpf: define bpf_jit_alloc_exec_limit for arm64 JIT
Date:   Fri, 24 Sep 2021 10:55:40 +0100
Message-Id: <20210924095542.33697-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210924095542.33697-1-lmb@cloudflare.com>
References: <20210924095542.33697-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the maximum amount of useable memory from the arm64 JIT.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 arch/arm64/net/bpf_jit_comp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 41c23f474ea6..803e7773fa86 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1136,6 +1136,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	return prog;
 }
 
+u64 bpf_jit_alloc_exec_limit(void)
+{
+	return BPF_JIT_REGION_SIZE;
+}
+
 void *bpf_jit_alloc_exec(unsigned long size)
 {
 	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
-- 
2.30.2

