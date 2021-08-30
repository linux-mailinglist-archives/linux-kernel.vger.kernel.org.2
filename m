Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3013FB213
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 09:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhH3HuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 03:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhH3HuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 03:50:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35B4C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 00:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=wA/gsUCb3PAoH4z1d3dqqDuu/3zM/xx6tIByC/CvD7s=; b=XcdoPMZy/0Fg3gM8QRg8zSs1qw
        f1WKz4JRPEXfas0+4i6K0UfdGnTpbYzU2Qep90nJauSrulL92kcHzLtCxm7ld9gUuAinQFgSsQPva
        61aQp/gYxcqmVwXE54qgjJtlYTHfFFQOM/wrrV2yrWmbOe6i29RT2wmcMW9OrYpndKBJU8D9wLtI+
        aT9QAICLaI7CRELUaYj3eyGctYk3nX8Bv10O/5e0j968I7hVpVsZp4G9fnERb3FsIZtpYqhfT/dN6
        /l1laEWM+6h4RIWzWyJ5XAVIMRpuWmeXaLsVKO1NAQ3rKeMWj/ebsr9Jyo+DZg+EV00dJCAxSijBC
        lpdaB8VQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKc20-00ELyC-MN; Mon, 30 Aug 2021 07:48:36 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8EF6981255; Mon, 30 Aug 2021 09:48:34 +0200 (CEST)
Date:   Mon, 30 Aug 2021 09:48:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, x86@kernel.org, mbenes@suse.com,
        rostedt@goodmis.org, dvyukov@google.com, elver@google.com
Subject: Re: [PATCH v2 01/24] x86/xen: Mark cpu_bringup_and_idle() as
 dead_end_function
Message-ID: <20210830074834.GE4353@worktop.programming.kicks-ass.net>
References: <20210624094059.886075998@infradead.org>
 <20210624095147.693801717@infradead.org>
 <20210820192224.ytrr6ybuuwegbeov@treble>
 <20210820193107.omvshmsqbpxufzkc@treble>
 <fc90e972-f81f-3706-b13a-988b16264650@suse.com>
 <d27cd344-1323-803c-d26d-9aa851681b69@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d27cd344-1323-803c-d26d-9aa851681b69@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 07:55:02AM +0200, Juergen Gross wrote:
> > > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > > Subject: [PATCH] x86/xen: Move hypercall_page to top of the file
> > >=20
> > > Because hypercall_page is page-aligned, the assembler inexplicably ad=
ds
> > > an unreachable jump from after the end of the previous code to the
> > > beginning of hypercall_page.
> > >=20
> > > That confuses objtool, understandably.=A0 It also creates significant=
 text
> > > fragmentation.=A0 As a result, much of the object file is wasted text
> > > (nops).
> > >=20
> > > Move hypercall_page to the beginning of the file to both prevent the
> > > text fragmentation and avoid the dead jump instruction.
> > >=20
> > > $ size /tmp/head_64.before.o /tmp/head_64.after.o
> > > =A0=A0=A0 text=A0=A0=A0=A0=A0=A0 data=A0=A0=A0=A0=A0=A0=A0 bss=A0=A0=
=A0=A0=A0=A0=A0 dec=A0=A0=A0=A0=A0=A0=A0 hex=A0=A0=A0 filename
> > > =A0=A0 10924=A0=A0=A0=A0 307252=A0=A0=A0=A0=A0=A0 4096=A0=A0=A0=A0 32=
2272=A0=A0=A0=A0=A0 4eae0
> > > /tmp/head_64.before.o
> > > =A0=A0=A0 6823=A0=A0=A0=A0 307252=A0=A0=A0=A0=A0=A0 4096=A0=A0=A0=A0 =
318171=A0=A0=A0=A0=A0 4dadb
> > > /tmp/head_64.after.o
> > >=20
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com
> >=20
> > Reviewed-by: Juergen Gross <jgross@suse.com>
>=20
> Umm, will this be carried through the tip tree, or shall I take it in
> the xen tree?

I have it in the whole x86/objtool/paravirt series. I you want it in the
Xen tree, I'll be happy to drop it from there, although I hope to get
all that merged this cycles somewhere.
