Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE33E407B4A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 04:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbhILCQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 22:16:10 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:34970 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhILCQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 22:16:09 -0400
X-Greylist: delayed 1033 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Sep 2021 22:16:09 EDT
Date:   Sat, 11 Sep 2021 21:57:41 -0400
From:   Rich Felker <dalias@libc.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, j-core@j-core.org
Subject: Re: [PATCH 0/3 v2] sh: fixes for various build and kconfig warnings
Message-ID: <20210912015740.GJ13220@brightrain.aerifal.cx>
References: <20210627220544.8757-1-rdunlap@infradead.org>
 <2bae95d0-0932-847c-c105-a333e9956dff@infradead.org>
 <f63694aa-85b3-0238-5228-eb35a52bf360@physik.fu-berlin.de>
 <CAFr9PXn5S_3mpJBF0bNo+S1US=Z5s89rbO-OhhqGk=zqPGWXoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXn5S_3mpJBF0bNo+S1US=Z5s89rbO-OhhqGk=zqPGWXoQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 06:08:58PM +0900, Daniel Palmer wrote:
> HI Adrian,
> 
> On Thu, 9 Sept 2021 at 17:25, John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > There are quite a number of patches on the mailing list that need reviewing and
> > I fear if that doesn't happen in the foreseeable future, the SH port is being
> > kicked out which would be a pity given that we're still maintaining the port in
> > Debian and given that there is new hardware available with the J-Core board [2].
> 
> This really is a poor situation. The fact that there are patches means
> that it's not totally dead but no one ever looking at them really puts
> people off bothering in the future.
> I might have a go at getting OF to work on the SH4 hardware I have but
> knowing that the patches will probably never get looked at is very
> demotivating.
> 
> Can we get a new maintainer from somewhere?

Hi. I see there's a situation that needs my attention here. I will
plan to review and merge anything important/blocking that doesn't have
problems this week.

In the bigger picture, the past few weeks and even months I've been in
a sort of "avoid burnout safety mode". :-) Probably partly on account
of this pandemic still being a thing because people insist on being
stupid. I'm not gone and won't be, but some things that haven't seemed
as urgent, including kernel stuff and especially piles of email of
mixed importance levels, have gotten pushed back to reduce stress.
Please don't hesitate to wave a "hey this is important, come take a
quick look!" flag at me if needed.

At the same time, I am open to the possibility of a new maintainer or
co-maintainer if that ends up being what makes sense. Are there any
candidates?

Rich
