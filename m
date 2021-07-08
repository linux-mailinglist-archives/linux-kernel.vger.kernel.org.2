Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34683BF8A0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhGHLDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 07:03:03 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:43156 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhGHLDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:03:02 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 232EC72C8B4;
        Thu,  8 Jul 2021 14:00:18 +0300 (MSK)
Received: from example.org (ip-89-103-72-154.net.upcbroadband.cz [89.103.72.154])
        by imap.altlinux.org (Postfix) with ESMTPSA id 91AAA4A46ED;
        Thu,  8 Jul 2021 14:00:17 +0300 (MSK)
Date:   Thu, 8 Jul 2021 13:00:16 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Subject: Re: [PATCH] ucounts: Fix UCOUNT_RLIMIT_SIGPENDING counter leak
Message-ID: <20210708110016.seeviageyspgctzk@example.org>
References: <CAHk-=wjQks3o_3=WewaXw++h+a318B3LTLSFER9Ee4n1pLCZLw@mail.gmail.com>
 <20210702175442.1603082-1-legion@kernel.org>
 <CAHk-=whfoVN6wiP5VHekckvqivRhpB+b1FnwyWEjz1SB2FN6HQ@mail.gmail.com>
 <20210707165008.tym4352uw3hu7uwp@example.org>
 <CAHk-=wirhF8G1XniAfxzJXCYUnuAx23Q1WLi_n4+HGsUXv72KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wirhF8G1XniAfxzJXCYUnuAx23Q1WLi_n4+HGsUXv72KQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 10:23:35AM -0700, Linus Torvalds wrote:
> On Wed, Jul 7, 2021 at 9:50 AM Alexey Gladkov <legion@kernel.org> wrote:
> >
> > >   +             dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING, 1);
> > >   +             fallthrough;
> > >   +     case LONG_MAX:
> >
> > I think that the counter should be decreased in this case too.
> > inc_rlimit_ucounts() increments the counter in all parent userns. If we
> > don't decrease the counter then the parent userns will have a counter
> > leak.
> 
> Ack. So basically that patch, but move the dec_rlimit_ucounts() into
> the LONG_MAX case?

Yep.

> Would you mind making a real patch with a commit message, and trying
> whatever test-case you had for that KASAN use-after-free report?

Sure. I will.

-- 
Rgrds, legion

