Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884D831EA73
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 14:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhBRN32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 08:29:28 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49851 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230218AbhBRLq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 06:46:26 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 11IBV7Lt013142;
        Thu, 18 Feb 2021 12:31:07 +0100
Date:   Thu, 18 Feb 2021 12:31:07 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <20210218113107.GA12547@1wt.eu>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com>
 <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <YC4atKmK7ZqlOGER@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC4atKmK7ZqlOGER@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 08:43:48AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 17, 2021 at 11:48:21AM -0800, Scott Branden wrote:
> > Other difficulty with the LTS version is the frequency it is updated.

What a stange statement! So basically if fixes come in quickly so that
customers are not exposed too long to well-known issues, it's a difficulty ?
I guess by now every serious OS vendor provides at least weekly fixes, and
at an era where devices are all interconnected, it's really necessary
(unless of course you don't care about your customer's security).

> > We would not
> > pickup the changes that frequently to test.  A quarterly, bi-annually, or when a critical fix
> > is identified would be when we update and perform any meaningful testing when in maintainence.
> 
> How are you "identifying" these "critical fixes"?  We fix at least one
> known security issue a week, and probably multitudes of
> unknown-at-this-moment ones.  How are you determining when you need to
> send a new base kernel update off to your customers?  At such long
> intervals it feels like anyone using your kernel releases is woefully
> insecure.

+1! It seems like this dangerous practice will never end :-(

Let me explain a personal experience. When I took over 2.6.32 many years
ago, Greg asked me to adapt to the new maintenance process involving the
patch reviews. At first I feared that it would increase my amount of work.
And it did. But I also discovered how important these reviews were, because
I started to get lots of "don't take this one in this version" and more
importantly "if you merge this you'll need these ones as well". And very
quickly I discovered how bogus the branches I used to maintain before
had been, given the high feedback ratio!

So based on this experience, I can assure anyone doing cherry-picks in
their garage from LTS kernels that they're doing crap and that they must
not distribute these kernels to anyone because THESE KERNELS ARE DANGEROUS.
It's even very easy to introduce vulnerabilities by doing this!

The only set of fixes that can be trusted are the "official" stable
kernels, because they are the only ones that are approved by the patches
authors themselves. Adding more stuff on top of stable kernels is fine
(and done at your own risk), but randomly dropping stuff from stable
kernels just because you don't think you need that is totally non-sense
and must not be done anymore!

Willy
