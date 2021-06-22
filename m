Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508D23B0F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 23:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhFVVSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 17:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFVVSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 17:18:04 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48227C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 14:15:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 69so11102448plc.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=8aXlZr1F1hmRY/0ubzREtKQU8RqK8VWzIaWz5se5XVM=;
        b=ZiS1KsAuKc+8e/DnZgzyiisLvo+nOkSKaI/nerQhWLjZnEehLJdcKAjvsYi/uNiW8C
         Cn8u55GDy8yD56EI6RN5+DzhZ/3+YnrjQbiNhTJWxxOPSjPBXzOgPvS20TVzBwmT70LD
         Km9N5bu0n4bY8X3x7YkXPQMZil+YpRFx97zYVTrRv/508YeE7tgk3JqIpY/aQOhP3OnJ
         X624Ubf3rqwIGSWgINreXEAMvpSS816RolKEFyFV0ockben/NZ/bXH4SQ7+eUPSYI2k6
         /CYs+idMQ3I03SMtRDbwvepPStHUMA7/USLs0KXLLQR4pO/pOkzFka2+7b79KhC7H2Vo
         af6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=8aXlZr1F1hmRY/0ubzREtKQU8RqK8VWzIaWz5se5XVM=;
        b=YNqpl5l21rSoRvsk7fnzfVhAp1OiXZt9M+GIEKynEA4EZGeKf+9kDexITD6fapPGCQ
         3aqVY08Ng9s0Ol8nkWZzxF3BytDk5k9rEZROg4KjHwU/lSzZzvpkAUshUDi5pKPgNLaB
         NG7SGCnERQea10X8L/IjMlfehE5y/wDM7dbh8nZGoKbpBZ+gVC+lmKLYYgYV/48Tqct2
         TtmKlYnCyMMEcHa/zNmlgamplFVGSG/ZNzsizFbn056FWhfvJWUtQfLnbDv5TOxgqVmC
         blnJLVe7TgBEp/sUtU6/Y+y+Tn3NZtsMfce2t1w2416OC4oYrZ+8tJ991R+xUCc93xKx
         IH1Q==
X-Gm-Message-State: AOAM5334OjNgpCTuOg7GmOpRbYXZyFQ2DK4srFDQwU2bi8+YQhu8ZekM
        +4Muc1FQmX1MA24hYvQ5LCAmRA==
X-Google-Smtp-Source: ABdhPJwHR46NOFLdkzfMM5u23p5KB2roPw+3M9Q2TKlyEO2CxhPxzKp7z20Mbyg+OUYuXY7JdXYasg==
X-Received: by 2002:a17:90b:23c5:: with SMTP id md5mr5797330pjb.93.1624396546723;
        Tue, 22 Jun 2021 14:15:46 -0700 (PDT)
Received: from smtpclient.apple ([2600:380:6c63:dde2:1527:d8a2:8789:f1f0])
        by smtp.gmail.com with ESMTPSA id 73sm227423pfy.83.2021.06.22.14.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 14:15:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Jens Axboe <axboe@kernel.dk>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH][next] block/mq-deadline: remove redundant assignment of variable ret
Date:   Tue, 22 Jun 2021 15:15:45 -0600
Message-Id: <F8A7A6B5-37DB-45D8-971F-85D392618512@kernel.dk>
References: <dce79425-05fb-26a3-2f01-f9893de41513@acm.org>
Cc:     Colin King <colin.king@canonical.com>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <dce79425-05fb-26a3-2f01-f9893de41513@acm.org>
To:     Bart Van Assche <bvanassche@acm.org>
X-Mailer: iPhone Mail (18G5042c)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 22, 2021, at 3:14 PM, Bart Van Assche <bvanassche@acm.org> wrote:
>=20
> =EF=BB=BFOn 6/22/21 9:17 AM, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>=20
>> Variable ret is being assigned a value at the end of the function
>> and the value is never read. The assignment is redundant and can
>> be removed.
>>=20
>> Addresses-Coverity: ("Unused value")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>> block/mq-deadline-main.c | 1 -
>> 1 file changed, 1 deletion(-)
>>=20
>> diff --git a/block/mq-deadline-main.c b/block/mq-deadline-main.c
>> index 4815e536091f..e3091d922ba2 100644
>> --- a/block/mq-deadline-main.c
>> +++ b/block/mq-deadline-main.c
>> @@ -639,7 +639,6 @@ static int dd_init_sched(struct request_queue *q, str=
uct elevator_type *e)
>>    if (ret)
>>        goto free_stats;
>>=20
>> -    ret =3D 0;
>>    q->elevator =3D eq;
>>    return 0;
>=20
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Assuming this is fallout from the recent series, we should add a fixes tag t=
o it.=20

=E2=80=94=20
Jens Axboe=
