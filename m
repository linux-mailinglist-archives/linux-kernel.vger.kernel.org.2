Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED7A38FF6C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhEYKll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhEYKli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:41:38 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADE0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:40:07 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i13so35583079edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3yGsDli2PAREI1UQ986mpjtZkmRUlq+YGTsPWpR9QLY=;
        b=PoHN5QbJ7cVqtT+aJZ/fZ6bQpbp7HSC+KQzI96mt73om9jrd0T28UiBx3mPHsyqE9q
         Kikp0+EF9KuZF630sLl+WedUmVr/N+ICAXcdPUed74W/6kxGcR/Ok2GffLJH5SzaOCQI
         cxuHbEYPap6BtvZ9weIP7XillEbLNNV7gQY5QOHM92hn8fwn90rN5DvW59zHPRAbffPi
         IWIWviPnYtnv5McBhpZ17mSZqUVDxRmVAkHnfpJHnJWWZrLERtCld0kg4RaxL6A5LJxz
         zfe7NXgWwfA9gH8ztQGC2HgylCv3pH7XabZ+JL7oMsNrcusktlppTETQ33hVoh9f4DEY
         bVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3yGsDli2PAREI1UQ986mpjtZkmRUlq+YGTsPWpR9QLY=;
        b=RGHcehgE3O3oQ1TArLP1iK+Ssbdgge0ObytexD5a2jdBNiMeBWTV7LxaHNKNmPhpHZ
         i1OqNZlFNOHe22AqpEOP8j0r/1U36ZBuYh2h5/K8AxgYbpTJVUbN/aQecBJ6/kdNRY6A
         OclDjQILVq9LYDVoPKu9kU/VnuRJRSsVlYWMhSZLRzmUMEY613eaZZTXlJpVI5SfABmE
         zhuHoMRqI47PM3C9SdhUndDBH82cWCg2Nev3UZGy1vW2EJ89DHDeyLSH2a3bTKLUcGiq
         IFaBP2IlCDu9pvDOQB7RQJ37lnWenPLO5EZMhXHo+WHHftmr2Nv3edHuahGfq7yeAfYQ
         dthA==
X-Gm-Message-State: AOAM531gp9m5q5Gssgbk+xc7QvIfEiPCfuAicPEE9Bv0lZjkvfzgQsLu
        HcYVCbaiZ7cAHqc20qKHwcUO+A==
X-Google-Smtp-Source: ABdhPJwUv0ff4G0qtBrwSGwTeFQv7B/6Xg1Fpb/cjIwpehR1PC9qWejMPdwsShgPNxxRXiP+UqxaRA==
X-Received: by 2002:aa7:cd16:: with SMTP id b22mr17174586edw.108.1621939206306;
        Tue, 25 May 2021 03:40:06 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id v12sm11130194edb.81.2021.05.25.03.40.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 May 2021 03:40:05 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH BUGFIX] block, bfq: fix delayed stable merge check
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <3005fed2-d5f6-f709-cb3a-3d865623015d@applied-asynchrony.com>
Date:   Tue, 25 May 2021 12:40:04 +0200
Cc:     Luca Mariotti <mariottiluca1@hotmail.it>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Pietro Pedroni <pedroni.pietro.96@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E3E9C04-9969-4BAE-8474-A9B3BF449F87@linaro.org>
References: <DB8PR01MB59647C41BF6C964467EAFE0D882C9@DB8PR01MB5964.eurprd01.prod.exchangelabs.com>
 <f23f8090-4a55-3c16-1bdd-f86634cd6f3b@applied-asynchrony.com>
 <E9D95C99-D07B-4A63-8C0E-67356887DE23@linaro.org>
 <c6a3d259-a118-0c7a-0faf-1ab48f9cd2ff@applied-asynchrony.com>
 <E4CEEAB2-7092-4CC5-AA37-59CA5343A5AA@linaro.org>
 <3005fed2-d5f6-f709-cb3a-3d865623015d@applied-asynchrony.com>
To:     =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 24 mag 2021, alle ore 20:45, Holger Hoffst=C3=A4tte =
<holger@applied-asynchrony.com> ha scritto:
>=20
> On 2021-05-24 19:41, Paolo Valente wrote:
>>> Il giorno 24 mag 2021, alle ore 19:13, Holger Hoffst=C3=A4tte =
<holger@applied-asynchrony.com> ha scritto:
>>>=20
>>> On 2021-05-24 18:57, Paolo Valente wrote:
>>>>> Il giorno 20 mag 2021, alle ore 09:15, Holger Hoffst=C3=A4tte =
<holger@applied-asynchrony.com> ha scritto:
>>>>>=20
>>>>> On 2021-05-18 12:43, Luca Mariotti wrote:
>>>>>> When attempting to schedule a merge of a given bfq_queue with the =
currently
>>>>>> in-service bfq_queue or with a cooperating bfq_queue among the =
scheduled
>>>>>> bfq_queues, delayed stable merge is checked for rotational or =
non-queueing
>>>>>> devs. For this stable merge to be performed, some conditions must =
be met.
>>>>>> If the current bfq_queue underwent some split from some merged =
bfq_queue,
>>>>>> one of these conditions is that two hundred milliseconds must =
elapse from
>>>>>> split, otherwise this condition is always met.
>>>>>> Unfortunately, by mistake, time_is_after_jiffies() was written =
instead of
>>>>>> time_is_before_jiffies() for this check, verifying that less than =
two
>>>>>> hundred milliseconds have elapsed instead of verifying that at =
least two
>>>>>> hundred milliseconds have elapsed.
>>>>>> Fix this issue by replacing time_is_after_jiffies() with
>>>>>> time_is_before_jiffies().
>>>>>> Signed-off-by: Luca Mariotti <mariottiluca1@hotmail.it>
>>>>>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
>>>>>> Signed-off-by: Pietro Pedroni <pedroni.pietro.96@gmail.com>
>>>>>> ---
>>>>>>  block/bfq-iosched.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>>>>> index acd1f881273e..2adb1e69c9d2 100644
>>>>>> --- a/block/bfq-iosched.c
>>>>>> +++ b/block/bfq-iosched.c
>>>>>> @@ -2697,7 +2697,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, =
struct bfq_queue *bfqq,
>>>>>>  	if (unlikely(!bfqd->nonrot_with_queueing)) {
>>>>>>  		if (bic->stable_merge_bfqq &&
>>>>>>  		    !bfq_bfqq_just_created(bfqq) &&
>>>>>> -		    time_is_after_jiffies(bfqq->split_time +
>>>>>> +		    time_is_before_jiffies(bfqq->split_time +
>>>>>>  					  =
msecs_to_jiffies(200))) {
>>>>>>  			struct bfq_queue *stable_merge_bfqq =3D
>>>>>>  				bic->stable_merge_bfqq;
>>>>>=20
>>>>> Not sure why but with this patch I quickly got a division-by-zero =
in BFQ and
>>>>> complete system halt. Unfortunately I couldn't capture the exact =
stack trace,
>>>>> but it read something like bfq_calc_weight() or something ike =
that.
>>>>> I looked through the code and found bfq_delta(), so maybe weight =
got
>>>>> reduced to 0?
>>>>>=20
>>>> Hi Holger,
>>>> is this (easily) reproducible for you?  If so, I'd like to propose =
you
>>>> a candidate fix.
>>>=20
>>> Yes, it's easily reproducible (should be reproducible on 5.13-rc as =
well).
>>> Simple read/write I/O on a cold FS (rotational disk obviously) will =
crash
>>> pretty much immediately; without it everything works fine, likely =
because the
>>> bug (in the recent queue merging patches?) is never triggered due to =
the
>>> accidentally-wrong time calculation.
>> Exactly!
>> Unfortunately, no crash happens on my systems.  Or, actually, crashes
>> stopped after the attached fix.
>>> Will gladly test your patch! :)
>>>=20
>> Here it is!
>> I'll make a proper commit after your early tests.
>> Crossing my fingers,
>> Paolo
>=20
> That did it - it now survived a bunch of heavy read/write/mixed I/O =
that
> would previously crash right away. Maybe it's because btrfs uses =
several
> workers and so different IOs got mixed together? Anyway:
>=20
> Fixes: 430a67f9d616 ("block, bfq: merge bursts of newly-created =
queues")
> Tested-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
>=20

Great!

Thank you very much!

I will put this fix in an upcoming patch series.

Paolo

> Thanks!
> Holger

