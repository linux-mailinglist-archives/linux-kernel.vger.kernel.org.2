Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA1F3F4A20
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbhHWL4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:56:06 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:35462 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233684AbhHWL4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:56:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UlO1MIH_1629719720;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UlO1MIH_1629719720)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 23 Aug 2021 19:55:21 +0800
Subject: Re: [RESEND][PATCH] virtio_console: protect max_nr_ports to avoid
 invalid value
To:     amit@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210820075219.202404-1-xianting.tian@linux.alibaba.com>
From:   Xianting TIan <xianting.tian@linux.alibaba.com>
Message-ID: <2746b7f2-2cd0-1042-3c36-b4392620525a@linux.alibaba.com>
Date:   Mon, 23 Aug 2021 19:55:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210820075219.202404-1-xianting.tian@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Could I get comments for the patch? thanks

Is the value of  MAX_NR_PORTS accurate?

this fix is similar to below patches, which are megered recently,

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.14-rc7&id=63947b3434f475418b9677a393d025c0962c2cf8 
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.14-rc7&id=63947b3434f475418b9677a393d025c0962c2cf8>

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.14-rc7&id=82e89ea077b93b3c131fa175b0df3acb5b1d5cdf 
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.14-rc7&id=82e89ea077b93b3c131fa175b0df3acb5b1d5cdf>

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.14-rc7&id=d00d8da5869a2608e97cfede094dfc5e11462a46 
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.14-rc7&id=d00d8da5869a2608e97cfede094dfc5e11462a46>


在 2021/8/20 下午3:52, Xianting Tian 写道:
> In theory untrusted remote host can pass a big or overflow value
> of max_nr_ports to guest, it may cause guest system consumes
> a lot of memory when create vqs and other impacts.
>
> Add the protection to guarantee max_nr_ports to get a safe value.
>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>   drivers/char/virtio_console.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 7eaf303a7..bba985c81 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -29,6 +29,8 @@
>   
>   #define is_rproc_enabled IS_ENABLED(CONFIG_REMOTEPROC)
>   
> +#define MAX_NR_PORTS	MAX_NR_HVC_CONSOLES
> +
>   /*
>    * This is a global struct for storing common data for all the devices
>    * this driver handles.
> @@ -2039,6 +2041,9 @@ static int virtcons_probe(struct virtio_device *vdev)
>   		multiport = true;
>   	}
>   
> +	/* limit max_nr_ports to avoid invalid value from untrusted remote host */
> +	portdev->max_nr_ports = min_t(u32, portdev->max_nr_ports, MAX_NR_PORTS);
> +
>   	err = init_vqs(portdev);
>   	if (err < 0) {
>   		dev_err(&vdev->dev, "Error %d initializing vqs\n", err);
