Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6C5362AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 23:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhDPVzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 17:55:24 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:34587 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDPVzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:55:22 -0400
Received: by mail-ej1-f44.google.com with SMTP id x12so23397421ejc.1;
        Fri, 16 Apr 2021 14:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNYtdO/g+6WIOvgKoAiURTxI1+VyUIZi9jzIsXvYayY=;
        b=rfvOqXrz7rkqVBa+rMVtyq2bieLDCBUDwVb0xpP5NSzjJpR+4Lb6BX2xXtFMAPP9yT
         UAyX/O5Ftc4GQqCaR0OgS5mkYkilI0ZRK4Ln95X8PzKazAEiztUoxR/tOEJF9e9JmdGd
         lAFjDS2YSkaLt9eSReVPHm+tuzirk8dmjBPxfatydXeucEw7qTh9ucKxbig5eoHwxRst
         mrXFDsP+YAKdHFUPC5SagrZPmkA3JHvXYMrrIcnlCkyB7fPrslaD127LkTWxQtBQP1WH
         LPfaJMw8KG+1OoiWigu7JoevuYSiect4Fv9ECMQA0U9omdhZSPDSCvUk2IJMZeCWPw4j
         1YhQ==
X-Gm-Message-State: AOAM531iFKQrbFtKcSv3ks5MQg+LPgs/AM65yad7gA2PJVuUknbJPBE6
        Q3f1NwK9P6M9mP1lV0M6aKFsCxnm4yWIZPNLuCQ=
X-Google-Smtp-Source: ABdhPJzgJhf2hIDGFAQD7G2Z5O1wvhp1n/pe27/t1Yx4f1F57Iue6J1BFx/xuzfQOCf52uleJqaVfnath2zdZczHv/M=
X-Received: by 2002:a17:906:ca45:: with SMTP id jx5mr10461248ejb.417.1618610094953;
 Fri, 16 Apr 2021 14:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com> <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
 <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
 <CALCETrVvapzL79BQNEvOupMHHzriR+n97955tRA+TPE6rgRC4Q@mail.gmail.com>
 <CAJvTdKmDb3TOHbb4w1YNcdYH2Pzr+RsAS_o0q3AFP1Xz55R37g@mail.gmail.com>
 <CALCETrUe4_DvSdq7CRJsUxZm8DSwfHevagxJEbHv88UjcC1Hkg@mail.gmail.com>
 <CAJvTdKmppOcyy=akSo3+dn0KN5GmOKLK5cp3eZ_ymujE-=ExwQ@mail.gmail.com> <CALCETrUxc1Y=4XmNthSSCeQfJ_SKNS762Nt3B-CynE-rhRSBGw@mail.gmail.com>
In-Reply-To: <CALCETrUxc1Y=4XmNthSSCeQfJ_SKNS762Nt3B-CynE-rhRSBGw@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 16 Apr 2021 17:54:43 -0400
Message-ID: <CAJvTdKmDskNka9tm5TMZkkP8tYa-K01sz8hAMccRSaAYKNPz5Q@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>, Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 12:24 PM Andy Lutomirski <luto@kernel.org> wrote:
> On Wed, Apr 14, 2021 at 2:48 PM Len Brown <lenb@kernel.org> wrote:

> > > ... the transition penalty into and out of AMX code

The concept of 'transition' exists between AVX and SSE instructions
because it is possible to mix both instruction sets and touch different
parts of the same registers.  The "unused" parts of those registers
need to be tracked to assure that data is not lost when mixing.

This concept is moot with AMX, which has its own dedicated registers.

> What is the actual impact of a trivial function that initializes the
> tile config, does one tiny math op, and then does TILERELEASE?

1. Task takes #NM on first touch of TILE registers
2. Kernel allocates 8KB for that task and dis-arms XFD
3. Kernel context switches XFD with task state

If the task takes a signal *before* TILERELEASE
4. XSAVE transfers AMX state to signal stack, XRESTOR the reverse.

If the task context switches *before* TILERELEASE
5. kernel context switch XSAVES the AMX state to 8KB context switch
buffer, XRESTORE the reverse.

If the task takes a signal *after* TILERELEASE
4. XSAVE does NOT transfer AMX state (or zeros) to signal stack, 8KB
is consumed on signal stack but not touched.  XRESTOR, the reverse.

If the task context switches *after* TILERELEASE
5. kernel contexts switch ignores INIT=1 AMX state.  8KB buffer is quiescent.

As we discussed previously,  there is no impact to frequency from
either INIT=0 or INIT=1 AMX state.
Frequency is impacted by *compute*, and since there isn't any compute
this scenario, there is no frequency impact.

As we discussed previously, for INIT=1 (which the kernel guarantees,
there is also no impact on power.

thanks,
Len Brown, Intel Open Source Technology Center
