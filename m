Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5803B31AE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhFXOqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231194AbhFXOq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:46:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEBD86135C;
        Thu, 24 Jun 2021 14:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624545849;
        bh=fWjsPxzvKGSs1dbSs7XVG4nfqro9YAmqQ4T6r3uflIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJiA0gFq+zuKimTijcPHn3xd+0Y/B+L3wbg4XtCXYQtjnB9yKdrFua4hTaAiXxSzV
         DWiECvT0cTylVFgee6R2VuLSFb+ooaDjeqDH6X6XdlNsMgVuaHk/zDReoFcolX+wwp
         RvlsrucxgaNoemZ46Z9yol0e8zU72N0W10hw2bvw=
Date:   Thu, 24 Jun 2021 16:44:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] x86/tools/relocs: add __printf attribute to die()
Message-ID: <YNSaMnRDwan+aYT4@kroah.com>
References: <YNRzSy3NuwBDYWwr@kroah.com>
 <YNR7aw+C+7AJnBIG@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Odd, I thought I tried that and something did not work.  Let me try it
again...
