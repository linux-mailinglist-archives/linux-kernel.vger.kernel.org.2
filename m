Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C614B43872F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 09:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhJXHKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 03:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhJXHKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 03:10:14 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F73AC061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 00:07:54 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso10299356otl.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 00:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fYsl9CYVa0vbeqaio429pJ7nWHE90zcqRVhgSRIdIYE=;
        b=Bk3oVRiinhyfUlUcu+RlImWiIPCpoTZ7ciEl/1OCvFY0dRkxxH18hHVnZpsoaIWFdy
         0iewLMOx/Pju7GJoyBoZS7tVK/q3k2yFnk7gBPGxa1bofWh5ApetiKpfjOeudXwYKIXL
         pSpSNWjKpvv0cH4AmnEIW+AiLFio7FO8t2fLFvwqna2BwBp19c2CQnYj0Xh4b54Z0FPG
         lT9afotWcfmVubaytI7b3r9ujl4Ag0LcG1GWEqyIyMkcRBaGdX/QHzUMMAKBQNqTYYnx
         OYMAG3AzVjOIn1JRxQ5hjhGbMQ/ssqJNVa+pHen+InDyatmILE6A1aUGQ2kR8aUo7hxo
         +rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYsl9CYVa0vbeqaio429pJ7nWHE90zcqRVhgSRIdIYE=;
        b=odgdSns+/jbpNg8RDC0TGNml3W1fQkOz7zkgvucBqE/QnA2uywDFRE34P77tF2YFMv
         W4JRNd5gbquudwru2mSBk/OEkdkeKb2gZ0P0BX3ibrFJVWpP+CacyDIS3j3TguG5T/Gd
         Ql6d64DIHt1XSx4mm+/ofHk3FY9ViLIE1zw0NqpEK8Se8h8H/R0Zan8y1aS/3/fILjDR
         V8lyaqaGW6rzP2QgnbC8r3Dp6VjVciPYSR9cW6hYodTQwVymqINqP9I0tzo5yyVp9YEU
         d0jRDEDeXuVNwBPvt+FdhNppudITjtneCSOohCwrznFcYKx5/n04iLdyT2PcM3gyoKA2
         MEEA==
X-Gm-Message-State: AOAM531DxU8DPPr1ZBgLuph8VBoQSCjFi7XgIoDkZjqWAVmMefgaqoqe
        +NoyLiQhk/nf+VWBq+y0of8qN2X+VvibTTvhjAKnnA==
X-Google-Smtp-Source: ABdhPJw1q5FXEGcSxeesKVoApYXL/oP86UXBU5bSp4qRUqAmI2LDoXKbuD0fL0nytKiZqzt44b+8WKu3IpswsmzEiNI=
X-Received: by 2002:a05:6830:402c:: with SMTP id i12mr8016921ots.319.1635059273605;
 Sun, 24 Oct 2021 00:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000062d0fc05cef24c57@google.com> <CACT4Y+aFvuvBew3c6gV9VwE5Fi_4tbPX9Am1xf628ynzKFFLeg@mail.gmail.com>
 <YXQp4MsT0EEKqMl/@kernel.org> <088FF23B-CD8E-4E53-B702-53E2C2382062@chromium.org>
 <YXSQuiahbU7YyYrk@casper.infradead.org> <YXTxN5skPPFPvScP@kernel.org>
In-Reply-To: <YXTxN5skPPFPvScP@kernel.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 24 Oct 2021 09:07:42 +0200
Message-ID: <CACT4Y+aqEOfSY+R1EkdNhCbnSCjWrLO4f0T9QxWG6-UV7z7+Fg@mail.gmail.com>
Subject: Re: [syzbot] WARNING: refcount bug in sys_memfd_secret
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        syzbot <syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com>,
        Jordy Zomer <jordy@pwning.systems>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2021 at 07:38, Mike Rapoport <rppt@kernel.org> wrote:
>
> On Sat, Oct 23, 2021 at 11:46:18PM +0100, Matthew Wilcox wrote:
> > On Sat, Oct 23, 2021 at 10:03:11AM -0700, Kees Cook wrote:
> > > On October 23, 2021 8:27:28 AM PDT, Mike Rapoport <rppt@kernel.org> wrote:
> > > >and my first reaction was to send a revert the untested commit 110860541f44
> > > >("mm/secretmem: use refcount_t instead of atomic_t").
> >
> > I think you should.  This isn't a real problem.
>
> Do you mean that creation of 4 billion of file descriptors is not feasible?

FWIW I think refcount is at least capable of catching the issue I
described with the counter temporarily going below its true value.
With refcount it can be caught during fuzzing as refcount reaching 0
and then being incremented again. Basically this warning, but a true
positive.
