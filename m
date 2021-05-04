Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05883724AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 05:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhEDDRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 23:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229708AbhEDDRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 23:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620098183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XKk2W5r7HRfkM2VxRD1ExD195oVL/dhaWQIOBv4OHnk=;
        b=R9xL0BVv+PY2hXXgL/kEMN5gsSoHnuLr+jEqCKVG/ZeG/astq18kGhwl6MMjiQpp2zDLgp
        +YRUuo1C6DxxLij0zdDofBbicu9e+SaCtgM/TDCMp8reD3NgiwqBMtaP3xnGUTARmoR1H3
        q8bjkpEp9cqz7froVElq1buG3sIpFVY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-BqZl-IspMSqAQw6DnWdfLw-1; Mon, 03 May 2021 23:16:20 -0400
X-MC-Unique: BqZl-IspMSqAQw6DnWdfLw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81F09801817;
        Tue,  4 May 2021 03:16:18 +0000 (UTC)
Received: from treble (ovpn-115-93.rdu2.redhat.com [10.10.115.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E6D65D9C0;
        Tue,  4 May 2021 03:16:17 +0000 (UTC)
Date:   Mon, 3 May 2021 22:16:16 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Kaplan <David.Kaplan@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: Re: Do we need to do anything about "dead =?utf-8?B?wrVvcHM/Ig==?=
Message-ID: <20210504031616.covixup7rhdil3yq@treble>
References: <CALCETrXRvhqw0fibE6qom3sDJ+nOa_aEJQeuAjPofh=8h1Cujg@mail.gmail.com>
 <20210503233010.x5lzpw4dq3gueg47@treble>
 <CALCETrVwFrpZU-6C=AVurVPk4ahV2yjqyhFeYbL_0OtBNJnZ=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrVwFrpZU-6C=AVurVPk4ahV2yjqyhFeYbL_0OtBNJnZ=w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 06:31:21PM -0700, Andy Lutomirski wrote:
> On Mon, May 3, 2021 at 4:30 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Sat, May 01, 2021 at 09:26:33AM -0700, Andy Lutomirski wrote:
> > > Hi all-
> > >
> > > The "I See Dead µops" paper that is all over the Internet right now is
> > > interesting, and I think we should discuss the extent to which we
> > > should do anything about it.  I think there are two separate issues:
> > >
> > > First, should we (try to) flush the µop cache across privilege
> > > boundaries?  I suspect we could find ways to do this, but I don't
> > > really see the point.  A sufficiently capable attacker (i.e. one who
> > > can execute their own code in the dangerous speculative window or one
> > > who can find a capable enough string of gadgets) can put secrets into
> > > the TLB, various cache levels, etc.  The µop cache is a nice piece of
> > > analysis, but I don't think it's qualitatively different from anything
> > > else that we don't flush.  Am I wrong?
> >
> > Wouldn't this type of gadget (half-v1 gadget + value-dependent-branch)
> > would be much more likely to occur than a traditional Spectre v1
> > (half-v1 gadget + value-addressed-load)?
> 
> I don't fully believe this.  It's certainly the case that:
> 
> if (mispredicted as false)
>   return;
> secret = some_secret();
> if (secret == 42)
>   do_something();

Well, obviously we should never write secret-protecting code in that
manner.

I was actually thinking more along the lines of

	val = 0;

	if (user_supplied_idx < ARRAY_SIZE) // trained to speculatively be 'true'
		val = boring_non_secret_array[user_supplied_idx];

	if (val & 1)
		do_something();

In other words, the victim code wouldn't be accessing the secret
intentionally.  So there's no reason for it to avoid doing
data-dependent branches.

> will leak the fact that the secret is 42 into the µop cache, but it
> will also leak it into the icache and lots of other things.  I see
> nothing new here.

Hm, I suppose.  I don't think I'd ever considered that vector though.

All the more reason to mask usercopy addresses...

-- 
Josh

