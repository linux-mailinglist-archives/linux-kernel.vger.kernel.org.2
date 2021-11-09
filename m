Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F2C44B301
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 20:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbhKITGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 14:06:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:36636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230445AbhKITGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 14:06:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E5B6611C9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 19:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636484644;
        bh=uazp6pX2elsGx6La1lQjbYJQaADfiPQ86aPoob7lx08=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WpwMKd44GJgeXaSFwxIbEmw+tXkqqXMclold2q2Drb5NsTATXhQDNF76pfzYFgFHI
         QZSXblJhmepd1A60+2aOaspNxQyVQGw0iERIzBqJc1isnab0rlih1AhsHIp+nBtWdU
         9g9uK565yzBQkW1X10ARnDJlOAsm7IqKitb92j51sECAYMV3CsO9hAIrRXqvKHB5Aw
         T5bktkgi3TWXYXW7xnO+5nrDX8WRunOXVgmx4oEpuJZWIBwHOdxXvZIAnlMRuAjotq
         Fpfi5wml9bCV5AjX9VLBnn8ftGdSyGP7FhrX3gLeViW2SWhP88E3bY+Y2ruB0899J4
         smcCXAZFkKOXQ==
Received: by mail-oi1-f172.google.com with SMTP id o83so490177oif.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 11:04:04 -0800 (PST)
X-Gm-Message-State: AOAM532bXUk1OoFfqrddFBsj4uDc8bVgbcWLIEyEzJWc9/WGkjBNcNSO
        PMoRvz4xChSIrp8GawaD8tTrZ3HgqagL7+ZbqnQ=
X-Google-Smtp-Source: ABdhPJx62iQExM8oQ/zEWUm6HekgmsReSStfqVnZwj2G6intc+Wa4+Nvam6v8BCjQ2l3WcpIpzwthC08ZEjEAkFcrNI=
X-Received: by 2002:a05:6808:12:: with SMTP id u18mr4059892oic.174.1636484643759;
 Tue, 09 Nov 2021 11:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20211109164549.1724710-1-ardb@kernel.org> <20211109164549.1724710-7-ardb@kernel.org>
 <YYrFOZT+6bNTfP+t@hirez.programming.kicks-ass.net>
In-Reply-To: <YYrFOZT+6bNTfP+t@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 9 Nov 2021 20:03:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHQ3YjNNrZE_rS5qYgCoOqXHmPy=q_Ncp-iYmcFfZG50w@mail.gmail.com>
Message-ID: <CAMj1kXHQ3YjNNrZE_rS5qYgCoOqXHmPy=q_Ncp-iYmcFfZG50w@mail.gmail.com>
Subject: Re: [RFC PATCH 6/7] static_call: rename EXPORT_ macros to be more self-explanatory
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2021 at 20:00, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 09, 2021 at 05:45:48PM +0100, Ard Biesheuvel wrote:
> > So let's rename these macros to
> >
> >   EXPORT_STATIC_CALL        -> EXPORT_STATIC_CALL_FOR_UPDATE
> >   EXPORT_STATIC_CALL_TRAMP  -> EXPORT_STATIC_CALL
> >
>
> Ok, let's pain this shed a bit.
>
> How about:
>
>         EXPORT_STATIC_CALL_RW
>         EXPORT_STATIC_CALL_RO
>

Works for me

> respectively. OR.. alternatively, have both:
>
>         EXPORT_STATIC_CALL_KEY
>         EXPORT_STATIC_CALL_TRAMP
>
> and those that want to export both get to use both.

Yeah but whether a trampoline even exists is an implementation detail,
which I would like to omit from the API.
