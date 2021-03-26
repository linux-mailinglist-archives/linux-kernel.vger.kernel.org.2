Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE7534AB78
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhCZP1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:27:47 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:33342 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhCZP1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:27:33 -0400
Received: by mail-ej1-f42.google.com with SMTP id k10so9070682ejg.0;
        Fri, 26 Mar 2021 08:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CsvTmaNAD+JZrfh5r3rTSTh1rpmcrxqU66s7Dv3Gkbc=;
        b=n6rfuhxBOr6U36vv91n2Iwiz0iL+xDyXds6Z+NczzAdx96UlVIoVf7viSuXZGW+Z6d
         D7am5fTfCqRJinkAlegfRDwTw5uoxuKBgQkVrXd2IuQQXW6Spa7Tlk7PLRAvx0e2dfYW
         Zw7IpT4o7N54RmIP93C6be4oQxV539ihK8J2AqQOoE5ZAJ6ywAPgBKExakfMJWCEd3o7
         oQyRI2BWAXIesbPW+3Ap/Nz7Po5Ite/gj2d8G/5tkrI3Nnti76fRDT6CNXbtL0BA0uyJ
         6BG8sJrpW/qcSpzGj53iTOW5SN/t4TtF3+IiE06cdh+nvbhdbD+Fi6p/DUI6YPwVW0y7
         1jow==
X-Gm-Message-State: AOAM532syNrsBvijHVPSMwXKRQLKJf30cAer7PZdWV9XUi8uc3YE1xsv
        TINlM7sQZw30bhTv6MpYHe5kqLjMHDb1GN9EMiujA1wt
X-Google-Smtp-Source: ABdhPJyFlw7rGrbUJFQ4KQwktBppReA8rH3lAxc1L6Lop8M+D8rVfU1AuaGVizQy1Tm1K2rwqAwvBOS8Mf3XBUZqRss=
X-Received: by 2002:a17:906:340f:: with SMTP id c15mr2779781ejb.317.1616772452060;
 Fri, 26 Mar 2021 08:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-23-chang.seok.bae@intel.com> <871rc9bl3v.fsf@nanos.tec.linutronix.de>
 <CAJvTdKkOKOgnmvAiPS6mWVoyAggbOB6hBOqb_tcHYDe8+-X+FQ@mail.gmail.com> <b1a8f92d-fd82-6e86-93ff-4ac200080d8c@intel.com>
In-Reply-To: <b1a8f92d-fd82-6e86-93ff-4ac200080d8c@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 26 Mar 2021 11:27:20 -0400
Message-ID: <CAJvTdKk-d2rpsAYiPg7iJNZ=sEyhjBnGrT3Hy8Mt5G1TkEJRDw@mail.gmail.com>
Subject: Re: [PATCH v4 22/22] x86/fpu/xstate: Introduce boot-parameters to
 control state component support
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 7:10 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 3/25/21 3:59 PM, Len Brown wrote:
> > We call AMX a "simple state feature" -- it actually requires NO KERNEL ENABLING
> > above the generic state save/restore to fully support userspace AMX
> > applications.
> >
> > While not all ISA extensions can be simple state features, we do expect
> > future features to share this trait, and so we want to be sure that it is simple
> > to update the kernel to turn those features on (and when necessary, off).
>
> From some IRC chats with Thomaas and Andy, I think it's safe to say that
> they're not comfortable blindly enabling even our "simple features".  I
> think we're going to need at least some additional architecture to get
> us to a point where everyone will be comfortable.

Hi Dave,

There is no code in this patch series, including patch 22, that enables
an unvalidated feature by default.

Yes, I fully accept that patch 22 allows a user to enable something
that a distro didn't validate.

If there is a new requirement that the kernel cmdline not allow anything
that a distro didn't explicitly validate, then about 99.9% of the kernel cmdline
options that exist today would need to be removed.

Does such a requirement exist, or does it not?

thanks,
-Len
