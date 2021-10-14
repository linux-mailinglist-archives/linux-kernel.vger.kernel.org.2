Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A26242CFFF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 03:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhJNBnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 21:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229877AbhJNBnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 21:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634175667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bIkaijae5P+JkUkpof6h1wsF8G71ZnOerZjw8vEk7g0=;
        b=R00SJQTbPZXdqHi+1GZpoVIyfRrbgSgECoQ/n409kRhLdpb3/O9dPKRAMGI3D52+eznJdT
        nEWG75sD2x6G1nFZuN3kTrDEi+lw7Dnp99MTdapnu5jThO8f6Ftmf5rSii+KW5b2ELB8em
        Bjrr5fQdieLSmo1YWug7wgYLshnhIX0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-IRm5rTWuMJOB8G58mgP3UA-1; Wed, 13 Oct 2021 21:41:06 -0400
X-MC-Unique: IRm5rTWuMJOB8G58mgP3UA-1
Received: by mail-qt1-f199.google.com with SMTP id h10-20020ac8584a000000b002a712bc435fso3435665qth.20
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 18:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bIkaijae5P+JkUkpof6h1wsF8G71ZnOerZjw8vEk7g0=;
        b=LUcQ6w/imL/LRKOv32nPUs3/E5q4U3SN+qY3iGkr/nmgCtY1678cO5AdkS7SoTYbfC
         iL/r0SLEj4xeVyh/KCeIp3tFd0hhW3WOg/TS716GK3DGiyKO4m24BkIBwBE1FGWz7TC9
         aZfkte8CKHN8MRVHYP6QkaWyWafYax0eBijSAZcd4+aW/Z00c1dv7AEDBQkpq8jG+shA
         Exc3BGQV9nF3T0Y+96BizaBImeUcD97nQ0QgVXOhD6wrTX4K00OsSDnj2CzCAMspqOAh
         b+wkZ1GHWpFbu3sQsVX2CAU7g3LSiShvtb8sp8DC6g7B1aSeNVgnsDZNjknvmhRnE0Lo
         aL9w==
X-Gm-Message-State: AOAM531O4bzk1peo2Gm9TEas61EngkxlVYJpfHTI29wlF3qI5OS1aPJh
        V/AxYFr005CdGjyYgcBPzgfeec+7DL/w2XZbLaCgjP5iuVw369CEUNq5RqMYdaSsfPZqZnSSpbH
        2qx2LPKcZixeIY//MPHxf/mCl
X-Received: by 2002:a37:43c2:: with SMTP id q185mr2321555qka.512.1634175665562;
        Wed, 13 Oct 2021 18:41:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXcY5HYwk05IO41TYoOci3q1aRvUhi28MMJm1T3T4rnl+CWgD8I1JKfzSN2+wmwif2o6R0Og==
X-Received: by 2002:a37:43c2:: with SMTP id q185mr2321538qka.512.1634175665333;
        Wed, 13 Oct 2021 18:41:05 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id c26sm819731qtm.21.2021.10.13.18.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 18:41:04 -0700 (PDT)
Date:   Wed, 13 Oct 2021 18:41:01 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Marios Pomonis <pomonis@google.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Kristen C Accardi <kristen.c.accardi@intel.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ivan Babrou <ivan@cloudflare.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hardening@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] x86/unwind/orc: Handle kretprobes_trampoline
Message-ID: <20211014014101.6du6jj2o7g4ficu5@treble>
References: <20210903021326.206548-1-keescook@chromium.org>
 <202110111403.3C59BF77@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202110111403.3C59BF77@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 02:03:26PM -0700, Kees Cook wrote:
> On Thu, Sep 02, 2021 at 07:13:26PM -0700, Kees Cook wrote:
> > From: Marios Pomonis <pomonis@google.com>
> > 
> > Fix a bug in the ORC unwinder when kretprobes has replaced a return
> > address with the address of `kretprobes_trampoline'. ORC mistakenly
> > assumes that the address in the stack is a return address and decrements
> > it by 1 in order to find the proper depth of the next frame.
> > 
> > This issue was discovered while testing the FG-KASLR series[0][1] and
> > running the live patching test[2] that was originally failing[3].
> > 
> > [0] https://lore.kernel.org/kernel-hardening/20200923173905.11219-1-kristen@linux.intel.com/
> > [1] https://github.com/KSPP/linux/issues/132
> > [2] https://github.com/lpechacek/qa_test_klp
> > [3] https://lore.kernel.org/lkml/alpine.LSU.2.21.2009251450260.13615@pobox.suse.cz/
> > 
> > Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
> > Signed-off-by: Marios Pomonis <pomonis@google.com>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
> > Cc: Kristen C Accardi <kristen.c.accardi@intel.com>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Ping again; Josh can you take this please?

I'm confused how this still fixes anything after Masami's patch set,
which is now in linux-next.

After those patches, for a CALL-type ORC entry, the unwinder sets
state->ip to the address returned by unwind_recover_ret_addr().  In the
case of a kretprobe, that means that state->ip will no longer point to
kretprobes_trampoline() -- making the above patch description incorrect.

Instead, state->ip will then contain the original call return address
which was replaced by kretpobes.  So it looks to the unwinder like a
normal call return address, and 'state->signal' should remain false.

Am I missing something?

-- 
Josh

