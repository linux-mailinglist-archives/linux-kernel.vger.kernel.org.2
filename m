Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D511C3FCF40
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 23:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240755AbhHaVpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 17:45:09 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:40862 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbhHaVpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 17:45:08 -0400
Received: by mail-ej1-f52.google.com with SMTP id lc21so2018875ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 14:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qj80+5X0Hk9qELCGgLDzAFTVAS9vfZCgqLfK/Rlubo0=;
        b=X9vZXfyfVxz3+EReFx0SAn3pOxIw64Wju94QJf20gzuhzlB/i+s5H+3WoYU44cc0QQ
         mqUsijbQiaAkgC1qR8xkfoAVEw7Z75KON6Eub93vVJ8U6wUDkgfiZoZwu663gOdE31+M
         stdDU7r7VPJbEuY6ua0I4d6yPVeNgGxeq3AJEmTZE74OZlfiITLDdpJXBoY+lmSKT+0o
         DfRV1WmU2eRZ9wS14UvhOWGhp29GzOS6igYWmgjjCGStLr2A2sapGan0mt7JiRaHRI5O
         yW3eyqcgKLtgt7tE7Ad2L7219EAvkZRTLZUimVutUD1VlQU7nNrywMO2TOUQ9AqPeBSq
         nrJw==
X-Gm-Message-State: AOAM530tcoveBHbvtqBLouKoi/SeqsGEcwuFaeNHk2omja7nV9LadEeP
        eHXr09ED5zu4OyGXI7XxU132P/7ydJ3kBfVonGo=
X-Google-Smtp-Source: ABdhPJwxSifo6H+uuUybemBu/VPfQKWpOjD9FKYiD3F085y15Jx8p8MxOp0Ef1VwKzmay1FDLQ0kKcGcY/DqPlIo0nw=
X-Received: by 2002:a17:906:31ca:: with SMTP id f10mr34268591ejf.73.1630446251978;
 Tue, 31 Aug 2021 14:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-13-chang.seok.bae@intel.com> <YR00U19168BGoRB9@zn.tnic>
 <CAJvTdKk6kh3yT==FFRJ0RXDSrpnWecOo06EAEgHctnWbwTg50Q@mail.gmail.com> <YS0YZZFyy0Z7slk6@zn.tnic>
In-Reply-To: <YS0YZZFyy0Z7slk6@zn.tnic>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 31 Aug 2021 17:44:00 -0400
Message-ID: <CAJvTdKknsU3=a=3aiK9nHH_2X6Asgu0vYSrkL-sCj4PdEfGhfg@mail.gmail.com>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, thiago.macieira@intel.com,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 1:41 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Aug 24, 2021 at 06:21:23PM -0400, Len Brown wrote:
> > MSR_IA32_XFD and MSR_IA32_XFD_ERR are architectural.
> >
> > (which is why they follow the convention of having an "IA32" in their name)
>
> Where is that official statement I can refer to that says that MSRs with
> "IA32" in the name are architectural?
>
> Perhaps that section of the SDM:
>
> "2.1 ARCHITECTURAL MSRS"

Yes.

> In any case, those MSRs are not there yet, maybe they need to trickle
> from the ISA to the SDM docs at some point first.

Right.
These new MSRs are already named IA32... even though the info from
the ISA Extensions Manual hasn't yet tricked into the SDM, because
they are defined to be architectural from the get-go.

Len Brown, Intel Open Source Technology Center
