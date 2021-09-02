Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE703FEA0B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 09:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243287AbhIBHdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbhIBHdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:33:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0985C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 00:32:08 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m9so1335069wrb.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 00:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FB2H+fs9Ic2HWr2KPvxlhV6W+9OYDzpAvt7cyfrCez8=;
        b=QUAkM2VGJwY/r/pdjAK8KkU0cfRlhpaXJ9dw14ehyd1MkL+JUwZp5+pbNZWTA3E1Bn
         UR0Z4gbXacFxySLrXSLRJnO11yv1/3nhq8l3dmULCSI8KjgzqM2IRIcCdHBIk1OlFz5l
         /g6YBvhZo+ZzKN3BnbN+J/987+dkXswTJ65elWwTd7dGSLKFcOZ9vOK/36XNojg+FQT2
         X/LWvT4I04MXSo5N82ka5YgPinKRi1OY4QOICVIKS4wLnjh724Qt8EaZA8odxvLfJUnM
         mBFk+IL1yLzuyDywPhqtkzVX6auTdNQSWMJ3aAwdgdISOk/vL7M+4W7nA2nImt/OjWBv
         7O1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FB2H+fs9Ic2HWr2KPvxlhV6W+9OYDzpAvt7cyfrCez8=;
        b=Kcj1kkltR+8zAIkrG7giwEWPNDSac5jsXp4wmWzxLHYKdclEgP9RWoJe9uJEKWluFj
         u7svjl612rF3GrcTnwf9wEFXll7KmftE5QOEf6G7kBa7z1IbZfNEgGHWm8gN+ER7er1j
         G6uwzd3bLIX1gqsdXe3CmJJHZ/J059/J/f1QK0LoQoz5XzW0TagkmoDYMzV7vQ1b63cq
         91BB6OjEOfgeOTjbr8do6RPzdSPCToR1QBJmP4Iojxwun9v3fl/tFCG30jobz2SSEQcu
         5vMcW2uJnR3yOmYq3gADK18tEbIW71HHBZPPMDBMmQtrwdxXaI/wzc0TmmELD1oVHF8k
         OnbQ==
X-Gm-Message-State: AOAM533BpuiU4OcifXBN45vW9v/2DjTt5dLyAmQy8bKCR8Df2vLrVxpg
        c0Ysu/1ZmqgARsvjcK9/mDhPyA==
X-Google-Smtp-Source: ABdhPJxUYIgLuag4yssIgLsyJSa/lYoh2516PsGVhNavHWWxX50IL1DRHIiYjJmU3Y61N+S0k4UGWw==
X-Received: by 2002:a5d:6e84:: with SMTP id k4mr1938533wrz.426.1630567927234;
        Thu, 02 Sep 2021 00:32:07 -0700 (PDT)
Received: from wifi-122-dhcprange-122-186.wifi.unimo.it (wifi-122-dhcprange-122-186.wifi.unimo.it. [155.185.122.186])
        by smtp.gmail.com with ESMTPSA id s12sm1011158wru.41.2021.09.02.00.32.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 00:32:06 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: honor already-setup queue merges
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <3BDD27BD-F49B-43B6-B41D-F7534B596A9A@linaro.org>
Date:   Thu, 2 Sep 2021 09:32:04 +0200
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        davidezini2@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <19A16AB9-8622-4BA3-B316-A3E6228296AA@linaro.org>
References: <20210802141352.74353-1-paolo.valente@linaro.org>
 <20210802141352.74353-2-paolo.valente@linaro.org>
 <3BDD27BD-F49B-43B6-B41D-F7534B596A9A@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 26 ago 2021, alle ore 11:16, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 2 ago 2021, alle ore 16:13, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>>=20
>> The function bfq_setup_merge prepares the merging between two
>> bfq_queues, say bfqq and new_bfqq. To this goal, it assigns
>> bfqq->new_bfqq =3D new_bfqq. Then, each time some I/O for bfqq =
arrives,
>> the process that generated that I/O is disassociated from bfqq and
>> associated with new_bfqq (merging is actually a redirection). In this
>> respect, bfq_setup_merge increases new_bfqq->ref in advance, adding
>> the number of processes that are expected to be associated with
>> new_bfqq.
>>=20
>> Unfortunately, the stable-merging mechanism interferes with this
>> setup. After bfqq->new_bfqq has been set by bfq_setup_merge, and
>> before all the expected processes have been associated with
>> bfqq->new_bfqq, bfqq may happen to be stably merged with a different
>> queue than the current bfqq->new_bfqq. In this case, bfqq->new_bfqq
>> gets changed. So, some of the processes that have been already
>> accounted for in the ref counter of the previous new_bfqq will not be
>> associated with that queue.  This creates an unbalance, because those
>> references will never be decremented.
>>=20
>> This commit fixes this issue by reestablishing the previous, natural
>> behaviour: once bfqq->new_bfqq has been set, it will not be changed
>> until all expected redirections have occurred.
>>=20
>=20
> Hi Jens,
> did you have time to look at this fix?
>=20

ping ...


> Thanks,
> Paolo
>=20
>=20
>> Signed-off-by: Davide Zini <davidezini2@gmail.com>
>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
>> ---
>> block/bfq-iosched.c | 16 +++++++++++++---
>> 1 file changed, 13 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 727955918563..08d9122dd4c0 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -2659,6 +2659,15 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct =
bfq_queue *new_bfqq)
>> 	 * are likely to increase the throughput.
>> 	 */
>> 	bfqq->new_bfqq =3D new_bfqq;
>> +	/*
>> +	 * The above assignment schedules the following redirections:
>> +	 * each time some I/O for bfqq arrives, the process that
>> +	 * generated that I/O is disassociated from bfqq and
>> +	 * associated with new_bfqq. Here we increases new_bfqq->ref
>> +	 * in advance, adding the number of processes that are
>> +	 * expected to be associated with new_bfqq as they happen to
>> +	 * issue I/O.
>> +	 */
>> 	new_bfqq->ref +=3D process_refs;
>> 	return new_bfqq;
>> }
>> @@ -2721,6 +2730,10 @@ bfq_setup_cooperator(struct bfq_data *bfqd, =
struct bfq_queue *bfqq,
>> {
>> 	struct bfq_queue *in_service_bfqq, *new_bfqq;
>>=20
>> +	/* if a merge has already been setup, then proceed with that =
first */
>> +	if (bfqq->new_bfqq)
>> +		return bfqq->new_bfqq;
>> +
>> 	/*
>> 	 * Check delayed stable merge for rotational or non-queueing
>> 	 * devs. For this branch to be executed, bfqq must not be
>> @@ -2822,9 +2835,6 @@ bfq_setup_cooperator(struct bfq_data *bfqd, =
struct bfq_queue *bfqq,
>> 	if (bfq_too_late_for_merging(bfqq))
>> 		return NULL;
>>=20
>> -	if (bfqq->new_bfqq)
>> -		return bfqq->new_bfqq;
>> -
>> 	if (!io_struct || unlikely(bfqq =3D=3D &bfqd->oom_bfqq))
>> 		return NULL;
>>=20
>> --=20
>> 2.20.1

