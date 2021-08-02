Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1313DD398
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 12:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbhHBKZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 06:25:46 -0400
Received: from foss.arm.com ([217.140.110.172]:33118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231854AbhHBKZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 06:25:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84319D6E;
        Mon,  2 Aug 2021 03:25:35 -0700 (PDT)
Received: from bogus (unknown [10.57.37.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 643283F70D;
        Mon,  2 Aug 2021 03:25:31 -0700 (PDT)
Date:   Mon, 2 Aug 2021 11:24:25 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        peter.hilber@opensynergy.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: Re: [PATCH v6 06/17] firmware: arm_scmi: Introduce monotonically
 increasing tokens
Message-ID: <20210802102425.67bhbvyrgzio7zzg@bogus>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-7-cristian.marussi@arm.com>
 <20210728141746.chqwhspnwviz67xn@bogus>
 <20210728165430.GJ6592@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728165430.GJ6592@e120937-lin>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 05:54:30PM +0100, Cristian Marussi wrote:
> On Wed, Jul 28, 2021 at 03:17:46PM +0100, Sudeep Holla wrote:
> > On Mon, Jul 12, 2021 at 03:18:22PM +0100, Cristian Marussi wrote:

[...]

> > >  
> > > +#define SCMI_PENDING_XFERS_HT_ORDER_SZ	9
> > > +
> > 
> > Is there any particular reason to choose half the token size as hash bucket
> > size ? IOW why not 1/3 or 1/4th of it ? I would appreciate a comment here.
> > I see it is mentioned in the commit log. Also is it not better to associate
> > or keep it close to MSG_TOKEN_ID_MASK and associated macros.
> > 
> 
> I'll move this in the proper place where associated macros are defined.
> 
> The reason for the size choice is tricky (and not sure about its value
> still...so I have not commented yet :D); the ideal size of this hashtable would
> be desc->max_msg so equal to the maximum number of inflight messages allowed on
> the system in order to minimize (probably to zero) collisions on the hashtable:
> unfortunately max_msg is only finally available at runtime time and the
> kernel hashtable is statically sized by design....
> 
> I tried to play some tricks to define dynamically the size but everything falls
> apart since a lot of stuff in linux/hashtable.h is based on ARRAY_SIZE() and
> friends (to speedup all I suppose). Another non-fit (in my opinion)
> alternative would be using relativistic hashtable (linux/rhashtable.h) but
> those are definitely overkill in our case since they are hashtables that
> can be resized completely at runtime while populated O_o. (with even
> more overhead)
> 
> At the end the size that fits all possible in-flight messages minimizing
> collisions in any possible case that I can set at compile time would be 10,
> which means really 2^10 1024 HT entries (equal to MAX_MSG_TOKEN) each of which
> is a struct list_head (*prev,*next 16bytes) i.e. 16KB HT: Peter pointed out
> that it would be a lot of wasted space on normal systems in which max in-flight
> messages are far-less than 1024 AND would not even fit in one 4Kb page, so I
> reduced it to 512 entries but the best would be 256 (8) if we want to
> fit in one regular 4kb page. The drawback will be a bit of HT collisions on
> system with more than 256 possible and effective in-flight messages.
>

I agree, 256 should be fine for now. Just add a note that it is chosen to
fit a page and can be updated if required.


> > >  /**
> > >   * struct scmi_xfers_info - Structure to manage transfer information
> > >   *
> > > - * @xfer_block: Preallocated Message array
> > >   * @xfer_alloc_table: Bitmap table for allocated messages.
> > >   *	Index of this bitmap table is also used for message
> > >   *	sequence identifier.
> > >   * @xfer_lock: Protection for message allocation
> > > + * @last_token: A counter to use as base to generate for monotonically
> > > + *		increasing tokens.
> > > + * @free_xfers: A free list for available to use xfers. It is initialized with
> > > + *		a number of xfers equal to the maximum allowed in-flight
> > > + *		messages.
> > > + * @pending_xfers: An hashtable, indexed by msg_hdr.seq, used to keep all the
> > > + *		   currently in-flight messages.
> > >   */
> > >  struct scmi_xfers_info {
> > > -	struct scmi_xfer *xfer_block;
> > >  	unsigned long *xfer_alloc_table;
> > >  	spinlock_t xfer_lock;
> > > +	atomic_t last_token;
> > 
> > Can we merge this and transfer_last_id ? Let this be free running like
> > transfer_last_id and just use [0-9] from this ? I don't see any point
> > having 2 different monotonically increasing tokens/id.
> > 
> 
> Mmm I was tempted about that, but the reason I did not was that in some
> rare limit condition as you can see in the ASCII art (:O) I can find a hole in
> the next available token ids so I have to skip and update last_token itself,
> not sure if this could cause confusion seeing transfer_ids with holes during
> tracing if I unify them.
>

That should be fine as it won't be used at all.

-- 
Regards,
Sudeep
