Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D973030DF5F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhBCQM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:12:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39921 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234977AbhBCQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612368609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Md5deGFTlNwWnMdHSwnNKkej1rIsSFXY3oqRw/3YWT0=;
        b=PH14XHQoAB+Qn41y6WQZwuhGSpzdoON9tQlxsfV+EqJLHXqTfnX2+zZ/AO0myRDPp2oOyw
        NYNKkRlhLONaiq2c1AhGJlI92bvTDLgN8XQ3vo7PjFED1CoYiyV9ovR4S12VQ03zpUoSA3
        6skj8rfUpMcVCmsmkGJAVw7PsDdnJP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-Cw8jCwDsPEmEHOoAb7OFcw-1; Wed, 03 Feb 2021 11:10:05 -0500
X-MC-Unique: Cw8jCwDsPEmEHOoAb7OFcw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07BEE6D4E0;
        Wed,  3 Feb 2021 16:10:03 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AF005FC3A;
        Wed,  3 Feb 2021 16:09:56 +0000 (UTC)
Date:   Wed, 3 Feb 2021 11:09:55 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Damien.LeMoal@wdc.com, hare@suse.de, ming.lei@redhat.com,
        agk@redhat.com, corbet@lwn.net, axboe@kernel.dk, jack@suse.cz,
        johannes.thumshirn@wdc.com, gregkh@linuxfoundation.org,
        koct9i@gmail.com, steve@sk2.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavgel.tide@veeam.com
Subject: Re: [PATCH v4 3/6] block: add blk_mq_is_queue_frozen()
Message-ID: <20210203160955.GA21359@redhat.com>
References: <1612367638-3794-1-git-send-email-sergei.shtepa@veeam.com>
 <1612367638-3794-4-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612367638-3794-4-git-send-email-sergei.shtepa@veeam.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03 2021 at 10:53am -0500,
Sergei Shtepa <sergei.shtepa@veeam.com> wrote:

> blk_mq_is_queue_frozen() allow to assert that the queue is frozen.
> 
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> ---
>  block/blk-mq.c         | 13 +++++++++++++
>  include/linux/blk-mq.h |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f285a9123a8b..924ec26fae5f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -161,6 +161,19 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait_timeout);
>  
> +
> +bool blk_mq_is_queue_frozen(struct request_queue *q)
> +{
> +	bool ret;
> +
> +	mutex_lock(&q->mq_freeze_lock);
> +	ret = percpu_ref_is_dying(&q->q_usage_counter) && percpu_ref_is_zero(&q->q_usage_counter);
> +	mutex_unlock(&q->mq_freeze_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_is_queue_frozen);
> +
>  /*
>   * Guarantee no request is in use, so we can change any data structure of
>   * the queue afterward.
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index d705b174d346..9d1e8c4e922e 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -525,6 +525,7 @@ void blk_freeze_queue_start(struct request_queue *q);
>  void blk_mq_freeze_queue_wait(struct request_queue *q);
>  int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
>  				     unsigned long timeout);
> +bool blk_mq_is_queue_frozen(struct request_queue *q);
>  
>  int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
>  void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
> -- 
> 2.20.1
> 

This needs to come before patch 2 (since patch 2 uses it).

Mike

