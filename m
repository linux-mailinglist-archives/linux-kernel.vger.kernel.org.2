Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FB3419513
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 15:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhI0NaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 09:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234058AbhI0NaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:30:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 688CC61058
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632749320;
        bh=vns6d7q7snjlnOGxuPZz3LzGfbU3pA9uIcUCFNFCBl0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rhhWa5RW0yQoJ4jqoEt5H5Uofm+jScQJy35aNLJ8PXqNbOcyKf2XD/jgwAfSdt3pB
         M3FWGdOlZTUrpTCAaddDpXdsWXc1Z/OBuQ5++wdyvmpKg5uj/k8/q69ormsZIgSyrX
         iIQgHs0qvuwnYWepuH2y9TPA+0pQIXNkZY/G0Rig+Z4MEe0yj1SKhmLVze4NzgLxIe
         iuC1W0XQMvp9TH7sWmhFTKnc4tPSN5ojmoeupA+c4+NBXteLHhgRL8oITIjJ/1vMX8
         8UzDqzxBX8eztOurMyEa9jTnKkiDIDOgTuGAjoN2FmqP66lGogVi6kcNxUqkP81BSU
         ToF3bTNBQqV/g==
Received: by mail-wr1-f44.google.com with SMTP id w29so51843822wra.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 06:28:40 -0700 (PDT)
X-Gm-Message-State: AOAM532gfr+ST+0PQavxV8PxnIrFl6GsGyNrr9+1nP6uNceUSODzrKHi
        7s+u4ds54tBFlD+notY+oAiVQEB3QJq/o28tbDQ=
X-Google-Smtp-Source: ABdhPJxbWPlRuOELSlE0iUvzwb9mv8lxk5wVCNSZHg1zaADn1v3AAN1pQjR4+krJ1avS9O0dJh2L8K7krNWt2DcmhtQ=
X-Received: by 2002:a5d:4b50:: with SMTP id w16mr27956996wrs.71.1632749318987;
 Mon, 27 Sep 2021 06:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210927125007.1581919-1-arnd@kernel.org> <YVHE1qclD6ZyjvvD@chrisdown.name>
In-Reply-To: <YVHE1qclD6ZyjvvD@chrisdown.name>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 27 Sep 2021 15:28:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3_0njnrTokeXmOuZ1vA00Nk9pqbxsOZw+6QcCL-Ng=xg@mail.gmail.com>
Message-ID: <CAK8P3a3_0njnrTokeXmOuZ1vA00Nk9pqbxsOZw+6QcCL-Ng=xg@mail.gmail.com>
Subject: Re: [PATCH] printk: avoid -Wsometimes-uninitialized warning
To:     Chris Down <chris@chrisdown.name>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 3:20 PM Chris Down <chris@chrisdown.name> wrote:
>
> Hi Arnd,
>
> Arnd Bergmann writes:
> >From: Arnd Bergmann <arnd@arndb.de>
> >
> >clang notices that the pi_get_entry() function would use
> >uninitialized data if it was called with a non-NULL module
> >pointer on a kernel that does not support modules:
>
> On a !CONFIG_MODULES kernel, we _never_ pass a non-NULL module pointer. This
> isn't just convention: we don't even have `struct module` fully fleshed out, so
> it technically cannot be so.

Yes, I understand that part, hence the "if it was called" rather then
"when it is called".

> >kernel/printk/index.c:32:6: error: variable 'nr_entries' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
> >        if (!mod) {
> >            ^~~~
> >kernel/printk/index.c:38:13: note: uninitialized use occurs here
> >        if (pos >= nr_entries)
> >                   ^~~~~~~~~~
> >kernel/printk/index.c:32:2: note: remove the 'if' if its condition is always true
> >        if (!mod) {
> >
> >Rework the condition to make it clear to the compiler that we are always
> >in the second case. Unfortunately the #ifdef is still required as the
> >definition of 'struct module' is hidden when modules are disabled.
>
> Having IS_ENABLED and then an #ifdef seems to hurt code readability to me.
>
> >Fixes: 337015573718 ("printk: Userspace format indexing support")
>
> Does this really fix anything, or just clang's ignorance? If the latter, clang
> needs to be smarter here: as far as I can see there are no occasions where
> there's even any opportunity for a non-NULL pointer to come in on a
> !CONFIG_MODULES kernel, since `struct module` isn't even complete.

I don't see how you would expect clang to understand that part. It does
not do cross-function analysis for the purpose of diagnostic output, and
even if it did, then this caller

static void *pi_next(struct seq_file *s, void *v, loff_t *pos)
{
        const struct module *mod = s->file->f_inode->i_private;
        struct pi_entry *entry = pi_get_entry(mod, *pos);
...
}

has no indication that "s->file->f_inode->i_private" is guaranteed to
be a NULL pointer.

         Arnd
