Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF0731ED53
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 18:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhBRR3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 12:29:19 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49859 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230513AbhBROqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 09:46:34 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 11IEXf7P014137;
        Thu, 18 Feb 2021 15:33:41 +0100
Date:   Thu, 18 Feb 2021 15:33:41 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Jari Ruusu <jariruusu@users.sourceforge.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <20210218143341.GB13671@1wt.eu>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com>
 <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <YC4atKmK7ZqlOGER@kroah.com>
 <20210218113107.GA12547@1wt.eu>
 <602E766F.758C74D8@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <602E766F.758C74D8@users.sourceforge.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 04:15:11PM +0200, Jari Ruusu wrote:
> Willy Tarreau wrote:
> > The only set of fixes that can be trusted are the "official" stable
> > kernels, because they are the only ones that are approved by the patches
> > authors themselves. Adding more stuff on top of stable kernels is fine
> > (and done at your own risk), but randomly dropping stuff from stable
> > kernels just because you don't think you need that is totally non-sense
> > and must not be done anymore!
> 
> This may be little bit off-topic... but stable kernel.org kernels
> can also bit-rot badly because of "selective" backporting... as in
> anything that does not apply cleanly gets dropped regardless of
> how critical they are.

Sure it will. And the huge difference is that it usually gets quickly
spotted and fixed. For sensitive servers I tend to apply the principle
of not necessarily updating to the latest stable kernel but one or two
versions before it which nobody complained about. And I'm pretty fine
with skipping a significant number of updates (we all do that anyway).

> I will give you one example: Intel WiFi (iwlwifi) on 4.19.y
> kernel.org stable kernels is currently missing many critical
> locking fixes. As a result, that in-tree iwlwifi driver causes
> erratic behavior to random unrelated processes, and has been doing
> so for many months now. My not-so-politically correct opinion is
> that in-tree iwlwifi is completely FUBAR unless someone steps up
> to do professional quality backport of those locking fixes from
> upstream out-of-tree Intel version [1] [2] of the driver.

I see, and it happens with plenty of other drivers or subsystems. Is
it in any way the stable branch's or stable maintainer's fault if
someone doesn't correctly do the backporting job on their driver ? No.
Is it expected that a driver works perfectly from its inclusion ? No.
Is it expected that a driver can always be fixed without a significant
rework that risks more breakage than fixes ? No. Some design limitations
or errors can require so many changes that they're unfixable in place.
I even had to *document* security issues in 2.4 because fixing them was
riskier than keeping them. This happens in any piece of software.

It's always been the case that some older kernels work less well than
some newer ones due to limited features, partially wrong drivers etc,
and getting better drivers is a valid reason for upgrading to a more
recent one. However the older driver ought to continue to be maintained
in a working state for those for whom it works fine.

> For me
> only way to get properly working WiFi on my laptop computer is to
> compile that Intel out-of-tree version. Sad, but true.

That's perfectly fine from my point of view. I've been doing the same
for certain driver (e.g. e100 vs eepro100 15 years ago) and have been
pleased to be able to stop using those out-of-tree versions. This is
also in order to make this possible for those who need to do it that
LTS kernels provide a lot of value: such out-of-tree drivers tend to
take some time to resynchronize with latest updates, and once they're
updated, you can use your machine for quite some time with them.

Obviously if somemone is able to figure the required fixes for the locking
bugs you mentioned above and to submit patches for stable branches, I'm
sure Greg will appreciate! But maybe that's not fixable there and you need
to upgrade. Usually you pick an LTS kernel for a specific hardware. If it
works that's great. But you cannot expect hardware to suddenly start to
work in the middle of a stable kernel. Sometimes it happens (PCI IDs) but
that's basically all and that's not their purpose.

Willy
