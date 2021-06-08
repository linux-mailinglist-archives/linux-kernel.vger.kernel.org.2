Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D4239F33E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhFHKMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:12:50 -0400
Received: from foss.arm.com ([217.140.110.172]:54702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229923AbhFHKMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:12:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9DFF1396;
        Tue,  8 Jun 2021 03:10:56 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAB743F719;
        Tue,  8 Jun 2021 03:10:54 -0700 (PDT)
Date:   Tue, 8 Jun 2021 11:10:48 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [RFC PATCH 01/10] firmware: arm_scmi: Reset properly xfer SCMI
 status
Message-ID: <20210608101048.GD40811@e120937-lin>
References: <20210606221232.33768-1-cristian.marussi@arm.com>
 <20210606221232.33768-2-cristian.marussi@arm.com>
 <20210607173809.et6fzayvubsosvso@bogus>
 <20210607180137.GB40811@e120937-lin>
 <20210607182754.3wsmhc2t5mh36ycm@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210607182754.3wsmhc2t5mh36ycm@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Mon, Jun 07, 2021 at 07:27:54PM +0100, Sudeep Holla wrote:
> On Mon, Jun 07, 2021 at 07:01:37PM +0100, Cristian Marussi wrote:
> > On Mon, Jun 07, 2021 at 06:38:09PM +0100, Sudeep Holla wrote:
> > > On Sun, Jun 06, 2021 at 11:12:23PM +0100, Cristian Marussi wrote:
> > > > When an SCMI command transfer fails due to some protocol issue an SCMI
> > > > error code is reported inside the SCMI message payload itself and it is
> > > > then retrieved and transcribed by the specific transport layer into the
> > > > xfer.hdr.status field by transport specific .fetch_response().
> > > >
> > > > The core SCMI transport layer never explicitly reset xfer.hdr.status,
> > > > so when an xfer is reused, if a transport misbehaved in handling such
> > > > status field, we risk to see an invalid ghost error code.
> > > >
> > > > Reset xfer.hdr.status to SCMI_SUCCESS right before each transfer is
> > > > started.
> > > >
> > >
> > > Any particular reason why it can't be part of xfer_get_init which has other
> > > initialisations ? If none, please move it there.
> > >
> >
> > Well it was there initially then I moved it here.
> >
> > The reason is mostly the same as the reason for the other patch in this
> > series that adds a reinit_completion() in this same point: the core does
> > not forbid to reuse an xfer multiple times, once obtained with xfer_get()
> > or xfer_get_init(), and indeed some protocols do such a thing: they
> > implements such do_xfer looping and bails out on error.
> >
> 
> Makes sense. But it is okay to retain xfer->transfer_id for every transfer
> in such a loop ?
> 
No you are right and indeed I saw that anomaly, but I have not addressed
it since, even if wrong, it is harmless and transfer_id is really used
only for debugging/profiling, while the missing reinit_completion is
potentially broken.

> > In the way that it is implemented now in protocols poses no problem
> > indeed because the do_xfer loop bails out on error and the xfer is put,
> > but as soon as some protocol is implemented that violates this common
> > practice and it just keeps on reuse an xfer after an error fo other
> > do_xfers() this breaks...so it seemed more defensive to just reinit the
> > completion and the status before each send.
> 
> Fair enough. But they use it to send same message I guess, may be if it
> gave error or something ? I would like to really know such a sequence
> instead of assisting that 😉. 
> 

So the current real 'looping do_xfer' behavior is safe and so this missing
reinit is only potentially broken in the future, and we cannot really
know now in advance about some future protocol needs, but it seems as of now
wrong that you'll want to keep going on and reuse an xfer for the same command
after an error in your loop.

On the other side we allow such behaviour, so I thought was good to
provide a safe net if it is misused.

But, beside this patches, that, as said, are more defensive that strictly
needed as of now, I think now it's worth mentioning that this same 'issue'
affects also, as an example, the new mechanism I introduced later in this
same series to always use monotonically increasing sequence number for
outgoing messages.

In that case I stick to the current behavior and I assign such monotonically
increasing sequence numbers to message during xfer_get, but the potential
issue is the same: if a do_xfer loop is used you end up reusing the same
seq_num for multiple do_xfers (so defeating really the mechanism itself
that aims not to reuse immediately the most recently used seq_num).

In that case I did this to keep it simple and to avoid placing more burden
on tx path by picking and assigning a seq_num upon each transfer...but, again,
also this behavior of picking a seq_num only at xfer_get is NOT really broken
as of now even for do_xfer loops since we bail out on error and you won't
really reuse that xfer.

It's just that in this seq_num selection case seems to add a lot of burden
and complexity if moved to the do_xfer phase, while status/reinit seemed
to me cheaper to move it in the do_xfer so I tried to play defensive.

At the end, in general I would say that all of these ops (status/reinit/
seq_nums/transfer_id) DO really belong logically to the do_xfer phase more than
to the xfer_get/xfer_get_init, but in reality we can cope with having them
@xfer_get/get_init and this keeps things simple and reduce burden, especially
in the monotonic seq_nums case: so I am not so sure anymore if it is fine to
move reinit/status to the do_xfer, as proposed here, while keeping seq_nums
(for good reasons) to the xfer_get phase, because we'd use 2 different strategies
to address similar issues.

I would say: just keep reinit and status in the xfer_get phase instead and
maybe warn somehow if a failed xfer is detected being reused. (but this
would anyway need a check in every tx transaction to see if status != SUCCESS
so is it worth ?)

Lot of overthinking for a one-liner :D ... sorry

Thanks,
Cristian


> --
> Regards,
> Sudeep
