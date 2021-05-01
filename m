Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778443707E0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 18:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhEAQ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 12:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230391AbhEAQ1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 12:27:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 617EB61450
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 16:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619886406;
        bh=tPS5YMSpUbvnf9amJgB2PY1uxjiZW0pwf+nn4c36Ryo=;
        h=From:Date:Subject:To:From;
        b=or7F4Umz9+LB76HTM8ZiBB4Gj2gyD0GOhSDDB7eNOXn9t6YUREfyiUE3IyMKZytg0
         F/xErSNMeMyjKDVWALyIH5tq4TwoYpad/7U7l1ZPmLqjpxY7lGcQ4wNCE8oy+JfhB9
         ZnI88qyXTjKddFVbMVoMyAD5Az70AZT/su6hDHnVFhnKFopujja0cCzIBHIRRp8b1h
         nL7dvQyZ3pdH1Q3QwurRV60d+47aHwrcKKQLxQ/AvDfBCaIb9k0qoNUB5JX3oK914p
         7z11ACKwsBLYXwQR5GRgmEteItEBA52t4Uf/XR2qlOBkKhSNHBUqBqvCUnwj6qwq54
         CyoHzNC42TdvQ==
Received: by mail-ed1-f51.google.com with SMTP id d14so1521710edc.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 09:26:46 -0700 (PDT)
X-Gm-Message-State: AOAM531LeLda0O3tacPLdhiwOHjY1txhAZt17SJsctH+dmQRHquh0cOO
        Hi62QdoikJHUHPYqDuPyHZYZRv8km+HqaaQ/emQYOw==
X-Google-Smtp-Source: ABdhPJw6L2ugFxYlY3DSuNMCZ4WbILphD+wldswJkG32BSBTHBEyVO2rP2tbk4MvQSNu15KvnHeM2sF/xiweHYOIoTk=
X-Received: by 2002:aa7:d390:: with SMTP id x16mr8460921edq.172.1619886404906;
 Sat, 01 May 2021 09:26:44 -0700 (PDT)
MIME-Version: 1.0
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 1 May 2021 09:26:33 -0700
X-Gmail-Original-Message-ID: <CALCETrXRvhqw0fibE6qom3sDJ+nOa_aEJQeuAjPofh=8h1Cujg@mail.gmail.com>
Message-ID: <CALCETrXRvhqw0fibE6qom3sDJ+nOa_aEJQeuAjPofh=8h1Cujg@mail.gmail.com>
Subject: =?UTF-8?Q?Do_we_need_to_do_anything_about_=22dead_=C2=B5ops=3F=22?=
To:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Kaplan <David.Kaplan@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all-

The "I See Dead =C2=B5ops" paper that is all over the Internet right now is
interesting, and I think we should discuss the extent to which we
should do anything about it.  I think there are two separate issues:

First, should we (try to) flush the =C2=B5op cache across privilege
boundaries?  I suspect we could find ways to do this, but I don't
really see the point.  A sufficiently capable attacker (i.e. one who
can execute their own code in the dangerous speculative window or one
who can find a capable enough string of gadgets) can put secrets into
the TLB, various cache levels, etc.  The =C2=B5op cache is a nice piece of
analysis, but I don't think it's qualitatively different from anything
else that we don't flush.  Am I wrong?

Second, the authors claim that their attack works across LFENCE.  I
think that this is what's happening:

load secret into %rax
lfence
call/jmp *%rax

As I understand it, on CPUs from all major vendors, the call/jmp will
gladly fetch before lfence retires, but the address from which it
fetches will come from the branch predictors, not from the
speculatively computed value in %rax.  So this is nothing new.  If the
kernel leaks a secret into the branch predictors, we have already
mostly lost, although we have a degree of protection from the various
flushes we do.  In other words, if we do:

load secret into %rax
<-- non-speculative control flow actually gets here
lfence
call/jmp *%rax

then we will train our secret into the predictors but also leak it
into icache, TLB, etc, and we already lose.  We shouldn't be doing
this in a way that matters.  But, if we do:

mispredicted branch
load secret into %rax
<-- this won't retire because the branch was mispredicted
lfence
<-- here we're fetching but not dispatching
call/jmp *%rax

then the leak does not actually occur unless we already did the
problematic scenario above.

So my tentative analysis is that no action on Linux's part is required.

What do you all think?

--Andy
