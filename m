Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CE93D8F54
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbhG1NoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:44:14 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:57502 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbhG1NoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:44:11 -0400
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 587BDB5C739;
        Wed, 28 Jul 2021 15:44:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1627479848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rPOP7/Kz1KvizmI5KULfeOViwk82LgpFRrXprpW0RXs=;
        b=U8e5fDFVH0PqYOA/hr+7M3hLr56ldBnO9rHfJEZNc/r6o5AHodaA2AYtmCzmSfCbVKMAGi
        A45p1Qw+clpzQz216kcosuVQmUXWBcZIFuvfQgDMRzBCfoxHmhSLumFFesagggtUlLy+/U
        G6HC0AfH/qadZLrYUcKkBIu6FlnDtfE=
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
Date:   Wed, 28 Jul 2021 15:44:06 +0200
Message-ID: <3180854.nXyytZ0Y3r@natalenko.name>
In-Reply-To: <YQAtL5i0pjlnBpHV@T590>
References: <4729812.CpyZKHjjVO@natalenko.name> <17691292.WCMSeNvH9h@natalenko.name> <YQAtL5i0pjlnBpHV@T590>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =C3=BAter=C3=BD 27. =C4=8Dervence 2021 17:58:39 CEST Ming Lei wrote:
> BTW, can you test the following patch? which is another approach on the s=
ame
> issue with other benefits.
>=20
> From c853e7ed05a75f631da5b7952b9a989983437819 Mon Sep 17 00:00:00 2001
> From: Ming Lei <ming.lei@redhat.com>
> Date: Mon, 7 Jun 2021 16:03:51 +0800
> Subject: [PATCH 2/2] block: support bio merge for multi-range discard
>=20
> So far multi-range discard treats each bio as one segment(range) of single
> discard request. This way becomes not efficient if lots of small sized
> discard bios are submitted, and one example is raid456.
>=20
> Support bio merge for multi-range discard for improving lots of small
> sized discard bios.
>=20
> Turns out it is easy to support it:
>=20
> 1) always try to merge bio first
>=20
> 2) run into multi-range discard only if bio merge can't be done
>=20
> 3) add rq_for_each_discard_range() for retrieving each range(segment)
> of discard request
>=20
> Reported-by: Wang Shanker <shankerwangmiao@gmail.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-merge.c          | 12 ++++-----
>  drivers/block/virtio_blk.c |  9 ++++---
>  drivers/nvme/host/core.c   |  8 +++---
>  include/linux/blkdev.h     | 51 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 66 insertions(+), 14 deletions(-)
>=20
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index bcdff1879c34..65210e9a8efa 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -724,10 +724,10 @@ static inline bool blk_discard_mergable(struct requ=
est
> *req) static enum elv_merge blk_try_req_merge(struct request *req,
>  					struct request *next)
>  {
> -	if (blk_discard_mergable(req))
> -		return ELEVATOR_DISCARD_MERGE;
> -	else if (blk_rq_pos(req) + blk_rq_sectors(req) =3D=3D blk_rq_pos(next))
> +	if (blk_rq_pos(req) + blk_rq_sectors(req) =3D=3D blk_rq_pos(next))
>  		return ELEVATOR_BACK_MERGE;
> +	else if (blk_discard_mergable(req))
> +		return ELEVATOR_DISCARD_MERGE;
>=20
>  	return ELEVATOR_NO_MERGE;
>  }
> @@ -908,12 +908,12 @@ bool blk_rq_merge_ok(struct request *rq, struct bio
> *bio)
>=20
>  enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
>  {
> -	if (blk_discard_mergable(rq))
> -		return ELEVATOR_DISCARD_MERGE;
> -	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) =3D=3D bio->bi_iter.bi_sec=
tor)
> +	if (blk_rq_pos(rq) + blk_rq_sectors(rq) =3D=3D bio->bi_iter.bi_sector)
>  		return ELEVATOR_BACK_MERGE;
>  	else if (blk_rq_pos(rq) - bio_sectors(bio) =3D=3D bio->bi_iter.bi_secto=
r)
>  		return ELEVATOR_FRONT_MERGE;
> +	else if (blk_discard_mergable(rq))
> +		return ELEVATOR_DISCARD_MERGE;
>  	return ELEVATOR_NO_MERGE;
>  }
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index b9fa3ef5b57c..970cb0d8acaa 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -116,7 +116,6 @@ static int virtblk_setup_discard_write_zeroes(struct
> request *req, bool unmap) unsigned short segments =3D
> blk_rq_nr_discard_segments(req);
>  	unsigned short n =3D 0;
>  	struct virtio_blk_discard_write_zeroes *range;
> -	struct bio *bio;
>  	u32 flags =3D 0;
>=20
>  	if (unmap)
> @@ -138,9 +137,11 @@ static int virtblk_setup_discard_write_zeroes(struct
> request *req, bool unmap) range[0].sector =3D cpu_to_le64(blk_rq_pos(req)=
);
>  		n =3D 1;
>  	} else {
> -		__rq_for_each_bio(bio, req) {
> -			u64 sector =3D bio->bi_iter.bi_sector;
> -			u32 num_sectors =3D bio->bi_iter.bi_size >> SECTOR_SHIFT;
> +		struct req_discard_range r;
> +
> +		rq_for_each_discard_range(r, req) {
> +			u64 sector =3D r.sector;
> +			u32 num_sectors =3D r.size >> SECTOR_SHIFT;
>=20
>  			range[n].flags =3D cpu_to_le32(flags);
>  			range[n].num_sectors =3D cpu_to_le32(num_sectors);
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 24bcae88587a..4b0a39360ce9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -813,7 +813,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns
> *ns, struct request *req, {
>  	unsigned short segments =3D blk_rq_nr_discard_segments(req), n =3D 0;
>  	struct nvme_dsm_range *range;
> -	struct bio *bio;
> +	struct req_discard_range r;
>=20
>  	/*
>  	 * Some devices do not consider the DSM 'Number of Ranges' field when
> @@ -835,9 +835,9 @@ static blk_status_t nvme_setup_discard(struct nvme_ns
> *ns, struct request *req, range =3D page_address(ns->ctrl->discard_page);
>  	}
>=20
> -	__rq_for_each_bio(bio, req) {
> -		u64 slba =3D nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> -		u32 nlb =3D bio->bi_iter.bi_size >> ns->lba_shift;
> +	rq_for_each_discard_range(r, req) {
> +		u64 slba =3D nvme_sect_to_lba(ns, r.sector);
> +		u32 nlb =3D r.size >> ns->lba_shift;
>=20
>  		if (n < segments) {
>  			range[n].cattr =3D cpu_to_le32(0);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index d66d0da72529..bd9d22269a7b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1007,6 +1007,57 @@ static inline unsigned int blk_rq_stats_sectors(co=
nst
> struct request *rq) return rq->stats_sectors;
>  }
>=20
> +struct req_discard_range {
> +	sector_t	sector;
> +	unsigned int	size;
> +
> +	/*
> +	 * internal field: driver don't use it, and it always points to
> +	 * next bio to be processed
> +	 */
> +	struct bio *__bio;
> +};
> +
> +static inline void req_init_discard_range_iter(const struct request *rq,
> +		struct req_discard_range *range)
> +{
> +	range->__bio =3D rq->bio;
> +}
> +
> +/* return true if @range stores one valid discard range */
> +static inline bool req_get_discard_range(struct req_discard_range *range)
> +{
> +	struct bio *bio;
> +
> +	if (!range->__bio)
> +		return false;
> +
> +	bio =3D range->__bio;
> +	range->sector =3D bio->bi_iter.bi_sector;
> +	range->size =3D bio->bi_iter.bi_size;
> +	range->__bio =3D bio->bi_next;
> +
> +	while (range->__bio) {
> +		struct bio *bio =3D range->__bio;
> +
> +		if (range->sector + (range->size >> SECTOR_SHIFT) !=3D
> +				bio->bi_iter.bi_sector)
> +			break;
> +
> +		/*
> +		 * ->size won't overflow because req->__data_len is defined
> +		 *  as 'unsigned int'
> +		 */
> +		range->size +=3D bio->bi_iter.bi_size;
> +		range->__bio =3D bio->bi_next;
> +	}
> +	return true;
> +}
> +
> +#define rq_for_each_discard_range(range, rq) \
> +	for (req_init_discard_range_iter((rq), &range); \
> +			req_get_discard_range(&range);)
> +
>  #ifdef CONFIG_BLK_DEV_ZONED
>=20
>  /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */

Do I have to revert the previous one and apply this one? If so, with this o=
ne the issue is triggered pretty quick:

```
kernel: ------------[ cut here ]------------
kernel: WARNING: CPU: 20 PID: 490 at drivers/nvme/host/core.c:850 nvme_setu=
p_discard+0x1b9/0x220
=E2=80=A6
kernel: CPU: 20 PID: 490 Comm: md0_raid10 Not tainted 5.13.0-pf4 #1
kernel: Hardware name: ASUS System Product Name/Pro WS X570-ACE, BIOS 3601 =
05/26/2021
kernel: RIP: 0010:nvme_setup_discard+0x1b9/0x220
kernel: Code: 38 4c 8b 88 40 0b 00 00 4c 2b 0d f2 06 d8 00 49 c1 f9 06 49 c=
1 e1 0c 4c 03 0d f3 06 d8 00 4d 89 c8 48 85 d2 0f 85 9f fe ff ff <0f> 0b b8=
 00 00 00 80 4c 01 c8 72 52 48 c7 c2 00 00 00 80 48 2b 15
kernel: RSP: 0018:ffffa3a34152ba10 EFLAGS: 00010202
kernel: RAX: ffff8b78d80db0c0 RBX: 000000000000000f RCX: 0000000000000400
kernel: RDX: 0000000000000000 RSI: 00000000241b5c00 RDI: 000000000000000d
kernel: RBP: ffff8b78cbd70380 R08: ffff8b78d80db000 R09: ffff8b78d80db000
kernel: R10: 00000000241b5c00 R11: 0000000000000000 R12: ffff8b78c5a4b800
kernel: R13: ffff8b78cbd704c8 R14: ffff8b78c5bd8000 R15: ffff8b78cabbf000
kernel: FS:  0000000000000000(0000) GS:ffff8b7fcef00000(0000) knlGS:0000000=
000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 00007faaaf746020 CR3: 00000001e0342000 CR4: 0000000000350ee0
kernel: Call Trace:
kernel:  nvme_setup_cmd+0x2d0/0x670
kernel:  nvme_queue_rq+0x79/0xc90
kernel:  ? __sbitmap_get_word+0x30/0x80
kernel:  ? sbitmap_get+0x85/0x180
kernel:  blk_mq_dispatch_rq_list+0x15c/0x810
kernel:  __blk_mq_do_dispatch_sched+0xca/0x320
kernel:  ? ktime_get+0x38/0xa0
kernel:  __blk_mq_sched_dispatch_requests+0x14d/0x190
kernel:  blk_mq_sched_dispatch_requests+0x2f/0x60
kernel:  __blk_mq_run_hw_queue+0x30/0xa0
kernel:  __blk_mq_delay_run_hw_queue+0x142/0x170
kernel:  blk_mq_sched_insert_requests+0x6d/0xf0
kernel:  blk_mq_flush_plug_list+0x111/0x1c0
kernel:  blk_finish_plug+0x21/0x30
kernel:  raid10d+0x7c8/0x1960 [raid10]
kernel:  ? psi_task_switch+0xf2/0x330
kernel:  ? __switch_to_asm+0x42/0x70
kernel:  ? finish_task_switch.isra.0+0xaa/0x290
kernel:  ? md_thread+0xc3/0x190 [md_mod]
kernel:  md_thread+0xc3/0x190 [md_mod]
kernel:  ? finish_wait+0x80/0x80
kernel:  ? md_rdev_init+0xb0/0xb0 [md_mod]
kernel:  kthread+0x1b3/0x1e0
kernel:  ? __kthread_init_worker+0x50/0x50
kernel:  ret_from_fork+0x22/0x30
kernel: ---[ end trace dc148fcea235e799 ]---
kernel: blk_update_request: I/O error, dev nvme0n1, sector 605615104 op 0x3=
:(DISCARD) flags 0x0 phys_seg 15 prio class 0
kernel: blk_update_request: I/O error, dev nvme1n1, sector 118159360 op 0x3=
:(DISCARD) flags 0x0 phys_seg 15 prio class 0
kernel: blk_update_request: I/O error, dev nvme0n1, sector 118200320 op 0x3=
:(DISCARD) flags 0x0 phys_seg 50 prio class 0
kernel: blk_update_request: I/O error, dev nvme1n1, sector 118326272 op 0x3=
:(DISCARD) flags 0x0 phys_seg 165 prio class 0
```

=2D-=20
Oleksandr Natalenko (post-factum)


