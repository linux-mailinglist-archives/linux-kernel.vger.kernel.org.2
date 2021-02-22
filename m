Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A23F321171
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 08:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhBVHgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 02:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhBVHgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 02:36:08 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBC0C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 23:35:28 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id v22so20447561edx.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 23:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=Iji0WeR6vKM0Z3iG2537zAB1TJYq/UVFyP+dbtL51mM=;
        b=gdM+aXHSKTgLU0VG/7m4Z9ee0ftRGE+Fcpc+3RgwVP+bydhQsEquyBLpCYaM/8nvkQ
         crCLEEdZ2vWAK43tmtv1gAGOdHly3FDlOHtcLhScMlHT1OCauRfrrsRm/BcrjiCc9Det
         fIplMLMa3fuv7rHpfrJaygVvqXF3kAmaQjZgCHsmomRlel8DmeXvK+yjSEm+yBJA+JYa
         95x5y9f3gxiU+WUMuduwhNqD5AW45XiB2ogz+Dt1FcSb18177yJXIW7xVsKWnDk92IBA
         g61jpVQ7xU+GSHZRukzzxQtfhTQYCtlZWYPou/cVbIOrY8jBRJWp/Iw5o9Mmbl5VKWXG
         lCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Iji0WeR6vKM0Z3iG2537zAB1TJYq/UVFyP+dbtL51mM=;
        b=BmexX0Q8fDlLYnIuEXP8gT4yia1DtnxjjK8WbsGCHuba9Z8HwpKzGvduRtRJnylzR3
         9M7yVDfNPsqzlajorjsNysbzDRMqWA/BHLyWEUXi81M6zR1fZ1klQFCgZoCJFHMoSNFj
         Ymv1oOeqqDdppHgXTMNpTm48L295Qt7qjk3jR/RKcQhufFgEsOt4C0eb5WZac4nSSXrX
         nxpcagLvIQRXfpf/UleAyPsjeCYc/NOtyhwKSKVBDXEiUBEhLwDjxJlrW1Up1h5V0vfx
         vJuJzutuA/BOs4DJpbtM/eOqgr1frphyfkb8T8w0T5zcAQwAS3SxmPk0dcainkVI853o
         OM9w==
X-Gm-Message-State: AOAM530qXs+zVD7UG57dzfrODcDugfPPc/5wj5LhuExtuYmPdIk49qE/
        uBlsa1BjbkbWVBqAubGWwkORbUEMB64dSxey
X-Google-Smtp-Source: ABdhPJxpyr7tn4lZ8nte4KPNPbXnvhS7eTEHIlc4MDPkNXkz3gfaudtSV7GKlAUlG3dMs2tOMcuMaA==
X-Received: by 2002:aa7:c54b:: with SMTP id s11mr5247917edr.82.1613979327131;
        Sun, 21 Feb 2021 23:35:27 -0800 (PST)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id bo12sm9708094ejb.93.2021.02.21.23.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Feb 2021 23:35:26 -0800 (PST)
Subject: Re: [PATCH] lightnvm: use kobj_to_dev()
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-nvme@lists.indradead.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210222060650.45373-1-chaitanya.kulkarni@wdc.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <1bae7eca-c41a-28ed-f575-e9891b4ce45d@lightnvm.io>
Date:   Mon, 22 Feb 2021 08:35:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210222060650.45373-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2021 07.06, Chaitanya Kulkarni wrote:
> This fixs coccicheck warning:-
>
> drivers/nvme//host/lightnvm.c:1243:60-61: WARNING opportunity for
> kobj_to_dev()
>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>   drivers/nvme/host/lightnvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index b705988629f2..e3240d189093 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -1240,7 +1240,7 @@ static struct attribute *nvm_dev_attrs[] = {
>   static umode_t nvm_dev_attrs_visible(struct kobject *kobj,
>   				     struct attribute *attr, int index)
>   {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>   	struct gendisk *disk = dev_to_disk(dev);
>   	struct nvme_ns *ns = disk->private_data;
>   	struct nvm_dev *ndev = ns->ndev;

Thanks, Chaitanya. I'll pull it in.

