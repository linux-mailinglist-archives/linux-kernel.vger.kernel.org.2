Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05FE325484
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhBYRZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhBYRZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:25:41 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBAEC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 09:25:00 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h98so6015294wrh.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 09:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MVkbF/1jc72x8ZGzUYYsizLbk7+O8V1Wq4Viv7ATlRM=;
        b=pbQ02jWikzGsiY9snWIAHCeyQM+XaczYLcwXs+SV8ZbYBmuG2+oSoY6CRN72gUjHhu
         eDV2XfeRG1O3MneZmVInnMAU46MSzVCGlSbDHXCpRH1HPxmJCYRvk66lvL/ihuoWAAvn
         FjodqSa4LIQBj7GQEdafh1dw189O3NVzVPiaFyWxPPkc0hEWiq5EK+uWLxjrQT0au6Xn
         KOZnJ4zBE2sN24jpnjv97CZQofAEZrHv4OqQhLnQO9liJtF8MSTC38aiF41R073QN36u
         ABRZPk3MLG+0xli8o4C512MoIdYB2yxksFc5mOsMAyTS1WW2t+47BGj8hkZBs7VNsHaT
         o7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MVkbF/1jc72x8ZGzUYYsizLbk7+O8V1Wq4Viv7ATlRM=;
        b=qbMim/WABT6e19EPGFJHr+FgcV1QB3w1BuerOu9Ygd/kAMB566eBqo3uUZcjwjnt6m
         kBNYM81Spo8Yo+yIzsA1w0ebsLA2iCQIq+ieBnIvIieWXgw3LavihkEoO2CYu+IawMdn
         98AGIZZK5YcZrYMzVNHiLfUryF8MXrrrCcnynbOkrIfl+Ar61WyXxGFKobd24T+92YPZ
         8k32JvcB3ebS6pO7yEjYu3tCvNtrRBfZois7eUb3/npKVtnFpJPTY4T+1qxWi3vYHcnA
         +AdTnJBoGdU3NyhN7oN9JHAOLtIhS3+ah2RU4tsXBjIHk8Zpq1zEQOyWAVU1Dr2TgM1m
         J8sw==
X-Gm-Message-State: AOAM5307Qng3GbD2qj/VeSmqedIis8z8ecMK6vbUa8POc79ok5f8LIYL
        sSPcYudniyaoUR/RnEITI11jeg==
X-Google-Smtp-Source: ABdhPJyrHo1WPhB3+0cKMV7aiFIAQKTMaoTrfzFCN6TFDitufQhT+C1RGUAe5vehIi2xEyqUmVJ36Q==
X-Received: by 2002:adf:bac8:: with SMTP id w8mr4677372wrg.68.1614273899260;
        Thu, 25 Feb 2021 09:24:59 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id o3sm2521016wmq.46.2021.02.25.09.24.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Feb 2021 09:24:58 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 6/6] block, bfq: merge bursts of
 newly-created queues
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <a4874bb3-006c-85d9-5015-12443baa1e87@kernel.dk>
Date:   Thu, 25 Feb 2021 18:25:53 +0100
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F6EF0B5-A63D-4A0B-A563-71495D7FFDCE@linaro.org>
References: <20210126105102.53102-1-paolo.valente@linaro.org>
 <20210126105102.53102-7-paolo.valente@linaro.org>
 <a4874bb3-006c-85d9-5015-12443baa1e87@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 26 gen 2021, alle ore 17:15, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 1/26/21 3:51 AM, Paolo Valente wrote:
>> @@ -2809,6 +2853,12 @@ void bfq_release_process_ref(struct bfq_data =
*bfqd, struct bfq_queue *bfqq)
>> 	    bfqq !=3D bfqd->in_service_queue)
>> 		bfq_del_bfqq_busy(bfqd, bfqq, false);
>>=20
>> +	if (bfqq->entity.parent &&
>> +	    bfqq->entity.parent->last_bfqq_created =3D=3D bfqq)
>> +		bfqq->entity.parent->last_bfqq_created =3D NULL;
>> +	else if (bfqq->bfqd && bfqq->bfqd->last_bfqq_created =3D=3D =
bfqq)
>> +		bfqq->bfqd->last_bfqq_created =3D NULL;
>> +
>> 	bfq_put_queue(bfqq);
>> }
>>=20
>> @@ -2905,6 +2955,13 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct =
bfq_io_cq *bic,
>> 	 */
>> 	new_bfqq->pid =3D -1;
>> 	bfqq->bic =3D NULL;
>> +
>> +	if (bfqq->entity.parent &&
>> +	    bfqq->entity.parent->last_bfqq_created =3D=3D bfqq)
>> +		bfqq->entity.parent->last_bfqq_created =3D new_bfqq;
>> +	else if (bfqq->bfqd && bfqq->bfqd->last_bfqq_created =3D=3D =
bfqq)
>> +		bfqq->bfqd->last_bfqq_created =3D new_bfqq;
>> +
>> 	bfq_release_process_ref(bfqd, bfqq);
>> }
>=20
> Almost identical code constructs makes it seem like this should have a
> helper instead.
>=20

Right, sorry. Improved in V2.

>> @@ -5033,6 +5090,12 @@ void bfq_put_queue(struct bfq_queue *bfqq)
>> 	bfqg_and_blkg_put(bfqg);
>> }
>>=20
>> +static void bfq_put_stable_ref(struct bfq_queue *bfqq)
>> +{
>> +	bfqq->stable_ref--;
>> +	bfq_put_queue(bfqq);
>> +}
>> +
>> static void bfq_put_cooperator(struct bfq_queue *bfqq)
>> {
>> 	struct bfq_queue *__bfqq, *next;
>> @@ -5089,6 +5152,17 @@ static void bfq_exit_icq(struct io_cq *icq)
>> {
>> 	struct bfq_io_cq *bic =3D icq_to_bic(icq);
>>=20
>> +	if (bic->stable_merge_bfqq) {
>> +		unsigned long flags;
>> +		struct bfq_data *bfqd =3D bic->stable_merge_bfqq->bfqd;
>> +
>> +		if (bfqd)
>> +			spin_lock_irqsave(&bfqd->lock, flags);
>> +		bfq_put_stable_ref(bic->stable_merge_bfqq);
>> +		if (bfqd)
>> +			spin_unlock_irqrestore(&bfqd->lock, flags);
>> +	}
>> +
>=20
> Construct like this are really painful. Just do:
>=20
> if (bfqd) {
> 	unsigned long flags;
>=20
> 	spin_lock_irqsave(&bfqd->lock, flags);
> 	bfq_put_stable_ref(bic->stable_merge_bfqq);
> 	spin_unlock_irqrestore(&bfqd->lock, flags);
> } else {
> 	bfq_put_stable_ref(bic->stable_merge_bfqq);
> }
>=20
> which is also less likely to cause code analyzer false warnings.

Done, thanks.

> Outside
> of that, it needs a comment on why it's ok NOT to grab the lock when
> bfqd is zero, because that seems counter-intuitive and more a case of
> "well we can't grab a lock for something we don't have". Maybe it's
> because bfqd is no longer visible at this point, and it's ok,

yes

> but it's
> definitely not clear just looking at this patch.

Right, the reason is already reported a few lines above, but not
repeated in this function.  I'll repeat it.


> Even with that, is the
> bfqq visible? Should the ref be atomic, and locking happen further =
down
> instead?
>=20

Since the scheduler is gone, no pending I/O is expected to still
reference bfqq.  I'll write this too in V2.

As I stated in my reply to another comments of yours, I'll submit the
V2 soon, unless I receive a reply before.

Thanks.
Paolo

> --=20
> Jens Axboe
>=20

