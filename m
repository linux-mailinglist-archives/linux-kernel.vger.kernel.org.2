Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE3539E606
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFGSAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:00:50 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:49056 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFGSAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:00:45 -0400
Received: by mail-yb1-f202.google.com with SMTP id v63-20020a2561420000b029053606377441so23546395ybb.15
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=1Cc61K2tL3uE0ek4kQDZHc3dKOqtFcSVcslXKoX6J78=;
        b=u1cLoSntaQxgxdMsbqLmkIHbuVJcWtSA66yHQOyg/R2IsOwGmjZ8lJrHAJlt9ABY2g
         QbUQMvI9KW7UbK5cxlCS7QGnRnIW4crc0oqgc/YUqaRoMjBLiSdFda7WJ42tewS56QYd
         gPPmNl7zH0q6am9T7fNKjBS7+alqFvBCit5yKyZ8HXl51UjykmLjR61wJMT0xwMMIRLj
         I8L91SOUN3JeXkZmj/zsBANh0kw3fOA60y6fgv34oz2qBmzTqqFJxv0kBczbyb4V0l/+
         iZL0teEtH6gwduKPRRmBFe8a5e5F5nvSjYDPsiN39Dm2iLizK5I7plO7b9xfU7zJ+Dnx
         niwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=1Cc61K2tL3uE0ek4kQDZHc3dKOqtFcSVcslXKoX6J78=;
        b=pnxoIGeo+GlpKXPMr0dhcnkoBXSOzJt1lIgXyr0DqLq8WiiCWS1rKRmnhiwnrA2GDi
         8iXXUehIdS4BngyVVGUmPI307mIomB9R1gxjZUoSl0+uvwuGWYYB4xJ5cUyRnG2jDWg6
         5TddB0Tz4zMOE46M4Sdk1quSxoQgLpgxlLxK+DzakBZLUWRaIn7TtvNcFG91va2jPmsY
         XTdVRQot4ya3vjlqbO6P3M+zUXXRXkyGWVhG1qx3H/jFE7POeEEL1lIHqAE729nHfMWj
         e/TSodOHYi97ay4wZuWsEN6xjmBzBcw2sf6Oq2dZp5ELUSyT1ZUETdii1FKwv3c5kl4D
         i8yA==
X-Gm-Message-State: AOAM531QQT+0BKlSiTWRiVNWuEszxkLcN25S1X+jaB/H40lzIx4vECMT
        cS6vVT2g6U2OBQI3gEXXbmwrL3u93pA=
X-Google-Smtp-Source: ABdhPJzDq+hLXaln2ksbk9PVUdpemW4opqT38C+kJTXAw6cNC89Gf5EsNNN+AiuKbitebJiMCQAEi/kUHK4=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:3979:b80:5651:64b3])
 (user=seanjc job=sendgmr) by 2002:a25:8884:: with SMTP id d4mr25492540ybl.410.1623088674039;
 Mon, 07 Jun 2021 10:57:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon,  7 Jun 2021 10:57:48 -0700
Message-Id: <20210607175748.674002-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH] KVM: x86: Ensure liveliness of nested VM-Enter fail
 tracepoint message
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the __string() machinery provided by the tracing subystem to make a
copy of the string literals consumed by the "nested VM-Enter failed"
tracepoint.  A complete copy is necessary to ensure that the tracepoint
can't outlive the data/memory it consumes and deference stale memory.

Because the tracepoint itself is defined by kvm, if kvm-intel and/or
kvm-amd are built as modules, the memory holding the string literals
defined by the vendor modules will be freed when the module is unloaded,
whereas the tracepoint and its data in the ring buffer will live until
kvm is unloaded (or "indefinitely" if kvm is built-in).

This bug has existed since the tracepoint was added, but was recently
exposed by a new check in tracing to detect exactly this type of bug.

  fmt: '%s%s
  ' current_buffer: ' vmx_dirty_log_t-140127  [003] ....  kvm_nested_vmenter_failed: '
  WARNING: CPU: 3 PID: 140134 at kernel/trace/trace.c:3759 trace_check_vprintf+0x3be/0x3e0
  CPU: 3 PID: 140134 Comm: less Not tainted 5.13.0-rc1-ce2e73ce600a-req #184
  Hardware name: ASUS Q87M-E/Q87M-E, BIOS 1102 03/03/2014
  RIP: 0010:trace_check_vprintf+0x3be/0x3e0
  Code: <0f> 0b 44 8b 4c 24 1c e9 a9 fe ff ff c6 44 02 ff 00 49 8b 97 b0 20
  RSP: 0018:ffffa895cc37bcb0 EFLAGS: 00010282
  RAX: 0000000000000000 RBX: ffffa895cc37bd08 RCX: 0000000000000027
  RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: ffff9766cfad74f8
  RBP: ffffffffc0a041d4 R08: ffff9766cfad74f0 R09: ffffa895cc37bad8
  R10: 0000000000000001 R11: 0000000000000001 R12: ffffffffc0a041d4
  R13: ffffffffc0f4dba8 R14: 0000000000000000 R15: ffff976409f2c000
  FS:  00007f92fa200740(0000) GS:ffff9766cfac0000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000559bd11b0000 CR3: 000000019fbaa002 CR4: 00000000001726e0
  Call Trace:
   trace_event_printf+0x5e/0x80
   trace_raw_output_kvm_nested_vmenter_failed+0x3a/0x60 [kvm]
   print_trace_line+0x1dd/0x4e0
   s_show+0x45/0x150
   seq_read_iter+0x2d5/0x4c0
   seq_read+0x106/0x150
   vfs_read+0x98/0x180
   ksys_read+0x5f/0xe0
   do_syscall_64+0x40/0xb0
   entry_SYSCALL_64_after_hwframe+0x44/0xae

Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: 380e0055bc7e ("KVM: nVMX: trace nested VM-Enter failures detected by H/W")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index a61c015870e3..4f839148948b 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -1550,16 +1550,16 @@ TRACE_EVENT(kvm_nested_vmenter_failed,
 	TP_ARGS(msg, err),
 
 	TP_STRUCT__entry(
-		__field(const char *, msg)
+		__string(msg, msg)
 		__field(u32, err)
 	),
 
 	TP_fast_assign(
-		__entry->msg = msg;
+		__assign_str(msg, msg);
 		__entry->err = err;
 	),
 
-	TP_printk("%s%s", __entry->msg, !__entry->err ? "" :
+	TP_printk("%s%s", __get_str(msg), !__entry->err ? "" :
 		__print_symbolic(__entry->err, VMX_VMENTER_INSTRUCTION_ERRORS))
 );
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

