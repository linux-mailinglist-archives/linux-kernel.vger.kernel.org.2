Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4056B340C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhCRRty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:49:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhCRRta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:49:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D55164E99;
        Thu, 18 Mar 2021 17:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616089769;
        bh=JMmu5Np1J+OYQZwLRQhUf1/zLFQt+qrWc+sHvATzSOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jEpV769TirZkbz+ed6A36UBDUHUhRISPVgwSncBi40ksVBjo5/gBIkNng4vfjDJ46
         8MqP76RYOt9D9l6K1clM0TmCgKKH7wU4Y/CtK9llWdXLuherAxVRqvxIGtJ0mKXU6U
         HHS/AoB4OJtZC+nztGLZUTAol/voUlIIpFBtN+7Q7kRblFpsZkVqlZO1uWnWguDach
         OyUFS/+iFneRrx+Y8L4wyQA6duZOzcv8pX26+YG0r9dEwWCrGLCAXbaBSuipDu1D6M
         yPyGtOFcdb/7W0L3fjsWoGyrwAApafkocCwSnkhfOeSFHTvji73faYcV8k5iJU5xOG
         7LHQqIL7GPg4A==
Date:   Thu, 18 Mar 2021 19:49:25 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH master] module: remove never implemented
 MODULE_SUPPORTED_DEVICE
Message-ID: <YFOSpQcrfP1UvqoL@unreal>
References: <20210317104547.442203-1-leon@kernel.org>
 <CAHk-=wj+Bsc1T41qziHxf9DvrBrYSBWKj27hEL0EbysCGRPzTA@mail.gmail.com>
 <YFMHYUbPmpS+Kzcj@unreal>
 <CAHk-=wgdHxuQmhKR9oAS5bhahmo5CFj3x6YdHVPBCGhbSz6rEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgdHxuQmhKR9oAS5bhahmo5CFj3x6YdHVPBCGhbSz6rEg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:36:36AM -0700, Linus Torvalds wrote:
> On Thu, Mar 18, 2021 at 12:55 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > Also, your email seems to have swallowed spaces at the ends of lines.
> > >
> > > I can (and did) apply the patch with "--whitespace=fix", but that then
> > > causes git to fix some _other_ whitespace too, so the end result isn't
> > > quite the same. Oh well.
> > >
> > > Please check what's up with your email sending client that it seems to
> > > remove space at end of lines in patches.
> >
> > This is strange, I'm sending patches with "git send-email" with pretty
> > standard settings:
>
> Hmm. I can't tell whats' wrong, but both my own mailbox and the
> lore.kernel.org clearly has missing whitespace at end of lines.
>
> You can see it yourself with a simple
>
>    b4 am 20210317104547.442203-1-leon@kernel.org
>
> (assuming you have b4 installed, of course:
>
>   https://pypi.org/project/b4/
>
> but with a kernel.org address I'm sure you've seen the emails about it
> even if you may not be a user).

Thanks, I'll try.

>
> > Also, I'm using mail.kernel.org as a SMTP especially to make sure that
> > my mails are not mangled by our exchange server.
>
> Yeah, the email looks fine in any other way technically, it passes SPF
> and DKIM, and I don't see anything else strange going on either.
>
> I think the same VIM issue that caused some whitespace line changes
> for you in the patch might have then bitten you when you sent it out -
> I know you must have edited the message, becasuse you have that
>
>    "I'm sending this patch to you directly because it is much saner to
>     apply it in one place instead of multiple patches saga that will [...]"
>
> below the commit message, that you presumable added with "--annotate".

No, I opened patch and added the note manually, so it is definitely my VIM.
Most likely this part of my .vimrc caused it.

 " Remove trailing white spaces
 " http://vim.wikia.com/wiki/Remove_unwanted_spaces
 autocmd BufWritePre * %s/\s\+$//e

>
> > Are you sure that such change came from me and not from "--whitespace=fix"?
>
> Yup. See above on how you can just use b4 to download a copy yourself..

I'll try, thanks for taking the patch and for the analysis.

>
>          Linus
