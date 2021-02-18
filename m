Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F21931EFBF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhBRTXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:23:08 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49865 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231152AbhBRSOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:14:21 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 11IIDU99015369;
        Thu, 18 Feb 2021 19:13:30 +0100
Date:   Thu, 18 Feb 2021 19:13:30 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <20210218181330.GA15217@1wt.eu>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com>
 <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <f2a03516-0247-522e-184a-7df4840ed345@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2a03516-0247-522e-184a-7df4840ed345@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian!

On Thu, Feb 18, 2021 at 09:42:00AM -0800, Florian Fainelli wrote:
> > Other difficulty with the LTS version is the frequency it is updated.  We would not
> > pickup the changes that frequently to test.  A quarterly, bi-annually, or when a critical fix
> > is identified would be when we update and perform any meaningful testing when in maintainence.
> 
> Well you really have the best of both worlds here, you are not forced to
> update your downstream fork of the stable kernel every week, though
> bonus points if you do.
> 
> For instance I try to test all the stable release candidates for 4.9,
> 5.4 and 5.10, and merge the stable tags every week when they show up. We
> do release to our customers every 6 weeks though, so usually they will
> jump several stable releases, and they are fine with that.
> 
> Yes it takes time, but I would rather do that than have to continuously
> respond to questions about is this CVE fixed in kernel X.Y.Z like it
> used to be before we did that. It also helps catch problem faster before
> customers do, the usual benefits of continuous integration/delivery.

Totally agreed! In our use case at haproxy, it's slightly different but
not that much. We're much less sensitive to kernel bugs except for the
network parts and any long-term stability issue. However we're extremely
sensitive to openssl bugs and haproxy bugs. Thus we use them as triggers
to emit a new release and we systematically update the kernel to the
latest one. Our local patches usually apply pretty well on top of that.

We face maybe 1-3 rejects a year which take half an hour of extra manual
work, and roughly one regression every 3 years, essentially caused by
one of our local patches applying to the wrong place due to changes and
not caught by QA tests before being put online. I think that in ~15 years
(we started with 2.4), only a single customer was ever affected by a
regression caused by the kernel, it is so low we could almost laugh about
it. Quite frankly this is unrivaled, and it illustrates the huge benefit
in almost blindly following LTS this way! More quality, less work, and
faster response to critical bugs! For sure there's no "kernel hero" in
our dev team, but who really wants that anyway ?

Cheers,
Willy
