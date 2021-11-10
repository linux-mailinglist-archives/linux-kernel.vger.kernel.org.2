Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0850444C4EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 17:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhKJQUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 11:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhKJQT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 11:19:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F037BC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 08:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=UWDh+GMb6sWN4ytXlAiAuYYmuWguzVsqO0bFdWf3SH0=; b=UsVeTI4F/S3KbJ/NJU7Rt8vqv7
        Ke5DLye4hvFBWXoNeyYs7joByByP9MU48PmOyROslgun0dA+iC/lD2pHD4HsppCu5DNGzqJNPM9O8
        8FrW3T5+cuQI5O67G0fqipdjPartvSI174j3JPwnLR/oySwOUrSf53LcSG+BYi+esFmeSr24pgO9T
        oo33xckSxwrJMJFCOCjKcc+rzo/zaFVll0G0eAyO3jiJZnLGGQZSxJUhc2onNzU5jx9AvXF3pD2ze
        xdSG58nsk37oxKCi9VEhtCaUMbvpNP31mGgOjtC1voXXmv+eE1Tl7mGW0CD3rBM+khAeqRZTIxmlW
        ZTqY+KJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkqHV-00FIp3-2Q; Wed, 10 Nov 2021 16:17:01 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3199B986972; Wed, 10 Nov 2021 17:17:00 +0100 (CET)
Date:   Wed, 10 Nov 2021 17:17:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, seanjc@google.com,
        pbonzini@redhat.com, mbenes@suse.cz
Subject: Re: [PATCH v2 11/23] x86,xen: Remove .fixup usage
Message-ID: <20211110161700.GC174703@worktop.programming.kicks-ass.net>
References: <20211110100102.250793167@infradead.org>
 <20211110101325.545019822@infradead.org>
 <42933d6b-c6f4-7420-1d0f-7f5d6ec17d8e@suse.com>
 <YYumVx7qO3gY2tgD@hirez.programming.kicks-ass.net>
 <YYu/Mg8lSO9zX01z@hirez.programming.kicks-ass.net>
 <62c65309-b37e-4974-c4c1-733081357808@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <62c65309-b37e-4974-c4c1-733081357808@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 01:52:57PM +0100, Juergen Gross wrote:
> On 10.11.21 13:46, Peter Zijlstra wrote:
> > On Wed, Nov 10, 2021 at 12:00:39PM +0100, Peter Zijlstra wrote:
> > > On Wed, Nov 10, 2021 at 11:35:37AM +0100, Juergen Gross wrote:
> >=20
> > > > > +		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAUL_REG, %[ret])
> > > >=20
> > > > I guess you didn't compile that? There is a typo: s/EFAUL/EFAULT/
> > >=20
> > > Damn.. I figure that must've gotten lost in the robot spam telling me
> > > clang can't do __cold on labels :/
> >=20
> > new patch at:
> >=20
> >    https://lkml.kernel.org/r/YYu/AteC/Wamqn46@hirez.programming.kicks-a=
ss.net
> >=20
>=20
> "not found"

Argh.. msgid contains '/' and that doesn't really work with URLs.

https://lore.kernel.org/lkml/YYu%2FAteC%2FWamqn46@hirez.programming.kicks-a=
ss.net/

is the right url, in case you hand't yet found the actual email.


