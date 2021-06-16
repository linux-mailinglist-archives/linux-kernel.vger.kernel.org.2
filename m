Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A3E3A9455
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhFPHsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:48:35 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:36473 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhFPHrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:47:18 -0400
Received: by mail-ej1-f51.google.com with SMTP id nd37so2307147ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I44AlZGltdTNJ59om6pbXb9iA0oswGYi9lcaUFcbTXk=;
        b=Mfp+lit0szC3YMcVYPtIoU0nmfUWJ1AFWWZl4MFD1W0gMnsDrMrZuxspiaOMXrK49r
         Cvduopy4gmpZ86Ww2YE1U3QI7XlWAtIYkqreYjsNVjaIQIZ+0bPJ/o7P0y/A5VCh1Z4b
         n9yEALgAp0ZxB29jxxPvoDX53JyPuVUpM+XkGXh7N2fQbKHnbYIq0XiCGeKmDbKlBrpy
         SETJj+G3oD8khtwOhfT0uwSDqjF2v1ZCBp5TU8lhO15/McU4rL4P3scv5rRBdNbW7cAe
         EUqv34XKEK6Y0k6iJFr8etuEwhZlZkQgiDcCwwB6//HS21LonvW+73/TIXsSVHJc6Tu9
         +h2Q==
X-Gm-Message-State: AOAM533zkdF7SY0k4mFt09aRhGdxXirc3n9Q5gF17svQGZQSTUMpbpgP
        5vp+oXq/s3qGENgoofDo6dnLEERD/hA=
X-Google-Smtp-Source: ABdhPJxtvGS61YQfRWViNjNx02ZsiJufMr3y9lCTOkavIRC2o4nj6j3nMKJWF+jkN1/dV5XPo5w2Pg==
X-Received: by 2002:a17:906:e45:: with SMTP id q5mr3974915eji.453.1623829512017;
        Wed, 16 Jun 2021 00:45:12 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id c19sm1061073edw.10.2021.06.16.00.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 00:45:11 -0700 (PDT)
Subject: Re: [PATCH] tty: n_gsm: Fix CR bit value when initiator=0
To:     Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?B?6LW15oyv5Zu9?= <zhenguo6858@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <1623812199-31866-1-git-send-email-zhenguo6858@gmail.com>
 <YMmYD3rkS8o+1dXr@kroah.com>
 <CAGGV+3JjiuAoXefUwpekbcqB_Xye32xQSMK0jKQ_zNM6dvOPAw@mail.gmail.com>
 <YMmqsJ3xwIIxzop+@kroah.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <e4511265-485c-915c-4567-930b658f7c0e@kernel.org>
Date:   Wed, 16 Jun 2021 09:45:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMmqsJ3xwIIxzop+@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16. 06. 21, 9:39, Greg KH wrote:
> 
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
> 
> A: No.
> Q: Should I include quotations after my reply?
> 
> http://daringfireball.net/2007/07/on_top
> 
> On Wed, Jun 16, 2021 at 03:29:11PM +0800, 赵振国 wrote:
>> Dear gregkh
>>
>> 1:  Documentation/driver-api/serial/n_gsm.rst
>>
>> The text introduces the config of master ( c.initiator = 1), but the
>> config of as responder is different.
>> when set gsm->initiator=0 by GSMIOC_SETCONF ,ngsm driver should be
>> responder(slaver)
>>
>> config：
>> 	c.initiator = 0;    // set initiator=0，ngsm as responder
>> 	ioctl(fd, GSMIOC_SETCONF, &c);
>>
>> 2:  if master side send SABM/DISC frame data by uart dev
>>      DLC0 control data frame:f9 03 3f 01 1c f9
>>      kernel log： gsmld_receive: 00000000: f9 03 3f 01 1c f9
>>
>> {
>> 	cr = gsm->address & 1;		/* C/R bit */
>> //CR value=1
>>
>> 	gsm_print_packet("<--", address, cr, gsm->control, gsm->buf, gsm->len);
>>
>> 	cr ^= 1 - gsm->initiator;	/* Flip so 1 always means command */
>> //when gsm->initiator is 0, CR value=0 by "^=" calculation
>> 	dlci = gsm->dlci[address];
>>
>> 	switch (gsm->control) {
>> 	case SABM|PF:
>> 		if (cr == 0)
>> 			goto invalid;                       //if CR value=0,ngsm will goto
>> invalid,but the dlc0 control frame data is right,if we can't modify
>> ,ngsm can't send UA response data
>> }
> 
> I am sorry, but I really do not understand what you are saying here.
> Please resubmit your patch with an updated changelog that explains why
> this change is needed and what it does.

And why it was able to work until now. I.e. isn't the Documentation wrong?

thanks,
-- 
js
suse labs
