Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D533A3441
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 21:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhFJTrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 15:47:05 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:43999 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFJTrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:47:05 -0400
Received: by mail-yb1-f177.google.com with SMTP id b9so931946ybg.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=45VPwdGqjIQ5wCNrWGGIfoD9uraRT5+Atyz+alwmg38=;
        b=X5XJumtlyeIp5HPzFMv/nxvx9JvtKffDFFV6O/lnyD5ZR+9p5P2VUaFv+EUJQyja2B
         I9j8zfUHK9W3A4/mQyMifOqryoycwEAYFLDIBcJ1M1UZ+zI1zn9AQY4bU+Q2WJ10saM6
         BOJ7sQO6yzKyrlrWQ8LopHq9VFQa4kQRYSAzP4yRdwJmefGoSeGZh2I9ebgiM7JFnKzP
         Aoon5mYwjUo53jIRWIWEQT5W/OGfWeG+t/nxzbr0QBwLy9dSBDgSXwc6xj5EN1lHxswf
         WH01VrxLrnt143A2CXXVaw4J01eRqD5SuMZBlM5EE0obnCv7a+7Y8r7m3wofLF0sAjVL
         oNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=45VPwdGqjIQ5wCNrWGGIfoD9uraRT5+Atyz+alwmg38=;
        b=SU8L2sKQDg9OgW899WnKMlowJjSQTQjHgoJHp7uE3XVBHkfxUDUzm8nopnEC6Na1C5
         QBflddoB0z3QpWWv5kNbv+TlfLjZGv1EnUE20scv5RFW8cUHk2ONN+9K9tLZxsFVv2Ou
         64uIFfXPEUNtP4SJPutBY3MwH3gnDiJYhmiayBylCZojsU4vWmAJF6qAFrGFBvyssCko
         YY7YlWjVoju5nkn30e4RKyY9HL6M3E5ALWDltnlkF7nlok3xOOf8CQWnV8TGNv/RbDwA
         Qe4fGc/NPMFjK77McL9juF7WsHMIQ/h29Zs5nneq+2Emg2G4uq19CiPZAcSO4lHypNxf
         +Uxg==
X-Gm-Message-State: AOAM531E7rsiL/EXVGYvUbEcN6Y9aUp8/C1yiw/r+0jpxBT/sm4yDUgR
        sYGdw/cF/wcON72yNzf+mKyzRVUBWAonTS6kiQPyYw==
X-Google-Smtp-Source: ABdhPJzoKZQlsWpGV3/ZGR29r5DYP0gR065zjq7rsav3u4YyrM3IZHe/SUegHDfMVWiXnikw9MrAounrShi73wpZMoQ=
X-Received: by 2002:a25:6409:: with SMTP id y9mr558728ybb.235.1623354247973;
 Thu, 10 Jun 2021 12:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210506193352.719596001@infradead.org> <20210506194157.452881700@infradead.org>
 <YMJWmzXgSipOqXAf@DESKTOP-1V8MEUQ.localdomain> <CABCJKudzC-Nss_LGrpYwRqwdDxeWOf1o6Bvp3J2fBQthEB=WGg@mail.gmail.com>
 <YMJpGLuGNsGtA5JJ@hirez.programming.kicks-ass.net>
In-Reply-To: <YMJpGLuGNsGtA5JJ@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 10 Jun 2021 12:43:56 -0700
Message-ID: <CABCJKudpajMRFGpn4Vh-JWzyfprEVrtYzX79iwp++rPu6rQWHw@mail.gmail.com>
Subject: Re: [PATCH 01/13] objtool: Rewrite hashtable sizing
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 12:33 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jun 10, 2021 at 11:50:36AM -0700, Sami Tolvanen wrote:
> > On Thu, Jun 10, 2021 at 11:14 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > > Adding Sami because I am not sure why this patch would have much of an impact
> > > in relation to LTO. https://git.kernel.org/tip/25cf0d8aa2a3 is the patch in
> > > question.
> >
> > It's because LLVM enables -ffunction-sections with LTO, so using .text
> > section size to estimate the reloc hash table size isn't going to be
> > accurate, as confirmed by objtool output with --stats:
> >
> >   OBJTOOL vmlinux.o
> > nr_sections: 141481
> > section_bits: 17
> > nr_symbols: 215262
> > symbol_bits: 17
> > max_reloc: 24850
> > tot_reloc: 590890
> > reloc_bits: 10
>
> Bah. Would something like the *completely* untested below help with that?

Yes, that seems to work:

tot_reloc: 590890
reloc_bits: 19

Nathan, can you confirm if this fixes the regression for you?

Sami
