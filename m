Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B564C31B257
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 20:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhBNTzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 14:55:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:42380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhBNTzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 14:55:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D6A064E64
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 19:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613332506;
        bh=fOho7G1cVTuDwmrGQ/ZxbP6bqnmh0teCq4WFoGAu3Ak=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EV1JLZuGyY0/d12dNOzYIehuHPJbPYcayzWcToJUTnK4nyQj+CsTPWQ0HBA20Zum2
         0Ip/fGkvUUOENXDwmvbwVXCwq2GoacID27xkv0GhoqF/fHPpMqCrUFzKYYO/CRwAxA
         sBsF+QhAAGX3c2xTgTk6RBt2qYgSn97LkNkaQXZGsq/Fnnk3ink8y6dhiuc8aJ5Ytr
         3G0+CO/zp38eBVRq/uFS1QAfMT7j7pcBlUu+z8957F11mRTAHcfcYGJ9yzEIrZZuZy
         scIkTcOovtB0ITp5+L6p/qnaZ2hRdEYyuYl8Z84VFlKrydFYcepP/yZQDC+GHkXoz9
         eC/fREdV+TCDQ==
Received: by mail-ed1-f45.google.com with SMTP id g3so3300211edb.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:55:06 -0800 (PST)
X-Gm-Message-State: AOAM533yj7xEmaxKgXriKaLktuCTJOcgwixqDhpLG06rJa3qQI1H0evY
        SLS/GhyxJRHWn9L/ovXqF1m1yNLw1LMrE+3zeXhI5A==
X-Google-Smtp-Source: ABdhPJwsznfo1JxuneQA6tEySA1VZy5/4vy5ABAsRDAuHyPuNse+EHjsaAl9fE1LtKl7a3HV8fvvjS7tYLwXW+3f6k8=
X-Received: by 2002:a05:6402:3585:: with SMTP id y5mr12399375edc.97.1613332504559;
 Sun, 14 Feb 2021 11:55:04 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrWPCTmoeFBEJvw98zwNpw316Xii_16COZAWoYNC=obF+w@mail.gmail.com>
 <YCbfyde9jl7ti0Oz@google.com> <8c23bbfd-e371-a7cf-7f77-ec744181547b@intel.com>
 <YCbm/umiGUS7UuVb@google.com> <514734d9-d8be-03ee-417e-4d0ad2f56276@intel.com>
 <YCbq+UEMIsE0NIWI@google.com> <7d0b08c4-5ae7-f914-e217-767a9fae7b78@intel.com>
 <YCb0/Dg28uI7TRD/@google.com> <CALCETrUnOVvC4d8c_Z=5ZDefAo+0t6-9hadttOjTypJykN6_3A@mail.gmail.com>
 <caa0b029-038c-cb59-6a69-70c84922fc6f@intel.com> <20210214193320.GH365765@tassilo.jf.intel.com>
In-Reply-To: <20210214193320.GH365765@tassilo.jf.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 14 Feb 2021 11:54:53 -0800
X-Gmail-Original-Message-ID: <CALCETrU9XypKbj-TrXLB3CPW6=MZ__5ifLz0ckbB=c=Myegn9Q@mail.gmail.com>
Message-ID: <CALCETrU9XypKbj-TrXLB3CPW6=MZ__5ifLz0ckbB=c=Myegn9Q@mail.gmail.com>
Subject: Re: [RFC v1 05/26] x86/traps: Add #VE support for TDX guest
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 11:33 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Fri, Feb 12, 2021 at 01:48:36PM -0800, Dave Hansen wrote:
> > On 2/12/21 1:47 PM, Andy Lutomirski wrote:
> > >> What about adding a property to the TD, e.g. via a flag set during TD creation,
> > >> that controls whether unaccepted accesses cause #VE or are, for all intents and
> > >> purposes, fatal?  That would allow Linux to pursue treating EPT #VEs for private
> > >> GPAs as fatal, but would give us a safety and not prevent others from utilizing
> > >> #VEs.
> > > That seems reasonable.
> >
> > Ditto.
> >
> > We first need to double check to see if the docs are right, though.
>
> I confirmed with the TDX module owners that #VE can only happen for:
> - unaccepted pages

Can the hypervisor cause an already-accepted secure-EPT page to
transition to the unaccepted state?  If so, NAK.  Sorry, upstream
Linux does not need yet more hacks to make it kind-of-sort-of work on
the broken x86 exception architecture, especially for a feature that
is marketed for security.

As I understand it, the entire point of the TDX modular design is to
make it possible to fix at least some amount of architectural error
without silicon revisions.  If it is indeed the case that an access to
an unaccepted secure-EPT page will cause #VE, then Intel needs to take
the following actions:

1. Update the documentation to make the behavior comprehensible to
mere mortals.  Right now, this information appears to exist in the
form of emails and is, as far as I can tell, not present in the
documentation in a way that we can understand.  Keep in mind that this
discussion includes a number of experts on the software aspects of the
x86 architecture, and the fact that none of us who don't work for
Intel can figure out, authoritatively, what the spec is trying to tell
us should be a huge red flag.

2. Fix the architecture.  Barring some unexpected discovery, some
highly compelling reason, or a design entailing a number of
compromises that will, frankly, be rather embarrassing, upstream Linux
will not advertise itself as a secure implementation of a TDX guest
with the architecture in its current state.  If you would like Linux
to print a giant message along the lines of "WARNING: The TDX
architecture is defective and, as a result, your system is vulnerable
to compromise attack by a malicious hypervisor that uses the
TDH.PAGE.MEM.REMOVE operation.  The advertised security properties of
the Intel TDX architecture are not available.  Use TDX at your own
risk.", we could consider that.  I think it would look pretty bad.

3. Engage with the ISV community, including Linux, to meaningfully
review new Intel designs for software usability.  Meaningful review
does not mean that you send us a spec, we tell you that it's broken,
and you ship it anyway.  Meaningful review also means that the
questions that the software people ask you need to be answered in a
public, authoritative location, preferably the primary spec publicly
available at Intel's website.  Emails don't count for this purpose.

There is no particular shortage of CVEs of varying degrees of severity
due to nonsensical warts in the x86 architecture causing CPL 0 kernels
to malfunction and become subject to privilege escalation.  We are
telling you loud and clear that the current TDX architecture appears
to be a minefield and that it is *specifically* vulnerable to an
attack in which a page accessed early in SYSCALL path (or late in the
SYSRET path) causes #VE. You need to take this seriously.

--Andy
