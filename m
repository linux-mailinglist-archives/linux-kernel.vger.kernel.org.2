Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FED4348504
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhCXXEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhCXXD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:03:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32EB2619E5;
        Wed, 24 Mar 2021 23:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1616627039;
        bh=+YrKy1muz/7uWov5cSY7UCF+Lj2d4yd3soyvSRh8Dak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bB/Eyu/6lI62iP3flDhGCR+tF03mrDLsS9ae1DCeVi7Os0EoFrBRDlD6+uJBnjmEd
         +/xRuWYQbiPok9i3iA0kAQ8v5bEi8HoUUG5bCWdMpX2avUIUy+Npj8GcHJiQJ1ExB3
         DLgEz+F0G6tJgAMXgl9BJwdhIG5xuCyxBiP/PJbY=
Date:   Wed, 24 Mar 2021 16:03:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marco Elver <elver@google.com>
Cc:     tl455047 <tl445047925@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] kernel: kcov: fix a typo in comment
Message-Id: <20210324160358.0f36aa1f8ea7098f66fe64bd@linux-foundation.org>
In-Reply-To: <CANpmjNMFfQs6bV4wrigfcWMwCvA_oMwBxy9gkaD4g+A1sZJ6-Q@mail.gmail.com>
References: <20210323062303.19541-1-tl445047925@gmail.com>
        <CACT4Y+atQZKKQqdUrk-JvQNXaZCBHz0S_tSkFuOA+nkTS4eoHg@mail.gmail.com>
        <CANpmjNMFfQs6bV4wrigfcWMwCvA_oMwBxy9gkaD4g+A1sZJ6-Q@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 23:32:57 +0100 Marco Elver <elver@google.com> wrote:

> On Tue, 23 Mar 2021 at 07:45, 'Dmitry Vyukov' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> > On Tue, Mar 23, 2021 at 7:24 AM tl455047 <tl445047925@gmail.com> wrote:
> > >
> > > Fixed a typo in comment.
> > >
> > > Signed-off-by: tl455047 <tl445047925@gmail.com>
> >
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> >
> > +Andrew, linux-mm as KCOV patches are generally merged into mm.
> >
> > Thanks for the fix
> 
> FYI, I believe this code may not be accepted due to this:
> 
> "[...] It is imperative that all code contributed to the kernel be legitimately
> free software.  For that reason, code from anonymous (or pseudonymous)
> contributors will not be accepted."
> 
> See Documentation/process/1.Intro.rst

Correct.  I let this one pass because the patch is so minor.  But yes,
a real name would be preferred, please.

