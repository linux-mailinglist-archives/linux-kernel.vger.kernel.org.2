Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D57232A13A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239607AbhCBFOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 00:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573578AbhCBDXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 22:23:55 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91706C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 19:23:15 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id b189so3950153vsd.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 19:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TPNrexzQzCuWVjxpMUICIUQCQbw5ciDHkJDXnFaj/PI=;
        b=Jj0ye+OIwQwqHjgxs32zgUqchMQ6+t8j812dJy3H2zUqcxInJvzLi/mZLFApOYuIwA
         iH+NqsJm7KQqeBBtYE+X3reshyqFKHdaw+Z08I5CqAc5hkxeMddrx22yGTfT898CC6xe
         8XrUL1G4TO84o2MC2kO0xD72izKJ/Ejgyr8BSRCrMLF2sYfApIHX8EroQC/sH7+1/87H
         EjjBNl5Ed9eFJE6R+0eeqxsuka0hi2b2aRiDrQa0nwS5cFxLepcYkbpwbJNBD7zdr6F2
         vquoJvQsA4ogXIA7u2WgANiTDkxcUz21O6GR6D0/OcexP/K2EqISWugYjxqBxa+1R2GQ
         sjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TPNrexzQzCuWVjxpMUICIUQCQbw5ciDHkJDXnFaj/PI=;
        b=L4+7jIkMlg8DVmDmwIJzHSsWBHhYMPjJmIGGPXptcnhuCHh60RxHndNUZkldDsmLM7
         74fKtjK6p5yoHATV0GMwQDkE+Z1nRdyjHmGSCi2o2ifbrGGnHngZOESqSK7C8lrVd/qF
         lnG9YA7Tefmj+c/6HTyfTgW3MZi0hsueRAnqAHv3lsl2q0kbwvyJc9UbwdoMLAKhW6in
         5inApt+cttpO35x17MLYAuCZz87XZsC8S/w6vePg5wYzdYjD7hn0CXh2lXI8JzINK8HR
         nmxSSW2xBYg28599JQ7WcOELiT+JJ3TchdWojWyQQuJBHNIy+HiaEbDX73P2LosY/ucK
         N1Tw==
X-Gm-Message-State: AOAM530MpJslGiU/UFTLTgrI2G+FU89DRirhAozbVvf9PHxfsDd4FQDZ
        H3Yd0VR4cK499G1rhBJqtjDFo/KvTU9rmBHi1K0pk84hPUE=
X-Google-Smtp-Source: ABdhPJzF2znXTNQDX5QQGJSLUaS7M8PMT1NHOK2SeMge2PXeaF4+DGJwG3o/fMe1JBJGvYbziOmbuuincu5mh603dlQ=
X-Received: by 2002:a67:ed4a:: with SMTP id m10mr1226275vsp.14.1614655394539;
 Mon, 01 Mar 2021 19:23:14 -0800 (PST)
MIME-Version: 1.0
References: <20210301074027.GD12822@xsang-OptiPlex-9020> <CABCJKuc8H83b_8_Ccp+Cb7O9x5oEu6sPNq63sjGcAJcgiwy0bw@mail.gmail.com>
 <20210301184524.7aa05ac1@gandalf.local.home> <CABCJKudQme=bcNJtNCORUpBnVA_Pkr2Zk_3Nu2EsfnuoE7LJ3g@mail.gmail.com>
 <20210301201526.65ce7f1c@oasis.local.home> <YD2loOkd/AYqKPB6@google.com> <20210301214702.1119c732@oasis.local.home>
In-Reply-To: <20210301214702.1119c732@oasis.local.home>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 1 Mar 2021 19:23:03 -0800
Message-ID: <CABCJKufOTubpoJyWQ5aMzgeiNsTRuO61T5FMEG=jFwnO0XZ-pQ@mail.gmail.com>
Subject: Re: [x86, build] 6dafca9780: WARNING:at_arch/x86/kernel/ftrace.c:#ftrace_verify_code
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 6:47 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 1 Mar 2021 18:40:32 -0800
> Sami Tolvanen <samitolvanen@google.com> wrote:
>
> > On Mon, Mar 01, 2021 at 08:15:26PM -0500, Steven Rostedt wrote:
> > > On Mon, 1 Mar 2021 16:03:51 -0800
> > > Sami Tolvanen <samitolvanen@google.com> wrote:
> > > >
> > > > >                 ret = ftrace_verify_code(rec->ip, old);
> > > > > +
> > > > > +               if (__is_defined(CC_USING_NOP_MCOUNT) && ret && old_nop) {
> > > > > +                       /* Compiler could have put in P6_NOP5 */
> > > > > +                       old = P6_NOP5;
> > > > > +                       ret = ftrace_verify_code(rec->ip, old);
> > > > > +               }
> > > > > +
> > > >
> > > > Wouldn't that still hit WARN(1) in the initial ftrace_verify_code()
> > > > call if ideal_nops doesn't match?
> > >
> > > That was too quickly written ;-)
> > >
> > > Take 2:
> > >
> > > [ with fixes for setting p6_nop ]
> >
> > Thanks, I tested this with the config from the build bot, and I can
> > confirm that it fixes the issue for me.
> >
> > I also tested a quick patch to disable the __fentry__ conversion in
> > objtool, and it seems to work too, but it's probably a good idea to
> > fix the issue with CC_USING_NOP_MCOUNT in any case.
>
> Thanks for testing, I'll make this into a proper patch and start
> testing it internally. I'm assuming you want this to go into the -rc
> release and possibly stable?

Sounds good, thank you. Yes, getting the fix to -rc would be great.
I'm not sure if it's necessary in -stable though, the objtool patch is
only in -rc1.

Sami
