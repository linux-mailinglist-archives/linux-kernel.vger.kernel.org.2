Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9028E3A6E88
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbhFNTGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:06:40 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:39692 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhFNTGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:06:38 -0400
Received: by mail-lf1-f42.google.com with SMTP id p17so22753237lfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iEYOmaWczuFfQkImwxqrXdOlZrbm3xpPMO2bFpeG0wM=;
        b=fOSQmcG3PVq3wF00JgOqcV8GrvIf3ssnAPjyJkX5nhEi7AqouXXwJRy3qpdOewql/Z
         ouIEL8osdg6qe6KX63lktAKS5/U6ICu7nOwqKjQrpbCQYHlfgUiUpbfzPTpo96A7vTNW
         nne4hFVN309bC5FPM80nvl+Tjj9VEhQYqT/v6xhkqkteNZrfVUGBYaHc29IaM7RFjiy+
         DTAtfhl9F1NGTFOO3foUIwRQji5Vtivzb+wUxu6tH5zJbzg9c48Z7cZWo0iJw1esM2mp
         FMNf8mP6EUF7J5uy9I/AUeG5tARA+6CgS1UYy1jEwTj6CA6yF+FtOS9IPK3menDMJYpf
         POag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iEYOmaWczuFfQkImwxqrXdOlZrbm3xpPMO2bFpeG0wM=;
        b=WzOlgMCK9URFPxtrDNXFItrM3rw7LxAp6MY75DjpfcEsptcNXm1KTtofdlyl+w7xeo
         3Q0I3RAjlOr9x82zY7by2Ker0KQQOB0a6p2vQcbdE5wzIrECDPCiG7Ct6Vm9JHtYYWHU
         aDj2IuRtU3APIIwBH/NmIOy4Vj+K0slb/NYe7lLGU+IhCxC2KPVc7TJqnKtMd7AVjx6B
         CMVwgcnb8fHp7MDGEqLDgSpijcyv2WWwuzBddq6YMP483waKk+jEKuwWrF5/HxTDL9oF
         OPK7rK/id6KMhvxD/5lAgwtsbzWVc4QNKqZVJQrahoK8lmAudYZrEkmHKlhEnyYt8oZf
         Ccsg==
X-Gm-Message-State: AOAM5320s8Ej7cqIG38rKBgY2V3VDdryddt2x1e5zOHR4i8PrDrwszuW
        8rKPHAVcqHwngDsUZO5bjW2KyW2sX7yFK53Lsw6KWA==
X-Google-Smtp-Source: ABdhPJxTlVDzkoB3Ktqt4nmgdqXbH/OnHgNc0oGNz0XTro7/H3wybhJwOB12KozxgndUUa6F54nyoCmw6RvQRHwCfnk=
X-Received: by 2002:a05:6512:51c:: with SMTP id o28mr12865111lfb.297.1623697406791;
 Mon, 14 Jun 2021 12:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <YMcssV/n5IBGv4f0@hirez.programming.kicks-ass.net>
 <CAKwvOd=PYrMnNOu060T3Z26RJriNXqu3iM85Daink4-BN__2sQ@mail.gmail.com>
 <20210614162018.GD68749@worktop.programming.kicks-ass.net>
 <CAKwvOdmPTi93n2L0_yQkrzLdmpxzrOR7zggSzonyaw2PGshApw@mail.gmail.com> <YMeeBJKJhddzReGe@zn.tnic>
In-Reply-To: <YMeeBJKJhddzReGe@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 14 Jun 2021 12:03:15 -0700
Message-ID: <CAKwvOdkV8DLKJb7h_=6mUb_V=qdmBaCqNMU8scaBhpqF7yeeMQ@mail.gmail.com>
Subject: Re: [PATCH] gcov,x86: Mark GCOV broken for x86
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 11:21 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jun 14, 2021 at 11:05:35AM -0700, Nick Desaulniers wrote:
> > __attribute__((no_instrument_function)) is already wired to not emit
> > calls to mcount()/fentry().  I think extending it to also apply to
> > coverage (-fprofile-arcs) and instrumentation based profiling
> > (-fprofile-generate) is reasonable.
>
> Is anyone going to ping the gcc folks so that they do it too or should
> we open a bug over there simply?

Yes, I will file a bug (or two) against GCC and then post the links on
the other thread (re: pgo) since that already has the toolchains
mailing list cc'ed.
-- 
Thanks,
~Nick Desaulniers
