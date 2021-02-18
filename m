Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250A731EFC2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhBRTXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:23:24 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49871 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231372AbhBRSVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:21:44 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 11IIKoE1015408;
        Thu, 18 Feb 2021 19:20:50 +0100
Date:   Thu, 18 Feb 2021 19:20:50 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Scott Branden <scott.branden@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <20210218182050.GB15217@1wt.eu>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com>
 <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <20210218165104.GC2013@sasha-vm>
 <00b9e2fb-d818-58d6-edae-4dbd6aa814f7@gmail.com>
 <YC6ptKgsMh20tmu6@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC6ptKgsMh20tmu6@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 06:53:56PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 18, 2021 at 09:21:13AM -0800, Florian Fainelli wrote:
> > As a company, we are most likely shooting ourselves in the foot by not
> > having a point of coordination with the Linux Foundation and key people
> > like you, Greg and other participants in the stable kernel.
> 
> What does the LF have to do with this?
> 
> We are here, on the mailing lists, working with everyone.  Just test the
> -rc releases we make and let us know if they work or not for you, it's
> not a lot of "coordination" needed at all.
> 
> Otherwise, if no one is saying that they are going to need these for 6
> years and are willing to use it in their project (i.e. and test it),
> there's no need for us to maintain it for that long, right?

Greg, please remember I expressed I really need them for slightly more than
3 years (say 3.5-4) :-) I'm fine with helping a bit more as time permits if
this saves me from having to take over these kernels after you, like in the
past, but I cannot engage on the regularity of my availability.

Overall I think that a lot of people completely underestimate the amount
of work it requires to maintain stable kernels, and how much it could be
distributed. By having a bunch of users participate a little bit more
(e.g. by sometimes backporting the patches that are essential to them,
by testing what's relevant to their use case), it already offloads a lot
of work. I don't think the extra work requires to be much organized if
there are enough participants to share the efforts.

Regards,
Willy
