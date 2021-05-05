Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0909B374697
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 19:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbhEERVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 13:21:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235514AbhEERGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 13:06:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16EBA61413
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 16:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620233727;
        bh=ICK8LXMu5D9HSPTuyfmZXivAQtzblQVD1iOb3ArwJvw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GNTD7s+wr+1xsf+7DNXlbyn3jg+NhX+d/hMBxyiFpLGm13tQBT+fyzFy/sj91u/m2
         s2jkDpwGCPIMiw9AXtZRvBa3lERF608pfwBmhrr4rbWA286rNbShSyplwGwbQAi1z7
         wyVRH4e8AnJrR1Jvapw50nGzAhvtMbWHHH/VtanCDgDkr7fMWesdcxS09X3YBl056f
         bWrFkLeXvEOtjGlqtrC6X/F/bCt8pcnD1JOLuDRNoJ8HolThKHP6ZRdgozGesckfGw
         XThbjajVbIrvQJ00LY0FlahXDpAHhOpn/6kFm/M9ItQK9W8A9YVtYrHLMbtsr+5c2T
         VNi/h2kKfH+oA==
Received: by mail-ej1-f43.google.com with SMTP id l4so3907295ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 09:55:26 -0700 (PDT)
X-Gm-Message-State: AOAM530l8G4jTgLa4HTFcKkb9fX3A4iLSN3cn3Od2IhCEX8oWX0T+wH+
        z8G7q3x0+Rp0PADYRfKj9E2O9vJIpjov9PBXysKqdQ==
X-Google-Smtp-Source: ABdhPJzHoiFMX0RZ9V7IQwV7ziECX8sN5pXQaUGKXoOpVjrXLncwiq1BtxDyqjiw4NM+L1s4wbfIJoWbIOVljFm1k3A=
X-Received: by 2002:a17:906:f742:: with SMTP id jp2mr28956111ejb.199.1620233725578;
 Wed, 05 May 2021 09:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620186182.git.jpoimboe@redhat.com> <5ba93cdbf35ab40264a9265fc24575a9b2f813b3.1620186182.git.jpoimboe@redhat.com>
In-Reply-To: <5ba93cdbf35ab40264a9265fc24575a9b2f813b3.1620186182.git.jpoimboe@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 5 May 2021 09:55:11 -0700
X-Gmail-Original-Message-ID: <CALCETrWQrMkeP+=pkNVNvSs9q3ZhhLq_ceHJ-N72Urp2KBrUfQ@mail.gmail.com>
Message-ID: <CALCETrWQrMkeP+=pkNVNvSs9q3ZhhLq_ceHJ-N72Urp2KBrUfQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] x86/uaccess: Use pointer masking to limit uaccess speculation
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 8:55 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> +/*
> + * Sanitize a user pointer such that it becomes NULL if it's not a valid user
> + * pointer.  This prevents speculatively dereferencing a user-controlled
> + * pointer to kernel space if access_ok() speculatively returns true.  This
> + * should be done *after* access_ok(), to avoid affecting error handling
> + * behavior.
> + */
> +#define mask_user_ptr(ptr)                                             \
> +({                                                                     \
> +       unsigned long _ptr = (__force unsigned long)ptr;                \
> +       unsigned long mask;                                             \
> +                                                                       \
> +       asm volatile("cmp %[max], %[_ptr]\n\t"                          \
> +                    "sbb %[mask], %[mask]\n\t"                         \
> +                    : [mask] "=r" (mask)                               \
> +                    : [_ptr] "r" (_ptr),                               \
> +                      [max] "r" (TASK_SIZE_MAX)                        \
> +                    : "cc");                                           \
> +                                                                       \
> +       mask &= _ptr;                                                   \
> +       ((typeof(ptr)) mask);                                           \
> +})

Is there an equally efficient sequence that squishes the pointer value
to something noncanonical or something like -1 instead of 0?  I'm not
sure this matters, but it opens up the possibility of combining the
access_ok check with the masking without any branches at all.

Also, why are you doing mask &= _ptr; mask instead of just
((typeof(ptr)) (_ptr & mask))?  or _ptr &= mask, for that matter?
