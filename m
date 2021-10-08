Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C822426661
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbhJHJPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44779 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230228AbhJHJPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633684425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8XYUgR9kHcOYFdSNrWNV6bYolumP9ymhRdSASBvoKM=;
        b=NvEV3wvzZGZ4sG2PhwJMZJozhTmoMRzYiJxYq7m78HbBGfeBIYfi3fBbq6IuaFujgKEjGe
        3jdcv2iJSFs/wIH6+2Zuh2SIU1nmDYdG77ngb+ThxfhMwJQGRz+1Au2k5TxkeqPnLhs/gn
        +E+9Osxuznz9QM+IbGjtTD93CDb+KJI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-Z5MlLexfNtSG4SMu6_-6cA-1; Fri, 08 Oct 2021 05:13:44 -0400
X-MC-Unique: Z5MlLexfNtSG4SMu6_-6cA-1
Received: by mail-wr1-f70.google.com with SMTP id 41-20020adf812c000000b00160dfbfe1a2so3130399wrm.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 02:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t8XYUgR9kHcOYFdSNrWNV6bYolumP9ymhRdSASBvoKM=;
        b=EjLWCOqsiF4so+wj2RCfPxX//4kfjsxHXpMkWGK/A0eWx34iwUj9GEbPW5lvUsNf0x
         vRF88ZMq2Q9veDsgDf+OZRaGTMk1JRKIJ+xIyArlsWJrnBo3SKvw/NqUxCGL2FRx4Rfl
         S/BljmQmvlT1gogdIY1HlZPBASkgXB8/oGO8+L+SjuU+V+BmWv0o5z+UOQmAJeDRejxy
         2aEaf2KhJhA2NwWIckb26qu6CLTZYj+AdP/jJ3nvdG9pXDY2p0/RT2Xa9gRU8gcZu32U
         59ISwuGRaGSXtsHprYwMSrTARgHkVEXOLoYogoUst8CWZlD1ABJht7ObeCnbXB0tYIBu
         IGcg==
X-Gm-Message-State: AOAM532Xq6VRQD7yFtMzHRxsHgJNRs+8yJp92m/1kfpIe6lhv1flskmt
        VWcjVnlsxHKFUooFJMUODLO5EiBqn760wVDWxuzs9ADC2VKrLdIacvh5oarAp43CIeoUq0QMCJX
        Eg2zKTl8as05ga5PW/jTAbKHR
X-Received: by 2002:adf:8b1a:: with SMTP id n26mr2553752wra.182.1633684423777;
        Fri, 08 Oct 2021 02:13:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7pqH/9VGiNhSSQLuJGc71f9A4S88upuxhvoibmjXrXfdo84xNDH3ZpV69N8QYUBNTaQgOdQ==
X-Received: by 2002:adf:8b1a:: with SMTP id n26mr2553740wra.182.1633684423641;
        Fri, 08 Oct 2021 02:13:43 -0700 (PDT)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id g25sm1822738wrc.88.2021.10.08.02.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 02:13:43 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 1/8] x86/ftrace: Remove extra orig rax move
Date:   Fri,  8 Oct 2021 11:13:29 +0200
Message-Id: <20211008091336.33616-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008091336.33616-1-jolsa@kernel.org>
References: <20211008091336.33616-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's identical move 2 lines earlier.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/ftrace_64.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 7c273846c687..a8eb084a7a9a 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -251,7 +251,6 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	 * If ORIG_RAX is anything but zero, make this a call to that.
 	 * See arch_ftrace_set_direct_caller().
 	 */
-	movq ORIG_RAX(%rsp), %rax
 	testq	%rax, %rax
 SYM_INNER_LABEL(ftrace_regs_caller_jmp, SYM_L_GLOBAL)
 	jnz	1f
-- 
2.31.1

