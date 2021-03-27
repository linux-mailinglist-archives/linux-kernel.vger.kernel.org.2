Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9C634B446
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 05:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhC0Emf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 00:42:35 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:39877 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhC0Elz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 00:41:55 -0400
Received: by mail-ej1-f49.google.com with SMTP id ce10so11421025ejb.6;
        Fri, 26 Mar 2021 21:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rW6IWmw3bAY+7I4axD3cCqiKwmk5Vb6mpW550G67qek=;
        b=dHAZnch3ODzFGca02JZ+qHhbcvViLtlpiEXEeZsD9Pp2VelbgO+35S0FLpgtUvuTR2
         b1GRmFeugGNF+bZYjD88Gi8cWKWn3UPjtTvU9CgKMiMXWuL1cm77Z8UX+Cn+3nBNEI8H
         XanpMeOqlvQXtOYbiojSM11sDRWo9LmxwqEIIcBMTvSUbUluBuH+qTyF8IOdzbpb62m9
         Udxguho6disjdiCYgzf1M21iDNudGUCgaSaPv4wxkisidmcjJNDJAH4iSdfk4NJJSDKC
         cAi8Q61bV3z0dS8S3hTGrSEn9s8XTyZCmG5yFainyPGr+lDmcLHu761ANG4ZInsbJjys
         U1ew==
X-Gm-Message-State: AOAM533Wq992FyXjANsIoc5DVMcmwWLmZkcvZwIk5og89+WFOXFiKz9h
        /r/T/jIOibmYe/8ix0KAXkj4dkbupJMz63EDzic=
X-Google-Smtp-Source: ABdhPJwchzUeuO7nwhZRNhfFlo0xto2pedUGrvaQ5JsN+Q4JVohbPScXOer60hKq42S2jad7HChK4a5meQdUfRdYvqI=
X-Received: by 2002:a17:906:4055:: with SMTP id y21mr18359714ejj.507.1616820114401;
 Fri, 26 Mar 2021 21:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-23-chang.seok.bae@intel.com> <871rc9bl3v.fsf@nanos.tec.linutronix.de>
 <CAJvTdKkOKOgnmvAiPS6mWVoyAggbOB6hBOqb_tcHYDe8+-X+FQ@mail.gmail.com>
 <CALCETrWOc7wwW=KY2dGJGy9k5Ag=KhkdGGTDZMvgRHgyQ5fDjQ@mail.gmail.com>
 <CAJvTdK=OGALDso0H+asjgkjD_VaPNZzm+LpV+msM_i5aVUm_qw@mail.gmail.com>
 <CALCETrXky0RuA5WeQ0Mxjs+e4ywk1A7vmpBxqCo=PTSBzUsz-g@mail.gmail.com>
 <CAJvTdK=_G11phL6=9Ri41fJQvhRNopok_oktgvRjTM0v6ojcbg@mail.gmail.com> <20210326181641.GD27507@zn.tnic>
In-Reply-To: <20210326181641.GD27507@zn.tnic>
From:   Len Brown <lenb@kernel.org>
Date:   Sat, 27 Mar 2021 00:41:43 -0400
Message-ID: <CAJvTdKmPBYcSVpZc=hDecOApOy-gWkuT304cS4U37XSjpMH8aw@mail.gmail.com>
Subject: Re: [PATCH v4 22/22] x86/fpu/xstate: Introduce boot-parameters to
 control state component support
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 2:17 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Mar 26, 2021 at 01:53:47PM -0400, Len Brown wrote:
> > At Dave's suggestion, we had a 64 *KB* sanity check on this path.
> > Boris forced us to remove it, because we could not tell him
> > how we chose the number 64.
>
> The only 64 I can remember is
>
> #define XSTATE_BUFFER_MAX_BYTES              (64 * 1024)
>
> What does an arbitrary number have to do with signal handling and
> pushing a fat frame on the sigaltstack?

You are right.  If that is where the check was, it was the wrong place.
It should be part of that sanity check code where CPUID is parsed.

thanks,
Len Brown, Intel Open Source Technology Center
