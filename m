Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4603CB5A8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbhGPKGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbhGPKGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:06:42 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB91C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:03:47 -0700 (PDT)
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 68993B379D9;
        Fri, 16 Jul 2021 12:03:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1626429825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SAjMBxEFbTM9QnXfWtqziwaXlTYwnx8l4JQwX90X8Hw=;
        b=VQ6/tmdQ6sgW7HAYv1Owa2kDon3HEiJ1nm7z6EL/2e561VoTHJrk79XinzisfYBhJyfV1u
        h6F0kw2lNu57bU+fc2O2Ur3su2ZamVj7zKizdOVMkwgt72Nbk0AUwX2QlYJfjuzcPfLdsb
        DXped+S2mMkDz8G6Hkn7LM3EsxRXWuc=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        David Jeffery <djeffery@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: New warning in nvme_setup_discard
Date:   Fri, 16 Jul 2021 12:03:43 +0200
Message-ID: <2455133.St5lIfLNcX@natalenko.name>
In-Reply-To: <YPFSUfG+fMITAH01@T590>
References: <4729812.CpyZKHjjVO@natalenko.name> <81322754.HEIg0oD171@natalenko.name> <YPFSUfG+fMITAH01@T590>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On p=C3=A1tek 16. =C4=8Dervence 2021 11:33:05 CEST Ming Lei wrote:
> Can you test the following patch?

Sure, building it at the moment, and will give it a try. Also please see my=
=20
comments and questions below.

>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 727955918563..673a634eadd9 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2361,6 +2361,9 @@ static int bfq_request_merge(struct request_queue *=
q,
> struct request **req, __rq =3D bfq_find_rq_fmerge(bfqd, bio, q);
>  	if (__rq && elv_bio_merge_ok(__rq, bio)) {
>  		*req =3D __rq;
> +
> +		if (blk_discard_mergable(__rq))
> +			return ELEVATOR_DISCARD_MERGE;
>  		return ELEVATOR_FRONT_MERGE;
>  	}
>=20
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index a11b3b53717e..f8707ff7e2fc 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -705,22 +705,6 @@ static void blk_account_io_merge_request(struct requ=
est
> *req) }
>  }
>=20
> -/*
> - * Two cases of handling DISCARD merge:
> - * If max_discard_segments > 1, the driver takes every bio
> - * as a range and send them to controller together. The ranges
> - * needn't to be contiguous.
> - * Otherwise, the bios/requests will be handled as same as
> - * others which should be contiguous.
> - */
> -static inline bool blk_discard_mergable(struct request *req)
> -{
> -	if (req_op(req) =3D=3D REQ_OP_DISCARD &&
> -	    queue_max_discard_segments(req->q) > 1)
> -		return true;
> -	return false;
> -}
> -
>  static enum elv_merge blk_try_req_merge(struct request *req,
>  					struct request *next)
>  {
> diff --git a/block/elevator.c b/block/elevator.c
> index 52ada14cfe45..a5fe2615ec0f 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -336,6 +336,9 @@ enum elv_merge elv_merge(struct request_queue *q, str=
uct
> request **req, __rq =3D elv_rqhash_find(q, bio->bi_iter.bi_sector);
>  	if (__rq && elv_bio_merge_ok(__rq, bio)) {
>  		*req =3D __rq;
> +
> +		if (blk_discard_mergable(__rq))
> +			return ELEVATOR_DISCARD_MERGE;
>  		return ELEVATOR_BACK_MERGE;
>  	}
>=20
> diff --git a/block/mq-deadline-main.c b/block/mq-deadline-main.c
> index 6f612e6dc82b..294be0c0db65 100644
> --- a/block/mq-deadline-main.c
> +++ b/block/mq-deadline-main.c

I had to adjust this against v5.13 because there's no mq-deadline-main.c, o=
nly=20
mq-deadline.c (due to Bart series, I assume). I hope this is fine as the pa=
tch=20
applies cleanly.

> @@ -677,6 +677,8 @@ static int dd_request_merge(struct request_queue *q,
> struct request **rq,
>=20
>  		if (elv_bio_merge_ok(__rq, bio)) {
>  			*rq =3D __rq;
> +			if (blk_discard_mergable(__rq))
> +				return ELEVATOR_DISCARD_MERGE;
>  			return ELEVATOR_FRONT_MERGE;
>  		}
>  	}
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 3177181c4326..87f00292fd7a 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1521,6 +1521,22 @@ static inline int
> queue_limit_discard_alignment(struct queue_limits *lim, sector return
> offset << SECTOR_SHIFT;
>  }
>=20
> +/*
> + * Two cases of handling DISCARD merge:
> + * If max_discard_segments > 1, the driver takes every bio
> + * as a range and send them to controller together. The ranges
> + * needn't to be contiguous.
> + * Otherwise, the bios/requests will be handled as same as
> + * others which should be contiguous.
> + */
> +static inline bool blk_discard_mergable(struct request *req)
> +{
> +	if (req_op(req) =3D=3D REQ_OP_DISCARD &&
> +	    queue_max_discard_segments(req->q) > 1)
> +		return true;
> +	return false;
> +}
> +
>  static inline int bdev_discard_alignment(struct block_device *bdev)
>  {
>  	struct request_queue *q =3D bdev_get_queue(bdev);

Do I understand correctly that this will be something like:

=46ixes: 2705dfb209 ("block: fix discard request merge")

?

Because as the bisection progresses, I've bumped into this commit only.=20
Without it the issue is not reproducible, at least so far.

Thanks!

=2D-=20
Oleksandr Natalenko (post-factum)


