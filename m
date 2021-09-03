Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9DF3FFC33
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbhICIlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348379AbhICIla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:41:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B876CC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 01:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=wBj6nos2hDwqH7CVknKIIQQxUxx9v/M+OP/YK2wBbOc=;
        t=1630658430; x=1631868030; b=Fe49fPp27uhD/qX5pw0kfudx/2F/OEJfPPSUuESgK553FRr
        jYUhdO1n89SDgZNK5FWOfZ0p1WZ87KMwFlgSlj3htepJlkQmyp7T2jCUAD+Dqb9YuvjgZ1g4M/G8o
        WbKY+FLVXMmG0x1VmH711nrMmEepwiQ0SHNSK5+yZzt5rS0317dSD+277nyPk6gPg/yn0XZDy7iiR
        szlo3Rfznm6UREmORbHYuv9ykaiqftspxXkZBubZbj0xPi909IU50AlIeZPt7NOMg8m0E/+GEZvS2
        c4skFqTs4DEIjfrLgkWKlhGcAj0Dojd7FQFqe+iDkEGeDTfIzTcjNhZMNHtqGUuQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mM4kK-001zew-4n; Fri, 03 Sep 2021 10:40:24 +0200
Message-ID: <30ab717a9ba1c2bb17e2a6948ff61d26c4430772.camel@sipsolutions.net>
Subject: Re: [PATCH] um: don't use CONFIG_X86_{32,64} symbols on x86
From:   Johannes Berg <johannes@sipsolutions.net>
To:     David Laight <David.Laight@ACULAB.COM>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 03 Sep 2021 10:40:23 +0200
In-Reply-To: <f177f8b287f14c93b04542d7ab4a8dfd@AcuMS.aculab.com>
References: <20210902102750.1ddfef4c1915.Icb5c49998c55b87c8584d46894c01b114ae2e661@changeid>
         <f177f8b287f14c93b04542d7ab4a8dfd@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-09-03 at 08:27 +0000, David Laight wrote:
> From: Johannes Berg
> > Sent: 02 September 2021 09:28
> > 
> > The CONFIG_X86_32 and CONFIG_X86_64 symbols are used by
> > both "real" x86 architecture builds and ARCH=um today.
> > However, clearly most people and places in the code are
> > treating it as the architecture Kconfig (technically
> > that's just CONFIG_X86) and use it to indicate that the
> > architecture is X86 in 32- or 64-bit flavour.
> > 
> > This has caused a fair amount of issues in the past,
> > for example drivers not building because use x86 macros
> > or similar under CONFIG_X86_{32,64} ifdef, and then we
> > find build reports and add "!UML" to their Kconfig etc.
> > 
> > However, this is error-prone and a kind of whack-a-mole
> > game, even with the build bots reporting things.
> 
> I suspect you've just changed the 'mole'.

Yeah, that thought occurred to me too.


> You've now got lots of lines like:
> 
> #if defined(CONFIG_X86_64) || defined(CONFIG_X86_64_UML)
> 
> Missing off the UML define is going to cause the 32bit code
> to get compiled by mistake - which is likely to be more
> confusing that the places where you need to do special 'stuff'
> for UML

I'm not sure I agree though.

Yes, I agree that I have a number of lines. But looking through them, we
have new ones:
 - AFS, and it fundamentally wants to know the arch. If it misses one,
   well, that can also happen with any other arch.
 - XFS/falloc has arch-specific stuff again, and considers other
   architectures too
 - fs/ioctl.c is actually unnecessary since CONFIG_COMPAT doesn't exist
   on UML
 - same for blktrace
 - BPF jit - not really sure about that one
 - crypto Kconfig - but again already considers different architectures
   there
 - sound - ok that's a stupid one :)
 - lzo - again stuff that already considers many architectures

But on the other side removal we have
 - sysctl
 - netfilter
 - security
 - many fixes to driver Kconfig that you don't see here because they're
   *missing* "depends on !UML" now


So my gut feeling is that while we've indeed traded one mole for another
in a sense, the somewhat surprising places (like sound and BPF) are much
fewer, and most of the places that we now need it are places that are
already considering different architectures.

johannes

