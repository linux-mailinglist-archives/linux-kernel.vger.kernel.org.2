Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7A23A93E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhFPHbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhFPHbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:31:18 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDA1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:29:12 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id v17-20020a4aa5110000b0290249d63900faso458465ook.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JbP1OzFgSfwxUirQ6jqrb0LQmGX7gpjz8D4fdoExXvA=;
        b=KyswCItanXFaUHAeTPBBuuhn4TH9R0bEzalW7u/84cu40ezyD4L0gvtbCD7vu9DOdl
         rqrt0mjVmj9YhwykAqxHwQ/ctkZiW0XzTBxbTQcWvt7Ba4oTyomTbhjDQ0cGKgszBepP
         7kVTNK3Lze0g5FdbtekAB+KYZNZqn+C4IVfgygy3oaBDjuNsakwd5VzxxhrunTKc4WeF
         t7OeSiw7Tp/4xRrgmzv36f2x46NFVdxtfXk1VI6YDmuziQjCp+nrc4uuLI7WncuHLX4d
         uHcxqOajAidxY48hjPHSre7+y2XOMnwdgbhixb6LB6cyEQf1kHBnCafXnNARZ00zwTWG
         51+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JbP1OzFgSfwxUirQ6jqrb0LQmGX7gpjz8D4fdoExXvA=;
        b=a8a+KOMs2daoO1e7GCiIZz6VWPUEvf6hcUmS7gzPxl1fT8M75Pd4uj2KwGXGW80zKI
         06HxFOF0383obPHJQIuGFHF53pOl1UY6wOYVMbRCrMbjSEZiU0y/YaYvuTCXiVhTghkB
         tjHXgplbKxIfX78aVM9YX0bMzysvsNA+4FiEwUBy40DuWh66JGAENUvnPPsXIcaQcrAn
         24wNfV6KolietGb5R7fble1L9YjM5AtiyjuwNbM9OyKb+uvH7hLuTl4re0rjd9mYWYep
         C0Iygjoj7fczEQKsDhYXlzI+smSAKCmFwh6wBMi9O42LH+z9kaYYc2fSEDS12U9K5slz
         Mq+w==
X-Gm-Message-State: AOAM532YqBTvXAXu1sUztxotWmI1jKyEfr0+RxQYF1UZtJT284y/jkQV
        FlzrUyYPcaHXe08T4uk3B2H0019TW3M+cEZzRWVJQcU7
X-Google-Smtp-Source: ABdhPJxonYERwtFL0nI5uSBopGxwJXZV8D5RCyn9CGRpoKzupMnfJ+1obTzw3ngsf8zASvv3qwfn7/1nlCxJL4DLF8k=
X-Received: by 2002:a4a:c287:: with SMTP id b7mr2743311ooq.8.1623828551699;
 Wed, 16 Jun 2021 00:29:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:33b2:0:0:0:0:0 with HTTP; Wed, 16 Jun 2021 00:29:11
 -0700 (PDT)
In-Reply-To: <YMmYD3rkS8o+1dXr@kroah.com>
References: <1623812199-31866-1-git-send-email-zhenguo6858@gmail.com> <YMmYD3rkS8o+1dXr@kroah.com>
From:   =?UTF-8?B?6LW15oyv5Zu9?= <zhenguo6858@gmail.com>
Date:   Wed, 16 Jun 2021 15:29:11 +0800
Message-ID: <CAGGV+3JjiuAoXefUwpekbcqB_Xye32xQSMK0jKQ_zNM6dvOPAw@mail.gmail.com>
Subject: Re: [PATCH] tty: n_gsm: Fix CR bit value when initiator=0
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear gregkh

1:  Documentation/driver-api/serial/n_gsm.rst

The text introduces the config of master ( c.initiator =3D 1), but the
config of as responder is different.
when set gsm->initiator=3D0 by GSMIOC_SETCONF ,ngsm driver should be
responder(slaver)

config=EF=BC=9A
	c.initiator =3D 0;    // set initiator=3D0=EF=BC=8Cngsm as responder
	ioctl(fd, GSMIOC_SETCONF, &c);

2:  if master side send SABM/DISC frame data by uart dev
    DLC0 control data frame:f9 03 3f 01 1c f9
    kernel log=EF=BC=9A gsmld_receive: 00000000: f9 03 3f 01 1c f9

{
	cr =3D gsm->address & 1;		/* C/R bit */
//CR value=3D1

	gsm_print_packet("<--", address, cr, gsm->control, gsm->buf, gsm->len);

	cr ^=3D 1 - gsm->initiator;	/* Flip so 1 always means command */
//when gsm->initiator is 0, CR value=3D0 by "^=3D" calculation
	dlci =3D gsm->dlci[address];

	switch (gsm->control) {
	case SABM|PF:
		if (cr =3D=3D 0)
			goto invalid;                       //if CR value=3D0,ngsm will goto
invalid,but the dlc0 control frame data is right,if we can't modify
,ngsm can't send UA response data
}


2021-06-16 14:19 GMT+08:00, Greg KH <gregkh@linuxfoundation.org>:
> On Wed, Jun 16, 2021 at 10:56:39AM +0800, Zhenguo Zhao wrote:
>> From: Zhenguo Zhao <zhenguo.zhao1@unisoc.com>
>>
>> 	When set initiator=3D0,switch to Responder,gsmld received dlci SABM/DIS=
C
>> 	frame,CR bit should be 0 by calculation.
>>
>> 	receive DLC0 SABM CMD:
>> 	[69.740263] c1 gsmld_receive: 00000000: f9 03 3f 01 1c f9
>> 	[69.893247] c1 gsm_queue cr:1
>> 	[69.897629] c1 <-- 0) C: SABM(P)
>> 	[69.907516] c1 gsm_queue cr:0
>
> Why is this changelog text indented by tabs?
>
> And I do not understand the changelog text here, what is this showing?
> What is wrong here and what is being fixed?
>
>> Signed-off-by: Zhenguo Zhao <zhenguo.zhao1@unisoc.com>
>
> Does this fix a long-standing issue?  Should a "Fixes:" tag go here?  If
> so, please provide it.
>
> Should it also be sent to stable kernels?
>
>> ---
>>  drivers/tty/n_gsm.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
>> index 5fea02c..becca2c 100644
>> --- a/drivers/tty/n_gsm.c
>> +++ b/drivers/tty/n_gsm.c
>> @@ -1779,7 +1779,7 @@ static void gsm_queue(struct gsm_mux *gsm)
>>
>>  	switch (gsm->control) {
>>  	case SABM|PF:
>> -		if (cr =3D=3D 0)
>> +		if (cr =3D=3D 1)
>
> How did the original code ever work properly?
>
>>  			goto invalid;
>>  		if (dlci =3D=3D NULL)
>>  			dlci =3D gsm_dlci_alloc(gsm, address);
>> @@ -1793,7 +1793,7 @@ static void gsm_queue(struct gsm_mux *gsm)
>>  		}
>>  		break;
>>  	case DISC|PF:
>> -		if (cr =3D=3D 0)
>> +		if (cr =3D=3D 1)
>
> Same here, how did this ever work?  Are you sure this change is correct?
>
> thanks,
>
> greg k-h
>
