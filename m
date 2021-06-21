Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E4B3AF910
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 01:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhFUXSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 19:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhFUXSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 19:18:11 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B04C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 16:15:56 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u11so16546917ljh.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 16:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=stNy8kLF5vctj8WXK363X+Ab+aWkvJsrhuAKRgNlaFY=;
        b=IL1c66HdRAXSPTueb6HvT7WAQ+hVTgraIpPVGrRtYIIPrdMk6idOyB+d7hgkhCbE/J
         WSDn2K6/KFlAr4ZepO/VZSbAHdCjsBoc9mInrjOrnW0t0J2Sklo0eRJQKmRh1FXkY2rP
         httftVRSDPt4omCrZhGPE4bzB66yBCzHc25jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stNy8kLF5vctj8WXK363X+Ab+aWkvJsrhuAKRgNlaFY=;
        b=cArIQ+MQdzEoTIW/33mGSO+k7dZd+iih3om1/t6TyxH5dP9/YS6h2x/QeTvYbndEdR
         b/OE9iZ4WHXr5ZHn1MLH2pgQUrLdaCFzyBwXIcv9ytoifT7fl2V4m3MgXCXuUawP+5lX
         /eom2N8J8IA21DgiDEi4pewaTcB0NnattmAheWt2kzHq+hNTlyEAcawEog/74bawcXAY
         g6hqoLJ2ajZgYRnWlasX/Y4rg6ms9doHn9ysRJBtmk662A0aMoyd7fdutUP10c0Olg+M
         X8A7h9pRxqo2w/HzXnTPzzzsWsGiiLako6RtAl13yUFw3PKduhx4m9dru2zLfJBvMDEG
         nkgQ==
X-Gm-Message-State: AOAM531pkQ0XRLjYe/Ioxrws1PNzISFvxQi+RKvXTpAn6i30WZ8Bgz8y
        1WWrLljOjS7Rfsc79I4dSdjvMZjMc/mtH6Wpfnw=
X-Google-Smtp-Source: ABdhPJzJaTf3CACuiskA7/lWLRPL/y9FOVdAIfQ6+7adN078PIy0IgI8N2VUDXs/FsBb4i0ZEMitNA==
X-Received: by 2002:a2e:9d4c:: with SMTP id y12mr535052ljj.80.1624317354790;
        Mon, 21 Jun 2021 16:15:54 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id q16sm2008025lfu.103.2021.06.21.16.15.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 16:15:53 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id p7so32702906lfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 16:15:53 -0700 (PDT)
X-Received: by 2002:a05:6512:15a2:: with SMTP id bp34mr498972lfb.40.1624317352941;
 Mon, 21 Jun 2021 16:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133> <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com> <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133> <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133> <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
 <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk> <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com> <87a6njf0ia.fsf@disp2133>
In-Reply-To: <87a6njf0ia.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Jun 2021 16:15:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
Message-ID: <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 1:04 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> For other ptrace_event calls I am playing with seeing if I can split
> them in two.  Like sending a signal.  So that we can have perform all
> of the work in get_signal.

That sounds like the right model, but I don't think it works.
Particularly not for exit(). The second phase will never happen.

              Linus
