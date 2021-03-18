Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3A4340080
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 08:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhCRHzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 03:55:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhCRHzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 03:55:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E61EC64E77;
        Thu, 18 Mar 2021 07:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616054117;
        bh=HZGet467p/PlbISyuo70G+BBC8oVsBYVDU0nP87ZhW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WDVhkm9xVEs6rrMDOIl7ll8Bo2EHZRtGzwV09UcMBr5c9TToC16kkfDDzrmGRSaqo
         9SNu5qxYhLE6TJcE/B0vWT7NaclJ9Svwm0i0upnKg0BXqtWURpd2rEmUXBIz4A+bf8
         /Lef2nYApemLwIeMjpXdZjoaG9Z/0AHn/qGdWivKYJn1q9KJfZxstiftpfBGGgl9Nw
         JGHsa6hhLvrSK2JnR8/6Hvk0kPA7Q19w9zrepFUCfO4e6pmhPX5ppCHKnz2R3GyD0K
         3+3vdYtypqnUahAdNp1vNK67VU7SABG9nPDF6uATnPg4rJv4S5DbByu51zXAyXuBOu
         SsfVaR5dy3orw==
Date:   Thu, 18 Mar 2021 09:55:13 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH master] module: remove never implemented
 MODULE_SUPPORTED_DEVICE
Message-ID: <YFMHYUbPmpS+Kzcj@unreal>
References: <20210317104547.442203-1-leon@kernel.org>
 <CAHk-=wj+Bsc1T41qziHxf9DvrBrYSBWKj27hEL0EbysCGRPzTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj+Bsc1T41qziHxf9DvrBrYSBWKj27hEL0EbysCGRPzTA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 01:17:32PM -0700, Linus Torvalds wrote:
> On Wed, Mar 17, 2021 at 3:46 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > I'm sending this patch to you directly because it is much saner to
> > apply it in one place instead of multiple patches saga that will
> > span for at least two cycles if per-maintainer path will be taken.
> >
> > It applies cleanly on v5.12-rc2 and completely unharmful.
>
> You have an odd whitespace-only part in the patch inside the comment
> underneath the "remove RME,Hammerfall" case.

This is something that I missed, my VIM changed whitespaces in many old
files and I didn't pay attention when added that chunk.

>
> Also, your email seems to have swallowed spaces at the ends of lines.
>
> I can (and did) apply the patch with "--whitespace=fix", but that then
> causes git to fix some _other_ whitespace too, so the end result isn't
> quite the same. Oh well.
>
> Please check what's up with your email sending client that it seems to
> remove space at end of lines in patches.

This is strange, I'm sending patches with "git send-email" with pretty
standard settings:

   28 [sendemail]
   29         smtpserver = /usr/local/bin/msmtp-enqueue.sh
   30         suppresscc = self
   31         chainReplyTo = false
   32         confirm = always
   33         from = Leon Romanovsky <leon@kernel.org>
   34         envelopeSender = Leon Romanovsky <leon@kernel.org>
   35         signingkey = leon@kernel.org
   36         composeencoding = utf-8

Also, I'm using mail.kernel.org as a SMTP especially to make sure that
my mails are not mangled by our exchange server.

Are you sure that such change came from me and not from "--whitespace=fix"?

Thanks

>
>             Linus
