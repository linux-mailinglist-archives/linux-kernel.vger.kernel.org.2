Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7CC30B35D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 00:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhBAXTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 18:19:54 -0500
Received: from mx1.opensynergy.com ([217.66.60.4]:43500 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhBAXTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 18:19:44 -0500
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 33F0EA1572;
        Tue,  2 Feb 2021 00:19:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=3eKKNhOJEF9l
        OOLKO3Ak9sBWvWnl92eP7oY9x7qFmWU=; b=h0Hawfh2dhk8PvkuVo/Sw+LPhGVz
        dqjsD10z7Qbi1qAApcLhB+LVBb7oZ7rBkK3ZLWuVv/q63CmsXndzv1+cr38MUIng
        +XR61zxw/EKMiwZji5tFdWV+/mD5V5eILIB/kn7FtgCHhypwNsobpOFR+j10QD2A
        Av4+rpTehW81WYHD3miqNXiJ6dg3VNFZ0Xy3o1OC4PjT3S1+46wmpWjpV69owxnc
        KM0rdfOYQpBuN09CbSX20pDhTUAA1IXMsOnAqx7HY1mwv3tDuMaNFmjRZgZoY+Xb
        BFyyWG3u/ThpC1qYOsD2dK6MRdB8EhS4xIuQA/EXjK0Md3oWOG9m7hhQuw==
Subject: Re: [virtio-dev] Re: [PATCH v2 3/9] ALSA: virtio: handling control
 messages
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>,
        <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
 <20210124165408.1122868-4-anton.yakovlev@opensynergy.com>
 <7436cb6-111c-4ac5-88ee-8e103ded954b@intel.com>
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <1418aae0-0970-6ff1-db5b-fd248557c5be@opensynergy.com>
Date:   Tue, 2 Feb 2021 00:18:58 +0100
MIME-Version: 1.0
In-Reply-To: <7436cb6-111c-4ac5-88ee-8e103ded954b@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25.01.2021 16:22, Guennadi Liakhovetski wrote:
 > I think the use of (devm_)kmalloc() and friends needs some refinement in
 > several patches in the series.

Maybe yes, but using non-managed resources will slightly complicate the
device removing path.


...[snip]...


 >> +/**
 >> + * virtsnd_ctl_msg_alloc_ext() - Allocate and initialize a control
 >> message.
 >> + * @vdev: VirtIO parent device.
 >> + * @request_size: Size of request header (pointed to by sg_request
 >> field).
 >> + * @response_size: Size of response header (pointed to by sg_response
 >> field).
 >> + * @sgs: Additional data to attach to the message (may be NULL).
 >> + * @out_sgs: Number of scattergather elements to attach to the
 >> request header.
 >> + * @in_sgs: Number of scattergather elements to attach to the
 >> response header.
 >> + * @gfp: Kernel flags for memory allocation.
 >> + *
 >> + * The message will be automatically freed when the ref_count value
 >> is 0.
 >> + *
 >> + * Context: Any context. May sleep if @gfp flags permit.
 >> + * Return: Allocated message on success, ERR_PTR(-errno) on failure.
 >> + */
 >> +struct virtio_snd_msg *virtsnd_ctl_msg_alloc_ext(struct virtio_device
 >> *vdev,
 >> +                                              size_t request_size,
 >> +                                              size_t response_size,
 >> +                                              struct scatterlist *sgs,
 >> +                                              unsigned int out_sgs,
 >> +                                              unsigned int in_sgs,
 >> gfp_t gfp)
 >> +{
 >> +     struct virtio_snd_msg *msg;
 >> +     size_t msg_size =
 >> +             sizeof(*msg) + (1 + out_sgs + 1 + in_sgs) *
 >> sizeof(*msg->sgs);
 >> +     unsigned int i;
 >> +
 >> +     msg = devm_kzalloc(&vdev->dev, msg_size + request_size +
 >> response_size,
 >> +                        gfp);
 >
 > Messages are short-lived, right? So, I think their allocation and freeing
 > has to be explicit, no need for devm_.

If explicit allocating and freeing is more appropriate here, then let it
be. Moreover, when deleting the control virtqueue, all pending messages
must be explicitly canceled. It should not be that hard to add explicit
freeing there.


...[snip]...


 >> +
 >> +/**
 >> + * virtsnd_ctl_msg_send() - Send an (asynchronous) control message.
 >> + * @snd: VirtIO sound device.
 >> + * @msg: Control message.
 >> + *
 >> + * If a message is failed to be enqueued, it will be deleted. If
 >> message content
 >> + * is still needed, the caller must additionally to
 >> virtsnd_ctl_msg_ref/unref()
 >> + * it.
 >> + *
 >> + * Context: Any context. Takes and releases the control queue spinlock.
 >> + * Return: 0 on success, -errno on failure.
 >> + */
 >> +int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct
 >> virtio_snd_msg *msg)
 >> +{
 >> +     struct virtio_device *vdev = snd->vdev;
 >> +     struct virtio_snd_queue *queue = virtsnd_control_queue(snd);
 >> +     struct virtio_snd_hdr *response = sg_virt(&msg->sg_response);
 >> +     bool notify = false;
 >> +     unsigned long flags;
 >> +     int rc = -EIO;
 >> +
 >> +     /* Set the default status in case the message was not sent or was
 >> +      * canceled.
 >> +      */
 >> +     response->code = cpu_to_virtio32(vdev, VIRTIO_SND_S_IO_ERR);
 >> +
 >> +     spin_lock_irqsave(&queue->lock, flags);
 >> +     if (queue->vqueue) {
 >
 > Is it allowed for queue->vqueue to be NULL?

In general it is possible. The device may request a reset when actively
used. In this case, we don't want to allow further use of the virtqueues.


 >> +             rc = virtqueue_add_sgs(queue->vqueue, msg->sgs,
 >> msg->out_sgs,
 >> +                                    msg->in_sgs, msg, GFP_ATOMIC);
 >> +             if (!rc) {
 >> +                     notify = virtqueue_kick_prepare(queue->vqueue);
 >> +                     list_add_tail(&msg->list, &snd->ctl_msgs);
 >> +             }
 >> +     }
 >> +     spin_unlock_irqrestore(&queue->lock, flags);
 >> +
 >> +     if (!rc) {
 >> +             if (!notify || virtqueue_notify(queue->vqueue))
 >> +                     return 0;
 >> +
 >> +             spin_lock_irqsave(&queue->lock, flags);
 >> +             list_del(&msg->list);
 >> +             spin_unlock_irqrestore(&queue->lock, flags);
 >> +     }
 >> +
 >> +     virtsnd_ctl_msg_unref(snd->vdev, msg);
 >> +
 >> +     return -EIO;
 >
 > wouldn't "return rc" be better here?

Yes, that would probably be better as there is no harm in propagating
the error returned by virtqueue_add_sgs.


 >> +}
 >> +
 >> +/**
 >> + * virtsnd_ctl_msg_send_sync() - Send a (synchronous) control message.
 >> + * @snd: VirtIO sound device.
 >> + * @msg: Control message.
 >> + *
 >> + * After returning from this function, the message will be deleted.
 >> If message
 >> + * content is still needed, the caller must additionally to
 >> + * virtsnd_ctl_msg_ref/unref() it.
 >> + *
 >> + * The msg_timeout_ms module parameter defines the message completion
 >> timeout.
 >> + * If the message is not completed within this time, the function
 >> will return an
 >> + * error.
 >> + *
 >> + * Context: Any context. Takes and releases the control queue spinlock.
 >> + * Return: 0 on success, -errno on failure.
 >> + *
 >> + * The return value is a message status code (VIRTIO_SND_S_XXX)
 >> converted to an
 >> + * appropriate -errno value.
 >> + */
 >> +int virtsnd_ctl_msg_send_sync(struct virtio_snd *snd,
 >> +                           struct virtio_snd_msg *msg)
 >> +{
 >> +     struct virtio_device *vdev = snd->vdev;
 >> +     unsigned int js = msecs_to_jiffies(msg_timeout_ms);
 >> +     struct virtio_snd_hdr *response;
 >> +     int rc;
 >> +
 >> +     virtsnd_ctl_msg_ref(vdev, msg);
 >> +
 >> +     rc = virtsnd_ctl_msg_send(snd, msg);
 >> +     if (rc)
 >> +             goto on_failure;
 >> +
 >> +     rc = wait_for_completion_interruptible_timeout(&msg->notify, js);
 >> +     if (rc <= 0) {
 >> +             if (!rc) {
 >> +                     struct virtio_snd_hdr *request =
 >> +                             sg_virt(&msg->sg_request);
 >> +
 >> +                     dev_err(&vdev->dev,
 >> +                             "control message (0x%08x) timeout\n",
 >> +                             le32_to_cpu(request->code));
 >> +                     rc = -EIO;
 >
 > Wouldn't -ETIMEDOUT be better here?

Yes, it would be.


 >> +             }
 >> +
 >> +             goto on_failure;
 >> +     }
 >> +
 >> +     response = sg_virt(&msg->sg_response);
 >> +
 >> +     switch (le32_to_cpu(response->code)) {
 >> +     case VIRTIO_SND_S_OK:
 >> +             rc = 0;
 >> +             break;
 >> +     case VIRTIO_SND_S_BAD_MSG:
 >> +             rc = -EINVAL;
 >> +             break;
 >> +     case VIRTIO_SND_S_NOT_SUPP:
 >> +             rc = -EOPNOTSUPP;
 >> +             break;
 >> +     case VIRTIO_SND_S_IO_ERR:
 >> +             rc = -EIO;
 >> +             break;
 >> +     default:
 >> +             rc = -EPERM;
 >
 > any special reason for EPERM as a default error code? I think often 
EINVAL
 > is used in similar cases.

No, there is no particular reason, I just wasn't sure what to choose for
the default value.


 >> +             break;
 >> +     }
 >> +
 >> +on_failure:
 >
 > cosmetic: this path is also taken on success, so maybe better just call
 > the lable "exit" or similar.

Ok! Then I probably need to check for other goto cases as well.


...[snip]...


 >> +
 >> +/**
 >> + * virtsnd_ctl_msg_unref() - Decrement reference counter for the
 >> message.
 >> + * @vdev: VirtIO parent device.
 >> + * @msg: Control message.
 >> + *
 >> + * The message will be freed when the ref_count value is 0.
 >> + *
 >> + * Context: Any context.
 >> + */
 >> +static inline void virtsnd_ctl_msg_unref(struct virtio_device *vdev,
 >> +                                      struct virtio_snd_msg *msg)
 >> +{
 >> +     if (!atomic_dec_return(&msg->ref_count))
 >
 > Since you use atomic operations, this function can probably be called 
with
 > no additional locking right? But if so, couldn't it be preempted here
 > between the check and the call to kfree()? As was mentioned in a previous
 > review, the use of atomic operations in this series has to be very
 > carefully examined...

The control message workflow is implemented in such a way that all
necessary increments occur before the first possible call to this
function. So even if preemption does occur, it shouldn't be a problem.


 >> +             devm_kfree(&vdev->dev, msg);
 >> +}
 >> +


...[snip]...


 >
 > ---------------------------------------------------------------------
 > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
 > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
 >
 >
-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

www.opensynergy.com

