Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C874347F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhJTJbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhJTJbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:31:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E832C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:29:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g10so23351375edj.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jZzGb3vO+QEI8hZOb8qtN4bmMEeRFebl3SxOzOsGTBo=;
        b=vCY4A5zLiPNS7NQIDxE7CFM5Xt0fWjFflyEs+UBnxbs+QUYgu8g9OfftHfe++iUhVP
         nIauw3XLlXGUiy8KoX5I8SNt3Q/cXPYMrtAQCmcxRXzgE4EfKY2DXg7ANlg1H6n81ZGY
         EEDvWftLzcyy/87+IMEl6AFE+60RA4GioSMZnN3p5zKbgzFMGOkDMhzsg1ERar7cjLmy
         zyI84pYaqGEewQ+zXeOun82AeUTs+mRPWuX8rwUz2lQvliaU3HdLyPlfb29cl0Lc4Uvn
         Yp3pF6qtVGBcZ4euPJUUQnZ06u6PYkzx0z27DSNoc8eUBy57iE4xoYGauzrWRr3WfRuV
         hgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jZzGb3vO+QEI8hZOb8qtN4bmMEeRFebl3SxOzOsGTBo=;
        b=vc89b5eNk9+dLnD7fn4bDUjprf6hN5j/FoOcFjSREZ18efu61vUWrXtI4X/U+esQoX
         F8OdB049G9x19vvZfl5ANuDq3ZlSNrgUkfFSjjlYz/W/FLaFXCar9BfvqKtQCp1AKQCA
         zvVHqpr4CZoaUeS2AdjwFwbGi4dUmSlJonDTisE/is4E1YcNhA/JNovvrIA+5Xked8Zf
         1IVdTkE1yrcLvZRc9zGzBQblZJxP5n+8O8UlVsj4AHW6iHIyUATQ824/HmW2QVdWXpdb
         df9QEG8mRY6TjzOdPC/BsfkmeFF0WO+Z0h8AAL1KAMoGzPq+QEeFzUaiwKRHVGNma4ha
         OXjA==
X-Gm-Message-State: AOAM533+NG7US7NQhShRoV02DAFBvS7+XWt1SjmNFM0aLlD+7uXzP7sT
        K3drhHZKMuiU6q4a8dIoanyJBZ5xkEQMaw==
X-Google-Smtp-Source: ABdhPJxg1Mbljl7owGUbgbqHmwnL2TBA4zDVxkHFfKe4wKSkPtf/kc0yzFjqDaDJ94HMJ9op3UEPew==
X-Received: by 2002:a17:907:7f24:: with SMTP id qf36mr27718174ejc.491.1634722171371;
        Wed, 20 Oct 2021 02:29:31 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id a13sm748381ejx.39.2021.10.20.02.29.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Oct 2021 02:29:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v4 1/2] block, bfq: counted root group into
 'num_groups_with_pending_reqs'
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1f89cece-a123-6190-bb72-d59035dac266@huawei.com>
Date:   Wed, 20 Oct 2021 11:29:29 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E8712BB-5BFB-4647-AE9A-B06E199500D7@linaro.org>
References: <20211014014556.3597008-1-yukuai3@huawei.com>
 <20211014014556.3597008-2-yukuai3@huawei.com>
 <0DD9CFF0-6110-497D-A352-9F37CADADC6B@linaro.org>
 <1f89cece-a123-6190-bb72-d59035dac266@huawei.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 20 ott 2021, alle ore 11:20, yukuai (C) <yukuai3@huawei.com> =
ha scritto:
>=20
> On 2021/10/20 16:51, Paolo Valente wrote:
>=20
>>> @@ -860,9 +870,25 @@ void bfq_weights_tree_remove(struct bfq_data =
*bfqd,
>>> 			     struct bfq_queue *bfqq)
>>> {
>>> 	struct bfq_entity *entity =3D bfqq->entity.parent;
>>> +	struct bfq_sched_data *sd;
>>> +
>>> +	/*
>>> +	 * If the bfq queue is in root group, the decrement of
>>> +	 * num_groups_with_pending_reqs is performed immediately upon =
the
>>> +	 * deactivation of entity.
>>> +	 */
>>> +	if (!entity) {
>>> +		entity =3D &bfqd->root_group->entity;
>>> +		sd =3D entity->my_sched_data;
>>> +
>>> +		if (!sd->in_service_entity)
>>> +			bfq_clear_group_with_pending_reqs(bfqd, entity);
>>> +
>>> +		return;
>>> +	}
>>>=20
>>> 	for_each_entity(entity) {
>>> -		struct bfq_sched_data *sd =3D entity->my_sched_data;
>>> +		sd =3D entity->my_sched_data;
>>>=20
>>> 		if (sd->next_in_service || sd->in_service_entity) {
>>> 			/*
>>> @@ -880,7 +906,8 @@ void bfq_weights_tree_remove(struct bfq_data =
*bfqd,
>>> 		}
>>>=20
>>> 		/*
>>> -		 * The decrement of num_groups_with_pending_reqs is
>>> +		 * If the bfq queue is not in root group,
>>> +		 * the decrement of num_groups_with_pending_reqs is
>> I'm sorry if I didn't notice this before, but why do you postpone the
>> decrement only for queues not in root group?  If I'm not missing
>> anything, the active (i.e., with pending reqs) state of the root =
group
>> is to be computed as that of ay other group.
>=20
> Hi, Paolo
>=20
> I thought if queue is in root group, then bfqq->entity.parent is NULL,
> and such case is handled above, which is separate from previous
> implementation for queues that are not in root group.
>=20
> Is this the wrong way to handle root group?
>=20

I think that, if we want to count also the root group among the active
ones, then the logic for tagging the root group as active must be the
same as the other groups. Or am I missing something?

Thanks,
Paolo

> Thanks,
> Kuai

