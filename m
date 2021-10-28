Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8878243F35A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 01:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhJ1XQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 19:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhJ1XQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 19:16:52 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DB1C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 16:14:24 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id a6so19369944ybq.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 16:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=y+aQvFezYxzvvp85LaviwlOrX50CoqLpz2QtvhGxwI0=;
        b=A6ld2Q7OywMkT1Yr0UKd1zinbUtsoTm1O3d0l+aCvb9yo+8zQjP1j4FyQQhMnCCG/p
         j//A/82XOE1KdblTUTw8KtvEBQ+le/vJ5jADzJh/rzCIolKxZjVpjC0FFbhevfRAohYH
         mW/fQkgU7NYQXFvcaFb+I5G66E+CZyNyChLlYtFI0nZoe5BdlSS51ohd4zuNVoOp1ITu
         EiC5ajUkxzGcrZvWPszSNqTnKXP0yoLtuRyjsozmHGKNKlHJ9CRBtUOLACQvLO1+ybUL
         0fTYQykbi2LJhEpjpBc5KhAItCNGzjix6p9bEy1dkXHv3RyDNsafPqh3iSCaogVc2cpV
         EyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=y+aQvFezYxzvvp85LaviwlOrX50CoqLpz2QtvhGxwI0=;
        b=ILSVEvq/AcecT0L46T6SCp65Vxk7FEVdxy4eK9YQaE6VS4ltQtTJmg5QAtA5j0ziLX
         42gct+d1t4RSlvuxjpOt8PQjxEvt75Ua/PUzqsTO6xlsP5kLinW2gCY5yYAq9266/PQt
         9u1JHoraNu78aeUQNiATS6j9fUzq55nTmkStF1/sSnRdT/8HOpe0AYYPe3G3giiOiD+j
         XidhMbZeHmolULF0AkBxiKMqhWL2MSSHhFNdzqjK2aMhH5C6J9kIEBqmBYKN/E8ODk4f
         O6hYUPUpeeShUGvgaS1dLwWAvyMhIJAZh3ZRoT4WubQ3PZ/EH9cOx7/K2fqfyGI8/NeY
         HzUg==
X-Gm-Message-State: AOAM531po9FMGvRDmCM8ZhE1uZKHqmt+1PcXI+z4uYMRJ/rzyNJYgcwT
        k7E8wWZ32qtfCC0dbKeXupQN33OOvC/57dDdTRAh7Qo0Bw0=
X-Google-Smtp-Source: ABdhPJxwPe6i8umjLQuM6EEiT9T6M6KWopZGxI9XvhZ1D2mx8BX3khSgtUIJQBu6QW7C3I+UhDoS+CGzC39DooOdj98=
X-Received: by 2002:a05:6902:1363:: with SMTP id bt3mr7992997ybb.152.1635462863296;
 Thu, 28 Oct 2021 16:14:23 -0700 (PDT)
MIME-Version: 1.0
From:   Samuel Marks <samuelmarks@gmail.com>
Date:   Thu, 28 Oct 2021 19:14:12 -0400
Message-ID: <CAMfPbcYukar5F=fK-xT9Ond_hFY6Uggu=gLD_MCoQxYBO-uFUw@mail.gmail.com>
Subject: [PATCH kernel folder `strlen` type to `size_t`]: use `size_t` not
 `int` for `strlen` response; change is trivial
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <trivial@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From dd8be0d9464db9644b781ef6891c31ebea3109aa Mon Sep 17 00:00:00 2001
From: Samuel Marks <807580+SamuelMarks@users.noreply.github.com>
Date: Thu, 28 Oct 2021 19:08:20 -0400
Subject: [PATCH 1/1]
 [kernel/{bpf/bpf_iter.c,debug/gdbstub.c,debug/kdb/{kdb_io.c,kdb_main.c,kdb_support.c},trace/{trace_events.c,trace_kprobe.c}}]
 Use `size_t` for `strlen` responses in trivial scope

---
 kernel/bpf/bpf_iter.c          | 2 +-
 kernel/debug/gdbstub.c         | 2 +-
 kernel/debug/kdb/kdb_io.c      | 2 +-
 kernel/debug/kdb/kdb_main.c    | 2 +-
 kernel/debug/kdb/kdb_support.c | 3 ++-
 kernel/trace/trace_events.c    | 2 +-
 kernel/trace/trace_kprobe.c    | 4 ++--
 7 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index b2ee45064..4d57f6332 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -332,7 +332,7 @@ bool bpf_iter_prog_supported(struct bpf_prog *prog)
     u32 prog_btf_id = prog->aux->attach_btf_id;
     const char *prefix = BPF_ITER_FUNC_PREFIX;
     struct bpf_iter_target_info *tinfo;
-    int prefix_len = strlen(prefix);
+    size_t prefix_len = strlen(prefix);
     bool supported = false;

     if (strncmp(attach_fname, prefix, prefix_len))
diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index 9d34d2364..ec48e7d88 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -770,7 +770,7 @@ static void gdb_cmd_query(struct kgdb_state *ks)
 #ifdef CONFIG_KGDB_KDB
     case 'R':
         if (strncmp(remcom_in_buffer, "qRcmd,", 6) == 0) {
-            int len = strlen(remcom_in_buffer + 6);
+            size_t len = strlen(remcom_in_buffer + 6);

             if ((len % 2) != 0) {
                 strcpy(remcom_out_buffer, "E01");
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 6735ac36b..a7e8aa967 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -38,7 +38,7 @@ static int kgdb_transition_check(char *buffer)
         KDB_STATE_SET(KGDB_TRANS);
         kdb_printf("%s", buffer);
     } else {
-        int slen = strlen(buffer);
+        const size_t slen = strlen(buffer);
         if (slen > 3 && buffer[slen - 3] == '#') {
             kdb_gdb_state_pass(buffer);
             strcpy(buffer, "kgdb");
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index fa6deda89..c72d8cf31 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -197,7 +197,7 @@ static inline bool kdb_check_flags(kdb_cmdflags_t
flags, int permissions,
 char *kdbgetenv(const char *match)
 {
     char **ep = __env;
-    int matchlen = strlen(match);
+    const size_t matchlen = strlen(match);
     int i;

     for (i = 0; i < __nenv; i++) {
diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index 7507d9a8d..54ece45e9 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -126,7 +126,8 @@ static char ks_namebuf[KSYM_NAME_LEN+1],
ks_namebuf_prev[KSYM_NAME_LEN+1];
 int kallsyms_symbol_complete(char *prefix_name, int max_len)
 {
     loff_t pos = 0;
-    int prefix_len = strlen(prefix_name), prev_len = 0;
+    const size_t prefix_len = strlen(prefix_name)
+        int prev_len = 0;
     int i, number = 0;
     const char *name;

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 830b3b994..0e1b90d4a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2561,7 +2561,7 @@ static void update_event_printk(struct
trace_event_call *call,
 {
     char *ptr;
     int quote = 0;
-    int len = strlen(map->eval_string);
+    const size_t len = strlen(map->eval_string);

     for (ptr = call->print_fmt; *ptr; ptr++) {
         if (*ptr == '\\') {
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 3a64ba4bb..39fa5d1df 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -101,9 +101,9 @@ static nokprobe_inline bool
trace_kprobe_has_gone(struct trace_kprobe *tk)
 }

 static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
-                         struct module *mod)
+                               struct module *mod)
 {
-    int len = strlen(module_name(mod));
+    const size_t len = strlen(module_name(mod));
     const char *name = trace_kprobe_symbol(tk);

     return strncmp(module_name(mod), name, len) == 0 && name[len] == ':';
-- 
2.33.1
