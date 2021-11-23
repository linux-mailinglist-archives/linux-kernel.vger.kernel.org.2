Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB35C45A23F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 13:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbhKWMOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 07:14:52 -0500
Received: from foss.arm.com ([217.140.110.172]:51794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234548AbhKWMOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 07:14:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6C07147A;
        Tue, 23 Nov 2021 04:11:40 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 161A43F5A1;
        Tue, 23 Nov 2021 04:11:38 -0800 (PST)
Date:   Tue, 23 Nov 2021 12:11:36 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Igor Skalkin <igor.skalkin@opensynergy.com>,
        Peter Hilber <peter.hilber@opensynergy.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v6 14/16] firmware: arm_scmi: Add atomic mode support to
 virtio transport
Message-ID: <20211123121136.GD56473@e120937-lin>
References: <20211122230640.1345-1-cristian.marussi@arm.com>
 <20211122230640.1345-15-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122230640.1345-15-cristian.marussi@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 11:06:38PM +0000, Cristian Marussi wrote:
> Add support for .mark_txdone and .poll_done transport operations to SCMI
> VirtIO transport as pre-requisites to enable atomic operations.
> 
> Add a Kernel configuration option to enable SCMI VirtIO transport polling
> and atomic mode for selected SCMI transactions while leaving it default
> disabled.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> Cc: Peter Hilber <peter.hilber@opensynergy.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>


Hi,

> ---
>  drivers/firmware/arm_scmi/Kconfig  |  15 ++
>  drivers/firmware/arm_scmi/virtio.c | 212 +++++++++++++++++++++++++++--
>  2 files changed, 214 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> index d429326433d1..7794bd41eaa0 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -118,6 +118,21 @@ config ARM_SCMI_TRANSPORT_VIRTIO_VERSION1_COMPLIANCE
>  	  the ones implemented by kvmtool) and let the core Kernel VirtIO layer
>  	  take care of the needed conversions, say N.
>  
> +config ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> +	bool "Enable atomic mode for SCMI VirtIO transport"
> +	depends on ARM_SCMI_TRANSPORT_VIRTIO
> +	help
> +	  Enable support of atomic operation for SCMI VirtIO based transport.
> +
> +	  If you want the SCMI VirtIO based transport to operate in atomic
> +	  mode, avoiding any kind of sleeping behaviour for selected
> +	  transactions on the TX path, answer Y.
> +
> +	  Enabling atomic mode operations allows any SCMI driver using this
> +	  transport to optionally ask for atomic SCMI transactions and operate
> +	  in atomic context too, at the price of using a number of busy-waiting
> +	  primitives all over instead. If unsure say N.
> +
>  endif #ARM_SCMI_PROTOCOL
>  

[snip]

>  static void scmi_vio_complete_cb(struct virtqueue *vqueue)
> @@ -138,12 +157,29 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
>  			goto unlock_ready_out;
>  		}
>  
> +#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> +		/* At first loop on pending_cmd_list of buffered msg if any */
> +		if (!vioch->is_rx) {
> +			struct scmi_vio_msg *tmp;
> +
> +			list_for_each_entry_safe(msg, tmp,
> +						 &vioch->pending_cmds_list,
> +						 list) {
> +				scmi_rx_callback(vioch->cinfo,
> +						 msg_read_header(msg->input),
> +						 msg);
> +				scmi_vio_feed_vq_tx(vioch, msg);
> +			}
> +		}
> +#endif
> +

doing further testing I spotted a trivial bug on the limit condition
where polling and non-polling requests are interleaved on the cmd
vqueue. (hard to reproduce ... but it's there and it's broken)

This one-liner fixes the issue with the above snippet:

diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 3101024751b0..cf247093ef48 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -168,6 +168,7 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
                                scmi_rx_callback(vioch->cinfo,
                                                 msg_read_header(msg->input),
                                                 msg);
+                               list_del(&msg->list);
                                scmi_vio_feed_vq_tx(vioch, msg);
                        }
                }

It seems there will be a V7 ...

Thanks,
Cristian
