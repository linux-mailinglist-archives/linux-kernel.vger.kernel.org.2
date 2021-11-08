Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C414478D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 04:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbhKHDT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 22:19:59 -0500
Received: from gw2.atmark-techno.com ([35.74.137.57]:34340 "EHLO
        gw2.atmark-techno.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbhKHDT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 22:19:58 -0500
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id C382720CEF
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 12:17:12 +0900 (JST)
Received: by mail-pj1-f70.google.com with SMTP id hg9-20020a17090b300900b001a6aa0b7d8cso6149706pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 19:17:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y2FcHysnsMknog0uaTYU3E4CwupcvxTmlhl1H6xc5dI=;
        b=2u1zuAFPIlKbX7KZIIuV4WiCTAxvMwA8umcL2f0WRvqbPn06bxOXjUN61T+xdza1Db
         RGuhWlDtivinTud1pEr8V9HfkkLSesOqm7eeaYMZhmyeB9w8YP2r4nBmXMVBvu6AyOYs
         GvSSsv3nujK5JUAQICPPsGLJauGbycI+Qyu1sYMMLx7XOHm+0outasDeMJZCULkjftOV
         9Cw6mM56BU4jq90tIK8BCDUOUB8NKNGWTvaowg7LrqM7F3gS7tvAMFTFGkBerMuszAom
         yrapvSBb5AhLMDPvU2FROxJV8M5Ztl0kxENyM8L5/4yH4Vi2Lr8kuIQkPEqKzjLAjVe3
         +Ndw==
X-Gm-Message-State: AOAM5307X0kl/J83uO1B+3QX7fb1ddR1OPhe3fmLlD/BZqiLJTyFerpQ
        IMddEEpUlIwLSIBMMky+eDWVEcxXsc7p/PU6BEN68XJ3eafyHOi6al+zE2iZSabEAkfOqku2Jjr
        q1okYS8o7C4aRjlM1hPg9ccr+kg==
X-Received: by 2002:a17:90a:4a06:: with SMTP id e6mr49437287pjh.228.1636341431870;
        Sun, 07 Nov 2021 19:17:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwy/Idfivc1sa4+t5BsWIwzMYc4fOxvigXDuH2qUjVpbqz8jnRkaYmiEpRRvsxFiZNPtRBLXQ==
X-Received: by 2002:a17:90a:4a06:: with SMTP id e6mr49437264pjh.228.1636341431644;
        Sun, 07 Nov 2021 19:17:11 -0800 (PST)
Received: from pc-0115 (70.211.187.35.bc.googleusercontent.com. [35.187.211.70])
        by smtp.gmail.com with ESMTPSA id t13sm8564924pfl.214.2021.11.07.19.17.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Nov 2021 19:17:11 -0800 (PST)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
        (envelope-from <martinet@pc-0115>)
        id 1mjv9h-005qLx-Uh; Mon, 08 Nov 2021 12:17:09 +0900
Date:   Mon, 8 Nov 2021 12:16:59 +0900
From:   Dominique Martinet <dominique.martinet@atmark-techno.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rtc-rv8803: fix writing back ctrl in flag register
Message-ID: <YYiWq564QzQgTsqV@atmark-techno.com>
References: <20211101013400.325855-1-dominique.martinet@atmark-techno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211101013400.325855-1-dominique.martinet@atmark-techno.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre, Alessandro,

the other patch was proved to be unneeded, but this one is still a valid
fix as far as I can understand the code (reusing RV8803_CTRL value to
write into RV8803_FLAG does not look correct)

(I'm also convinced either mostly work because the original values are
usually close enough, but that's not a reason to keep using the wrong
one)


Would you have time to take a look?


Thanks!

Dominique Martinet wrote on Mon, Nov 01, 2021 at 10:33:59AM +0900:
> ctrl is set from read_regs(..FLAG, 2, ctrl), so ctrl[0] is FLAG
> and ctrl[1] is the CTRL register.
> Use ctrl[0] to write back to the FLAG register as appropriate.
> 
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> ---
>  drivers/rtc/rtc-rv8803.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
> index 72adef5a5ebe..0d5ed38bf60c 100644
> --- a/drivers/rtc/rtc-rv8803.c
> +++ b/drivers/rtc/rtc-rv8803.c
> @@ -340,8 +340,8 @@ static int rv8803_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  		}
>  	}
>  
> -	ctrl[1] &= ~RV8803_FLAG_AF;
> -	err = rv8803_write_reg(rv8803->client, RV8803_FLAG, ctrl[1]);
> +	ctrl[0] &= ~RV8803_FLAG_AF;
> +	err = rv8803_write_reg(rv8803->client, RV8803_FLAG, ctrl[0]);
>  	mutex_unlock(&rv8803->flags_lock);
>  	if (err)
>  		return err;
