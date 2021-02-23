Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4FD32349C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 01:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhBXAZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 19:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbhBWXuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:50:18 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDA4C06178A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:42:06 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id e6so234747pgk.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XmdEFwlRSgTwWjhTIOCD45ph+gJBk6ITkuI62uYBDIg=;
        b=eXy+FB07yVuJ6/cjvt5/xXTNB5HkilzciwQ3E62QYNk88ggJ5p4xodew9wvHKDwQW2
         MUjiv3z8KgJ1243MREGKwB37pRozEyiSkhGqmEt+F02HjduI5yhia6e0KDoI3Ykfed90
         K791jSCktesKHq8oeNRISv5v8RnPu2YH7lrhw6WukXGiuNXQ61LwWb/BgZ3+44mWeXUt
         MprZjNzRJ09BhYQBoRiFfLnJhQRuitckB7jXR8bpTpEe2vCzKi8MvNXDfDiH+FzzPoi6
         IdZfv7qhWY4zoDEQ/rlC6p6qQQALcyFsiAc01hpUQvmTn4FyP6L2f5BWMUtaIWQH7YIi
         fEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XmdEFwlRSgTwWjhTIOCD45ph+gJBk6ITkuI62uYBDIg=;
        b=oEnKCbD5ibnuFnEJyI1jecBMzOZMR/AUMX9SDQJedlhyX8bLjGOJAbIkOHZRy0B6ZU
         471jC1Vy7hNQ9qui3JlsV00mJQcRGo/RsmULYwxayzUAugGYT9KIlvwD74VekcKJy3aR
         0ZsaN3WOAi0b6XrtfkWhYodK+csU6X0kbslu0vGRxrfGtdLG6LFIQwSfhVIYF/oqyLQF
         r4N1a7tMhQZ3dC8hSuZRNSVbnIb7I3QJWlPDbrDbD7sbyqq8rqUPlUojI9bZ5Itwq1Bf
         w5tCSlWeGh/iUkXg1VbpLOchK3Jrq3DmfcfjSwBuMfOOuxGsEtbW4notN8Z2BPUh/G1+
         e+Sg==
X-Gm-Message-State: AOAM533MvBTPN84GTObUy1H6K8y0sOIz7tdnRDDTmADOOEiaE+BYFe8/
        DOLdTbOABWd/5uwxdXG2Cefhpw==
X-Google-Smtp-Source: ABdhPJw0H/0JO4IDoJrNMO3b+L5jJU62/Ziwu57iowle9OzZNgacqILcHibge23EoOYkCUkn0n2HVQ==
X-Received: by 2002:a63:da4a:: with SMTP id l10mr26339797pgj.222.1614123726083;
        Tue, 23 Feb 2021 15:42:06 -0800 (PST)
Received: from google.com ([2620:15c:f:10:385f:4012:d20f:26b5])
        by smtp.gmail.com with ESMTPSA id c22sm297716pfc.12.2021.02.23.15.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 15:42:05 -0800 (PST)
Date:   Tue, 23 Feb 2021 15:41:58 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     David Edmondson <david.edmondson@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: dump_vmcs should not assume
 GUEST_IA32_EFER is valid
Message-ID: <YDWSxqOODX4RYTeP@google.com>
References: <20210219144632.2288189-1-david.edmondson@oracle.com>
 <20210219144632.2288189-2-david.edmondson@oracle.com>
 <YDWG51Io0VJEBHGg@google.com>
 <CALMp9eQ5HQqRRBu0HJbuTOJwKSUA950JWSHrLkXz7cHWKt+ymg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eQ5HQqRRBu0HJbuTOJwKSUA950JWSHrLkXz7cHWKt+ymg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021, Jim Mattson wrote:
> On Tue, Feb 23, 2021 at 2:51 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Fri, Feb 19, 2021, David Edmondson wrote:
> > > If the VM entry/exit controls for loading/saving MSR_EFER are either
> > > not available (an older processor or explicitly disabled) or not
> > > used (host and guest values are the same), reading GUEST_IA32_EFER
> > > from the VMCS returns an inaccurate value.
> > >
> > > Because of this, in dump_vmcs() don't use GUEST_IA32_EFER to decide
> > > whether to print the PDPTRs - do so if the EPT is in use and CR4.PAE
> > > is set.
> >
> > This isn't necessarily correct either.  In a way, it's less correct as PDPTRs
> > are more likely to be printed when they shouldn't, assuming most guests are
> > 64-bit guests.  It's annoying to calculate the effective guest EFER, but so
> > awful that it's worth risking confusion over PDTPRs.
> 
> I still prefer a dump_vmcs that always dumps every VMCS field.

I'm a-ok with that approach.
