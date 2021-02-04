Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD61830AFFC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhBATDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhBATDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:03:47 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73C8C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 11:03:05 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q7so17792127wre.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 11:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=r79og0veGhEihkU+mu+paNDi4ipep7cQ44YPcJU32Sw=;
        b=dZHNPBoswNeKtCXBlp58sTAgxQ4QRva3Z+Xzhg1fMOVjxJraq+Xi8+Fm/uOUqMgnmp
         RvH6QdsMIaf3O84W3ehR0uHs4D6IS//ZrL/ez4zl7BMZVWrGohyFTv6Hq0VXc3msurOG
         GKx2QC/isqjnBrIqR6HgOgGO703+8CRvdLV5LxnRVmfgHE9ge18NI4PX1QcLCW17RXVm
         J3yqskvA/5CDXKo5k9hLr5+c/+pmdWCeM7IAoTAnmCQWH2Y5jaZuIIkc+DxRylDTBvM2
         VG6QSf4bjMbrOsvUSDJjV41rHqBFodkp3465vFngL0d25CkcBLab8P7TEUA6cTj+K+1/
         n1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=r79og0veGhEihkU+mu+paNDi4ipep7cQ44YPcJU32Sw=;
        b=MHPcqML67XL+82h67Gl989lXzXQby97EP7zWPi6AjhT1OmjAwlNyIlxSasO9yFlMSs
         RHPSjxjHrzO6gu61lG+KjoVFyRxUQ6BG4rh1Em4U9lCh3zD24a4rRjJDg6P2ioK5YX3o
         xQv63WqDcnm8jWM0QWMmOEc4BeUPTRHUxrbr4bC9s08zk/psK8AAGgW2eSaoTBR/yUs3
         JA5aqccYa7589t8VozNEzmSPlivHPrzAi5SFb5L09mBZBYLd95Ex2R2OgilQIwISEBwT
         2m8gd3JEFyffU+XQGSneFOR91Cvsfy2Tgw3vaUXCGeLTtCeqHpILUef/9oNyQIWmfNXl
         ZElQ==
X-Gm-Message-State: AOAM530L6vDeZZY6iWmFGEqHdvIVQnlGct6kDhRAcp75s2s4MOscAeDq
        oxmcC/BLulVTbxrj7FlvbPyvuA==
X-Google-Smtp-Source: ABdhPJyN+Av8fhXFy3ssiIfpTJKkTrLUE+Ntf+BBnSk0M1ZHswZOFHSoS/0C53jTpO/xMNc04nAVCg==
X-Received: by 2002:adf:b64f:: with SMTP id i15mr19144803wre.279.1612206184561;
        Mon, 01 Feb 2021 11:03:04 -0800 (PST)
Received: from [192.168.159.233] ([37.162.183.28])
        by smtp.gmail.com with ESMTPSA id z15sm25944615wrt.8.2021.02.01.11.03.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 11:03:03 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Revert "bfq: Fix computation of shallow depth"
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <749df7e1-98b5-a575-506d-a7c7c4d96a6f@wangsu.com>
Date:   Mon, 1 Feb 2021 20:03:02 +0100
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5CCEC0EB-60DA-43C3-A251-BDB96B036B09@linaro.org>
References: <20210129111808.45796-1-linf@wangsu.com>
 <749df7e1-98b5-a575-506d-a7c7c4d96a6f@wangsu.com>
To:     Lin Feng <linf@wangsu.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 1 feb 2021, alle ore 08:32, Lin Feng <linf@wangsu.com> ha =
scritto:
>=20
> Hi, it seems that this patch was blocked by linux mailist servers, so =
ping again.
>=20
> Based on =
https://patchwork.kernel.org/project/linux-block/patch/20201210094433.2549=
1-1-jack@suse.cz/,
> it looks like we have made a consensus about bfqd->word_depths[2][2]'s =
changing, so now the
> computation codes for bfq's word_depths array are not necessary and =
one variable is enough.
>=20
> But IMHO async depth limitation for slow drivers is essential, which =
is what we always did in cfq age.
>=20

It is essential.

Thanks,
Paolo

> On 1/29/21 19:18, Lin Feng wrote:
>> This reverts commit 6d4d273588378c65915acaf7b2ee74e9dd9c130a.
>> bfq.limit_depth passes word_depths[] as shallow_depth down to sbitmap =
core
>> sbitmap_get_shallow, which uses just the number to limit the scan =
depth of
>> each bitmap word, formula:
>> scan_percentage_for_each_word =3D shallow_depth / (1 << =
sbimap->shift) * 100%
>> That means the comments's percentiles 50%, 75%, 18%, 37% of bfq are =
correct.
>> But after commit patch 'bfq: Fix computation of shallow depth', we =
use
>> sbitmap.depth instead, as a example in following case:
>> sbitmap.depth =3D 256, map_nr =3D 4, shift =3D 6; sbitmap_word.depth =
=3D 64.
>> The resulsts of computed bfqd->word_depths[] are {128, 192, 48, 96}, =
and
>> three of the numbers exceed core dirver's 'sbitmap_word.depth=3D64' =
limit
>> nothing. Do we really don't want limit depth for such workloads, or =
we
>> just want to bump up the percentiles to 100%?
>> Please correct me if I miss something, thanks.
>> Signed-off-by: Lin Feng <linf@wangsu.com>
>> ---
>>  block/bfq-iosched.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 9e4eb0fc1c16..9e81d1052091 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -6332,13 +6332,13 @@ static unsigned int bfq_update_depths(struct =
bfq_data *bfqd,
>>  	 * limit 'something'.
>>  	 */
>>  	/* no more than 50% of tags for async I/O */
>> -	bfqd->word_depths[0][0] =3D max(bt->sb.depth >> 1, 1U);
>> +	bfqd->word_depths[0][0] =3D max((1U << bt->sb.shift) >> 1, 1U);
>>  	/*
>>  	 * no more than 75% of tags for sync writes (25% extra tags
>>  	 * w.r.t. async I/O, to prevent async I/O from starving sync
>>  	 * writes)
>>  	 */
>> -	bfqd->word_depths[0][1] =3D max((bt->sb.depth * 3) >> 2, 1U);
>> +	bfqd->word_depths[0][1] =3D max(((1U << bt->sb.shift) * 3) >> 2, =
1U);
>>    	/*
>>  	 * In-word depths in case some bfq_queue is being weight-
>> @@ -6348,9 +6348,9 @@ static unsigned int bfq_update_depths(struct =
bfq_data *bfqd,
>>  	 * shortage.
>>  	 */
>>  	/* no more than ~18% of tags for async I/O */
>> -	bfqd->word_depths[1][0] =3D max((bt->sb.depth * 3) >> 4, 1U);
>> +	bfqd->word_depths[1][0] =3D max(((1U << bt->sb.shift) * 3) >> 4, =
1U);
>>  	/* no more than ~37% of tags for sync writes (~20% extra tags) =
*/
>> -	bfqd->word_depths[1][1] =3D max((bt->sb.depth * 6) >> 4, 1U);
>> +	bfqd->word_depths[1][1] =3D max(((1U << bt->sb.shift) * 6) >> 4, =
1U);
>>    	for (i =3D 0; i < 2; i++)
>>  		for (j =3D 0; j < 2; j++)
>=20

