Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D3331F17B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 22:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhBRVBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 16:01:51 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49881 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhBRVBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 16:01:32 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 11IL0bNG016334;
        Thu, 18 Feb 2021 22:00:37 +0100
Date:   Thu, 18 Feb 2021 22:00:37 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <20210218210037.GA16034@1wt.eu>
References: <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com>
 <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <20210218165104.GC2013@sasha-vm>
 <00b9e2fb-d818-58d6-edae-4dbd6aa814f7@gmail.com>
 <YC6ptKgsMh20tmu6@kroah.com>
 <20210218182050.GB15217@1wt.eu>
 <YC6zq3u2jciI2gyZ@kroah.com>
 <b283eaa5-028f-a3d0-42a1-5b11c48ffe91@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b283eaa5-028f-a3d0-42a1-5b11c48ffe91@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 12:16:50PM -0800, Scott Branden wrote:
> On 2021-02-18 10:36 a.m., Greg Kroah-Hartman wrote:
> > On Thu, Feb 18, 2021 at 07:20:50PM +0100, Willy Tarreau wrote:
> >> On Thu, Feb 18, 2021 at 06:53:56PM +0100, Greg Kroah-Hartman wrote:
> >>> On Thu, Feb 18, 2021 at 09:21:13AM -0800, Florian Fainelli wrote:
> >>>> As a company, we are most likely shooting ourselves in the foot by not
> >>>> having a point of coordination with the Linux Foundation and key people
> >>>> like you, Greg and other participants in the stable kernel.
> >>>
> >>> What does the LF have to do with this?
> >>>
> >>> We are here, on the mailing lists, working with everyone.  Just test the
> >>> -rc releases we make and let us know if they work or not for you, it's
> >>> not a lot of "coordination" needed at all.
> >>>
> >>> Otherwise, if no one is saying that they are going to need these for 6
> >>> years and are willing to use it in their project (i.e. and test it),
> >>> there's no need for us to maintain it for that long, right?
> >>
> >> Greg, please remember I expressed I really need them for slightly more than
> >> 3 years (say 3.5-4) :-) I'm fine with helping a bit more as time permits if
> >> this saves me from having to take over these kernels after you, like in the
> >> past, but I cannot engage on the regularity of my availability.
> > 
> > Ok, great!
> > 
> > That's one person/company saying they can help out (along with what CIP
> > has been stating.)
> > 
> > What about others?  Broadcom started this conversation, odd that they
> > don't seem to want to help out :)
> Greg, I'm sorry but I'm not in a position to provide such a commitment.

Are you at least in a position to defend that ? There are necessarily
some people in your company who understand the benefits of using open
source provdided for free by others and who understand that devoting
a few people's time to this task is extremely cheap compared to the
amount of work required by having to do it entirely yourself for a
lower quality.

> My original question arose because the 5.10 kernel is declared as 2 years LTS
> while older LTS kernels are now 6 years.
(...)
> If all LTS kernels were declared as 3.5-4 years as Willy commented this would
> solve a few issues. 6 year LTS kernels would only have a maximum 1 year
> lifespan over the latest declared LTS kernel. Also, many products take a year
> or more to develop, there isn't any life left in an LTS kernel if it is only
> 2 years.

We all have the same problem regarding this but how do you want Greg to
engage into such a task by himself if he's not certain he can count on
others to help ? The few of us having worked on extended kernels know
that there's a limit around 2.5 years beyond which backports become much
harder to perform and to test. Doing it every year would result in 6 LTS
kernels to maintain in addition to the last 1-2 stable ones. That becomes
a huge amount of work! I even think that having one LTS kernel every 2
years but maintained one extra year (e.g. 5 vs 4 in my case) would reduce
the effort.

> After 1-3 years of kernel age the relevant parties that want to invest and
> care about supporting specific kernel versions longer should become apparent
> and could commit to longer support.

But that's exactly what's currently being done. Greg initially commits
to 2 years hoping to get some help to pursue this longer, and this causes
trouble to some of us not being certain upfront whether or not we're choosing
the right kernel. So only the solution I'm seeing is for Greg to know
early who jumps in so that those of us without the power or skill to
entirely maintain a kernel by themselves know early which version to
choose. Quite frankly if we ship an LTS kernel in a product, the least
we can do is to give back a little bit to make sure the situation remains
durable.

As such even if you are not in a position to provide such a commitment,
I'd appreciate it if you would bring these arguments to those who are in
such a position, so that I don't end up as one of the too few ones having
to share a significant part of that task to make sure this valuable kernel
continues to exist.

Thanks,
Willy
