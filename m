Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA3F32D48F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 14:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241552AbhCDNtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 08:49:41 -0500
Received: from smtp2.axis.com ([195.60.68.18]:20525 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241576AbhCDNtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 08:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1614865758;
  x=1646401758;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=pvW1cr6C8vMTfIXRPLqxLsq2XODT6Ks7EDNeGRY1fIg=;
  b=jeuoVGXp0nOjzeswz3rcwd6SDHSy2laaWt4Auw7unEDZDZcGNiq/72k3
   ri6GwPYfDZAfDDO6pxAUWhywiG3QmdLLZPurG/gfMtDLffz6PJLi07I4U
   U4XNhazW4iM4bpzINuLwLVFKSD4ik5NnePK3SMGgFSHbTr3v8Ml2eQ/SV
   XPoulA2w+GdoSVKfRD6aDF+4JDpDtL77/AnQSL8Dq2XEFuBF9Ohd/RnCv
   sULGsAON/qRt49wYLKwISwVYojlqkS0Mt9Jdw02066W11n51Mhj3Wb6p3
   rCJ2G4UkhRue731XTuCbaTbzbfKF/rxr7IsuQgEZAlBth1zPKNRsRMRLQ
   A==;
Date:   Thu, 4 Mar 2021 14:48:37 +0100
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel <kernel@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: Try power cycling card if command request times out
Message-ID: <20210304134836.xlw7wbbvkc5bqzmm@axis.com>
References: <20210216224252.22187-1-marten.lindahl@axis.com>
 <CAPDyKFoASx=U8b1Oqtuo6ikiM=gXfL2x1Gsz=rfAn9zxP0y_iA@mail.gmail.com>
 <20210301215923.6jfg6mg5ntorttan@axis.com>
 <CAPDyKFoaKfuwweaEMf1Pz+ECAPU3P9-gmCJcpq+MADH5gH1c=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFoaKfuwweaEMf1Pz+ECAPU3P9-gmCJcpq+MADH5gH1c=Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf! My apologies for the delay.

On Tue, Mar 02, 2021 at 09:45:02AM +0100, Ulf Hansson wrote:
> On Mon, 1 Mar 2021 at 22:59, Marten Lindahl <martenli@axis.com> wrote:
> >
> > Hi Ulf!
> >
> > Thank you for your comments!
> >
> > On Mon, Mar 01, 2021 at 09:50:56AM +0100, Ulf Hansson wrote:
> > > + Adrian
> > >
> > > On Tue, 16 Feb 2021 at 23:43, Mårten Lindahl <marten.lindahl@axis.com> wrote:
> > > >
> > > > Sometimes SD cards that has been run for a long time enters a state
> > > > where it cannot by itself be recovered, but needs a power cycle to be
> > > > operational again. Card status analysis has indicated that the card can
> > > > end up in a state where all external commands are ignored by the card
> > > > since it is halted by data timeouts.
> > > >
> > > > If the card has been heavily used for a long time it can be weared out,
> > > > and should typically be replaced. But on some tests, it shows that the
> > > > card can still be functional after a power cycle, but as it requires an
> > > > operator to do it, the card can remain in a non-operational state for a
> > > > long time until the problem has been observed by the operator.
> > > >
> > > > This patch adds function to power cycle the card in case it does not
> > > > respond to a command, and then resend the command if the power cycle
> > > > was successful. This procedure will be tested 1 time before giving up,
> > > > and resuming host operation as normal.
> > >
> > > I assume the context above is all about the ioctl interface?
> > >
> >
> > Yes, that's correct. The problem we have seen is triggered by ioctls.
> >
> > > So, when the card enters this non functional state, have you tried
> > > just reading a block through the regular I/O interface. Does it
> > > trigger a power cycle of the card - and then makes it functional
> > > again?
> > >
> >
> > Yes, we have tried that, and it does trigger a power cycle, making the card
> > operational again. But as it requires an operator to trigger it, I thought
> > it might be something that could be automated here. At least once.
> 
> Not sure what you mean by operator here? In the end it's a userspace
> program running and I assume it can deal with error paths. :-)
> 
> In any case, I understand your point.
> 

Yes, we have a userspace program. So if the userspace program will try to
restore the card in a situation such as the one we are trying to solve
here, how shall it perform it? Is it expected that a ioctl CMD0 request
should be enough, or is there any other support for a userspace program to
reset the card?

If it falls on a ioctl command to reset the card, how do we handle the case
where the ioctl times out anyway? Or is the only way for a userspace program
to restore the card, to make a block transfer that fails?

Kind regards
Mårten

> >
> > > >
> > > > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > > > ---
> > > > Please note: This might not be the way we want to handle these cases,
> > > > but at least it lets us start the discussion. In which cases should the
> > > > mmc framework deal with error messages like ETIMEDOUT, and in which
> > > > cases should it be handled by userspace?
> > > > The mmc framework tries to recover a failed block request
> > > > (mmc_blk_mq_rw_recovery) which may end up in a HW reset of the card.
> > > > Would it be an idea to act in a similar way when an ioctl times out?
> > >
> > > Maybe, it's a good idea to allow the similar reset for ioctls as we do
> > > for regular I/O requests. My concern with this though, is that we
> > > might allow user space to trigger a HW resets a bit too easily - and
> > > that could damage the card.
> > >
> > > Did you consider this?
> > >
> >
> > Yes, that is a valid point, and that is why the power cycle is only tried
> > once. But the conditon for this reset is a -ETIMEDOUT, and this is the part of
> > this patch where I am myself not sure of if it is enough to check for. Would
> > this be an error that you could expect to happen with ioctl requests in other
> > situations also, but not necessarily cause by a stalled card?
> 
> Exactly.
> 
> Many different commands can get pushed down to the card through the
> mmc ioctl interface. It's difficult to know what error path we should
> pick, other than reporting and propagating the error codes.
> 
> [...]
> 
> Kind regards
> Uffe
