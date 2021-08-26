Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B066B3F8CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 19:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243187AbhHZRBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 13:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243178AbhHZRBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 13:01:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BD6C0613D9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 10:00:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id z9-20020a7bc149000000b002e8861aff59so3198973wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 10:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=z12D9KyHke5IVslTWHsg63NbHgk31TJu3pkgdV/CCBM=;
        b=D0sgTM1tGgdMqNH7vALTdpWJAu+PEkmOhb/sbCJGaU/9V/k5xKPWxis/ePLgPoRIAv
         55n5oSJWTIR+dGDMU26mXsStgSCwE+S0L1VBFssOBM89EhHN7I6wUxQ/vLr6hkOoAre/
         IzLCLkOxjMZyWEKZ+oenZD05a4xp+IL2V52X+scNf3iL9aRqQqIG0NtxdY90EZYcAa1j
         piIUnB8pEObt/p4V0Vnr7nWdY8o3oa8Q7qeA0SQh74P/wX91NMyBshlZcRY4J4V0F6bH
         wxYjIaMwRMic6WkPhniycEVIsyvfyq0cJZTYpsl0tLpqPUhCCZgyhqIKtCGC8FVS1y7N
         qy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=z12D9KyHke5IVslTWHsg63NbHgk31TJu3pkgdV/CCBM=;
        b=B2jgnT6RDrON/nLz3sjORhi7GIfLHEws6zTJpcublRYpc+i3ZFiZmimLDJCtXF1BYD
         U58Bf3AJqHCIzJjpiFxmYZG28q7FP2Y+V2kii+iEpcrH7ipOYdrD3jUaj7Dk+1t8EOaY
         RHqIM/DRXWVgFDayiphl7+TbW8TCRgWBJcFeeLetV4OyJeQkqLycd+AE8ieRqHMmdLS1
         2/sv5hQCK6hctRTEpSLZqRvsVJL7LP+JUZZJNAcgIqF3H/lLpzobIsSqDhK1KqAg6aRV
         sG1bhvh/5b0SURUtxyEYwAJbh5F2CUe45IEvVjJ05SaRDa9FfdLErFVG+nPFW4/YUCTg
         k7PA==
X-Gm-Message-State: AOAM530nHYyfOx9gK1KcntPnpB6QQU3+KI77cANfvR2qsIp/P+g2kdGI
        K4PN0McSQkBl1TWa4xuJu32x0A==
X-Google-Smtp-Source: ABdhPJwyTbu4VIwUdrvhSkVrXZSBi664z33pRmIoXoANKExq4AZ2WvTBD+ziTDsk1mP5n7MFElu12A==
X-Received: by 2002:a1c:7dd0:: with SMTP id y199mr4746860wmc.148.1629997254822;
        Thu, 26 Aug 2021 10:00:54 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id t5sm2552698wra.95.2021.08.26.10.00.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Aug 2021 10:00:54 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 1/4] block, bfq: add support to track if root_group
 have any pending requests
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210806020826.1407257-2-yukuai3@huawei.com>
Date:   Thu, 26 Aug 2021 19:00:53 +0200
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2968B663-F855-4C41-AE9B-E33787DA6AF9@linaro.org>
References: <20210806020826.1407257-1-yukuai3@huawei.com>
 <20210806020826.1407257-2-yukuai3@huawei.com>
To:     Yu Kuai <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 6 ago 2021, alle ore 04:08, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> Add a new member in bfq_data to track number of queues that are in
> root_group with any pending requests.

maybe modify the last part of the sentence as: ... and that have some =
pending request

> This will be used in next patch
> to optmize queue idle judgment when root_group doesn't have any
> pending requests.
>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> block/bfq-iosched.c |  8 +++++++-
> block/bfq-iosched.h | 13 +++++++++++--
> block/bfq-wf2q.c    | 37 ++++++++++++++++++++++++-------------
> 3 files changed, 42 insertions(+), 16 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 727955918563..7c6b412f9a9c 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -859,8 +859,14 @@ void __bfq_weights_tree_remove(struct bfq_data =
*bfqd,
> void bfq_weights_tree_remove(struct bfq_data *bfqd,
> 			     struct bfq_queue *bfqq)
> {
> -	struct bfq_entity *entity =3D bfqq->entity.parent;
> +	struct bfq_entity *entity =3D &bfqq->entity;
> +
> +	if (entity->in_groups_with_pending_reqs) {
> +		entity->in_groups_with_pending_reqs =3D false;
> +		bfqd->num_queues_with_pending_reqs_in_root--;

Here you cross the comment "The decrement of
num_groups_with_pending_reqs is not performed immediately upon ...".

Find a way to
- move that comment up, and to make it correct for this slightly
  different decrement
- leave a correct comment (probably shorter) in the original position

> +	}
>=20
> +	entity =3D entity->parent;
> 	for_each_entity(entity) {
> 		struct bfq_sched_data *sd =3D entity->my_sched_data;
>=20
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 99c2a3cb081e..610769214f72 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -195,7 +195,12 @@ struct bfq_entity {
> 	/* flag, set to request a weight, ioprio or ioprio_class change  =
*/
> 	int prio_changed;
>=20
> -	/* flag, set if the entity is counted in =
groups_with_pending_reqs */
> +	/*
> +	 * If entity represents bfq_group, this flag will set

will be set?

> if the group is
> +	 * not root_group and have

has

> any pending requests; If entity represents

one more nit: use lowercase after semicolon

> +	 * bfq_queue, this flag will set

will be set

> if the queue is in root_group and have
> +	 * any pending requests.
> +	 */
> 	bool in_groups_with_pending_reqs;
>=20

The name of the above field follows from the fact that entity is
counted in groups_with_pending_reqs.  You change this fact, because,
in your patch, a queue is not counted in groups_with_pending_reqs.
But you leave the same name. This creates confusion.


> 	/* last child queue of entity created (for non-leaf entities) */
> @@ -539,7 +544,11 @@ struct bfq_data {
> 	 * with no request waiting for completion.
> 	 */
> 	unsigned int num_groups_with_pending_reqs;
> -
> +	/*
> +	 * number of queues that are in root_group with at least one =
request
> +	 * waiting for completion.

please link somehow this comment to the long comment that comes before =
it

> +	 */
> +	unsigned int num_queues_with_pending_reqs_in_root;

Why using two counters?  I mean, couldn't you simply count also the
root group in num_groups_with_pending_reqs?

> 	/*
> 	 * Per-class (RT, BE, IDLE) number of bfq_queues containing
> 	 * requests (including the queue in service, even if it is
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 7a462df71f68..188c8f907219 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -946,6 +946,29 @@ static void bfq_update_fin_time_enqueue(struct =
bfq_entity *entity,
> 	bfq_active_insert(st, entity);
> }
>=20
> +static void bfq_update_groups_with_pending_reqs(struct bfq_entity =
*entity)
> +{
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
> +	struct bfq_queue *bfqq =3D bfq_entity_to_bfqq(entity);
> +

why do you introduce an extra variable bfqq, instead of doing as in
the original version of the code?  In addition, you remove the comment
/* bfq_group */

Thanks,
Paolo

> +	if (bfqq) {
> +		if (!entity->parent && =
!entity->in_groups_with_pending_reqs) {
> +			entity->in_groups_with_pending_reqs =3D true;
> +			=
bfqq->bfqd->num_queues_with_pending_reqs_in_root++;
> +		}
> +	} else {
> +		if (!entity->in_groups_with_pending_reqs) {
> +			struct bfq_group *bfqg =3D
> +				container_of(entity, struct bfq_group, =
entity);
> +			struct bfq_data *bfqd =3D bfqg->bfqd;
> +
> +			entity->in_groups_with_pending_reqs =3D true;
> +			bfqd->num_groups_with_pending_reqs++;
> +		}
> +	}
> +#endif
> +}
> +
> /**
>  * __bfq_activate_entity - handle activation of entity.
>  * @entity: the entity being activated.
> @@ -999,19 +1022,7 @@ static void __bfq_activate_entity(struct =
bfq_entity *entity,
> 		entity->on_st_or_in_serv =3D true;
> 	}
>=20
> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
> -		struct bfq_group *bfqg =3D
> -			container_of(entity, struct bfq_group, entity);
> -		struct bfq_data *bfqd =3D bfqg->bfqd;
> -
> -		if (!entity->in_groups_with_pending_reqs) {
> -			entity->in_groups_with_pending_reqs =3D true;
> -			bfqd->num_groups_with_pending_reqs++;
> -		}
> -	}
> -#endif
> -
> +	bfq_update_groups_with_pending_reqs(entity);
> 	bfq_update_fin_time_enqueue(entity, st, backshifted);
> }
>=20
> --=20
> 2.31.1
>=20

