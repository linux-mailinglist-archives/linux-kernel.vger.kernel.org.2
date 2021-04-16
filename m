Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79385362972
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343694AbhDPUjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343643AbhDPUjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:15 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C99C061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:38:49 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id t12so1218800qkm.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RbFM/FOV0/3txgisl3034f4RrM8GnTQruaePZt0Evbk=;
        b=f7Bw46plZOqlptGDXST+MXI1hXmLkbQvqIezCVQGQqI4O5mhkaRHCID1vyZcdPONT3
         jx8yEYK7mIJZXw/SCKURxP3wAK5L4o2KyTJD2LFYiL563Y5zofxqEHaKqSWqo+hay+LB
         z3MYRqy6T3UyLWZy/O3/fhDwMg2PJeVsUP5cjdUgB7pFaWj030kAUPnYmtuWfSHvOk9z
         AeVa3xvxQ+dGCZVN4QKtTSnobHUDAzaINOlnc/arbM6EXDg5GO+mhurjQe/xFj0Jqykn
         S8iV/y2tecn9ldXNpCyI99vVbhC7WyrCQw/o8t7uQeOdkTQEw/9//8k/gATMWz7uHIyF
         1yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RbFM/FOV0/3txgisl3034f4RrM8GnTQruaePZt0Evbk=;
        b=GJQSlyb8eAl7O7VEnKR71yt+aHOsIF1IfnV1GWPLXxzaqFqZ5eypC3nrPelggDowNz
         5BB30txeAKuk/fA9XMXHjEymvqQQWyImGulGRqcRZWiICNIHWun4/DcBiYBwkzsZmzJ1
         LDACgtKpfTjx1MNpgIpanbzhrDodV5CWHWN+Hil65Qf/58P43LW8fSVdYwuFEiDC0e9u
         qkvomDyJbVR0C+tmE01xMFL6kALx7K+apdzrGf++Gzmgt9QqWrR19v5NrzwLiKiMyn2l
         YWKC4EVK1SzKHbf1hMC8JRyNnaz5TTQwIUeKZf/9fI6DxTDki23zwVP4R4S9yURsjZVz
         tuMg==
X-Gm-Message-State: AOAM530DQvSVf//D72TxFsYnfWe/bfC+VsjT5s4ZjLEsPBsam6Oe3hE3
        rxMQN3yorzS6FQHwxQZcwtASiQccU41pE+Ed3mc=
X-Google-Smtp-Source: ABdhPJx14/HIHrgP+PDvi3GMAUmLbEk0HIqe60qxMsDGjOaXLdLsX3bhei5pkhEttzRftHK0AOKlKm8rbOh7gvJ0+zc=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:1d0c:: with SMTP id
 e12mr10335145qvd.0.1618605528476; Fri, 16 Apr 2021 13:38:48 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:30 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 01/15] objtool: Find a destination for jumps beyond the
 section end
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With -ffunction-sections, Clang can generate a jump beyond the end of
a section when the section ends in an unreachable instruction. If the
offset matches the section length, use the last instruction as the
jump destination.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 tools/objtool/check.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a0a8ce61cd4d..5fd60e055a5c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -870,6 +870,10 @@ static int add_jump_destinations(struct objtool_file *file)
 		}
 
 		insn->jump_dest = find_insn(file, dest_sec, dest_off);
+
+		if (!insn->jump_dest && dest_sec->len == dest_off)
+			insn->jump_dest = find_last_insn(file, dest_sec);
+
 		if (!insn->jump_dest) {
 
 			/*
-- 
2.31.1.368.gbe11c130af-goog

