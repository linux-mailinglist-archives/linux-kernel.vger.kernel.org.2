Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052E4389780
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 22:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhESUIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 16:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhESUIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 16:08:04 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90570C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 13:06:44 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id g11so9276688ilq.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yZeOnuZeT/FAFpEU8iKvZOWrDJSy1lQIQkosiknz+tw=;
        b=B4L4Cf4ob7jI8O9tCpuGsSoGTTsYT8cNP5C9LiGilDHx9PkhpMToY9/1ewEkYXeKHj
         W3jdPK68fcLfLZGyadnqvj01SLWr2Eb73VBvpyJD+DHI0LHr0rY0JI/7Vea++hnf8wA2
         tn6oQnUx4SLKT/CFbkcyjDyq5A/I/Rs1GTu4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yZeOnuZeT/FAFpEU8iKvZOWrDJSy1lQIQkosiknz+tw=;
        b=kfukYC1N8tvSCGbpYr4FIXXAvXiTT7XPGy0ToanT33vJD/aDKUFWGkNFF2Q2rV3/Zi
         X4uLttHrz+oCcqck4lOO1V2svI5JILXY48Qzh7hQ//0KgY+y8yHZ6CnUyutThmrfGqDo
         L8IG35xHUaVibppEbXHalwWbyajNermlroIZZXNtjvWVLPbBPWrHJ5YKVjtgbGjcDyY2
         ZJS2ST2tgcSnIAGt+ggyqJHWG+vp4aE8BQ6SSJj7mSnXzHta/kA4UwwLDyPZQbrVRbZ2
         s7DJdx0yAEPUsLNmE9x+FI6UaPwzX+l79Q5vvvg+RJ94giEv4HFoF7KYk5ViqxJoujwv
         v9FQ==
X-Gm-Message-State: AOAM532nAsilFIk18nf63GDtOGp7QgchMkQErgB1sqvmhsXga/GnE4IG
        YaF3rUJ83HYKPz/+9xEdjhZeekbEHAoiLB4K
X-Google-Smtp-Source: ABdhPJyMEwvEgzqb8XIl+iED4/ZpznyOYcX85jjsq1lC52oKNgGcLJYBNbDvhDFAMFiGWRJzkYm2+w==
X-Received: by 2002:a92:3f08:: with SMTP id m8mr884825ila.154.1621454803442;
        Wed, 19 May 2021 13:06:43 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id v2sm577049ioh.14.2021.05.19.13.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 13:06:42 -0700 (PDT)
Subject: Re: [PATCH V2] Staging: greybus: fix open parenthesis error in
 gbphy.c
To:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210519181938.30813-1-asha.16@itfac.mrt.ac.lk>
From:   Alex Elder <elder@ieee.org>
Message-ID: <4af943f6-9baa-72a6-12b5-6b35179a7019@ieee.org>
Date:   Wed, 19 May 2021 15:06:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519181938.30813-1-asha.16@itfac.mrt.ac.lk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/21 1:19 PM, F.A.Sulaiman wrote:
> This patch fix "Alignment should match open parenthesis" checkpatch error.
> 
> Signed-off-by: "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>

I have mixed feelings about this one.  This alignment rule
is fine, but I personally don't think it improves things.

Aside from that, there are a few more places in the Greybus
code that lead to exactly this warning.  So I guess, if we're
going to have the code follow this alignment rule, why not
just fix all spots at once (i.e., in a patch series)?

Anyway, I'll offer this, but perhaps others can provide
their opinion.

Acked-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/staging/greybus/gbphy.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/gbphy.c b/drivers/staging/greybus/gbphy.c
> index 9fc5c47be9bd..13d319860da5 100644
> --- a/drivers/staging/greybus/gbphy.c
> +++ b/drivers/staging/greybus/gbphy.c
> @@ -27,7 +27,7 @@ struct gbphy_host {
>   static DEFINE_IDA(gbphy_id);
>   
>   static ssize_t protocol_id_show(struct device *dev,
> -				 struct device_attribute *attr, char *buf)
> +				struct device_attribute *attr, char *buf)
>   {
>   	struct gbphy_device *gbphy_dev = to_gbphy_dev(dev);
>   
> @@ -221,7 +221,7 @@ void gb_gbphy_deregister_driver(struct gbphy_driver *driver)
>   EXPORT_SYMBOL_GPL(gb_gbphy_deregister_driver);
>   
>   static struct gbphy_device *gb_gbphy_create_dev(struct gb_bundle *bundle,
> -				struct greybus_descriptor_cport *cport_desc)
> +						struct greybus_descriptor_cport *cport_desc)
>   {
>   	struct gbphy_device *gbphy_dev;
>   	int retval;
> 

