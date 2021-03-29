Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9D434D436
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhC2PoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:44:24 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:33590 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhC2PoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:44:12 -0400
Received: by mail-ed1-f45.google.com with SMTP id w18so14831746edc.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 08:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARY1tt7Z2fm1BA03rp3wXrVNMntpKVDtYEkyEcqsAso=;
        b=We8zSVYqWLkVCPN7dUYta2RC3Fxzjtrulx/CGBPuJY18Sdqs+cBicnaj1hiJLqlKWE
         qgXKoQFClSkf6UKEtVTmE1o/2PvZa4Dt0DcQDZMUdE9Ec2EUwYrI2V+GnJ/AvKNaZhk3
         Gw7FpnL98ij1LFr4ifBnBdhfRBwkG3fHxidbBU8K8d4QD24WcNHSH8+x/HobtmtLpffk
         cGlsVkEeM9jjBJTZ/lP4qOSesNfVMGM+xBd6lnyBq9Ef5YeHKs3l6ZqnccR1RhzoGNzQ
         00a7yuDa+ytaCfpL+cFUoCzYfk4GG5uUzeLA1adV0FZFjknhE1mv/wOnj49k2EQrLVPV
         V+HA==
X-Gm-Message-State: AOAM5310yM0HjcGxYWNnQUm0e8hYhzLN78FZ3MOlLJ46/2CSGYVVya1Y
        UMsD2OjbKqDs6BJcwAlkjVPSZ5YUolBy4AsfBok=
X-Google-Smtp-Source: ABdhPJw8Z0EZzhuSUXX7k89nLHSMaMDKkYQALqwFILzJmM9ySjfTNvypMuX9POD5Fy8rHW0WH565wBmsrsOGGDxLCHw=
X-Received: by 2002:a05:6402:1613:: with SMTP id f19mr29568445edv.222.1617032651152;
 Mon, 29 Mar 2021 08:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-15-chang.seok.bae@intel.com> <87o8fda2ye.fsf@nanos.tec.linutronix.de>
 <CAJvTdKkZEWTsqhXLC+qiQ49c2xn7GDF95PfTBi0rw1FnE--JKQ@mail.gmail.com> <87r1jyaxum.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87r1jyaxum.ffs@nanos.tec.linutronix.de>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 29 Mar 2021 11:43:59 -0400
Message-ID: <CAJvTdKnBRmogm6zF0KyDtx1VC_bpRa8_H1P9mxtMP06fy8a57g@mail.gmail.com>
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the
 first use of dynamic user state
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 9:33 AM Thomas Gleixner <tglx@linutronix.de> wrote:

> > I found the author of this passage, and he agreed to revise it to say this
> > was targeted primarily at VMMs.
>
> Why would this only a problem for VMMs?

VMMs may have to emulate different hardware for different guest OS's,
and they would likely "context switch" XCR0 to achieve that.

As switching XCR0 at run-time would confuse the heck out of user-space,
it was not imagined that a bare-metal OS would do that.

But yes, if a bare metal OS doesn't support any threading libraries
that query XCR0 with xgetbv, and they don't care about the performance
impact of switching XCR0, they could choose to switch XCR0 and
would want to TILERELEASE to assure C6 access, if it is enabled.

> > "negative power and performance implications" refers to the fact that
> > the processor will not enter C6 when AMX INIT=0, instead it will demote
> > to the next shallower C-state, eg C1E.
> >
> > (this is because the C6 flow doesn't save the AMX registers)
> >
> > For customers that have C6 enabled, the inability of a core to enter C6
> > may impact the maximum turbo frequency of other cores.
>
> That's the same on bare metal, right?

Yes, the hardware works exactly the same way.

thanks,
Len Brown, Intel Open Source Technology Center
