Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B7442D1BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 06:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhJNEyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 00:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhJNEyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 00:54:41 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96A1C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 21:52:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so6070074pjw.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 21:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gJDlq0YOd3FIp9yltFh10NZ+GTEdKsRbgNrMT/fMhy8=;
        b=l7CblFVsCZ9q2NJP3e6RC8afxRYWYpADQJqPj/4vdlDauWotjdin6xfqggpL2Ard9Z
         Gw9G1Gf0s6Coi79Pqbh6QyIJX6A+DTtF0+VszjbTrDFLSzQrep9oJjDiXz4XiEsjEk/D
         IwMKa1N11jJ36T6XQl7xIrSisVsiFt9cK91mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gJDlq0YOd3FIp9yltFh10NZ+GTEdKsRbgNrMT/fMhy8=;
        b=x1pNl4wd+76vrn1MBxL7On+g4mUJr42Op8Wu0KYZNAN0Qf2jEGb8EdiO1JRT3DCFai
         0I0B+UScdUVlwiXeLTWdqaXIQ26b8VpQEx492NooqVY0hpVhARDpLkrProV2FP5YaRgD
         u8LrQRlkC4mIzpVJQsuCRfE2KkGv+vIHYo3udkyPvOtdNv+rsWZXv1Ojo1kxNFUlsCJ8
         wv8ylbPkE+7MvGZ4xL9hEPW0DLuDm65H+KFjFimy8mEi5t2xewt3myZs+5GnyBmji5oj
         90JiV7PSJUkZQbnsQMqgrUPez7Dy4I42COxYPK1sr01zA4iOqZQUZBifkNnAPCq8HK6U
         7b/A==
X-Gm-Message-State: AOAM533QqbnVAqP09OfaBCUq/o3rvYlkztDsBuS+OEInH2a5tQfrk+9z
        dXJSsujTN0vSgMT9CoQ1l5Cqqg==
X-Google-Smtp-Source: ABdhPJwwQZfVLF1jPk/lor0aB50rGf7fWVKbiUn2BwtlZa1P/VwX+4e2ZVASHShBHv5BWJhIvXW9lg==
X-Received: by 2002:a17:90a:c594:: with SMTP id l20mr17666973pjt.223.1634187157408;
        Wed, 13 Oct 2021 21:52:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e12sm1066229pgv.82.2021.10.13.21.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 21:52:37 -0700 (PDT)
Date:   Wed, 13 Oct 2021 21:52:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
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
Message-ID: <202110132151.F78F49AD8@keescook>
References: <20210903021326.206548-1-keescook@chromium.org>
 <202110111403.3C59BF77@keescook>
 <20211014014101.6du6jj2o7g4ficu5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014014101.6du6jj2o7g4ficu5@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 06:41:01PM -0700, Josh Poimboeuf wrote:
> On Mon, Oct 11, 2021 at 02:03:26PM -0700, Kees Cook wrote:
> > On Thu, Sep 02, 2021 at 07:13:26PM -0700, Kees Cook wrote:
> > > From: Marios Pomonis <pomonis@google.com>
> > > 
> > > Fix a bug in the ORC unwinder when kretprobes has replaced a return
> > > address with the address of `kretprobes_trampoline'. ORC mistakenly
> > > assumes that the address in the stack is a return address and decrements
> > > it by 1 in order to find the proper depth of the next frame.
> > > 
> > > This issue was discovered while testing the FG-KASLR series[0][1] and
> > > running the live patching test[2] that was originally failing[3].
> > > 
> > > [0] https://lore.kernel.org/kernel-hardening/20200923173905.11219-1-kristen@linux.intel.com/
> > > [1] https://github.com/KSPP/linux/issues/132
> > > [2] https://github.com/lpechacek/qa_test_klp
> > > [3] https://lore.kernel.org/lkml/alpine.LSU.2.21.2009251450260.13615@pobox.suse.cz/
> > > 
> > > Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
> > > Signed-off-by: Marios Pomonis <pomonis@google.com>
> > > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > > Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
> > > Cc: Kristen C Accardi <kristen.c.accardi@intel.com>
> > > Cc: Sami Tolvanen <samitolvanen@google.com>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > 
> > Ping again; Josh can you take this please?
> 
> I'm confused how this still fixes anything after Masami's patch set,
> which is now in linux-next.
> 
> After those patches, for a CALL-type ORC entry, the unwinder sets
> state->ip to the address returned by unwind_recover_ret_addr().  In the
> case of a kretprobe, that means that state->ip will no longer point to
> kretprobes_trampoline() -- making the above patch description incorrect.
> 
> Instead, state->ip will then contain the original call return address
> which was replaced by kretpobes.  So it looks to the unwinder like a
> normal call return address, and 'state->signal' should remain false.
> 
> Am I missing something?

I'll let Marios answer in more detail, but my understanding is that
Masami's patch set didn't solve the FGKASLR-vs-kretprobes issue[1].
I don't understand _why_ yet, though.

-Kees

[1] https://lore.kernel.org/all/CAKXAmdgS3SL_qyjzjY32_DXe3WVTN+O=wYwJ9vkUXKhjmt87fA@mail.gmail.com/

-- 
Kees Cook
