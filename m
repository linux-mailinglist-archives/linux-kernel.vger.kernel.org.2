Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2C8337002
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhCKK2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:28:49 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:36300 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232320AbhCKK2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:28:44 -0500
X-Greylist: delayed 68067 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Mar 2021 05:28:43 EST
Received: from iva8-d077482f1536.qloud-c.yandex.net (iva8-d077482f1536.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:2f26:0:640:d077:482f])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id B7F442E12E6;
        Thu, 11 Mar 2021 13:28:41 +0300 (MSK)
Received: from mail.yandex-team.ru (mail.yandex-team.ru [2a02:6b8:0:408:9070:8be:747c:6edb])
        by iva8-d077482f1536.qloud-c.yandex.net (mxbackcorp/Yandex) with HTTP id XSSwT00xO0U1-SfxC3Had;
        Thu, 11 Mar 2021 13:28:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1615458521; bh=+zceFxQk7nfPU+KX7fq6I3PyIlzkWp+mnYkoAvCzRJU=;
        h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
        b=iLmdU9t4oIENoprgeKOkE/s2sWuXYCAuyKqLfa5hz9ZaD0KJB+ChoIHtoV8WWa+oq
         O7TWrR3p6Hff1+ULO22ba8yY3zdijokhYY2iR3p8SA5X4VT8LjkY5MWdME3s0J51pE
         xADzxYV6MSUr3c9fdizGNXGdGWkO6s5UvZM1nSko=
Authentication-Results: iva8-d077482f1536.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000084479
X-Yandex-Avir: 1
Received: from iva8-d077482f1536.qloud-c.yandex.net (iva8-d077482f1536.qloud-c.yandex.net [2a02:6b8:c0c:2f26:0:640:d077:482f])
        by iva4-81f2a0d63507.qloud-c.yandex.net with LMTP id BPigBz2fop-fCrbe7Rg
        for <dmtrmonakhov@yandex-team.ru>; Thu, 11 Mar 2021 13:28:30 +0300
Received: by iva8-edafde7c849c.qloud-c.yandex.net with HTTP;
        Thu, 11 Mar 2021 13:28:30 +0300
From:   Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Chaitanya.Kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>
In-Reply-To: <20210310134110.GA13063@lst.de>
References: <1615377076-3251-1-git-send-email-dmtrmonakhov@yandex-team.ru> <20210310132156.GA12145@lst.de> <20210310134110.GA13063@lst.de>
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a Samsung PM1725a
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 11 Mar 2021 13:28:40 +0300
Message-Id: <7141615457844@mail.yandex-team.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



10.03.2021, 16:41, "Christoph Hellwig" <hch@lst.de>:
> On Wed, Mar 10, 2021 at 02:21:56PM +0100, Christoph Hellwig wrote:
>>  Can you try this patch instead?
>>
>>  http://lists.infradead.org/pipermail/linux-nvme/2021-February/023183.html
>
> Actually, please try the patch below instead, it looks like our existing
> logic messes up the units:
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e68a8c4ac5a6ea..1867fdf2205bd7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1963,30 +1963,18 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
>                  blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
>  }
>
> -static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
> +/*
> + * Even though NVMe spec explicitly states that MDTS is not applicable to the
> + * write-zeroes, we are cautious and limit the size to the controllers
> + * max_hw_sectors value, which is based on the MDTS field and possibly other
> + * limiting factors.
> + */
> +static void nvme_config_write_zeroes(struct request_queue *q,
> + struct nvme_ctrl *ctrl)
>  {
> - u64 max_blocks;
> -
> - if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) ||
> - (ns->ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
> - return;
> - /*
> - * Even though NVMe spec explicitly states that MDTS is not
> - * applicable to the write-zeroes:- "The restriction does not apply to
> - * commands that do not transfer data between the host and the
> - * controller (e.g., Write Uncorrectable ro Write Zeroes command).".
> - * In order to be more cautious use controller's max_hw_sectors value
> - * to configure the maximum sectors for the write-zeroes which is
> - * configured based on the controller's MDTS field in the
> - * nvme_init_identify() if available.
> - */
> - if (ns->ctrl->max_hw_sectors == UINT_MAX)
> - max_blocks = (u64)USHRT_MAX + 1;
> - else
> - max_blocks = ns->ctrl->max_hw_sectors + 1;
> -
> - blk_queue_max_write_zeroes_sectors(disk->queue,
> - nvme_lba_to_sect(ns, max_blocks));
> + if ((ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) &&
> + !(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
> + blk_queue_max_write_zeroes_sectors(q, ctrl->max_hw_sectors);
>  }
>
>  static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
> @@ -2158,7 +2146,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>          set_capacity_and_notify(disk, capacity);
>
>          nvme_config_discard(disk, ns);
> - nvme_config_write_zeroes(disk, ns);
> + nvme_config_write_zeroes(disk->queue, ns->ctrl);
>
>          set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
>                  test_bit(NVME_NS_FORCE_RO, &ns->flags));
In order to exclude possible issue with incorrect request sized I've run test which does write_zeroes,
via fio-fallocate randrtim, which actually does fallocate punch_hole+keep_size which converts to blkdev_issue_zeroout()
note: fio should be patched, see: https://github.com/axboe/fio/pull/1203

fio --name t --ioengine=falloc --rw=randtrim --bs=512 --size=100M --filename=/dev/nvme0n1 --numjobs=16
After a couple of minutes it stuck, and then timeout occour.
cat /sys/kernel/debug/block/nvme0n1/hctx*/busy                                                                                                                                                   
00000000cd27b755 {.op=WRITE_ZEROES, .cmd_flags=SYNC, .rq_flags=DONTPREP|IO_STAT|STATS, .state=in_flight, .tag=205, .internal_tag=-1}
000000009d3f2b8f {.op=WRITE_ZEROES, .cmd_flags=SYNC, .rq_flags=DONTPREP|IO_STAT|STATS, .state=in_flight, .tag=244, .internal_tag=-1}
00000000eb4166fe {.op=WRITE_ZEROES, .cmd_flags=SYNC, .rq_flags=DONTPREP|IO_STAT|STATS, .state=in_flight, .tag=709, .internal_tag=-1}
0000000049b49c60 {.op=WRITE_ZEROES, .cmd_flags=SYNC, .rq_flags=DONTPREP|IO_STAT|STATS, .state=in_flight, .tag=433, .internal_tag=-1}
0000000018b93c40 {.op=WRITE_ZEROES, .cmd_flags=SYNC, .rq_flags=DONTPREP|IO_STAT|STATS, .state=in_flight, .tag=5, .internal_tag=-1}
00000000ac15ef73 {.op=WRITE_ZEROES, .cmd_flags=SYNC, .rq_flags=DONTPREP|IO_STAT|STATS, .state=in_flight, .tag=268, .internal_tag=-1}

So, this is definitely hardware issue, and write_zeroes should be disabled for this particular model.

