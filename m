Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4810F42E1D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 21:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhJNTJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 15:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58285 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232749AbhJNTJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634238419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bXPqLb26D1n+X254p2WStepO6UEQEU6i6Gw3sazT/Yk=;
        b=cyX2Q8LRojC/+xSJT+Vqs+7Sqbc+9hzjXH64Cll6rGZHkZsnt3hqLP3R2rC/mnkKtlcVgr
        cmpTo5JYKh3csrltaQpQiqCwdZDf5jG4tLSdjsyzBL3VmVHTRbXkU+BPUHTFIPFNOGI0wd
        fWmJJBkOvT99xjOvQYz5+KJeP8hIS78=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-mHNEwkLjMyqtuvGJauJpjQ-1; Thu, 14 Oct 2021 15:06:58 -0400
X-MC-Unique: mHNEwkLjMyqtuvGJauJpjQ-1
Received: by mail-ot1-f71.google.com with SMTP id 100-20020a9d02ed000000b0054e1a7095faso4253386otl.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 12:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bXPqLb26D1n+X254p2WStepO6UEQEU6i6Gw3sazT/Yk=;
        b=NbaDymMkhiwgDDuNoh3x5S5myJ2EjMXShhEzKqCavE01cPS+aaDxU9DxSgQFB5Glmg
         IU1gpEDq1hBh89yQHV6culRH89gzeAOZMBGSGKBENbFJfUgyDraBGnkvalEwEhsb43Z7
         sT0knv5EQhBbZnUXubnmpoZ9NLdcpNLUOjFg2QDuUEgRePgFWGqoc5l1EDXx0yqYPVf/
         G0Gcc44C66xAVEYR783hFTMUF05fUcpMgd3tw6lHVdcRvpjup2DjLu+vDtxSCKbAv4EU
         U1kJ6W/3LamKQcMrazrjoASQl2qqjlNGLfLStrCHFb6hTfc5raVUVMe+l18N5LP/oYMp
         L7PQ==
X-Gm-Message-State: AOAM532tcIdHWjPTGx1Ak0uXIF4X91z3hJQcATlBHODe8FAc6eOni9Kb
        DLbaXzjkHV4t43RCcVLtkhTKo7E7I8uR2K52SbeePJ81vDb5oa/jX+QdfnyAKlXT43812oPbpCW
        FlswDrmFDqtBQvAND19po3cow
X-Received: by 2002:a05:6820:253:: with SMTP id b19mr5649112ooe.28.1634238417795;
        Thu, 14 Oct 2021 12:06:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgmz6lljfLOy6EZAroJmPTbavii7SUe9t45FCkVEtlRBE3RWcOGCsz7qZDG4VxilKyIlLG0w==
X-Received: by 2002:a05:6820:253:: with SMTP id b19mr5649093ooe.28.1634238417583;
        Thu, 14 Oct 2021 12:06:57 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id l16sm593952oou.7.2021.10.14.12.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 12:06:57 -0700 (PDT)
Date:   Thu, 14 Oct 2021 12:06:54 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>,
        Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 09/15] x86: Use an opaque type for functions not
 callable from C
Message-ID: <20211014190654.gn2jd43vw35gzdvs@treble>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-10-samitolvanen@google.com>
 <YWgSwmzPFrRbMC1P@zn.tnic>
 <202110140904.41B5183E@keescook>
 <YWhpbu/Y6V2p/zlY@zn.tnic>
 <202110141141.870A67E@keescook>
 <20211014145211.573579e6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211014145211.573579e6@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 02:52:11PM -0400, Steven Rostedt wrote:
> On Thu, 14 Oct 2021 11:47:01 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > On Thu, Oct 14, 2021 at 07:31:26PM +0200, Borislav Petkov wrote:
> > > On Thu, Oct 14, 2021 at 09:07:57AM -0700, Kees Cook wrote:
> > > Looking at the changelog, DECLARE_ASM_FUNC_SYMBOL, makes a lot more
> > > sense to me even if it doesn't specify the aspect that it is not called
> > > by C but who cares - it is generic enough.  
> > 
> > Around we go. :) Josh[1] and Steven[2] explicitly disagreed with
> > that name, leading to the current name[3]. Do you want it to be
> > DECLARE_ASM_FUNC_SYMBOL() over those objections?
> 
> Just note, that I was fine with the original name, but was against the
> version Josh suggested ;-)

Naming is important, especially for something as confusing as this.  We
need to be able to read it in a few months and have some idea of what's
going on.

"DECLARE_ASM_FUNC_SYMBOL" is nonsensical.  As a reader of the code I
wonder why are some asm functions using it and not others?  And how do I
know if I need it for my new function?

"extern const u8 int3_magic[]" is even worse.  Why are some asm
functions randomly declared as arrays, and others not?  Where can I go
to find out more without digging through the commit log?

-- 
Josh

