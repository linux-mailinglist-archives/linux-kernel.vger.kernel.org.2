Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1A73D89CB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhG1Ibd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:31:33 -0400
Received: from foss.arm.com ([217.140.110.172]:52658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234311AbhG1Ibb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:31:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B2FD1FB;
        Wed, 28 Jul 2021 01:31:30 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD8AC3F73D;
        Wed, 28 Jul 2021 01:31:27 -0700 (PDT)
Date:   Wed, 28 Jul 2021 09:31:25 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, sudeep.holla@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        igor.skalkin@opensynergy.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: Re: [PATCH v6 07/17] firmware: arm_scmi: Handle concurrent and
 out-of-order messages
Message-ID: <20210728083125.GJ49078@e120937-lin>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-8-cristian.marussi@arm.com>
 <a163653c-51f9-adf0-c978-b747ddf2498a@opensynergy.com>
 <20210719091451.GF49078@e120937-lin>
 <85868de4-54bf-cca8-3786-61a404b80117@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85868de4-54bf-cca8-3786-61a404b80117@opensynergy.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 10:32:58AM +0200, Peter Hilber wrote:
> On 19.07.21 11:14, Cristian Marussi wrote:
> > On Thu, Jul 15, 2021 at 06:36:03PM +0200, Peter Hilber wrote:
> > > On 12.07.21 16:18, Cristian Marussi wrote:
> 
> [snip]
> 
> > > > @@ -608,6 +755,7 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
> > > >    			      xfer->hdr.protocol_id, xfer->hdr.seq,
> > > >    			      xfer->hdr.poll_completion);
> > > > +	xfer->state = SCMI_XFER_SENT_OK;
> > > 
> > > To be completely safe, this assignment could also be protected by the
> > > xfer->lock.
> > > 
> > 
> > In fact this would be true being xfer->lock meant to protect the state but it
> > seemed to me unnecessary here given that this is a brand new xfer with a
> > brand new (monotonic) seq number so that any possibly late-received msg will
> > carry an old stale seq number certainly different from this such that cannot be
> > possibly mapped to this same xfer. (but just discarded on xfer lookup in
> > xfer_command_acquire)
> > 
> > The issue indeed could still exist only for do_xfer loops (as you pointed out
> > already early on) where the seq_num is used, but in that case on a timeout we
> > would have already bailed out of the loop and reported an error so any timed-out
> > late received response would have been anyway discarded; so at the end I thought
> > I could avoid spinlocking here.
> > 
> > Thanks,
> > Cristian
> > 

Hi Peter,

sorry for the late answer.

> 
> I mostly meant to refer to the possibility of a very fast response not
> seeing this assignment, since the next line is
> 
> >  	ret = info->desc->ops->send_message(cinfo, xfer);
> 
> and during that a regular scmi_rx_callback(), reading xfer->state, can
> already arrive. But maybe this is too theoretical.
> 

Right, that's a possibility indeed to account for even if remote: given
that, though, no race is possible here on state as said, I'd still avoid the
spinlock and related irq-off and opt instead for a barrier to avoid
re-ordering and to be sure that the scmi_rx_callback() on the RX processor
can see the latest value (a dmb(ish) + cache coherence magic should be enough)

Thanks,
Cristian
