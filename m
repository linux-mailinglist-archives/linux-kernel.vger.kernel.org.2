Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05E23B42DD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFYMJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhFYMJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:09:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F32561626;
        Fri, 25 Jun 2021 12:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624622822;
        bh=090sjp2XUcitjPtdHyo/ODoO6o69If4/P/e7QRlSCac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ibXknSS7ciZT/ilp9Pqzelxt1IW5Uk7QHioPdk7aAcYZUxaFopL1fpmS9I/nrVXti
         byL/Q4MAwhfPWwqMhrw7YOvq1407p9HMmknn6SlSJiuaSWuuwT8jzR2DnFNzmUGa3h
         J5gZ0N2QoQchpfYmj7DBYHB8rKoBwnc1VUVcpIHk=
Date:   Fri, 25 Jun 2021 14:06:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] x86/tools/relocs: add __printf attribute to die()
Message-ID: <YNXG472lXPHlbuCF@kroah.com>
References: <YNRzSy3NuwBDYWwr@kroah.com>
 <YNR7aw+C+7AJnBIG@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNR7aw+C+7AJnBIG@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 02:32:43PM +0200, Borislav Petkov wrote:
> On Thu, Jun 24, 2021 at 01:58:03PM +0200, Greg Kroah-Hartman wrote:
> > There are a number of printf "mismatches" in the use of die() in
> > x86/tools/relocs.c.  Fix them up and add the printf attribute to the
> > reloc.h header file to prevent them from ever coming back.
> > 
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  arch/x86/tools/relocs.c | 21 +++++++++++----------
> >  arch/x86/tools/relocs.h |  1 +
> >  2 files changed, 12 insertions(+), 10 deletions(-)
> > 
> > Originally sent back in Feb, but it seems to have been missed:
> > 	https://lore.kernel.org/r/20210227095356.603513-1-gregkh@linuxfoundation.org
> > 
> > 
> > diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> > index ce7188cbdae5..c3105a8c6cde 100644
> > --- a/arch/x86/tools/relocs.c
> > +++ b/arch/x86/tools/relocs.c
> > @@ -389,7 +389,8 @@ static void read_ehdr(FILE *fp)
> >  		Elf_Shdr shdr;
> >  
> >  		if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0)
> > -			die("Seek to %d failed: %s\n", ehdr.e_shoff, strerror(errno));
> > +			die("Seek to %d failed: %s\n",
> > +			    (int)ehdr.e_shoff, strerror(errno));
> 
> Instead of casting all those, I think you should use %zu as, apparently,
> we're using unsigned types for Elf{32,64}_Off and Elf{32,64}_Xword, etc.

Ah, that does not work, I tried it and I get:

arch/x86/tools/relocs.c: In function ‘read_ehdr’:
arch/x86/tools/relocs.c:392:40: warning: format ‘%zu’ expects argument of type ‘size_t’, but argument 2 has type ‘Elf32_Off’ {aka ‘unsigned int’} [-Wformat=]
  392 |                         die("Seek to %zu failed: %s\n",
      |                                      ~~^
      |                                        |
      |                                        long unsigned int
      |                                      %u
  393 |                             ehdr.e_shoff, strerror(errno));
      |                             ~~~~~~~~~~~~
      |                                 |
      |                                 Elf32_Off {aka unsigned int}

Casting seems to be the only way to make this "quiet" that I can tell.

Unless someone else has a good idea?

thanks,

greg k-h
