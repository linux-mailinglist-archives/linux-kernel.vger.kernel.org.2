Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB44423228
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbhJEUix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:38:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232250AbhJEUiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633466220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/2lg8os1dn3LeWQY69s6PgxMEZ7LguAFPcGthQmKdLc=;
        b=LA0njWdwHEhIo+0h+DKwj3u4Jcbw2X0ZDvWYgYn4S2thOrCTrYsAk6t7AtPR3sbjfucQaX
        Hr9JVLOkGNrHLm8WcKg7peKgXZVz0vwf0QcUCBwu5VZikzZEh8+9rEKhXhG6DumoY69MaR
        gUUzFdUNBwVxHERlCKDga7dM4G1ZoU4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-qpJW-z9gMiyWB4PqXAm1FA-1; Tue, 05 Oct 2021 16:36:59 -0400
X-MC-Unique: qpJW-z9gMiyWB4PqXAm1FA-1
Received: by mail-qt1-f200.google.com with SMTP id d9-20020ac86149000000b002a6d33107c5so305282qtm.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 13:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/2lg8os1dn3LeWQY69s6PgxMEZ7LguAFPcGthQmKdLc=;
        b=7zuUkOkA27ULhf388rdqjFvLzdMbXI8VKHQjYNYzv9f4Omw3x//u3qSGnjed3e9uqP
         1DuPmt9CbCJQ+kQcqjhB0rEkGtxgoKIgJSgWxTyTx8ePEgshK2gLK3BkNgAYvOcxku1S
         QSh2EfIUmqPa/L2SOqDa2nQ358oNQHAJ77zP7spaFVTjYGuubNcPgpaAkk+YbUwEYDic
         3JU07pdE0LqTZGN/mpcyC3rLN0bap47+QWpxSs/Qz7PKb5eaY4qCOqy/DK+ZrC3eTLIj
         Iug40AYVLQ04xodEZOV+fTFrgfqzvdaR5tNk+YrnImIue1FfqBiXs9ZBoB1JNq+djWPg
         s0qQ==
X-Gm-Message-State: AOAM5300SLEVVm9fyLyfM25BD1TzbRkSmNi2p2HK8SNE788jAFFHwiPJ
        QHF5Hyq+9tUvjRycIrNo3S2coSP4CaxC9Jw4CpfGslA9TtcOIRHsCClsob1ntUAoRbdJ0Cu1KqN
        Ffynhz+WQFtZZTRyM/5FrbyJw
X-Received: by 2002:ac8:615c:: with SMTP id d28mr4325699qtm.103.1633466219387;
        Tue, 05 Oct 2021 13:36:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiUlDt7M96h8AoBqBLpXzaS3T7Kh4lNL7lZpOFg6AtZ305uLibjt9iiB/xDGibdlAu3aY9YQ==
X-Received: by 2002:ac8:615c:: with SMTP id d28mr4325678qtm.103.1633466219183;
        Tue, 05 Oct 2021 13:36:59 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id 18sm11884045qtz.49.2021.10.05.13.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:36:58 -0700 (PDT)
Date:   Tue, 5 Oct 2021 13:36:55 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4 00/15] x86: Add support for Clang CFI
Message-ID: <20211005203655.cvjfxmjvgx2knkuk@treble>
References: <20210930180531.1190642-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:05:16AM -0700, Sami Tolvanen wrote:
> This series adds support for Clang's Control-Flow Integrity (CFI)
> checking to x86_64. With CFI, the compiler injects a runtime
> check before each indirect function call to ensure the target is
> a valid function with the correct static type. This restricts
> possible call targets and makes it more difficult for an attacker
> to exploit bugs that allow the modification of stored function
> pointers. For more details, see:
> 
>   https://clang.llvm.org/docs/ControlFlowIntegrity.html
> 
> Note that v4 is based on tip/master. The first two patches contain
> objtool support for CFI, the remaining patches change function
> declarations to use opaque types, fix type mismatch issues that
> confuse the compiler, and disable CFI where it can't be used.
> 
> You can also pull this series from
> 
>   https://github.com/samitolvanen/linux.git x86-cfi-v4

Does this work for indirect calls made from alternatives?

I'm also wondering whether this works on CONFIG_RETPOLINE systems which
disable retpolines at runtime, combined with Peter's patch to use
objtool to replace retpoline thunk calls with indirect branches:

  9bc0bb50727c ("objtool/x86: Rewrite retpoline thunk calls")

Since presumably objtool runs after the CFI stuff is inserted.

-- 
Josh

