Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6917316A85
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 16:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhBJPyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhBJPyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:54:49 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7862CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 07:54:09 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id z6so3109181wrq.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 07:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=diEVw5/O8/Cy8oiBHC8W2XTuoIkYQ2nZAo/0L37zzlA=;
        b=WrxKkBGiNt0lpiBKQGILDGQoZOf6yr0kAlqHLYYFYcjMSJ8NcuITvVF+C9QqhvC2Uy
         +bgxUTlXmwUCh5S9/or4Zeju6IG4TBVuqSZI8F999LcKPyQHlhpbczAbbqulxjTJUG8U
         o0L2/lMRI1xuAP8bfX8tiOtKLvjJE9dUwVs9BhgwvWTdDxttqbGEAtr0O2SoJP+9B9jV
         8HFZUkAI0MJtPvIkG02y+T4g6VBbJd7dz0CmyolNqRQYomSQaHwGoFTrWiQ49U/gPPiy
         xx8hodBASgNWiO64H9WubL+A13Jn5Dhe0NQ50NoHP6UgV6aRyPDQiyvOpb+07x376uZW
         d4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=diEVw5/O8/Cy8oiBHC8W2XTuoIkYQ2nZAo/0L37zzlA=;
        b=YP7sIk3TYHoH01QV128rJOCQRyErdH8BtWtlhAxWn9MMEIcY/KjU45c/G87G1ssqyJ
         7x7gt3BRj5ji5BzWQjy9i5m8XagWqaeH6NwIbbuGOehBNuUqfLTIHy0y/N59TEVpN3o2
         AZmWopKoJyCzTP0rf9bJV3vHKkWByIk1zhWdRLV42kooyXKNAkhv7wmVpT6o00TEZ6fm
         t9mJKnmLYBfEfinpWw3YKxcBAWfLVjoGigHqO9QzSr//xzjS2NFW76qGGb4HaZH73kDY
         ZWcaoBzhaeAWhDRxvH7/TTiExa0io8B3TmyvE23Fl13vf42fvPuhB9vtnXyp2+4QyTg+
         2s6Q==
X-Gm-Message-State: AOAM5316AA4UL8pf5d/QlSXUuQcnuAb/vF5e3nnXcBSxAsph7AwaigdV
        SgBAwgQ7kChS7i1rqwzvaslNToQ5ajpUPQ==
X-Google-Smtp-Source: ABdhPJw1QFVpKunbCZwyU8NE9x73nKK0p7MMY16TugmV4n0fp/nCj5n532ESqNTyy0hqmas54no7zQ==
X-Received: by 2002:adf:ecd2:: with SMTP id s18mr4408622wro.311.1612972448181;
        Wed, 10 Feb 2021 07:54:08 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id z6sm2787750wmi.39.2021.02.10.07.54.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2021 07:54:07 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] bfq: remove some useless logic of
 bfq_update_next_in_service()
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <bc39aeb5-4fb6-db15-3ad5-b310f5d5b486@kernel.dk>
Date:   Wed, 10 Feb 2021 16:54:15 +0100
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Chunguang Xu <brookxu.cn@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6FFDC28C-BB1B-45F8-B2E9-2BCDF2CC1B61@linaro.org>
References: <1611917485-584-1-git-send-email-brookxu@tencent.com>
 <B4751549-78D9-4A84-8FB2-5DAA86ED39C8@linaro.org>
 <20210210152034.puimoewzgtnnp2zl@spock.localdomain>
 <bc39aeb5-4fb6-db15-3ad5-b310f5d5b486@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 10 feb 2021, alle ore 16:21, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 2/10/21 8:20 AM, Oleksandr Natalenko wrote:
>> On Wed, Feb 10, 2021 at 12:13:29PM +0100, Paolo Valente wrote:
>>>=20
>>>=20
>>>> Il giorno 29 gen 2021, alle ore 11:51, Chunguang Xu =
<brookxu.cn@gmail.com> ha scritto:
>>>>=20
>>>> From: Chunguang Xu <brookxu@tencent.com>
>>>>=20
>>>> The if statement at the end of the function is obviously useless,
>>>> maybe we can delete it.
>>>>=20
>>>=20
>>> Thanks for spotting this mistake.
>>>=20
>>> Acked-by: Paolo Valente <paolo.valente@linaro.org>
>>>=20
>>>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
>>>> ---
>>>> block/bfq-wf2q.c | 3 ---
>>>> 1 file changed, 3 deletions(-)
>>>>=20
>>>> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
>>>> index 26776bd..070e34a 100644
>>>> --- a/block/bfq-wf2q.c
>>>> +++ b/block/bfq-wf2q.c
>>>> @@ -137,9 +137,6 @@ static bool bfq_update_next_in_service(struct =
bfq_sched_data *sd,
>>>>=20
>>>> 	sd->next_in_service =3D next_in_service;
>>>>=20
>>>> -	if (!next_in_service)
>>>> -		return parent_sched_may_change;
>>>> -
>>=20
>> Unless I'm missing something, this has already been fixed here:
>>=20
>> =
https://git.kernel.dk/cgit/linux-block/commit/?h=3Dfor-5.12/block&id=3D1a2=
3e06cdab2be07cbda460c6417d7de564c48e6
>=20
> Yep indeed.
>=20

I seemed to remember this patch as well. But my memory is rather weak.

> --=20
> Jens Axboe

