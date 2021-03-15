Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BB333C63F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhCOS7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhCOS7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:59:32 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08FAC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:59:31 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 16so17554996ljc.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=550wHzziWpZqbBMI1ekRhxDFsnHTjr1szst8UF4SJU8=;
        b=JMdhuIvzqTnOtufRzT37+yVapww0nLbHI/0DmhITx8GHvixpSo51d1jlECqEGew189
         cg/O6uMttH3L94lbGo25PeKEXZST4sf0pSTQxKEDsjTBdb7PPeuCsD1WAp1AVdPRHyr0
         jZvxg+4MUORDltrd0NEn7jmEhuNavIswCANFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=550wHzziWpZqbBMI1ekRhxDFsnHTjr1szst8UF4SJU8=;
        b=uSLT1dl3bBq5RZ3awfbQajUktENQDDIMpH4Vf4egXGdWHJnCs7wH77OuLAYnx6M6E1
         iL+p3XBA14ww3QbuICnTD7kBrN7vDF4P1IkF9LvWdzSskvRGPwXDjxFWXYmYlXVqvQto
         z+/bhVPQhCvVQ9xDLZqqB7FI7IWWJqnAemZ6kSw5v3UXRRAdiZtzm0nQBh6zAgKCvRwt
         fhIMASMci36HaNrOL37JQKYPoMgoVfHw0hbz1yUCAtUdUAxfOohIzmW1ekZe5jugUQT7
         OgsHSKdTXu5f5rvxukae8u1QWnZ8aSAqfIWd66Ty2Ltp6dFrsMbosrutcl1gJcVLaWCg
         N/yQ==
X-Gm-Message-State: AOAM532pFT/5Zgez6ucAp6SvnRR8BbV/nMfSiqARCMn17WMK9RiP+cXB
        jQIB6C4OFWf9ZE7D6EJw65KvrCR86C1o5w==
X-Google-Smtp-Source: ABdhPJxw+umRjdr8z8V2P2IYGg7do6d3W0Blu1YDeB5Ek6Uug6GuGO8VDSmXXSPAZoJISqGWHJdTnQ==
X-Received: by 2002:a05:651c:1194:: with SMTP id w20mr269721ljo.283.1615834769797;
        Mon, 15 Mar 2021 11:59:29 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id v9sm2789826lfa.32.2021.03.15.11.59.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 11:59:29 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id v9so58585402lfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:59:28 -0700 (PDT)
X-Received: by 2002:a05:6512:104b:: with SMTP id c11mr8438078lfb.421.1615834768439;
 Mon, 15 Mar 2021 11:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <161573639668.27979.17827928369874291298.tglx@nanos>
 <CAHk-=wjuD2cCptSJmmHBp2c9chTPnZcSi+0vA+QJ8JNjYTJKCw@mail.gmail.com>
 <YE8b6dgsEG4OU0ay@hirez.programming.kicks-ass.net> <YE9AkgbqL+eVO6p1@hirez.programming.kicks-ass.net>
 <YE9EVNG4/5UMJvFp@hirez.programming.kicks-ass.net> <YE9OOx0za7ZH3AXe@hirez.programming.kicks-ass.net>
 <20210315170321.ndeqgjzdfupvuiak@treble>
In-Reply-To: <20210315170321.ndeqgjzdfupvuiak@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Mar 2021 11:59:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjE1Z2L87B_ahMMEd9E+jumMwsw=HDCgDkV4gmS=F9u6A@mail.gmail.com>
Message-ID: <CAHk-=wjE1Z2L87B_ahMMEd9E+jumMwsw=HDCgDkV4gmS=F9u6A@mail.gmail.com>
Subject: Re: [GIT pull] locking/urgent for v5.12-rc3
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 10:03 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Though instead of using objtool, it can be done in the module linker
> script:

This is obviously the way to go, but it raises another question: do we
guarantee that functions are aligned?

We actually have a couple of 32-bit x86 sub-architectures that do

    -falign-functions=0

ie Crusoe, Efficeon, and Cyrix III. Also "-Os" does that, iirc.

Is it only the static_call_sites entry itself that needs the
alignment? Or do we end up depending on the static call function being
at least 4-byte aligned too? The way it plays games with the key makes
me worry.

             Linus
