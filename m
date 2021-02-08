Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C997313E7E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhBHTIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbhBHRsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:48:15 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E42C06178C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 09:47:34 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l18so9210518pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 09:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EG70JcTg+HXJQVcl1iMme19NSe9O1PuL3y6mzQOJh0c=;
        b=nrwV5PcQns4BqCIdHzHixrjqF6qcar1G2sRBbSa/xIQc3DGUH0tjSPE8paL2Mlx9Lb
         Kc3zVnEdFlV5JvhTWgAs1k9GDXUTSS7w6b1LN8ZdC2PSfY2wE4xE47Dv3kx5zb6DL6F3
         VJWd5hymvmtGQ3H2DkOE1Lyg6APb2xKwAazDVgI45lZ3qvDoQ1NfEiiDGEYyRsBtZXy4
         j9BpfjQfoZZ6eMlcTH37Cy0RhDvU+sYDgjHliOPA4mkYErR9kyWlb3B0Utc6pOPkKash
         5wgDPzbyErzJarnEzMJcwB+IbqwJEugPzMa/2MLvVr9jMG4E0n05qwFStOmLFz4j1Wu0
         wH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EG70JcTg+HXJQVcl1iMme19NSe9O1PuL3y6mzQOJh0c=;
        b=jFYVZxGkTeajQpKxIqwgY4BzWU9yPY9gD1SWm0PlwzsITnVU2QIIjVCOeF4pSxd3C5
         D6XbI4pUFBrwSP8ZrcVeMy/66aBzVgAVSC5g5FmAEeEZcQOYFIWblZYcX9oC/CjVUhIA
         vfA3oeyAW2pf9YjkpNSQeffFS9fwe5DgaQ1ICw9QZAR47n8iqbPjf2lVCLywZdW5qD6G
         BpYoCRwyy/ZvyEPacARNr9YIxeHGAJGQT2IDuccrbFYJMi8dNeGqz1BJxerKj7+tbf/m
         zNX/Y6rXf4+DDqA5GWOEwFzsYhwDw9+Z+K28QEZ7wV4PgWJsvfQxovgWVMHOpb84aE/E
         B1Ew==
X-Gm-Message-State: AOAM53381d8VGWHvOehFrKJyZzCFf2nvmGjAtfZXLgy/CLRLvpmVZmbQ
        8he9tf//33F7js7yOhQa9JKCOA==
X-Google-Smtp-Source: ABdhPJwf2xeHH5Yabbzij86gBlzZAvfWiFM2pXUnAdK6NyvoHLlciCGixWdWGpl9VmGISiFlCdg4wQ==
X-Received: by 2002:a17:902:e74b:b029:df:e5d6:c35f with SMTP id p11-20020a170902e74bb02900dfe5d6c35fmr17144345plf.57.1612806454181;
        Mon, 08 Feb 2021 09:47:34 -0800 (PST)
Received: from google.com ([2620:15c:f:10:e4db:abc1:a5c0:9dbc])
        by smtp.gmail.com with ESMTPSA id w124sm234757pfw.176.2021.02.08.09.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 09:47:33 -0800 (PST)
Date:   Mon, 8 Feb 2021 09:47:27 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v1 09/26] x86/tdx: Handle CPUID via #VE
Message-ID: <YCF5LyZCIXkLV9ln@google.com>
References: <f81afd12-91ed-27c9-58d6-e59e7e1178c0@intel.com>
 <0A886D87-1979-419C-86DE-EA2FABDFF3EB@amacapital.net>
 <YCFwo5tD3Jad6F69@google.com>
 <CALCETrWC8qEFuUBdknaU-u_BbB1+HEibAKSjygH_bX0fYR1hYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWC8qEFuUBdknaU-u_BbB1+HEibAKSjygH_bX0fYR1hYg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021, Andy Lutomirski wrote:
> On Mon, Feb 8, 2021 at 9:11 AM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Sun, Feb 07, 2021, Andy Lutomirski wrote:
> > >
> 
> > > How much of the register state is revealed to the VMM when we do a TDVMCALL?
> > > Presumably we should fully sanitize all register state that shows up in
> > > cleartext on the other end, and we should treat all regs that can be modified
> > > by the VMM as clobbered.
> >
> > The guest gets to choose, with a few restrictions.  RSP cannot be exposed to the
> > host.  RAX, RCX, R10, and R11 are always exposed as they hold mandatory info
> > about the TDVMCALL (TDCALL fn, GPR mask, GHCI vs. vendor, and TDVMCALL fn).  All
> > other GPRs are exposed and clobbered if their bit in RCX is set, otherwise they
> > are saved/restored by the TDX-Module.
> >
> > I agree with Dave, pass everything required by the GHCI in the main routine, and
> > sanitize and save/restore all such GPRs.
> 
> Sounds okay to me.

One clarification: only non-volatile GPRs (R12-R15) need to be saved/restored.

And I think it makes sense to sanitize any exposed GPRs (that don't hold an
output value) after TDVMCALL to avoid speculating with a host-controlled value.
