Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8866836DFA3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 21:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243786AbhD1Tck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 15:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbhD1TcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 15:32:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF81C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 12:31:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id n25so3576095edr.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HrayqRNczCcPu9+bk0jpm7mJ8w0nq6oxQzLYUtdFM7Y=;
        b=rIJJ0pPqtQ9bFZJbxSCEDYKqjAbnJFiaYvtRPj8NncIZTjslSq7FBzkemxQfYClCcA
         7+/ixKTKDQyu2pmgxC+YQulXSsognZ6b3bL+/Zjea9GvjAYY3+sEImrt8dT5/jO4CRua
         7bGBEEPlkDv35muCNMJ0AtZLw4Ke4aqGghPPLLOJVWVlk/ehmpyMknhNid97qjI0hdH1
         yUjXJYVmPvQDcOduozATfh5oREb8wUdWbmiRspvvqy8w63Ly7PWgdU3Jsv6383/umNcV
         D6Xbj5wRlHICy7j2N+Z6o0cFBi545f7VjPNdghkTRqRWH28hu4oF7XTk6Q3okmsS9TCr
         Fp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HrayqRNczCcPu9+bk0jpm7mJ8w0nq6oxQzLYUtdFM7Y=;
        b=RxwgVk1k9zVTi5M1HvQV8LhZvxrNhPAz2s+ReZIjg1EHmzTQ5ai6oUCe34ujxJjacL
         iR9WXkTYZLIdFvaZFop3PANMQ0LIdQsJMfXoThzSZxA7kHIaOqt9WpGBMLHf2SM3D9qH
         Dr5WtdPH6LGtrFjhCP6wczicA6HoRwX+Xy8cd+/0bp9JU5NevVaaslHlcdpD7TYBMn0W
         L+Wpcy/eRzItQfEayPhrP68g6MkjyhBSxIey9vBse/TYMEPnunSvje07TeqFp1hyiMG5
         AtxkTv3cEKVfSZPANO7ndxpqsF+pkjmW0fraMcg7imML20slQ2eJ08A2yQvleDoarxz6
         KBIg==
X-Gm-Message-State: AOAM530BqUjqdp5ngXyuOhdk4R/snJp982XbH6BANUYggwvU0WvRJf9g
        TgDPUUJnTjPLBh/DIwm5PwlkcC8l0DKkNng30dgX
X-Google-Smtp-Source: ABdhPJwwhyU0cCNm9Cp+xIWb4nDhZBoSMeH7MowF+KZQ6SQzY8WkbB8DXqGmTQ/+hlq+PD+dqC4+bcFrsCC6ELuVyVk=
X-Received: by 2002:a05:6402:3592:: with SMTP id y18mr1115175edc.77.1619638272304;
 Wed, 28 Apr 2021 12:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210423205159.830854-1-morbo@google.com> <20210428172847.GC4022@arm.com>
 <20210428174010.GA4593@sirena.org.uk> <CAGG=3QUATefn9AG+HvnCfEOBv3iRu4fzFwfmA7Djrh2CmP_weA@mail.gmail.com>
In-Reply-To: <CAGG=3QUATefn9AG+HvnCfEOBv3iRu4fzFwfmA7Djrh2CmP_weA@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Wed, 28 Apr 2021 12:31:01 -0700
Message-ID: <CAGG=3QUNykCfkS22g+HRWb0Goa8DJ72TUueLtMe5v1YfnStojw@mail.gmail.com>
Subject: Re: [PATCH] arm64/vdso: Discard .note.gnu.property sections in vDSO
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Daniel Kiss <Daniel.Kiss@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 12:21 PM Bill Wendling <morbo@google.com> wrote:
> On Wed, Apr 28, 2021 at 10:40 AM Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Apr 28, 2021 at 06:28:47PM +0100, Catalin Marinas wrote:
> > > On Fri, Apr 23, 2021 at 01:51:59PM -0700, Bill Wendling wrote:
> >
> > > > Since the note.gnu.property section in the vDSO is not checked by the
> > > > dynamic linker, discard the .note.gnu.property sections in the vDSO.
> >
> > > Can we not instead fix the linker script to preserve the
> > > .note.gnu.property, correctly aligned? It doesn't take much space and
> > > while we don't use it now, it has the BTI information about the binary.
> >
> > > Cc'ing a few others who were involved in the BTI support.
> >
> > Not just BTI, we also flag PAC usage in there too and could add other
> > extensions going forwards.  While the note isn't actively used by
> > anything right now due to the kernel mapping the vDSO prior to userspace
> > starting it is part of the ABI and something could end up wanting to use
> > it and getting confused if it's not there.  It would be much better to
> > fix the alignment issue.
>
> If there's only one of the 8-byte aligned sections guaranteed, we
> could place it first in the note. Otherwise, we will have to change
> the alignment of the note (or somehow merge multiple notes).
>
I should have clarified that there's only one *entry* in the
.note.gnu.properties section, and if not then is it possible to merge
multiple entries into one. (Excuse my ignorance if this is already the
case.)

-bw
