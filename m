Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6A738F7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 04:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhEYCOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 22:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhEYCOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 22:14:23 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED3FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 19:12:54 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1llMYV-000d1X-M4; Tue, 25 May 2021 02:12:27 +0000
Date:   Tue, 25 May 2021 02:12:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Phi Nguyen <phind.uet@gmail.com>
Cc:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        phil@raspberrypi.com, amarjargal16@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vchiq_arm: Using copy_from_user() to copy data
 from userspace address
Message-ID: <YKxdCwsEb49Siwo6@zeniv-ca.linux.org.uk>
References: <20210522053429.82710-1-phind.uet@gmail.com>
 <YKilx7iNSBYYbXSs@zeniv-ca.linux.org.uk>
 <51eaace6-e464-147f-85be-ec8188e0e2ef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51eaace6-e464-147f-85be-ec8188e0e2ef@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 01:26:23AM +0800, Phi Nguyen wrote:
> On 22/5/21 2:33 pm, Al Viro wrote:
> > On Sat, May 22, 2021 at 01:34:29PM +0800, Nguyen Dinh Phi wrote:
> > > This commit to fix the following sparse warning:
> > > incorrect type in assignment (different address spaces)
> > > expected void *[assigned] userdata
> > > got void [noderef] __user *userdata
> > > 
> > > Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> > > ---
> > >   .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c    | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > > index afbf01b7364c..2a4fc599f977 100644
> > > --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > > +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > > @@ -960,7 +960,10 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
> > >   			current->pid);
> > >   		userdata = &waiter->bulk_waiter;
> > >   	} else {
> > > -		userdata = args->userdata;
> > > +		if (copy_from_user(userdata, args->userdata, sizeof(args->userdata))) {
> > 
> > 	The contents of userdata (local variable of type void *) is uninitialized at that
> > point.
> Sorry, That was my mistake.
> 
> > Just what do you think that call of copy_from_user() would do?
> 
> Because according to the definition of struct vchiq_queue_bulk_transfer, the
> args->userdata pointer is userspace address.

That it is, but I'd asked "what would it do", not "why did it make sparse STFU"...

Seriously, the first question should always be "what is it doing", not "what
change would make given heuristics stop triggering"; after all, removing that
assignment would also eliminate the warning.  So would replacing it with
	if (((unsigned long)args->userdata) % 10000 == 6969)
		printk(KERN_INFO "address in decimal form is somewhat obscene");
for that matter.

Folks, warnings are not oracles or entities to be appeased.  Their role is
different - they are heuristics pointing to the places that might (or might
not) be worth looking into.  "It looks odd, something might be mangled nearby,
someone better take a look".  THAT'S IT.  They can't pass the Turing Test;
all they can do is flag a funny-looking place for somebody who *can*.  And
(hopefully) provide some summary of what looks odd there.

It's not hard to confuse sparse (or gcc, or clang, or whatever tool you are
using) into not noticing anything odd.  The thing one should never, ever
do is the "I don't understand what's going on there, I don't understand
what (if anything) I'd changed, but $TOOL doesn't complain anymore" kind
of patches.

I'm not familiar with the code in question, so all I can do is to look
around and try to figure out what's going on.  Let's see:

The function in question is vchiq_irq_queue_bulk_tx_rx().  Warning complains
about the value of args->userdata being stored in local variable (userdata),
possibly mixing userland and kernel pointers.  That sits in one of the
branches cascade of ifs (happens when args->mode, whatever that might be,
is neither VCHIQ_BULK_MODE_BLOCKING nor VCHIQ_BULK_MODE_WAITING, whatever
those might be).  In other branches the same local variable gets
assigned &waiter->bulk_waiter (whatever that, etc.) and at least in
one of those waiter had just been returned by kzalloc(), so it definitely
can be pointing to kernel memory.  In the other branch it's been looked
up in some kind of list, and seeing that we dereference other members
of the same structure in there, it would better be in kernel memory
as well.

OK, so far it looks genuine.  What do we do with that pointer afterwards?
        status = vchiq_bulk_transfer(args->handle, NULL, args->data, args->size,
					     userdata, args->mode, dir);
Hmm...  The value of args->mode had been passed along with it, so it's
not impossible that the thing it calls acts differently depending upon
that.

Next question: where is that thing called and what does it get in args?

        case VCHIQ_IOC_QUEUE_BULK_TRANSMIT:
        case VCHIQ_IOC_QUEUE_BULK_RECEIVE: {
                struct vchiq_queue_bulk_transfer args;
                struct vchiq_queue_bulk_transfer __user *argp;

                enum vchiq_bulk_dir dir =
                        (cmd == VCHIQ_IOC_QUEUE_BULK_TRANSMIT) ?
                        VCHIQ_BULK_TRANSMIT : VCHIQ_BULK_RECEIVE;

                argp = (void __user *)arg;
                if (copy_from_user(&args, argp, sizeof(args))) {
                        ret = -EFAULT;
                        break;
                }

                ret = vchiq_irq_queue_bulk_tx_rx(instance, &args,
                                                 dir, &argp->mode);
        } break;

Uh-oh...  At least here args->mode can be whatever the hell user has passed,
and so can args->userdata.  Another caller is
        if (copy_from_user(&args32, argp, sizeof(args32)))
                return -EFAULT;

        args = (struct vchiq_queue_bulk_transfer) {
                .handle   = args32.handle,
                .data     = compat_ptr(args32.data),
                .size     = args32.size,
                .userdata = compat_ptr(args32.userdata),
                .mode     = args32.mode,
        };

        return vchiq_irq_queue_bulk_tx_rx(file->private_data, &args,
                                          dir, &argp->mode);
and those two look like ioctl() and the variant of the same for 32bit
processes.  And yes, that's definitely meant to be a userland pointer.
It does smell fishy, all right.  Now, what is that pointer passed to
and what's done with it there? <greps> Looks like it lives at
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:3055

Yup, we do look at the mode there:
        switch (mode) {
        case VCHIQ_BULK_MODE_NOCALLBACK:
        case VCHIQ_BULK_MODE_CALLBACK:
                break;
        case VCHIQ_BULK_MODE_BLOCKING:
                bulk_waiter = userdata;
                init_completion(&bulk_waiter->event);
                bulk_waiter->actual = 0;
                bulk_waiter->bulk = NULL;
                break;
        case VCHIQ_BULK_MODE_WAITING:
                bulk_waiter = userdata;
                bulk = bulk_waiter->bulk;
                goto waiting;
        default:
                goto error_exit;
        }
So presumably only those 4 values are accepted.  In the last two
we copy the pointer to (local) bulk_waiter, and that's the cases
where we had a kernel pointer passed to that sucker.  In the other
two we don't use it (yet) and bulk_waiter is... <checks> left NULL.
Downstream from there we have this:
        bulk = &queue->bulks[BULK_INDEX(queue->local_insert)];

        bulk->mode = mode;
        bulk->dir = dir;
        bulk->userdata = userdata;
        bulk->size = size;
        bulk->actual = VCHIQ_BULK_ACTUAL_ABORTED;
then spew the pointer into syslog (presumably) in
        vchiq_log_info(vchiq_core_log_level,
                "%d: bt (%d->%d) %cx %x@%pad %pK",
                state->id, service->localport, service->remoteport, dir_char,
                size, &bulk->data, userdata);
and that's it - we don't use that argument anymore.  OK...
What the hell is that 'bulk' thing, anyway?
        struct vchiq_bulk *bulk;
Let's see...  Declared with void *userdata, which isn't saying much; how
is it used?  Ow...  Somebody has an unhealthy attraction to that identifier -
a _lot_ of structures with member called that.  Oh, well - only 60-odd instances
of that word in the vicinity.  And most of them refer to different structures...
After trimming those:

drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:469:                              bulk->userdata = NULL;
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:492:                      bulk->userdata = NULL;
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1017:                     waiter->bulk_waiter.bulk->userdata = NULL;
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:1276:                                    waiter = bulk->userdata;
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:1295:                                            reason, NULL, bulk->userdata);
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:3133:    bulk->userdata = userdata;

Sigh...  OK, several of those simply store NULL there.  NULL is NULL, userland
or kernel...  The last hit is the assignment quoted above that had brought
that structure to our attention.  And the two before that are places that look
at it.  OK...

Around line 1276:
                                if (bulk->mode == VCHIQ_BULK_MODE_BLOCKING) {
                                        struct bulk_waiter *waiter;

                                        spin_lock(&bulk_waiter_spinlock);
                                        waiter = bulk->userdata;
                                        if (waiter) {
                                                waiter->actual = bulk->actual;
                                                complete(&waiter->event);
                                        }
                                        spin_unlock(&bulk_waiter_spinlock);

OK, that one wants the kernel pointer and looks like it gets one
(MODE_BLOCKING is one of the cases where we store a kernel pointer there,
so we should be fine, unless something changes bulk->mode somewhere else).

... and around line 1295 it's
                                } else if (bulk->mode ==
                                        VCHIQ_BULK_MODE_CALLBACK) {
                                        enum vchiq_reason reason = (bulk->dir ==
                                                VCHIQ_BULK_TRANSMIT) ?
                                                ((bulk->actual ==
                                                VCHIQ_BULK_ACTUAL_ABORTED) ?
                                                VCHIQ_BULK_TRANSMIT_ABORTED :
                                                VCHIQ_BULK_TRANSMIT_DONE) :
                                                ((bulk->actual ==
                                                VCHIQ_BULK_ACTUAL_ABORTED) ?
                                                VCHIQ_BULK_RECEIVE_ABORTED :
                                                VCHIQ_BULK_RECEIVE_DONE);
                                        status = make_service_callback(service,
                                                reason, NULL, bulk->userdata);
                                        if (status == VCHIQ_RETRY)
                                                break;
                                }
Bugger...  In this case it's "whatever the userland has passed" and the name
of the function we are passing it to is interesting - it's entirely possible
that this "userdata" thing is neither kernel nor userland pointer in this
case.  Or not...  Let's check:
static inline enum vchiq_status
make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
                      struct vchiq_header *header, void *bulk_userdata)
{

and we are dealing with the last argument.  OK...
        status = service->base.callback(reason, header, service->handle,
                bulk_userdata);
Passed as-is to whatever's that .callback() method is (another grep-friendly
name, that...)  <greps>

drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:2379:    service->base.callback = params->callback;

Copies from the member of struct vchiq_service_params_kernel of the same name,
and the rest are assignments to that:

drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c:129:                .callback               = audio_vchi_callback,
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:834:              .callback = service_callback,
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:2234:             .callback    = vchiq_keepalive_vchiq_callback,
drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c:1870:             .callback               = service_callback,

OK, so it's one of the 4 functions (both 'service_callback' are static in
their files).  Let's see...  audio_vchi_callback() ignores its last argument
completely and so does vchiq_keepalive_vchiq_callback().  vchiq_arm.c
service_callback() is... ouch.  OK, it gets spewed into syslog, then
we have
                                status = add_completion(instance, reason,
                                        NULL, user_service, bulk_userdata);
and
        return add_completion(instance, reason, header, user_service,
                bulk_userdata);
and add_completion() is doing what?
        completion->bulk_userdata = bulk_userdata;
<obscenities> All right, what's _that_ about?  It's in
struct vchiq_completion_data_kernel {
        enum vchiq_reason reason;
        struct vchiq_header *header;
        void *service_userdata;
        void *bulk_userdata;
};
and it's used only in
                /*
                 * FIXME: address space mismatch, does bulk_userdata
                 * actually point to user or kernel memory?
                 */
                user_completion.bulk_userdata = completion->bulk_userdata;

                if (vchiq_put_completion(args->buf, &user_completion, ret)) {
                        if (ret == 0)
                                ret = -EFAULT;
                        break;
                }
that put_completion thing being basically copy_to_user().  OK, so that looks
like an opaque cookie identifying user request(?) and passed back to userland
when some event happens.  All right, assuming the genuine kernel pointers
can't leak out that way...

The last instance (mmal one):
static enum vchiq_status service_callback(enum vchiq_reason reason,
                                          struct vchiq_header *header,
                                          unsigned int handle, void *bulk_ctx)
and the last argument is used in
                bulk_receive_cb(instance, bulk_ctx);
and
                bulk_abort_cb(instance, bulk_ctx);

What.  The.  Hell?
static void bulk_receive_cb(struct vchiq_mmal_instance *instance,
                            struct mmal_msg_context *msg_context)
{
        msg_context->u.bulk.status = 0; 

        /* schedule the port callback */
        schedule_work(&msg_context->u.bulk.work);
}
_that_ is definitely expecting a kernel pointer.  And so does
static void bulk_abort_cb(struct vchiq_mmal_instance *instance,
                          struct mmal_msg_context *msg_context)
{
        pr_err("%s: bulk ABORTED msg_context:%p\n", __func__, msg_context);

        msg_context->u.bulk.status = -EINTR;

        schedule_work(&msg_context->u.bulk.work);
}
Incidentally, other callers of make_service_callback() are passing NULL
to it, apparenly ending up with NULL passed all the way down to those two.
How does it manage to avoid oopsing?

	No, wait - it's actually even messier than that.  There are several
ways towards that assignment of bulk->userdata.  vchiq_irq_queue_bulk_tx_rx()
is not the only thing that calls vchiq_bulk_transfer().  There's also
vchiq_bulk_transmit(), vchiq_bulk_receive() and vchiq_blocking_bulk_transfer().
The last one passes VCHIQ_BULK_MODE_BLOCKING as mode and kernel pointer
as 'userdata'; that's an expected combination.  vchiq_bulk_transmit() is
called with VCHIQ_BULK_MODE_BLOCKING / NULL combination.  And
vchiq_bulk_receive() is used by that mmal thing (and nowhere else)
and it gets VCHIQ_BULK_MODE_CALLBACK / msg_context (kernel pointer).
vchiq_irq_queue_bulk_tx_rx() is not used by mmal at all.  That's how
it (presumably) manages to avoid stepping into oopsen there.

	So...   Looks like the rules for userdata argument of
vchiq_bulk_transfer() are
* if mode is VCHIQ_BULK_MODE_BLOCKING or VCHIQ_BULK_MODE_WAITING,
it's a (kernel) pointer to struct bulk_waiter
* if mode is VCHIQ_BULK_MODE_NOCALLBACK, completely ignored
* if mode is VCHIQ_BULK_MODE_CALLBACK, whatever the fuck is expected by
service->base.callback when 'reason' is one of
VCHIQ_BULK_{SEND,RECEIVE}_{ABORTED,DONE}; type safety?  Wassat?
Avoiding mismatches is up to whatever leads to call of vchiq_bulk_transfer()...

For vchiq-mmal it's struct mmal_msg_context *; for vchiq_irq_queue_bulk_tx_rx()
(ioctls) it's an opaque cookie supplied by userland and copied back on
completion.  And AFAICS nothing else can lead down that way...

Oh, and 'userdata' is a fairly gross misnomer.  Misannotated one in case of
struct vchiq_queue_bulk_transfer.  I would replace it with unsigned long,
but it's much too late for that.

Conclusions:
	* the code in question most definitely does smell fishy, along with
rather wide area around it.  As in "who the hell has dumped a truckload
of herring on hot tarmac and let it sit there for days?"
	* that "userland pointer" is actually misannotated; as far as the
kernel is concerned, it's an opaque 32bit or 64bit value that might or
might not contain an address of some sort - the kernel never uses it for
any kind of memory access.
	* no, we do *NOT* want to copy whatever it might be pointing to
into the kernel space.  Incidentally, if it *is* a pointer, we have no
way to tell what it points to, so how much would we copy into the kernel
space anyway?
	* vendor drivers suck.  Looking into those can easily lead to
acute nausea; if analysis starts to uncover something _that_ ugly, the
best thing to do is to pass it to somebody else.  This one is among the
worse ones - usually the things are milder.
