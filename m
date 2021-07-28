Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB583D8546
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 03:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhG1BXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 21:23:38 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:57557 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234038AbhG1BXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 21:23:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 759333200754;
        Tue, 27 Jul 2021 21:23:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 27 Jul 2021 21:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=qcOAmK
        Z6XlEpzxajr3df3EJ15DHZZ8RZdgiDKKttjE8=; b=bphnyQefhT87xYqE1Dz+S+
        BCwnhIlGXpb30wU14kB5j38Bz+p3TaPn7/oReiMP0t7HefZlzMMMtTSZOIhQHnCQ
        SpjD0QZh4PdYAipgYpWeq2Es0e5cXUWNTkM4ymvlwL9mHcp2mSP9fy9saHXwnzp9
        gThzFyqSa1Debqy9sth+MA3Zj8R+nw5b5Pyl6gFsXnPriEWwBdRPe8KQVJXu+QFY
        Zh2t57Dn2Tfquw2phHKsw4B6aydecKsosHWlUiISJdlOUroTRxx9W+RqERRfFDcP
        6Y/5Ml+jK/WFVRxwOho57YAzgJXLfxO58C88ZDiy6/wm1fzmTm0yA5f0mtaqEckA
        ==
X-ME-Sender: <xms:lLEAYXclOqZgRjS46tWHY66lpVzl94T9RCKm45Yf2erVThV39bVtPg>
    <xme:lLEAYdP5FAhaXnmeq9YPJxFy8Ind430wShQVn-cliOQiN_6LmPS98A2cqvkghoZKg
    Hub-oO4vmuRB_Pv2h0>
X-ME-Received: <xmr:lLEAYQhJRol931B0O0_Kp5LObpZkZQLgAd8LxI_DXeFjzZeq6sOznaj2J_wCWiMjn9oSbIyZS_rPvNLfslAMNgVfMsx03bFaFK4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeekgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeekveevtdekfedtfefhvdfgleelfefhtdefieetjeejvefghfdufeejkeehgfeu
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdr
    ohhrgh
X-ME-Proxy: <xmx:lLEAYY-0zSCe0eEytEXlRXdlialLTSfwiev3qbYVVykYW5AIWJ-iZg>
    <xmx:lLEAYTsf5nl9IdRJfTK4c1_REjoOH7ZHgdeyVeUiIcqZlVGq8FcNyw>
    <xmx:lLEAYXHqVByZVm24f1Or_6WgzFPBc-K8pE8KWhTbwoJQH7HZlSdUyw>
    <xmx:lrEAYc64YYkMZ3wl5WOzy3xblqCH0rXdXSLXuvWANRI9zhjfDj7wUA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jul 2021 21:23:29 -0400 (EDT)
Date:   Wed, 28 Jul 2021 11:23:24 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][CFT] signal handling fixes
In-Reply-To: <YQAbTazP4/JB8Aas@zeniv-ca.linux.org.uk>
Message-ID: <689cf6b8-e8fc-dc35-9d47-2c3d3e6aafb1@linux-m68k.org>
References: <YP2c1xk9LJ0zE3KW@zeniv-ca.linux.org.uk> <5622d120-1b89-6898-d091-8b4ceff6418@linux-m68k.org> <YQAbTazP4/JB8Aas@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2021, Al Viro wrote:

> On Tue, Jul 27, 2021 at 08:21:52PM +1000, Finn Thain wrote:
> > On Sun, 25 Jul 2021, Al Viro wrote:
> > 
> > > 
> > > 	The series is on top of 5.14-rc1; it lives in
> > > git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #untested.m68k
> > > Individual patches in followups...
> > > 
> > > 	_Very_ lightly tested on aranym; no real hardware to test it on.
> > > Any help with review and testing would be very welcome.
> > > 
> > 
> > I can test this branch on a Motorola 68040 machine I have here. Can you 
> > advise how to get decent code coverage? Maybe there's a package out there 
> > with a signal-heavy test suite? Maybe I need a break point in a signal 
> > handler? Or perhaps just send ^C to a process running under strace?
> 
> Generally, SIGINT is not the best insertion vector...
> 

True. I see that 'man 7 signal' says that SIGQUIT will produce a coredump. 
Would that contain anything of interest?

> Set a handler of e.g. SIGALRM with sigaction(), with a couple of other signals
> in sa_mask (e.g. SIGUSR1 and SIGUSR2).  With raise() on those inside the
> SIGALRM handler - then they will become deliverable on return from handler.
> And have SIGUSR1 and SIGUSR2 handlers print siginfo and ucontext contents
> (have them set with SA_SIGINFO in sa_flags, look at the second and third
> arguments of sighandler).
> 
> Use alarm(2) to arrange for SIGALRM and sit in a tight loop - that'll give you
> delivery on return from interrupt.  Alternatively, raise(SIGALRM) will give
> you delivery on return from trap.  And making that a SIGBUS handler instead,
> mmapping a file, truncating it to 0 and dereferencing something in mmapped
> area will give you delivery on return from access error trap.  Division by
> zero (and insertion handler on SIGFPE) ought to give you a type 2 exception
> stack frame (4 bytes of aux data, that makes shifted exception frame bugger
> format and vector fields of the original).
> 
> FWIW, the third argument of handler points to
> struct ucontext {
>         unsigned long     uc_flags;
>         struct ucontext  *uc_link;
>         stack_t           uc_stack;
>         struct mcontext   uc_mcontext;
>         unsigned long     uc_filler[80];
>         sigset_t          uc_sigmask;   /* mask last for extensibility */
> };
> and type/vector is stored in uc_filler[54] (216 bytes into the array), with
> aux data from exception stack frame starting from uc_filler[55].
> 

OK, give me a week or so and I'll see what I can come up with. 
