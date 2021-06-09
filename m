Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEF73A1F28
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhFIVqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhFIVqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:46:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF5AC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 14:44:11 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bp38so4818471lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 14:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aaXF2yQYlF3XaWxmnf9WH9rzEvbnGjon/80g8w4+GyI=;
        b=I0Uv1/Obcy6RZhS3152uYEHuLVSidy2Itl/6Pz8iSIW5HjbdZiHIic91RTMHJu5nBU
         W1zV/GRWkSf8fG3bTYSYA7A1IUfcQ7z+NLf6Pc+4PlIpLqHS3KhxsY5r4DnUxChi0o2U
         JGC6Ia6Pgrb6fYuxAFQpZcxJZ7vJMdjMpMdbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aaXF2yQYlF3XaWxmnf9WH9rzEvbnGjon/80g8w4+GyI=;
        b=tL1zjupJuugMqt+V3YbrFx5HtvBVqwNn9/KiyP+pHxskSlyEgfpf4GHAXDd8WZWoZ5
         7ZCCtjhhNfaQCJ1DOUkiw29YZ5C2r+oGBL5qZTzo1HdyFO5VxM0fknVC2rIqAZCgHbqM
         gc00DcN8wdv4P2Mv/911w/o/1U/3KYnbHOznw9XvqPlSv9QLQOY49HNNmWpVMCbWE533
         Z1M06M6G0AbKem71Edwh9FWIWlxSfstrNSs4gseh6ZkjfboHgIAl1J+BnvoiTZ1fsK/N
         vJOKbs5mAgKKjzEWqOWVQqUsbJCxlUzVEy/dI1H29p2QK8pQfUOmggoIdA8RceWRMTi6
         HCzA==
X-Gm-Message-State: AOAM532zJuNmdgj8FCb0/aiIs4erQoT/aGUEreDCJzh3nAPig98ObSLy
        AqF5kbcJ1Hxev2c/5uLGZ9vo54ipcLp07ejJum4=
X-Google-Smtp-Source: ABdhPJw5895cNVjBkBLn2VrTJdR7Ccn6n+vH/qacy0pFG6L2Zw9vleGiIMSiwoJNQJRq2LTMJn9vTA==
X-Received: by 2002:ac2:5e3b:: with SMTP id o27mr941323lfg.241.1623275050046;
        Wed, 09 Jun 2021 14:44:10 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id g19sm100092lfu.274.2021.06.09.14.44.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 14:44:08 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id u18so1727441lju.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 14:44:07 -0700 (PDT)
X-Received: by 2002:a2e:8587:: with SMTP id b7mr1307218lji.465.1623275047231;
 Wed, 09 Jun 2021 14:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210607125734.1770447-1-liangyan.peng@linux.alibaba.com>
 <71fa2e69-a60b-0795-5fef-31658f89591a@linux.alibaba.com> <CAHk-=whKbJkuVmzb0hD3N6q7veprUrSpiBHRxVY=AffWZPtxmg@mail.gmail.com>
 <20210609165154.3eab1749@oasis.local.home>
In-Reply-To: <20210609165154.3eab1749@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Jun 2021 14:43:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGWjxs7EVUpccZEi6esvjpHJdgHQ=vtUeJ5crL62hx9A@mail.gmail.com>
Message-ID: <CAHk-=wiGWjxs7EVUpccZEi6esvjpHJdgHQ=vtUeJ5crL62hx9A@mail.gmail.com>
Subject: Re: [PATCH] tracing: Correct the length check which causes memory corruption
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     James Wang <jnwang@linux.alibaba.com>,
        Liangyan <liangyan.peng@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        yinbinbin@alibabacloud.com, wetp <wetp.zy@linux.alibaba.com>,
        stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 1:52 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > That "sizeof(*entry)" is clearly wrong, because it doesn't take the
> > unsized array into account.
>
> Correct. That's because I forgot that the structure has that empty array :-(

Note that 'sparse' does have the option to warn about odd flexible
array uses. Including 'sizeof()'.

You can do something like

    CF='-Wflexible-array-sizeof' make C=2 kernel/trace/trace.o

and you'll see

  kernel/trace/trace.c:1022:17: warning: using sizeof on a flexible structure
  kernel/trace/trace.c:2645:17: warning: using sizeof on a flexible structure
  kernel/trace/trace.c:2739:41: warning: using sizeof on a flexible structure
  kernel/trace/trace.c:3290:16: warning: using sizeof on a flexible structure
  kernel/trace/trace.c:3350:16: warning: using sizeof on a flexible structure
  kernel/trace/trace.c:6989:16: warning: using sizeof on a flexible structure
  kernel/trace/trace.c:7070:16: warning: using sizeof on a flexible structure

and I suspect every single one of those should be using
'struct_size()' instead for a sizeof() on the base structure plus some
manual arithmetic (or, as in the case of this bug, _without_ the extra
arithmetic).

And yeah, it isn't just the tracing code that does this. We have it
all over, so that sparse check isn't on by default. Sparse is pretty
darn noisy even without it, but it can be worth using that
CF='-Wflexible-array-sizeof' on individual files that you want to
check.

               Linus
