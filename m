Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4467343481B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhJTJpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhJTJpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:45:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83C9C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:43:25 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a25so23569849edx.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=v1VSTfmj+2omzHjhOYwuPhGVdz2EGeKwbUST3Yohfp8=;
        b=b4aLpPEOdV/TIxwTKhJahMs87GTv74bw7jmVmHTZ7cs3ACizYGm48qQd6k+CAkSF6i
         odDbyf6hymgVeDmxcBaYCqnY1n+6Ixee8rOqgqFcV/1qpLCkcY2b+zB94AsySvrDDKjL
         9EHL1ODLW3Uo3pBF5utQR7L8NQSgxFXaMqaAOT2AKCTmAKcl0TOgBYfhIAwi5AzU2N8b
         0C8gjkB6isP32/zSrc6I1TJanHRb8Sn+M9DRqr/sde5GaCiFs72TfAgxd4DptvlWNxQy
         Xm06CtYANZWpTTdv7cIAKZLVxHhsBngflVsJDVkb55UAueFt2WbUfJ6KzzPAGD0idD0A
         qCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=v1VSTfmj+2omzHjhOYwuPhGVdz2EGeKwbUST3Yohfp8=;
        b=oOML5haaDGWBwhhbHAmJKt13dLEzYIMWRQeIcq3fTQUY4nl76Dg37u/4LUsFse6ENV
         VeyrcFzCNCpDqjJbiM+bLCldKdJYRFZoKBKhi9fbo0y921gg236f2ZRgaYVd0vvC628B
         xkt9Occ4cF0hmJBl8NQbDPx5hyqsFBCaTt9rHPCm61YWjz2rZlAHJ9rtjC6KEL4norJV
         0VtpgQsfV3HIkt4idqXewT5nyK4WmgOnhKvP++dG8VQ4WaiLdpbjF2d7ruFzsNydaU0i
         pKaIG9FK6JrigiwlDNeY31ORBoUYM+Hk92Kp7hRZFXc0p98P+QGDDSQxP3v6uFIzjPyt
         a8YQ==
X-Gm-Message-State: AOAM530mdKiA296RKu4eBcgkMzmFuDDuDNmUtGAIeGeFa8/RS4tneRs2
        6IAmO0QmE0LewEEvpwYTElz5Ww==
X-Google-Smtp-Source: ABdhPJy+ZQccMneiNAm3ecn4imRuDdy7DOOhi+6IM973twATsLL7fRQpW0eUwpLeTBURbwkyEeyJCQ==
X-Received: by 2002:a50:e14a:: with SMTP id i10mr61558844edl.73.1634723004215;
        Wed, 20 Oct 2021 02:43:24 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id s7sm857404edw.67.2021.10.20.02.43.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Oct 2021 02:43:23 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v4 1/2] block, bfq: counted root group into
 'num_groups_with_pending_reqs'
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <8912e5ca-67bb-4a9a-a2ce-ba13e0fc86ed@huawei.com>
Date:   Wed, 20 Oct 2021 11:43:22 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <AA986626-D3BF-43F3-81C2-FD7AA3C1ACD2@linaro.org>
References: <20211014014556.3597008-1-yukuai3@huawei.com>
 <20211014014556.3597008-2-yukuai3@huawei.com>
 <0DD9CFF0-6110-497D-A352-9F37CADADC6B@linaro.org>
 <1f89cece-a123-6190-bb72-d59035dac266@huawei.com>
 <2E8712BB-5BFB-4647-AE9A-B06E199500D7@linaro.org>
 <8912e5ca-67bb-4a9a-a2ce-ba13e0fc86ed@huawei.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 20 ott 2021, alle ore 11:38, yukuai (C) <yukuai3@huawei.com> =
ha scritto:
>=20
> On 2021/10/20 17:29, Paolo Valente wrote:
>>> Il giorno 20 ott 2021, alle ore 11:20, yukuai (C) =
<yukuai3@huawei.com> ha scritto:
>>>=20
>>> On 2021/10/20 16:51, Paolo Valente wrote:
>>>=20
>>>>> @@ -860,9 +870,25 @@ void bfq_weights_tree_remove(struct bfq_data =
*bfqd,
>>>>> 			     struct bfq_queue *bfqq)
>>>>> {
>>>>> 	struct bfq_entity *entity =3D bfqq->entity.parent;
>>>>> +	struct bfq_sched_data *sd;
>>>>> +
>>>>> +	/*
>>>>> +	 * If the bfq queue is in root group, the decrement of
>>>>> +	 * num_groups_with_pending_reqs is performed immediately upon =
the
>>>>> +	 * deactivation of entity.
>>>>> +	 */
>>>>> +	if (!entity) {
>>>>> +		entity =3D &bfqd->root_group->entity;
>>>>> +		sd =3D entity->my_sched_data;
>>>>> +
>>>>> +		if (!sd->in_service_entity)
>>>>> +			bfq_clear_group_with_pending_reqs(bfqd, entity);
>>>>> +
>>>>> +		return;
>>>>> +	}
>>>>>=20
>>>>> 	for_each_entity(entity) {
>>>>> -		struct bfq_sched_data *sd =3D entity->my_sched_data;
>>>>> +		sd =3D entity->my_sched_data;
>>>>>=20
>>>>> 		if (sd->next_in_service || sd->in_service_entity) {
>>>>> 			/*
>>>>> @@ -880,7 +906,8 @@ void bfq_weights_tree_remove(struct bfq_data =
*bfqd,
>>>>> 		}
>>>>>=20
>>>>> 		/*
>>>>> -		 * The decrement of num_groups_with_pending_reqs is
>>>>> +		 * If the bfq queue is not in root group,
>>>>> +		 * the decrement of num_groups_with_pending_reqs is
>>>> I'm sorry if I didn't notice this before, but why do you postpone =
the
>>>> decrement only for queues not in root group?  If I'm not missing
>>>> anything, the active (i.e., with pending reqs) state of the root =
group
>>>> is to be computed as that of ay other group.
>>>=20
>>> Hi, Paolo
>>>=20
>>> I thought if queue is in root group, then bfqq->entity.parent is =
NULL,
>>> and such case is handled above, which is separate from previous
>>> implementation for queues that are not in root group.
>>>=20
>>> Is this the wrong way to handle root group?
>>>=20
>> I think that, if we want to count also the root group among the =
active
>> ones, then the logic for tagging the root group as active must be the
>> same as the other groups. Or am I missing something?
>=20
> Hi, Paolo
>=20
> Currently, if queue is in root group, bfqq->entity.parent is NULL, and
> this makes it hard to keep the same logic.
>=20
> Can we store root_group->my_entity to bfqq->entity.parent if the queue
> is in root group?
>=20

Any sensible implementation is ok for me.  Usually, stuff for root
group is in the bfqd.

Thanks,
Paolo

> Thanks,
> Kuai

