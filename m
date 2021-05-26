Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C039391A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbhEZOmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:42:15 -0400
Received: from foss.arm.com ([217.140.110.172]:45824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233371AbhEZOmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:42:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E65CB1516;
        Wed, 26 May 2021 07:40:40 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E95F3F73D;
        Wed, 26 May 2021 07:40:37 -0700 (PDT)
Date:   Wed, 26 May 2021 15:40:35 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org,
        Igor Skalkin <igor.skalkin@opensynergy.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com, souvik.chakravarty@arm.com,
        alex.bennee@linaro.org, jean-philippe@linaro.org,
        mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com,
        Vasyl Vavrychuk <Vasyl.Vavrychuk@opensynergy.com>,
        Andriy Tryshnivskyy <Andriy.Tryshnivskyy@opensynergy.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH v3 11/12] firmware: arm_scmi: Add virtio transport
Message-ID: <20210526144035.GN28060@e120937-lin>
References: <20210511002040.802226-1-peter.hilber@opensynergy.com>
 <20210511002040.802226-12-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511002040.802226-12-peter.hilber@opensynergy.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

as anticipated I'm adding some new SCMI core mechanisms that should help
simplyfying virtio-scmi series.

Such core work is still in progress (and to be properly reviewed) and it
is at:

https://lore.kernel.org/linux-arm-kernel/20210524231503.34924-1-cristian.marussi@arm.com/

but in the meantime I have an initial but working (for me at least :D)
rework of your V3 virtio-scmi series; rework is still in progress and to be
cleaned up (nor I have addressed probing sequence or polling mode), and I am
anyway holding it for now since Rob asked about DT txt-to-yaml conversion
too, BUT if you can or want to have a look in the meantime, you can find the
whole V4 transitional series rebased on top of my core changes with some
changes on top at:

https://gitlab.arm.com/linux-arm/linux-cm/-/commits/scmi_virtio_trans_V4_rework/

where:

 - I dropped V3 patches 7,8,12
 - the virtio changes I applied to make use of my core changes are all
   embedded in the last patch (just for now):
   
 	[RFC] firmware: arm_scmi: make virtio-scmi use delegated xfers

Definitely not the final version, so you may want to just wait for a
real V4, but just to give an idea of the direction I'm trying to follow
if you want.

Thanks,
Cristian

On Tue, May 11, 2021 at 02:20:39AM +0200, Peter Hilber wrote:
> From: Igor Skalkin <igor.skalkin@opensynergy.com>
> 
> This transport enables accessing an SCMI platform as a virtio device.
> 
> Implement an SCMI virtio driver according to the virtio SCMI device spec
> [1]. Virtio device id 32 has been reserved for the SCMI device [2].
> 
> The virtio transport has one Tx channel (virtio cmdq, A2P channel) and
> at most one Rx channel (virtio eventq, P2A channel).
> 
> The following feature bit defined in [1] is not implemented:
> VIRTIO_SCMI_F_SHARED_MEMORY.
> 
> After the preparatory patches, this implements the virtio transport as
> paraphrased:
> 
> Only support a single arm-scmi device (which is consistent with the SCMI
> spec). scmi-virtio init is called from arm-scmi module init. During the
> arm-scmi probing, link to the first probed scmi-virtio device. Defer
> arm-scmi probing if no scmi-virtio device is bound yet.
> 
> For simplicity, restrict the number of messages which can be pending
> simultaneously according to the virtqueue capacity. (The virtqueue sizes
> are negotiated with the virtio device.)
> 
> As soon as Rx channel message buffers are allocated or have been read
> out by the arm-scmi driver, feed them to the virtio device.
> 
> Since some virtio devices may not have the short response time exhibited
> by SCMI platforms using other transports, set a generous response
> timeout.
> 
> Limitations:
> 
> - Polling is not supported.
> 
> - The timeout for delayed responses has not been adjusted.
> 
> [1] https://github.com/oasis-tcs/virtio-spec/blob/master/virtio-scmi.tex
> [2] https://www.oasis-open.org/committees/ballot.php?id=3496
> 
> Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
> [ Peter: Adapted patch for submission to upstream. ]
> Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> ---
>  MAINTAINERS                        |   1 +
>  drivers/firmware/Kconfig           |  12 +
>  drivers/firmware/arm_scmi/Makefile |   1 +
>  drivers/firmware/arm_scmi/common.h |   3 +
>  drivers/firmware/arm_scmi/driver.c |   3 +
>  drivers/firmware/arm_scmi/virtio.c | 523 +++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_ids.h    |   1 +
>  include/uapi/linux/virtio_scmi.h   |  25 ++
>  8 files changed, 569 insertions(+)
>  create mode 100644 drivers/firmware/arm_scmi/virtio.c
>  create mode 100644 include/uapi/linux/virtio_scmi.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bd7aff0c120f..449c336872f3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17705,6 +17705,7 @@ F:	drivers/regulator/scmi-regulator.c
>  F:	drivers/reset/reset-scmi.c
>  F:	include/linux/sc[mp]i_protocol.h
>  F:	include/trace/events/scmi.h
> +F:	include/uapi/linux/virtio_scmi.h
>  
>  SYSTEM RESET/SHUTDOWN DRIVERS
>  M:	Sebastian Reichel <sre@kernel.org>
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index e8377b12e4d0..7e9eafdd9b63 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -39,6 +39,18 @@ config ARM_SCMI_HAVE_MSG
>  	  This declares whether a message passing based transport for SCMI is
>  	  available.
>  
> +# This config option includes the dependencies of ARM_SCMI_PROTOCOL so that
> +# this config doesn't show up when SCMI wouldn't be available.
> +config VIRTIO_SCMI
> +	bool "Virtio transport for SCMI"
> +	select ARM_SCMI_HAVE_MSG
> +	depends on VIRTIO && (ARM || ARM64 || COMPILE_TEST)
> +	help
> +	  This enables the virtio based transport for SCMI.
> +
> +	  If you want to use the ARM SCMI protocol between the virtio guest and
> +	  a host providing a virtio SCMI device, answer Y.
> +
>  config ARM_SCMI_POWER_DOMAIN
>  	tristate "SCMI power domain driver"
>  	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> index f6b4acb8abdb..db1787606fb2 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -5,6 +5,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
>  scmi-transport-$(CONFIG_MAILBOX) += mailbox.o
>  scmi-transport-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) += smc.o
>  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
> +scmi-transport-$(CONFIG_VIRTIO_SCMI) += virtio.o
>  scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o
>  scmi-module-objs := $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
>  		    $(scmi-transport-y)
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index 4cb6571c7aaf..bada06cfd33d 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -349,6 +349,9 @@ extern const struct scmi_desc scmi_mailbox_desc;
>  #ifdef CONFIG_HAVE_ARM_SMCCC
>  extern const struct scmi_desc scmi_smc_desc;
>  #endif
> +#ifdef CONFIG_VIRTIO_SCMI
> +extern const struct scmi_desc scmi_virtio_desc;
> +#endif
>  
>  int scmi_set_transport_info(struct device *dev, void *transport_info);
>  void *scmi_get_transport_info(struct device *dev);
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index e04e7c8e6928..a31187385470 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -1637,6 +1637,9 @@ static const struct of_device_id scmi_of_match[] = {
>  #endif
>  #ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
>  	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
> +#endif
> +#ifdef CONFIG_VIRTIO_SCMI
> +	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
>  #endif
>  	{ /* Sentinel */ },
>  };
> diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
> new file mode 100644
> index 000000000000..20972adf6dc7
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/virtio.c
> @@ -0,0 +1,523 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Virtio Transport driver for Arm System Control and Management Interface
> + * (SCMI).
> + *
> + * Copyright (C) 2020 OpenSynergy.
> + */
> +
> +/**
> + * DOC: Theory of Operation
> + *
> + * The scmi-virtio transport implements a driver for the virtio SCMI device.
> + *
> + * There is one Tx channel (virtio cmdq, A2P channel) and at most one Rx
> + * channel (virtio eventq, P2A channel). Each channel is implemented through a
> + * virtqueue. Access to each virtqueue is protected by spinlocks.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <uapi/linux/virtio_ids.h>
> +#include <uapi/linux/virtio_scmi.h>
> +
> +#include "common.h"
> +
> +#define VIRTIO_SCMI_MAX_MSG_SIZE 128 /* Value may be increased. */
> +#define VIRTIO_SCMI_MAX_PDU_SIZE \
> +	(VIRTIO_SCMI_MAX_MSG_SIZE + SCMI_MSG_MAX_PROT_OVERHEAD)
> +#define DESCRIPTORS_PER_TX_MSG 2
> +
> +/**
> + * struct scmi_vio_channel - Transport channel information
> + *
> + * @lock: Protects access to all members except ready.
> + * @ready_lock: Protects access to ready. If required, it must be taken before
> + *              lock.
> + * @vqueue: Associated virtqueue
> + * @cinfo: SCMI Tx or Rx channel
> + * @free_list: List of unused scmi_vio_msg, maintained for Tx channels only
> + * @is_rx: Whether channel is an Rx channel
> + * @ready: Whether transport user is ready to hear about channel
> + */
> +struct scmi_vio_channel {
> +	spinlock_t lock;
> +	spinlock_t ready_lock;
> +	struct virtqueue *vqueue;
> +	struct scmi_chan_info *cinfo;
> +	struct list_head free_list;
> +	u8 is_rx;
> +	u8 ready;
> +};
> +
> +/**
> + * struct scmi_vio_msg - Transport PDU information
> + *
> + * @request: SDU used for commands
> + * @input: SDU used for (delayed) responses and notifications
> + * @list: List which scmi_vio_msg may be part of
> + * @rx_len: Input SDU size in bytes, once input has been received
> + */
> +struct scmi_vio_msg {
> +	struct scmi_msg_payld *request;
> +	struct scmi_msg_payld *input;
> +	struct list_head list;
> +	unsigned int rx_len;
> +};
> +
> +static bool scmi_vio_have_vq_rx(struct virtio_device *vdev)
> +{
> +	return virtio_has_feature(vdev, VIRTIO_SCMI_F_P2A_CHANNELS);
> +}
> +
> +static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
> +			       struct scmi_vio_msg *msg)
> +{
> +	struct scatterlist sg_in;
> +	int rc;
> +	unsigned long flags;
> +
> +	sg_init_one(&sg_in, msg->input, VIRTIO_SCMI_MAX_PDU_SIZE);
> +
> +	spin_lock_irqsave(&vioch->lock, flags);
> +
> +	rc = virtqueue_add_inbuf(vioch->vqueue, &sg_in, 1, msg, GFP_ATOMIC);
> +	if (rc)
> +		dev_err_once(vioch->cinfo->dev,
> +			     "%s() failed to add to virtqueue (%d)\n", __func__,
> +			     rc);
> +	else
> +		virtqueue_kick(vioch->vqueue);
> +
> +	spin_unlock_irqrestore(&vioch->lock, flags);
> +
> +	return rc;
> +}
> +
> +static void scmi_vio_complete_cb(struct virtqueue *vqueue)
> +{
> +	unsigned long ready_flags;
> +	unsigned long flags;
> +	unsigned int length;
> +	struct scmi_vio_channel *vioch;
> +	struct scmi_vio_msg *msg;
> +	bool cb_enabled = true;
> +
> +	if (WARN_ON_ONCE(!vqueue->vdev->priv))
> +		return;
> +	vioch = &((struct scmi_vio_channel *)vqueue->vdev->priv)[vqueue->index];
> +
> +	for (;;) {
> +		spin_lock_irqsave(&vioch->ready_lock, ready_flags);
> +
> +		if (!vioch->ready) {
> +			if (!cb_enabled)
> +				(void)virtqueue_enable_cb(vqueue);
> +			goto unlock_ready_out;
> +		}
> +
> +		spin_lock_irqsave(&vioch->lock, flags);
> +		if (cb_enabled) {
> +			virtqueue_disable_cb(vqueue);
> +			cb_enabled = false;
> +		}
> +		msg = virtqueue_get_buf(vqueue, &length);
> +		if (!msg) {
> +			if (virtqueue_enable_cb(vqueue))
> +				goto unlock_out;
> +			else
> +				cb_enabled = true;
> +		}
> +		spin_unlock_irqrestore(&vioch->lock, flags);
> +
> +		if (msg) {
> +			msg->rx_len = length;
> +
> +			/*
> +			 * Hold the ready_lock during the callback to avoid
> +			 * races when the arm-scmi driver is unbinding while
> +			 * the virtio device is not quiesced yet.
> +			 */
> +			scmi_rx_callback(vioch->cinfo,
> +					 msg_read_header(msg->input), msg);
> +		}
> +		spin_unlock_irqrestore(&vioch->ready_lock, ready_flags);
> +	}
> +
> +unlock_out:
> +	spin_unlock_irqrestore(&vioch->lock, flags);
> +unlock_ready_out:
> +	spin_unlock_irqrestore(&vioch->ready_lock, ready_flags);
> +}
> +
> +static const char *const scmi_vio_vqueue_names[] = { "tx", "rx" };
> +
> +static vq_callback_t *scmi_vio_complete_callbacks[] = {
> +	scmi_vio_complete_cb,
> +	scmi_vio_complete_cb
> +};
> +
> +static unsigned int virtio_get_max_msg(bool tx,
> +				       struct scmi_chan_info *base_cinfo)
> +{
> +	struct scmi_vio_channel *vioch = base_cinfo->transport_info;
> +	unsigned int ret;
> +
> +	ret = virtqueue_get_vring_size(vioch->vqueue);
> +
> +	/* Tx messages need multiple descriptors. */
> +	if (tx)
> +		ret /= DESCRIPTORS_PER_TX_MSG;
> +
> +	if (ret > MSG_TOKEN_MAX) {
> +		dev_info_once(
> +			base_cinfo->dev,
> +			"Only %ld messages can be pending simultaneously, while the %s virtqueue could hold %d\n",
> +			MSG_TOKEN_MAX, tx ? "tx" : "rx", ret);
> +		ret = MSG_TOKEN_MAX;
> +	}
> +
> +	return ret;
> +}
> +
> +static int scmi_vio_match_any_dev(struct device *dev, const void *data)
> +{
> +	return 1;
> +}
> +
> +static struct virtio_driver virtio_scmi_driver; /* Forward declaration */
> +
> +static int virtio_link_supplier(struct device *dev)
> +{
> +	struct device *vdev = driver_find_device(
> +		&virtio_scmi_driver.driver, NULL, NULL, scmi_vio_match_any_dev);
> +
> +	if (!vdev) {
> +		dev_notice_once(
> +			dev,
> +			"Deferring probe after not finding a bound scmi-virtio device\n");
> +		return -EPROBE_DEFER;
> +	}
> +
> +	/* Add device link for remove order and sysfs link. */
> +	if (!device_link_add(dev, vdev, DL_FLAG_AUTOREMOVE_CONSUMER)) {
> +		put_device(vdev);
> +		dev_err(dev, "Adding link to supplier virtio device failed\n");
> +		return -ECANCELED;
> +	}
> +
> +	put_device(vdev);
> +	return scmi_set_transport_info(dev, dev_to_virtio(vdev));
> +}
> +
> +static bool virtio_chan_available(struct device *dev, int idx)
> +{
> +	struct virtio_device *vdev;
> +
> +	/* scmi-virtio doesn't support per-protocol channels */
> +	if (is_scmi_protocol_device(dev))
> +		return false;
> +
> +	vdev = scmi_get_transport_info(dev);
> +	if (!vdev)
> +		return false;
> +
> +	switch (idx) {
> +	case VIRTIO_SCMI_VQ_TX:
> +		return true;
> +	case VIRTIO_SCMI_VQ_RX:
> +		return scmi_vio_have_vq_rx(vdev);
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
> +			     bool tx)
> +{
> +	unsigned long flags;
> +	struct virtio_device *vdev;
> +	struct scmi_vio_channel *vioch;
> +	int index = tx ? VIRTIO_SCMI_VQ_TX : VIRTIO_SCMI_VQ_RX;
> +	int max_msg;
> +	int i;
> +
> +	if (!virtio_chan_available(dev, index))
> +		return -ENODEV;
> +
> +	vdev = scmi_get_transport_info(dev);
> +	vioch = &((struct scmi_vio_channel *)vdev->priv)[index];
> +
> +	spin_lock_irqsave(&vioch->lock, flags);
> +	cinfo->transport_info = vioch;
> +	vioch->cinfo = cinfo;
> +	spin_unlock_irqrestore(&vioch->lock, flags);
> +
> +	max_msg = virtio_get_max_msg(tx, cinfo);
> +
> +	for (i = 0; i < max_msg; i++) {
> +		struct scmi_vio_msg *msg;
> +
> +		msg = devm_kzalloc(cinfo->dev, sizeof(*msg), GFP_KERNEL);
> +		if (!msg)
> +			return -ENOMEM;
> +
> +		if (tx) {
> +			msg->request = devm_kzalloc(cinfo->dev,
> +						    VIRTIO_SCMI_MAX_PDU_SIZE,
> +						    GFP_KERNEL);
> +			if (!msg->request)
> +				return -ENOMEM;
> +		}
> +
> +		msg->input = devm_kzalloc(cinfo->dev, VIRTIO_SCMI_MAX_PDU_SIZE,
> +					  GFP_KERNEL);
> +		if (!msg->input)
> +			return -ENOMEM;
> +
> +		if (tx) {
> +			spin_lock_irqsave(&vioch->lock, flags);
> +			list_add_tail(&msg->list, &vioch->free_list);
> +			spin_unlock_irqrestore(&vioch->lock, flags);
> +		} else {
> +			scmi_vio_feed_vq_rx(vioch, msg);
> +		}
> +	}
> +
> +	spin_lock_irqsave(&vioch->ready_lock, flags);
> +	vioch->ready = true;
> +	spin_unlock_irqrestore(&vioch->ready_lock, flags);
> +
> +	return 0;
> +}
> +
> +static int virtio_chan_free(int id, void *p, void *data)
> +{
> +	unsigned long flags;
> +	struct scmi_chan_info *cinfo = p;
> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
> +
> +	spin_lock_irqsave(&vioch->ready_lock, flags);
> +	vioch->ready = false;
> +	spin_unlock_irqrestore(&vioch->ready_lock, flags);
> +
> +	scmi_free_channel(cinfo, data, id);
> +	return 0;
> +}
> +
> +static int virtio_send_message(struct scmi_chan_info *cinfo,
> +			       struct scmi_xfer *xfer)
> +{
> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
> +	struct scatterlist sg_out;
> +	struct scatterlist sg_in;
> +	struct scatterlist *sgs[DESCRIPTORS_PER_TX_MSG] = { &sg_out, &sg_in };
> +	unsigned long flags;
> +	int rc;
> +	struct scmi_vio_msg *msg;
> +
> +	/*
> +	 * TODO: For now, we don't support polling. But it should not be
> +	 * difficult to add support.
> +	 */
> +	if (xfer->hdr.poll_completion)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&vioch->lock, flags);
> +
> +	if (list_empty(&vioch->free_list)) {
> +		spin_unlock_irqrestore(&vioch->lock, flags);
> +		return -EBUSY;
> +	}
> +
> +	msg = list_first_entry(&vioch->free_list, typeof(*msg), list);
> +	list_del(&msg->list);
> +
> +	msg_tx_prepare(msg->request, xfer);
> +
> +	sg_init_one(&sg_out, msg->request, msg_command_size(xfer));
> +	sg_init_one(&sg_in, msg->input, msg_response_size(xfer));
> +
> +	rc = virtqueue_add_sgs(vioch->vqueue, sgs, 1, 1, msg, GFP_ATOMIC);
> +	if (rc) {
> +		list_add(&msg->list, &vioch->free_list);
> +		dev_err_once(vioch->cinfo->dev,
> +			     "%s() failed to add to virtqueue (%d)\n", __func__,
> +			     rc);
> +	} else {
> +		virtqueue_kick(vioch->vqueue);
> +	}
> +
> +	spin_unlock_irqrestore(&vioch->lock, flags);
> +
> +	return rc;
> +}
> +
> +static void virtio_fetch_response(struct scmi_chan_info *cinfo,
> +				  struct scmi_xfer *xfer, void *msg_handle)
> +{
> +	struct scmi_vio_msg *msg = msg_handle;
> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
> +
> +	if (!msg) {
> +		dev_dbg_once(&vioch->vqueue->vdev->dev,
> +			     "Ignoring %s() call with NULL msg_handle\n",
> +			     __func__);
> +		return;
> +	}
> +
> +	msg_fetch_response(msg->input, msg->rx_len, xfer);
> +}
> +
> +static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
> +				      size_t max_len, struct scmi_xfer *xfer,
> +				      void *msg_handle)
> +{
> +	struct scmi_vio_msg *msg = msg_handle;
> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
> +
> +	if (!msg) {
> +		dev_dbg_once(&vioch->vqueue->vdev->dev,
> +			     "Ignoring %s() call with NULL msg_handle\n",
> +			     __func__);
> +		return;
> +	}
> +
> +	msg_fetch_notification(msg->input, msg->rx_len, max_len, xfer);
> +}
> +
> +static void dummy_clear_channel(struct scmi_chan_info *cinfo)
> +{
> +}
> +
> +static bool dummy_poll_done(struct scmi_chan_info *cinfo,
> +			    struct scmi_xfer *xfer)
> +{
> +	return false;
> +}
> +
> +static void virtio_drop_message(struct scmi_chan_info *cinfo, void *msg_handle)
> +{
> +	unsigned long flags;
> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
> +	struct scmi_vio_msg *msg = msg_handle;
> +
> +	if (!msg) {
> +		dev_dbg_once(&vioch->vqueue->vdev->dev,
> +			     "Ignoring %s() call with NULL msg_handle\n",
> +			     __func__);
> +		return;
> +	}
> +
> +	if (vioch->is_rx) {
> +		scmi_vio_feed_vq_rx(vioch, msg);
> +	} else {
> +		spin_lock_irqsave(&vioch->lock, flags);
> +		list_add(&msg->list, &vioch->free_list);
> +		spin_unlock_irqrestore(&vioch->lock, flags);
> +	}
> +}
> +
> +static const struct scmi_transport_ops scmi_virtio_ops = {
> +	.link_supplier = virtio_link_supplier,
> +	.chan_available = virtio_chan_available,
> +	.chan_setup = virtio_chan_setup,
> +	.chan_free = virtio_chan_free,
> +	.get_max_msg = virtio_get_max_msg,
> +	.send_message = virtio_send_message,
> +	.fetch_response = virtio_fetch_response,
> +	.fetch_notification = virtio_fetch_notification,
> +	.clear_channel = dummy_clear_channel,
> +	.poll_done = dummy_poll_done,
> +	.drop_message = virtio_drop_message,
> +};
> +
> +static int scmi_vio_probe(struct virtio_device *vdev)
> +{
> +	struct device *dev = &vdev->dev;
> +	struct scmi_vio_channel *channels;
> +	bool have_vq_rx;
> +	int vq_cnt;
> +	int i;
> +	int ret;
> +	struct virtqueue *vqs[VIRTIO_SCMI_VQ_MAX_CNT];
> +
> +	have_vq_rx = scmi_vio_have_vq_rx(vdev);
> +	vq_cnt = have_vq_rx ? VIRTIO_SCMI_VQ_MAX_CNT : 1;
> +
> +	channels = devm_kcalloc(dev, vq_cnt, sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	if (have_vq_rx)
> +		channels[VIRTIO_SCMI_VQ_RX].is_rx = true;
> +
> +	ret = virtio_find_vqs(vdev, vq_cnt, vqs, scmi_vio_complete_callbacks,
> +			      scmi_vio_vqueue_names, NULL);
> +	if (ret) {
> +		dev_err(dev, "Failed to get %d virtqueue(s)\n", vq_cnt);
> +		return ret;
> +	}
> +	dev_info(dev, "Found %d virtqueue(s)\n", vq_cnt);
> +
> +	for (i = 0; i < vq_cnt; i++) {
> +		spin_lock_init(&channels[i].lock);
> +		spin_lock_init(&channels[i].ready_lock);
> +		INIT_LIST_HEAD(&channels[i].free_list);
> +		channels[i].vqueue = vqs[i];
> +	}
> +
> +	vdev->priv = channels;
> +
> +	return 0;
> +}
> +
> +static void scmi_vio_remove(struct virtio_device *vdev)
> +{
> +	vdev->config->reset(vdev);
> +	vdev->config->del_vqs(vdev);
> +}
> +
> +static unsigned int features[] = {
> +	VIRTIO_SCMI_F_P2A_CHANNELS,
> +};
> +
> +static const struct virtio_device_id id_table[] = {
> +	{ VIRTIO_ID_SCMI, VIRTIO_DEV_ANY_ID },
> +	{ 0 }
> +};
> +
> +static struct virtio_driver virtio_scmi_driver = {
> +	.driver.name = "scmi-virtio",
> +	.driver.owner = THIS_MODULE,
> +	.feature_table = features,
> +	.feature_table_size = ARRAY_SIZE(features),
> +	.id_table = id_table,
> +	.probe = scmi_vio_probe,
> +	.remove = scmi_vio_remove,
> +};
> +
> +static int __init virtio_scmi_init(void)
> +{
> +	return register_virtio_driver(&virtio_scmi_driver);
> +}
> +
> +static void __exit virtio_scmi_exit(void)
> +{
> +	unregister_virtio_driver(&virtio_scmi_driver);
> +}
> +
> +const struct scmi_desc scmi_virtio_desc = {
> +	.init = virtio_scmi_init,
> +	.exit = virtio_scmi_exit,
> +	.ops = &scmi_virtio_ops,
> +	.max_rx_timeout_ms = 60000, /* for non-realtime virtio devices */
> +	.max_msg = 0, /* overridden by virtio_get_max_msg() */
> +	.max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
> +};
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index f0c35ce8628c..c146fe30e589 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -56,5 +56,6 @@
>  #define VIRTIO_ID_PMEM			27 /* virtio pmem */
>  #define VIRTIO_ID_BT			28 /* virtio bluetooth */
>  #define VIRTIO_ID_MAC80211_HWSIM	29 /* virtio mac80211-hwsim */
> +#define VIRTIO_ID_SCMI			32 /* virtio SCMI */
>  
>  #endif /* _LINUX_VIRTIO_IDS_H */
> diff --git a/include/uapi/linux/virtio_scmi.h b/include/uapi/linux/virtio_scmi.h
> new file mode 100644
> index 000000000000..732b01504c35
> --- /dev/null
> +++ b/include/uapi/linux/virtio_scmi.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/*
> + * Copyright (C) 2020 OpenSynergy GmbH
> + */
> +
> +#ifndef _UAPI_LINUX_VIRTIO_SCMI_H
> +#define _UAPI_LINUX_VIRTIO_SCMI_H
> +
> +#include <linux/virtio_types.h>
> +
> +/* Feature bits */
> +
> +/* Device implements some SCMI notifications, or delayed responses. */
> +#define VIRTIO_SCMI_F_P2A_CHANNELS 0
> +
> +/* Device implements any SCMI statistics shared memory region */
> +#define VIRTIO_SCMI_F_SHARED_MEMORY 1
> +
> +/* Virtqueues */
> +
> +#define VIRTIO_SCMI_VQ_TX 0 /* cmdq */
> +#define VIRTIO_SCMI_VQ_RX 1 /* eventq */
> +#define VIRTIO_SCMI_VQ_MAX_CNT 2
> +
> +#endif /* _UAPI_LINUX_VIRTIO_SCMI_H */
> -- 
> 2.25.1
> 
> 
