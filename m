Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5123411318
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 12:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbhITKuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 06:50:00 -0400
Received: from foss.arm.com ([217.140.110.172]:45684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231686AbhITKtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:49:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 063B51063;
        Mon, 20 Sep 2021 03:48:27 -0700 (PDT)
Received: from bogus (unknown [10.57.23.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4101F3F719;
        Mon, 20 Sep 2021 03:48:25 -0700 (PDT)
Date:   Mon, 20 Sep 2021 11:48:06 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Igor Skalkin <igor.skalkin@opensynergy.com>,
        Peter Hilber <peter.hilber@opensynergy.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] firmware: arm_scmi: fix VIRTIO dependency
Message-ID: <20210920104806.bi4gky3y6w5h2rur@bogus>
References: <20210920100301.1466486-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920100301.1466486-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 12:02:51PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building with CONFIG_VIRTIO=m but CONFIG_ARM_SCMI_PROTOCOL=y leads to
> a link error for the scmi virtio transport:
> 
> arm-linux-gnueabi-ld: drivers/firmware/arm_scmi/virtio.o: in function `virtio_send_message':
> virtio.c:(.text+0x200): undefined reference to `virtqueue_add_sgs'
> arm-linux-gnueabi-ld: virtio.c:(.text+0x280): undefined reference to `virtqueue_kick'
> arm-linux-gnueabi-ld: drivers/firmware/arm_scmi/virtio.o: in function `scmi_vio_feed_vq_rx':
> virtio.c:(.text+0x390): undefined reference to `virtqueue_add_inbuf'
> arm-linux-gnueabi-ld: virtio.c:(.text+0x3dc): undefined reference to `virtqueue_kick'
> arm-linux-gnueabi-ld: drivers/firmware/arm_scmi/virtio.o: in function `virtio_scmi_exit':
> virtio.c:(.text+0x538): undefined reference to `unregister_virtio_driver'
> arm-linux-gnueabi-ld: drivers/firmware/arm_scmi/virtio.o: in function `virtio_chan_available':
> 
> Prevent this configuration by making the Kconfig dependency a bit
> stricter.
> 
> Fixes: 46abe13b5e3d ("firmware: arm_scmi: Add virtio transport")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/firmware/arm_scmi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Hi Arnd,

I have already queued similar fix by Cristain[1] a while ago. I was waiting
to get other possible fixes sorted before sending pull request. Sorry for
that, will do that soon.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20210816141609.41751-1-cristian.marussi@arm.com/
