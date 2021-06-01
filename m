Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4394939782B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhFAQjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhFAQjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:39:01 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4EAC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 09:37:19 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x18so11825463pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jw7eEn8WRmuNIKvsIPD/e4rEX2czc+qLrBRNaCLC/iE=;
        b=KlY09Ax0G3nVN9VFNsQc0ck3P6nHOfM3AwN+2FcnWQJYMCAGIg2X0gWu5cXgDlt7mn
         GAY9FUnQHGGN8ZPirEFzJw51wx4BRDsKA8QVLhJMWoCTA1zwIk6cue8OT2bQQSsrW95X
         5Lkbu4fnc7lWS7BddGSx++ikGWviCc5hEirzD4E08/LhwDkhURmw5Y3/OIwARRoTYmB4
         dvaBKR+7iMU5wI/GM4Nd5G1o11InuNQjxhubLS50A+3P3/wDctwJlAxAAlSLXYH2VARV
         F/9Ml4xxEcbIZqj5vlJtWE7kO+EHfqv8nmwjL9vWayD+reNv9I/WdAXYtd5+0Rk0JOs4
         jjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jw7eEn8WRmuNIKvsIPD/e4rEX2czc+qLrBRNaCLC/iE=;
        b=dnzPyZhZ0tUKK+CNETwfxGoYRgmem+kZaByZo+AUJlj4XDOjDCba/zBAK5h9N0eUva
         i8CrUxCzh2TU+3EwLu8fht3qZ+ZwZhD8gv4YYdwzRzu8esswY3LkQqGPMyqs8l/9fm8f
         L5Il9qLcw3KDOBIgCkQSpb49LJWkuX2MY9hPPuKUgoft0YqJxyUFwgwnywFP0qJPrYN8
         ygmED1b1xOTqg3AiJGVlEto+afbrtwjVOsul+hD6+ZOSZamHHBWhFV9SbzjHHAlDGiSf
         kqaia0C8J1/Mx7ZdyyRsXurCW2VOHGM1Y/9EnitFFAk51XBEa/DGAO3qePyIRJ0YmnGW
         lPpw==
X-Gm-Message-State: AOAM530eKn4LiGSUqtyw6UaCZj6Rv2h2AI+qnQv+rGx4VQ5jrgEyiS0i
        iWwsc+reF6qSNRoR0DcPvDnt2Lkk5k4=
X-Google-Smtp-Source: ABdhPJzuKbgtC85hMEW+w6pFLo2AJhE+zoPx1W8UgDHJfL0a0hGI/Vz/y5N6r8NpxDuhmUjWhyb/Kw==
X-Received: by 2002:aa7:8507:0:b029:2ea:559:da5 with SMTP id v7-20020aa785070000b02902ea05590da5mr3073306pfn.45.1622565438779;
        Tue, 01 Jun 2021 09:37:18 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id k12sm9749782pga.13.2021.06.01.09.37.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 09:37:18 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC PATCH 0/4] x86/entry/nmi: solidify userspace NMI entry
Date:   Tue,  1 Jun 2021 14:52:13 +0800
Message-Id: <20210601065217.23540-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Current kernel has no code to enforce data breakpoint not on the thread
stack.  If there is any data breakpoint on the top area of the thread
stack, there might be problem.

For example, when NMI hits on userspace in this setting, the code copies
the exception frame from the NMI stack to the thread stack and it will
cause #DB and after #DB is handled, the not yet copied portion on the
NMI stack is in danger of corruption because the NMI is unmasked.

The similar problem happens when #DB hits on userspace with data
breakpoint on the thread stack.  We will also fix it for #DB when we
agree on the problem on NMI and the way to fix it.

The way to fix for NMI is to switch to the entry stack before switching
to the thread stack.  It also paves the path to use idtentry_body
macro for NMI since the huge refactor on entry code made idtentry
macros really low level.

Lai Jiangshan (4):
  x86/entry/nmi: Switch to the entry stack before switching to the
    thread stack
  x86/entry/nmi: Use normal idtentry macro for NMI from userspace
  x86/entry: Remove parameter rdx from macro PUSH_AND_CLEAR_REGS and
    PUSH_REGS
  x86/entry/nmi: unmask NMIs on userspace NMI when entry debugging

Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Andy Lutomirski <luto@kernel.org>,
Cc: Thomas Gleixner <tglx@linutronix.de>,
Cc: Ingo Molnar <mingo@redhat.com>,
Cc: Borislav Petkov <bp@alien8.de>,
Cc: x86@kernel.org,
Cc: "H. Peter Anvin" <hpa@zytor.com>

 arch/x86/entry/calling.h      |  8 ++--
 arch/x86/entry/entry_64.S     | 82 +++++++++++++++++------------------
 arch/x86/kernel/asm-offsets.c |  1 +
 3 files changed, 44 insertions(+), 47 deletions(-)

-- 
2.19.1.6.gb485710b

