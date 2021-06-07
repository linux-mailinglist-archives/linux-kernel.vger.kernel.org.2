Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708E239E6B2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhFGScs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:32:48 -0400
Received: from foss.arm.com ([217.140.110.172]:40002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230253AbhFGScq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:32:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F8B812FC;
        Mon,  7 Jun 2021 11:30:55 -0700 (PDT)
Received: from bogus (unknown [10.57.73.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 954613F73D;
        Mon,  7 Jun 2021 11:30:53 -0700 (PDT)
Date:   Mon, 7 Jun 2021 19:30:30 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [RFC PATCH 02/10] firmware: arm_scmi: Add missing xfer
 reinit_completion
Message-ID: <20210607182924.yauvg4zli6gmulev@bogus>
References: <20210606221232.33768-1-cristian.marussi@arm.com>
 <20210606221232.33768-3-cristian.marussi@arm.com>
 <20210607174142.jdirvbasvgl7q4oj@bogus>
 <20210607180434.GC40811@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607180434.GC40811@e120937-lin>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 07:04:34PM +0100, Cristian Marussi wrote:
> Hi,
> 
> On Mon, Jun 07, 2021 at 06:42:57PM +0100, Sudeep Holla wrote:
> > On Sun, Jun 06, 2021 at 11:12:24PM +0100, Cristian Marussi wrote:
> > > Reusing timed out xfers in a loop can lead to issue if completion was not
> > > properly reinitialized.
> > >
> > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > ---
> > >  drivers/firmware/arm_scmi/driver.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > > index bee33f9c2032..759ae4a23e74 100644
> > > --- a/drivers/firmware/arm_scmi/driver.c
> > > +++ b/drivers/firmware/arm_scmi/driver.c
> > > @@ -448,6 +448,7 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
> > >  			      xfer->hdr.poll_completion);
> > >
> > >  	xfer->hdr.status = SCMI_SUCCESS;
> > > +	reinit_completion(&xfer->done);
> > >
> > 
> > What could happen after xfer_get_init->scmi_xfer_get->reinit_completion
> > that it needs to be re-initialised again. I don't see any reason for this ?
> > If there are, please state them explicitly. If this is needed, I would drop
> > the one in scmi_xfer_get().
> > 
> 
> The reason, like I explained in the other reply in hdr.status, is the
> possibility of do_xfer loops and being more defensive.
>

Understood.

> I agree that if what I blabbed in the other email is acceptable, I could
> drop the reinit_completion in xfer_get() and just use it before
> send_message().
>

I wonder if it is possible to reset only on error if possible and not
expensive of-course ?

--
Regards,
Sudeep
