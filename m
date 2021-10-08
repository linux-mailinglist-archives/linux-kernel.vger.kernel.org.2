Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65938426BED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 15:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhJHNt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 09:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhJHNt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:49:56 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B225C061570;
        Fri,  8 Oct 2021 06:48:01 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id g125so7098311oif.9;
        Fri, 08 Oct 2021 06:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=owauN8E9WyTrLg+ecsECRpMCBv/zlvKq2Fz1GE8ZEqE=;
        b=kNpIwcsalPwDQni1fW6Ag4Mq598wCddb551PBc6ngJ8Dg3Stii11gd1s8bvUCz8kqn
         bnm1jM1e+B7M/HEYDpINHbsoqgnKlIixu/rhL7zRDEU4tYYtIVrRt5pqBe/cfPbleYmn
         7S/X74Trm9HUdMtCX6ingE9ruF2t6DwiwkZt9fM+TLwPLDCWSlOmD8OMMpu5zt36orub
         H2je+3Zi4CuJFMHMfh7eQpGLC5VQM6vBTZryBojJp2WEsrEL+6oTr4CWDD086Gb61+aL
         2UKEpEMAK+8e/hffRmX6qf6qUHKiC9dRxsQrAQfzo98XWNSqjMUGVV7ry30wTm33atek
         KQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=owauN8E9WyTrLg+ecsECRpMCBv/zlvKq2Fz1GE8ZEqE=;
        b=eyzJFlVu+C1C39Rt07VDe37pLUk5oNysQjvmGvmfzVqWPoYXMwxwESw/Z1rGpobAl5
         Ac+JnXZ7J6EJ/s5z7n7MC1j2C8ugvaGar+7zjehD78HDj3u1LeMyl9pzoe9Ecxnr9UJN
         zOoBUh32mzT3eSBM+erCY7dRnNJBps34e/2H2Ga19RS3ZRzZs4cjX8hExdO9M9PXovBG
         1xkjV/giGvePN1EeEvW7V9itka/od9aIHQb/bgSQpk2P6SDvZsfznAMWmc/NPjIclo4d
         mW5db3b1w3mEiK6uyH6jRbYCa3ny9ez7EqGOrldB4Sv86ka72++ikdVSjbgVAgpEtdAQ
         8pCg==
X-Gm-Message-State: AOAM530G2iBxTj/hvE11A6oSzz3foJGvXt+10P+60yzaCoQLZ/ZeEc0X
        iAUIeUV4I860HbV7R29wTJc=
X-Google-Smtp-Source: ABdhPJxeR9TrMSORws6VMM1ay4I6Bc2nhbdSSeySdUjerUdlyTBxwdkL2WpD15sg/UfE65GaNc+Yeg==
X-Received: by 2002:aca:ac82:: with SMTP id v124mr3411243oie.0.1633700880966;
        Fri, 08 Oct 2021 06:48:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r4sm545368oti.27.2021.10.08.06.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 06:48:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 8 Oct 2021 06:47:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] hwmon: (pmbus/lm25066) Let compiler determine outer
 dimension of lm25066_coeff
Message-ID: <20211008134759.GA1243066@roeck-us.net>
References: <20210928092242.30036-1-zev@bewilderbeest.net>
 <20210928092242.30036-5-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928092242.30036-5-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 02:22:38AM -0700, Zev Weiss wrote:
> Maintaining this manually is error prone (there are currently only
> five chips supported, not six); gcc can do it for us automatically.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Fixes: 666c14906b49 ("hwmon: (pmbus/lm25066) Drop support for LM25063")

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/lm25066.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
> index 4dc003ff859e..1ff5407b6977 100644
> --- a/drivers/hwmon/pmbus/lm25066.c
> +++ b/drivers/hwmon/pmbus/lm25066.c
> @@ -51,7 +51,7 @@ struct __coeff {
>  #define PSC_CURRENT_IN_L	(PSC_NUM_CLASSES)
>  #define PSC_POWER_L		(PSC_NUM_CLASSES + 1)
>  
> -static struct __coeff lm25066_coeff[6][PSC_NUM_CLASSES + 2] = {
> +static struct __coeff lm25066_coeff[][PSC_NUM_CLASSES + 2] = {
>  	[lm25056] = {
>  		[PSC_VOLTAGE_IN] = {
>  			.m = 16296,
