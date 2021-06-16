Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2C73A8D82
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 02:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhFPAfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 20:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhFPAfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 20:35:11 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A04C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 17:33:05 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 131so1228075ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 17:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBfvBtPeeZ+txOyCfuRZiBcTJq4klTe+mp15Vdy8/1A=;
        b=SmeDvHt0uOBK4zkN8iVTIqG+FjaChfdwC2QGIxtkRL4PGE0lM8qGLzbl4cRN7HzV5w
         jO2VtBLzpPVhsTyfy7YZsAbgvV+j8Nc61Qw+wNUiccqLf5kSFaP0Zub0/uHF5dtn68Nw
         1mjlMKuoILO0G/BzShMseFzUbIY2yTZDFBTKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBfvBtPeeZ+txOyCfuRZiBcTJq4klTe+mp15Vdy8/1A=;
        b=ZBKY/HP3Jc1HUJ8+XzVj0/o3K9ZopOgjX9eTmQPEGEk+BZdchbpOEjgsJ2p2tHTsza
         KByBRjzAr2LCQ0vmWjF/OrvDqeWJx5gvBsYFGMxxZoM2FWsat+mBSPlY1gdhjsDPPGkk
         AZnjhESoyHU1T4XH+PdY9PYMvNSqOW6wPVV7FAqN46RC+HR83K19A8wu/gNH6R00mBS0
         IB+/O8ZEAV0dtJfJ1LdqcZEsT3xXpoogkLxNiDHhqBVPnfu3pWnHfDnZUxMebHD9MwU/
         FrZt3OuCrZjVLR+DhXHd8ZWqeLtnj/UDHgaXRECkU4i7mbuMCntRbH1f34ytgLvAdYlx
         72ug==
X-Gm-Message-State: AOAM533URLoLpqGmiAMUM1oidQsd4JZYYxaZkw08wFtpPotY27Cg1w/o
        K9ayRtnZrW0ieN/FSpdbcclX+aZ5T3UIkk8NL10=
X-Google-Smtp-Source: ABdhPJwH+py3NWmdBUuBpDyESy1PyFq0f2mmpW4aJ9NqXogNwakCZoDbiBG2Z4XFGP3rQYE6OVQrcQ==
X-Received: by 2002:a2e:8758:: with SMTP id q24mr1957101ljj.212.1623803582937;
        Tue, 15 Jun 2021 17:33:02 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id c9sm46483ljr.104.2021.06.15.17.33.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 17:33:02 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id x14so1196458ljp.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 17:33:02 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr1939304ljh.507.1623803581822;
 Tue, 15 Jun 2021 17:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <162375813191.653958.11993495571264748407.stgit@warthog.procyon.org.uk>
 <CAHk-=whARK9gtk0BPo8Y0EQqASNG9SfpF1MRqjxf43OO9F0vag@mail.gmail.com> <f2764b10-dd0d-cabf-0264-131ea5829fed@infradead.org>
In-Reply-To: <f2764b10-dd0d-cabf-0264-131ea5829fed@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Jun 2021 17:32:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPPWYXKQv6YjaPQgQCf+78S+0HmAtyzO1cFMdcqQp5-A@mail.gmail.com>
Message-ID: <CAHk-=whPPWYXKQv6YjaPQgQCf+78S+0HmAtyzO1cFMdcqQp5-A@mail.gmail.com>
Subject: Re: [PATCH] afs: fix no return statement in function returning non-void
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Hulk Robot <hulkci@huawei.com>,
        Zheng Zengkai <zhengzengkai@huawei.com>,
        Tom Rix <trix@redhat.com>, linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 4:58 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Some implementations of BUG() are macros, not functions,

Not "some", I think. Most.

> so "unreachable" is not applicable AFAIK.

Sure it is. One common pattern is the x86 one:

  #define BUG()                                                   \
  do {                                                            \
          instrumentation_begin();                                \
          _BUG_FLAGS(ASM_UD2, 0);                                 \
          unreachable();                                          \
  } while (0)

and that "unreachable()" is exactly what I'm talking about.

So I repeat: what completely broken compiler / config / architecture
is it that needs that "return 0" after a BUG() statement?

Because that environment is broken, and the warning is bogus and wrong.

It might not be the compiler. It might be some architecture that does
this wrong. It might be some very particular configuration that does
something bad and makes the "unreachable()" not work (or not exist).

But *that* is the bug that should be fixed. Not adding a pointless and
incorrect line that makes no sense, just to hide the real bug.

               Linus

                 Linus
