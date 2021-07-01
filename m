Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7C53B9068
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 12:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbhGAKSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 06:18:55 -0400
Received: from foss.arm.com ([217.140.110.172]:50518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235939AbhGAKSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 06:18:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B87BDD6E;
        Thu,  1 Jul 2021 03:16:23 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 018313F718;
        Thu,  1 Jul 2021 03:16:19 -0700 (PDT)
Date:   Thu, 1 Jul 2021 11:16:17 +0100
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
Subject: Re: [PATCH v4 04/16] firmware: arm_scmi: Introduce monotonically
 increasing tokens
Message-ID: <20210701101617.GA17807@e120937-lin>
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-5-cristian.marussi@arm.com>
 <cb7f3259-0ad5-8ce0-15e7-2abee1f704ff@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb7f3259-0ad5-8ce0-15e7-2abee1f704ff@opensynergy.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 01, 2021 at 10:42:45AM +0200, Peter Hilber wrote:
> I find `monotonically increasing tokens' misleading, since the token may
> wrap around quite often during normal usage. How about `modulo
> incrementing'?
> 

Ok, I'll have a though about a better naming.

> On 11.06.21 18:59, Cristian Marussi wrote:
> > Tokens are sequence numbers embedded in the each SCMI message header: they
> > are used to correlate commands with responses (and delayed responses), but
> > their usage and policy of selection is entirely up to the caller (usually
> > the OSPM agent), while they are completely opaque to the callee (SCMI
> > server platform) which merely copies them back from the command into the
> > response message header.
> > This also means that the platform does not, can not and should not enforce
> > any kind of policy on received messages depending on the contained sequence
> > number: platform can perfectly handle concurrent requests carrying the same
> > identifiying token if that should happen.
> > 
> > Moreover the platform is not required to produce in-order responses to
> > agent requests, the only constraint in these regards is that in case of
> > an asynchronous message the delayed response must be sent after the
> > immediate response for the synchronous part of the command transaction.
> > 
> > Currenly the SCMI stack of the OSPM agent selects a token for the egressing
> > commands picking the lowest possible number which is not already in use by
> > an existing in-flight transaction, which means, in other words, that we
> > immediately reuse any token after its transaction has completed or it has
> > timed out: this policy indeed does simplify management and lookup of tokens
> > and associated xfers.
> > 
> > Under the above assumptions and constraints, since there is really no state
> > shared between the agent and the platform to let the platform know when a
> > token and its associated message has timed out, the current policy of early
> > reuse of tokens can easily lead to the situation in which a spurious or
> > late received response (or delayed_response), related to an old stale and
> > timed out transaction, can be wrongly associated to a newer valid in-flight
> > xfer that just happens to have reused the same token.
> > 
> > This misbehaviour on such ghost responses is more easily exposed on those
> > transports that naturally have an higher level of parallelism in processing
> > multiple concurrent in-flight messages.
> > 
> > This commit introduces a new policy of selection of tokens for the OSPM
> > agent: each new transfer now gets the next available and monotonically
> > increasing token, until tokens are exhausted and the counter rolls over.
> > 
> > Such new policy mitigates the above issues with ghost responses since the
> > tokens are now reused as late as possible (when they roll back ideally)
> > and so it is much easier to identify such ghost responses to stale timed
> > out transactions: this also helps in simplifying the specific transports
> > implementation since stale transport messages can be easily identified
> > and discarded early on in the rx path without the need to cross check
> > their actual state with the core transport layer.
> > This mitigation is even more effective when, as is usually the case, the
> > maximum number of pending messages is capped by the platform to a much
> > lower number than the whole possible range of tokens values (2^10).
> > 
> > This internal policy change in the core SCMI transport layer is fully
> > transparent to the specific transports so it has not and should not have
> > any impact on the transports implementation.
> > 
> > The empirically observed cost of such new procedure of token selection
> > amounts in the best case to ~10us out of an observed full transaction cost
> > of 3ms for the completion of a synchronous sensor reading command on a
> > platform supporting commands completion interrupts.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/common.h |  23 +++
> >  drivers/firmware/arm_scmi/driver.c | 243 +++++++++++++++++++++++++----
> >  2 files changed, 233 insertions(+), 33 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > index 6bb734e0e3ac..e64c5ca9ee7c 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -14,7 +14,10 @@
> >  #include <linux/device.h>
> >  #include <linux/errno.h>
> >  #include <linux/kernel.h>
> > +#include <linux/hashtable.h>
> > +#include <linux/list.h>
> >  #include <linux/module.h>
> > +#include <linux/refcount.h>
> >  #include <linux/scmi_protocol.h>
> >  #include <linux/types.h>
> > @@ -127,6 +130,21 @@ struct scmi_msg {
> >  	size_t len;
> >  };
> > +/**
> > + * An helper macro to lookup an xfer from the @pending_xfers hashtable
> > + * using the message sequence number token as a key.
> > + */
> > +#define XFER_FIND(__ht, __k)					\
> > +({								\
> > +	typeof(__k) k_ = __k;					\
> > +	struct scmi_xfer *xfer_ = NULL;				\
> > +								\
> > +	hash_for_each_possible((__ht), xfer_, node, k_)		\
> > +		if (xfer_->hdr.seq == k_)			\
> > +			break;					\
> > +	 xfer_;							\
> 
> There is an extra space before the return value.
> 

Ah right.

> > +})
> > +
> >  /**
> >   * struct scmi_xfer - Structure representing a message flow
> >   *
> > @@ -138,6 +156,9 @@ struct scmi_msg {
> >   *	buffer for the rx path as we use for the tx path.
> >   * @done: command message transmit completion event
> >   * @async_done: pointer to delayed response message received event completion
> > + * @users: A refcount to track the active users for this xfer
> > + * @node: An hlist_node reference used to store this xfer, alternatively, on
> > + *	  the free list @free_xfers or in the @pending_xfers hashtable
> >   */
> >  struct scmi_xfer {
> >  	int transfer_id;
> > @@ -146,6 +167,8 @@ struct scmi_xfer {
> >  	struct scmi_msg rx;
> >  	struct completion done;
> >  	struct completion *async_done;
> > +	refcount_t users;
> > +	struct hlist_node node;
> >  };
> >  struct scmi_xfer_ops;
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index 20f8f0581f3a..f0b20ddb24f4 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/io.h>
> >  #include <linux/kernel.h>
> >  #include <linux/ktime.h>
> > +#include <linux/hashtable.h>
> >  #include <linux/list.h>
> >  #include <linux/module.h>
> >  #include <linux/of_address.h>
> > @@ -65,19 +66,29 @@ struct scmi_requested_dev {
> >  	struct list_head node;
> >  };
> > +#define SCMI_PENDING_XFERS_HT_ORDER_SZ	9
> 
> Micro-optimization note: This increases struct scmi_info size to > 8 kiB (on
> 64-bit architectures). A lower size of the hash table would be enough for
> some transports.
> 

Indeed, I did not like this fixed ht, and I went for it for simplicity
at first: I would have liked to dynamically size the HT based on the real
number of pending in-flight messages declared by the transport with
max_msg (since it should be good enough to approximate an HT with the
minimum size needed to also minimize collision.) Unfortunately kernel HT
support above works only with statically sized HT, you cannot just
allocate dynamically the underlying array, all supporting macros will
break. (unless I'm missing something)

Unless I'll find a solution for this dynamic sizing, I think that sizing
it down as you proposed will be a good idea.

> > +
> >  /**
> >   * struct scmi_xfers_info - Structure to manage transfer information
> >   *
> > - * @xfer_block: Preallocated Message array
> >   * @xfer_alloc_table: Bitmap table for allocated messages.
> >   *	Index of this bitmap table is also used for message
> >   *	sequence identifier.
> >   * @xfer_lock: Protection for message allocation
> > + * @last_token: A counter to use as base to generate for monotonically
> > + *		increasing tokens.
> > + * @free_xfers: A free list for available to use xfers. It is initialized with
> > + *		a number of xfers equal to the maximum allowed in-flight
> > + *		messages.
> > + * @pending_xfers: An hashtable, indexed by msg_hdr.seq, used to keep all the
> > + *		   currently in-flight messages.
> >   */
> >  struct scmi_xfers_info {
> > -	struct scmi_xfer *xfer_block;
> >  	unsigned long *xfer_alloc_table;
> >  	spinlock_t xfer_lock;
> > +	atomic_t last_token;
> > +	struct hlist_head free_xfers;
> > +	DECLARE_HASHTABLE(pending_xfers, SCMI_PENDING_XFERS_HT_ORDER_SZ);
> >  };
> >  /**
> > @@ -203,6 +214,117 @@ void *scmi_notification_instance_data_get(const struct scmi_handle *handle)
> >  	return info->notify_priv;
> >  }
> > +/**
> > + * scmi_xfer_token_set  - Reserve and set new token for the xfer at hand
> > + *
> > + * @minfo: Pointer to Tx/Rx Message management info based on channel type
> > + * @xfer: The xfer to act upon
> > + *
> > + * Pick the next unused monotonically increasing token and set it into
> > + * xfer->hdr.seq: picking a monotonically increasing value avoids immediate
> > + * reuse of freshly completed or timed-out xfers, thus mitigating the risk
> > + * of incorrect association of a late and expired xfer with a live in-flight
> > + * transaction, both happening to re-use the same token identifier.
> > + *
> > + * Since platform is NOT required to answer our request in-order we should
> > + * account for a few rare but possible scenarios:
> > + *
> > + *  - exactly 'next_token' may be NOT available so pick xfer_id >= next_token
> > + *    using find_next_zero_bit() starting from candidate next_token bit
> > + *
> > + *  - all tokens ahead upto (MSG_TOKEN_ID_MASK - 1) are used in-flight but we
> > + *    are plenty of free tokens at start, so try a second pass using
> > + *    find_next_zero_bit() and starting from 0.
> > + *
> > + *  X = used in-flight
> > + *
> > + * Normal
> > + * ------
> > + *
> > + *		|- xfer_id picked
> > + *   -----------+----------------------------------------------------------
> > + *   | | |X|X|X| | | | | | ... ... ... ... ... ... ... ... ... ... ...|X|X|
> > + *   ----------------------------------------------------------------------
> > + *		^
> > + *		|- next_token
> > + *
> > + * Out-of-order pending at start
> > + * -----------------------------
> > + *
> > + *	  |- xfer_id picked, last_token fixed
> > + *   -----+----------------------------------------------------------------
> > + *   |X|X| | | | |X|X| ... ... ... ... ... ... ... ... ... ... ... ...|X| |
> > + *   ----------------------------------------------------------------------
> > + *    ^
> > + *    |- next_token
> > + *
> > + *
> > + * Out-of-order pending at end
> > + * ---------------------------
> > + *
> > + *	  |- xfer_id picked, last_token fixed
> > + *   -----+----------------------------------------------------------------
> > + *   |X|X| | | | |X|X| ... ... ... ... ... ... ... ... ... ... |X|X|X||X|X|
> > + *   ----------------------------------------------------------------------
> > + *								^
> > + *								|- next_token
> > + *
> > + * Context: Assumes to be called with @xfer_lock already acquired.
> > + *
> > + * Return: 0 on Success or error
> > + */
> > +static int scmi_xfer_token_set(struct scmi_xfers_info *minfo,
> > +			       struct scmi_xfer *xfer)
> > +{
> > +	unsigned long xfer_id, next_token;
> > +
> > +	/* Pick a candidate monotonic token in range [0, MSG_TOKEN_MAX - 1] */
> > +	next_token = (atomic_inc_return(&minfo->last_token) &
> > +		      (MSG_TOKEN_MAX - 1));
> > +
> > +	/* Pick the next available xfer_id >= next_token */
> > +	xfer_id = find_next_zero_bit(minfo->xfer_alloc_table,
> > +				     MSG_TOKEN_MAX, next_token);
> > +	if (xfer_id == MSG_TOKEN_MAX) {
> > +		/*
> > +		 * After heavily out-of-order responses, there are no free
> > +		 * tokens ahead, but only at start of xfer_alloc_table so
> > +		 * try again from the beginning.
> > +		 */
> > +		xfer_id = find_next_zero_bit(minfo->xfer_alloc_table,
> > +					     MSG_TOKEN_MAX, 0);
> > +		/*
> > +		 * Something is wrong if we got here since there can be a
> > +		 * maximum number of (MSG_TOKEN_MAX - 1) in-flight messages
> > +		 * but we have not found any free token [0, MSG_TOKEN_MAX - 1].
> > +		 */
> > +		if (WARN_ON_ONCE(xfer_id == MSG_TOKEN_MAX))
> > +			return -ENOMEM;
> > +	}
> > +
> > +	/* Update +/- last_token accordingly if we skipped some hole */
> > +	if (xfer_id != next_token)
> > +		atomic_add((int)(xfer_id - next_token), &minfo->last_token);
> > +
> > +	/* Set in-flight */
> > +	set_bit(xfer_id, minfo->xfer_alloc_table);
> > +	xfer->hdr.seq = (u16)xfer_id;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * scmi_xfer_token_clear  - Release the token
> > + *
> > + * @minfo: Pointer to Tx/Rx Message management info based on channel type
> > + * @xfer: The xfer to act upon
> > + */
> > +static inline void scmi_xfer_token_clear(struct scmi_xfers_info *minfo,
> > +					 struct scmi_xfer *xfer)
> > +{
> > +	clear_bit(xfer->hdr.seq, minfo->xfer_alloc_table);
> > +}
> > +
> >  /**
> >   * scmi_xfer_get() - Allocate one message
> >   *
> > @@ -212,36 +334,49 @@ void *scmi_notification_instance_data_get(const struct scmi_handle *handle)
> >   * Helper function which is used by various message functions that are
> >   * exposed to clients of this driver for allocating a message traffic event.
> >   *
> > - * This function can sleep depending on pending requests already in the system
> > - * for the SCMI entity. Further, this also holds a spinlock to maintain
> > - * integrity of internal data structures.
> > + * Picks an xfer from the free list @free_xfers (if any available), sets a
> > + * monotonically increasing token and stores the inflight xfer into the
> > + * @pending_xfers hashtable for later retrieval.
> > + *
> > + * The successfully initialized xfer is refcounted.
> > + *
> > + * Context: Holds @xfer_lock while manipulating @xfer_alloc_table and
> > + *	    @free_xfers.
> >   *
> >   * Return: 0 if all went fine, else corresponding error.
> >   */
> >  static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
> >  				       struct scmi_xfers_info *minfo)
> >  {
> > -	u16 xfer_id;
> > +	int ret;
> > +	unsigned long flags;
> >  	struct scmi_xfer *xfer;
> > -	unsigned long flags, bit_pos;
> > -	struct scmi_info *info = handle_to_scmi_info(handle);
> > -	/* Keep the locked section as small as possible */
> >  	spin_lock_irqsave(&minfo->xfer_lock, flags);
> > -	bit_pos = find_first_zero_bit(minfo->xfer_alloc_table,
> > -				      info->desc->max_msg);
> > -	if (bit_pos == info->desc->max_msg) {
> > +	if (hlist_empty(&minfo->free_xfers)) {
> >  		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> >  		return ERR_PTR(-ENOMEM);
> >  	}
> > -	set_bit(bit_pos, minfo->xfer_alloc_table);
> > -	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> > -	xfer_id = bit_pos;
> > +	/* grab an xfer from the free_list */
> > +	xfer = hlist_entry(minfo->free_xfers.first, struct scmi_xfer, node);
> > +	hlist_del_init(&xfer->node);
> > -	xfer = &minfo->xfer_block[xfer_id];
> > -	xfer->hdr.seq = xfer_id;
> > -	xfer->transfer_id = atomic_inc_return(&transfer_last_id);
> > +	/* Pick and set monotonic token */
> > +	ret = scmi_xfer_token_set(minfo, xfer);
> > +	if (!ret) {
> > +		hash_add(minfo->pending_xfers, &xfer->node, xfer->hdr.seq);
> > +	} else {
> > +		dev_err(handle->dev, "Failed to get monotonic token %d\n", ret);
> > +		hlist_add_head(&xfer->node, &minfo->free_xfers);
> > +		xfer = ERR_PTR(ret);
> > +	}
> > +	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> > +
> > +	if (!IS_ERR(xfer)) {
> > +		refcount_set(&xfer->users, 1);
> 
> Maybe it would be better to do this inside the lock, so that there is no
> (unlikely) race with refcount_inc() in scmi_xfer_acquire().
> 

I'll check on this.

Thanks,
Cristian

