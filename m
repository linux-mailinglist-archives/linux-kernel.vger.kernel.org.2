Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBF03F8C9D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 19:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243168AbhHZRBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 13:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243160AbhHZRBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 13:01:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A0CC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 10:00:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z4so6143630wrr.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 10:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=22dpL5Rs5C0+u/YTjsMji/cXeTNadrILM/A1uSYoeqQ=;
        b=StZyLy4jouZImc01/r9rdpec0h1H9RTdnQwCk3pJ21JGs/xh4DvG8WsICGvUNovCCp
         0h3llQ+sLdvGu2olPFQ3q1ZxnDvcmGYTqUxsQGV0BCPFHI8hC3SkElo8tJLzTv2QlAA0
         59ZlHgOTWaemWBU/jMgZaFJ7qsJJZDKd3EJaH7/F/QczUDEbnNQPyGV3jufBgqjZU83c
         j8nqRdPBu0+fdNTGacT1Gi6FM4u+OAz5RRhubgGvrHi0kcrzp1VPRA+xrT57BDXusdPt
         X7nRm8e0X2cTzgHAnXJOqY9iWgME4hNEavKRGvIeJV42uVZXLSjZwYZZwWNVSqrUm42j
         A9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=22dpL5Rs5C0+u/YTjsMji/cXeTNadrILM/A1uSYoeqQ=;
        b=tbExOQflj5U6K7NUwBPyPX/ysjyQ8R/7/viLmey27/fsT9IyDieIaM/bSirqzv2oWN
         x95PVx0/udkjbQTPtNUMLwqBb36McjGPeUFY/FV0Bk/IGLed9zslfOKyUcq3mD+16wRX
         rNZ4GoxEtalmlafdPCXYdH/Gs4zBHCrvYP5q4ufEBqcsRRWRuing+1wuuMXRG7FCEOLh
         Elgpa0k4YSHF/6Kl3C39hrun2tVyHI9pewcWeh/OhiCqIOuOeo6jHsOZ5G6bYtl8QBMn
         ywhqvX+ts0+qSmlY774Yl3E21cZ7cUw7FRk2UqidqQ6XoU3pV36L2ai4m8CXzwcx2lO/
         HBlg==
X-Gm-Message-State: AOAM532/G1sPw3sRWzIovJHllXJmHgpL970flHOWEFnedznwj4yEJWDl
        7DNDwWOHcwPVyGFxofi2NAFKjQ==
X-Google-Smtp-Source: ABdhPJzDVBBuLpvZac1T+rGejjKIbMox7l8W2oSE1XiNXyOT8Y9shGoSV6T4yZljXxRYuy8bErHyOg==
X-Received: by 2002:adf:a2c4:: with SMTP id t4mr5264387wra.258.1629997251236;
        Thu, 26 Aug 2021 10:00:51 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id t5sm2552698wra.95.2021.08.26.10.00.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Aug 2021 10:00:50 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 2/4] block, bfq: do not idle if only one cgroup is
 activated
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210806020826.1407257-3-yukuai3@huawei.com>
Date:   Thu, 26 Aug 2021 19:00:49 +0200
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <21FA636D-2C21-4ACD-B7DE-180ABB1F3562@linaro.org>
References: <20210806020826.1407257-1-yukuai3@huawei.com>
 <20210806020826.1407257-3-yukuai3@huawei.com>
To:     Yu Kuai <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 6 ago 2021, alle ore 04:08, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> If only one group is activated, there is no need to guarantee the same
> share of the throughput of queues in the same group.
>=20
> If CONFIG_BFQ_GROUP_IOSCHED is enabled, there is no need to check
> 'varied_queue_weights' and 'multiple_classes_busy':
> 1) num_groups_with_pending_reqs =3D 0, idle is not needed
> 2) num_groups_with_pending_reqs =3D 1
>   - if root group have any pending requests, idle is needed
>   - if root group is idle, idle is not needed
> 3) num_groups_with_pending_reqs > 1, idle is needed
>=20
> Test procedure:
> run "fio -numjobs=3D1 -ioengine=3Dpsync -bs=3D4k -direct=3D1 =
-rw=3Drandread..."
> multiple times in the same cgroup(not root).
>=20
> Test result: total bandwidth(Mib/s)
> | total jobs | before this patch | after this patch      |
> | ---------- | ----------------- | --------------------- |
> | 1          | 33.8              | 33.8                  |
> | 2          | 33.8              | 65.4 (32.7 each job)  |
> | 4          | 33.8              | 106.8 (26.7 each job) |
> | 8          | 33.8              | 126.4 (15.8 each job) |
>=20
> By the way, if I test with "fio -numjobs=3D1/2/4/8 ...", test result =
is
> the same with or without this patch.
>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> block/bfq-iosched.c | 35 ++++++++++++++++++++++++++---------
> 1 file changed, 26 insertions(+), 9 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 7c6b412f9a9c..a780205a1be4 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -709,7 +709,9 @@ bfq_pos_tree_add_move(struct bfq_data *bfqd, =
struct bfq_queue *bfqq)
>  * much easier to maintain the needed state:
>  * 1) all active queues have the same weight,
>  * 2) all active queues belong to the same I/O-priority class,
> - * 3) there are no active groups.
> + * 3) there are one active group at most(incluing root_group).

there are -> there is
incluing -> including
add a space before left parenthesis

> + * If the last condition is false, there is no need to guarantee the,

remove comma

> + * same share of the throughput of queues in the same group.

Actually, I would not add this extra comment on the last condition at =
all.

>  * In particular, the last condition is always true if hierarchical
>  * support or the cgroups interface are not enabled, thus no state
>  * needs to be maintained in this case.
> @@ -717,7 +719,26 @@ bfq_pos_tree_add_move(struct bfq_data *bfqd, =
struct bfq_queue *bfqq)
> static bool bfq_asymmetric_scenario(struct bfq_data *bfqd,
> 				   struct bfq_queue *bfqq)
> {
> -	bool smallest_weight =3D bfqq &&
> +	bool smallest_weight;
> +	bool varied_queue_weights;
> +	bool multiple_classes_busy;
> +
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
> +	if (bfqd->num_groups_with_pending_reqs > 1)
> +		return true;
> +
> +	if (bfqd->num_groups_with_pending_reqs &&
> +	    bfqd->num_queues_with_pending_reqs_in_root)
> +		return true;
> +
> +	/*
> +	 * Reach here means only one group(incluing root group) has =
pending
> +	 * requests, thus it's safe to return.
> +	 */
> +	return false;
> +#endif
> +
> +	smallest_weight =3D bfqq &&
> 		bfqq->weight_counter &&
> 		bfqq->weight_counter =3D=3D
> 		container_of(
> @@ -729,21 +750,17 @@ static bool bfq_asymmetric_scenario(struct =
bfq_data *bfqd,
> 	 * For queue weights to differ, queue_weights_tree must contain
> 	 * at least two nodes.
> 	 */
> -	bool varied_queue_weights =3D !smallest_weight &&
> +	varied_queue_weights =3D !smallest_weight &&
> 		!RB_EMPTY_ROOT(&bfqd->queue_weights_tree.rb_root) &&
> 		(bfqd->queue_weights_tree.rb_root.rb_node->rb_left ||
> 		 bfqd->queue_weights_tree.rb_root.rb_node->rb_right);
>=20
> -	bool multiple_classes_busy =3D
> +	multiple_classes_busy =3D
> 		(bfqd->busy_queues[0] && bfqd->busy_queues[1]) ||
> 		(bfqd->busy_queues[0] && bfqd->busy_queues[2]) ||
> 		(bfqd->busy_queues[1] && bfqd->busy_queues[2]);
>=20
> -	return varied_queue_weights || multiple_classes_busy
> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	       || bfqd->num_groups_with_pending_reqs > 0

Why do you make these extensive changes, while you can leave all the
function unchanged and just modify the above condition to something
like

|| bfqd->num_groups_with_pending_reqs > 1
|| (bfqd->num_groups_with_pending_reqs && =
bfqd->num_queues_with_pending_reqs_in_root)

In addition, I still wonder whether you can simply add also the root
group to bfqd->num_groups_with_pending_reqs (when the root group is
active).  This would make the design much cleaner.

Thanks,
Paolo

> -#endif
> -		;
> +	return varied_queue_weights || multiple_classes_busy;
> }
>=20
> /*
> --=20
> 2.31.1
>=20

