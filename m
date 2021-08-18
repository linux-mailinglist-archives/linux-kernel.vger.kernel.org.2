Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D54F3F0B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 20:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhHRSnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 14:43:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57672 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhHRSnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 14:43:05 -0400
Received: from zn.tnic (p200300ec2f0cc30025743e574fa309df.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c300:2574:3e57:4fa3:9df])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CF5F1EC0541;
        Wed, 18 Aug 2021 20:42:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629312145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DNHh5O90xMiN10/O0h49EwPp7W2Ntgkh4B00NNWxBBk=;
        b=IFfP6Vv1rB9yU7La9DdIb9K7+Vzi6VdZldAFO8qwMjLphP90ekCnJZ5I2ftb7t7wq0GXkC
        //rnIsWnsYx0cw+Kl/stDFyjBbkFSr5hsBvRefStzC71IhGdSKo23/EtsdXEWQd8+mgpW6
        6cZy2Nw17KnhtBkyQbNSEFkCEPUJX9E=
Date:   Wed, 18 Aug 2021 20:43:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tor Vic <torvic9@mailbox.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "graysky@archlinux.us" <graysky@archlinux.us>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] x86, Makefile: Add new generic x86-64 settings
 v2/v3/v4
Message-ID: <YR1UuJM0GumaTIi2@zn.tnic>
References: <269701460.117528.1629210189833@office.mailbox.org>
 <796036867.117557.1629210288168@office.mailbox.org>
 <YRwBs89eogLJEiRn@zn.tnic>
 <1708009975.124311.1629299321026@office.mailbox.org>
 <YR1KDD/azm1IDr9u@zn.tnic>
 <25f1e81a-84f7-e63c-2989-cd4fddd695e7@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25f1e81a-84f7-e63c-2989-cd4fddd695e7@mailbox.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 06:28:47PM +0000, Tor Vic wrote:
> That's something I'd like to help with, hence my (not very good)
> submissions. You're one of the kernel colonels, so I'm happy to get
> some *useful* feedback which enables noobs like me to get a better
> understanding of the kernel stuff.

Sure, Greg so happens to have written a reply recently explaining what
to do:

https://lists.kernelnewbies.org/pipermail/kernelnewbies/2017-April/017765.html

Thx Greg!

In addition to the above, I'd suggest reading lkml, reading other
people's patches, review of those patches by people and trying to
understand what they're talking about. And then following through the
code to try to see it.

What also really helps is setting up a kvm guest, booting the kernel
with it and adding printks here and there and dumping interesting
information with them.

Once you start dealing with this, you might spend a couple of decades
figuring it all out in full depth. :-)

Oh, and this https://www.kernel.org/doc/html/latest

has all of the kernel's documentation formatted nicely.

I sincerely hope that helps a bit.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
