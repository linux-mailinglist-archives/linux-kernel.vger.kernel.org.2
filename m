Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B437428157
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 14:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhJJMrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 08:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37193 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231842AbhJJMrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 08:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633869925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hGzveYbUBicRzug96qwjzZADX2Wt9eAHz5hNvkN82fY=;
        b=TKurP6/v5EmufEOyF61+NJDVW1vGcJEbd9Vfy8adnwgkjxEIcVgyZL1raHn9Nglbgr5xVN
        TdgAb1MdxmI2Tiu0zQ/3dmpigY6F0RIscw3jTRoOCtJkYdN86/C3THMcyVkcjfiSODmw3N
        w+NZoO7eUhnBBAWaid2khPOyeZPHaw4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-tphaKzNUMgeXWCW1zxq4ZA-1; Sun, 10 Oct 2021 08:45:23 -0400
X-MC-Unique: tphaKzNUMgeXWCW1zxq4ZA-1
Received: by mail-ed1-f69.google.com with SMTP id cy14-20020a0564021c8e00b003db8c9a6e30so936765edb.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 05:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hGzveYbUBicRzug96qwjzZADX2Wt9eAHz5hNvkN82fY=;
        b=7A1WgwRWmgehfPJh1q9rflBnHMWV9Lu9811SAqS38gmReJdNPNp/I9sC6VrKQAj8QR
         2E9lXLnNiEKXuCGJooqLaews71A90cTzHLZYeqDAI2KqRJg6hUQZlVlyf1qf2en8f9VM
         ag23EnyicCjKDB8pULaFd+Lp4tE21vZM0WkSRhKOSXUteXJuZzgm4NkMS8T+bLgR8HM8
         ZqrpdUA8Pk2mLakSCWJkDFz4obqPw4nhFHx9rq1V5woY23jbJhM067q5HSH5coHJK1WU
         7DhBLgra9VYy/0mElXbydwdgFd4xlQ8LQqlXQjMgqhyROWiqMTG/QMVZwa2/Ce1w5hFn
         Lb3w==
X-Gm-Message-State: AOAM530YimSDrwFP0VrS1EuxIeFR8/bqUKwqoT1fUDI1AhB2RJr0NrYh
        DKq5a1MPI8jXDgldAYNPwzyraYJMxDfx7Iah1EMKdKvUMipL35rolQlScs1zJkwal4qTfauJk70
        UJiRspWfIknTk6YsYV88FCCoY
X-Received: by 2002:a05:6402:268c:: with SMTP id w12mr31316106edd.376.1633869922640;
        Sun, 10 Oct 2021 05:45:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5R81f51iOnHvmeJnqpJ7elPHbjPZqqu58M/bMxC5dmnMuMA5wa5cZk8kiknyGER654My7eg==
X-Received: by 2002:a05:6402:268c:: with SMTP id w12mr31316077edd.376.1633869922440;
        Sun, 10 Oct 2021 05:45:22 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id oz11sm2036382ejc.72.2021.10.10.05.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 05:45:22 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8723bs: hal: remove duplicate check
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        marcocesati@gmail.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YWKRfYpTioAmTWa0@user>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6c589c93-b224-1490-5f38-63947f02ff6a@redhat.com>
Date:   Sun, 10 Oct 2021 14:45:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YWKRfYpTioAmTWa0@user>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/10/21 9:08 AM, Saurav Girepunje wrote:
> Remove 'bPerformance' from if condition check. As on previous
> if condition it is already check for same variable.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/staging/rtl8723bs/hal/odm_DIG.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/odm_DIG.c b/drivers/staging/rtl8723bs/hal/odm_DIG.c
> index beda7b8a7c6a..7e92c373cddb 100644
> --- a/drivers/staging/rtl8723bs/hal/odm_DIG.c
> +++ b/drivers/staging/rtl8723bs/hal/odm_DIG.c
> @@ -544,7 +544,7 @@ void odm_DIG(void *pDM_VOID)
>  	/* 1 Adjust initial gain by false alarm */
>  	if (pDM_Odm->bLinked && bPerformance) {
> 
> -		if (bFirstTpTarget || (FirstConnect && bPerformance)) {
> +		if (bFirstTpTarget || FirstConnect) {
>  			pDM_DigTable->LargeFAHit = 0;
> 
>  			if (pDM_Odm->RSSI_Min < DIG_MaxOfMin) {
> --
> 2.32.0
> 

