Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415E13D4466
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 04:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhGXBvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 21:51:14 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:54184 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232673AbhGXBvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 21:51:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UglKWF5_1627093904;
Received: from 192.168.0.105(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UglKWF5_1627093904)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 24 Jul 2021 10:31:45 +0800
Subject: Re: [PATCH] dm io: fix comments to align with on-stack plugging
To:     agk@redhat.com, snitzer@redhat.com
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org
References: <1626537263-8752-1-git-send-email-xianting_tian@126.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <ee68b3ff-2448-9c6b-acbe-f4f0b5585f48@linux.alibaba.com>
Date:   Sat, 24 Jul 2021 10:31:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1626537263-8752-1-git-send-email-xianting_tian@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Could I get the comments for the patch?  thanks

在 2021/7/17 下午11:54, Xianting Tian 写道:
> From: Xianting Tian <xianting.tian@linux.alibaba.com>
>
> Ther is no unplugging timer now, on-stack io plugging is used:
> 	struct blk_plug plug;
>
> 	blk_start_plug(&plug);
> 	submit_batch_of_io();
> 	blk_finish_plug(&plug);
>
> So remove the old comments for unplugging timer.
>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>   drivers/md/dm-io.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
> index 2d3cda0..7dba193 100644
> --- a/drivers/md/dm-io.c
> +++ b/drivers/md/dm-io.c
> @@ -528,11 +528,6 @@ static int dp_init(struct dm_io_request *io_req, struct dpages *dp,
>   
>   /*
>    * New collapsed (a)synchronous interface.
> - *
> - * If the IO is asynchronous (i.e. it has notify.fn), you must either unplug
> - * the queue with blk_unplug() some time later or set REQ_SYNC in
> - * io_req->bi_opf. If you fail to do one of these, the IO will be submitted to
> - * the disk after q->unplug_delay, which defaults to 3ms in blk-settings.c.
>    */
>   int dm_io(struct dm_io_request *io_req, unsigned num_regions,
>   	  struct dm_io_region *where, unsigned long *sync_error_bits)
