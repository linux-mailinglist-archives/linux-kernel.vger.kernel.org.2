Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E2A34789B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhCXMhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbhCXMhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:37:06 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BF7C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:37:05 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g8so24578143lfv.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nIJfnQhLwGUTSTIDPdo6RHmVYRmlX0sZ1w6RVIyynBI=;
        b=i5DUa2aEATi7n6D2eLMJyHy8wVNfTnyi972S30ueEKbiiHCAvOirY5mjLJ7ssFdyBb
         7J2Ls4I2pPN90vYC+RcErwtG2kRYl3RB+3bTUJ3SAht6x9qYrzTvTtAzgsq326lx/yyx
         JiUnmR8oVnehNtcllk8wPsLTpX2mw2/sTomBnRaOg5e+J0sixfzsELbJCOQKNn9UyRw4
         xuKUD1LHPYsxerOIku441hSXKa8iQI90NYgcVeyShrXJ/qqt5wQA1KIL4J6wlOhK6OIM
         SzbtUhCNHXS+8BncA8K7d94TfqleTbWP4LNFGftUUDn027sUxgxdNskasii0T43ivtxK
         Kkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nIJfnQhLwGUTSTIDPdo6RHmVYRmlX0sZ1w6RVIyynBI=;
        b=ebccPgENhvWg1CneviLmIR1P4Jp+ZEeZa4/KB63/gOOJxiS5dfFQ+bMLLgkXiGvrux
         uHkvheRIobNDO5AhC/QuKP1P3YkfiCys2Mo/2GbavQbBVIoVXZM9qFP60axC6ZxVoCGa
         RUcqmx/CseohL0dR/zifQzZZhgnc3wqJtofJJ1h+FrIoOcarf+7WZjrsnbr33YhRq4Ty
         01lE6gr2WrKHonkVUgkwIu9R7YbmmYNT/JKWRX6zibkAlyktOBKyoXqJlqrGptrqifro
         71Yv25kegF1qrpdwamfweW2br3kV1IKVzkuubdX8SA4+pLy1ngCH0JGjSz3j7hOib4gD
         K0sQ==
X-Gm-Message-State: AOAM531mf8inXCNJkXrXDePYdrJExs059pfmD8MZElcgap6N+NfIhbPa
        xPTiGT75U8kq/ftyJ+Dbt+x2tlvdDdk=
X-Google-Smtp-Source: ABdhPJy2KFt7fWcIVloNQhgT+OkHkLkGosPIQmJjZ6nALGrW8AdpeKa0/8Ng5nJlLHjReKESojuWpQ==
X-Received: by 2002:a19:c14f:: with SMTP id r76mr1915986lff.218.1616589423852;
        Wed, 24 Mar 2021 05:37:03 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-60.dynamic.spd-mgts.ru. [109.252.193.60])
        by smtp.googlemail.com with ESMTPSA id d13sm218870lfi.247.2021.03.24.05.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 05:37:03 -0700 (PDT)
Subject: Re: [PATCH v6] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, willy@infradead.org
References: <20210324010547.4134370-1-minchan@kernel.org>
 <cbe10402-6574-6e46-9fd9-98b503bd26a4@nvidia.com>
 <YFqxm7UQBtWqH6VU@google.com>
 <d224c6bd-f5b1-74f6-2afc-c3d5b0519ba4@nvidia.com>
 <YFrRugjVLlazTNPy@google.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5b1a9f6c-ea7b-6e90-1c77-a49a10896f08@gmail.com>
Date:   Wed, 24 Mar 2021 15:37:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFrRugjVLlazTNPy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.03.2021 08:44, Minchan Kim пишет:
> On Tue, Mar 23, 2021 at 09:47:27PM -0700, John Hubbard wrote:
>> On 3/23/21 8:27 PM, Minchan Kim wrote:
>> ...
>>>>> +static int __init cma_sysfs_init(void)
>>>>> +{
>>>>> +	unsigned int i;
>>>>> +
>>>>> +	cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
>>>>> +	if (!cma_kobj_root)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	for (i = 0; i < cma_area_count; i++) {
>>>>> +		int err;
>>>>> +		struct cma *cma;
>>>>> +		struct cma_kobject *cma_kobj;
>>>>> +
>>>>> +		cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
>>>>> +		if (!cma_kobj) {
>>>>> +			kobject_put(cma_kobj_root);
>>>>> +			return -ENOMEM;
>>>>
>>>> This leaks little cma_kobj's all over the floor. :)
>>>
>>> I thought kobject_put(cma_kobj_root) should deal with it. No?
>>>
>> If this fails when i > 0, there will be cma_kobj instances that
>> were stashed in the cma_areas[] array. But this code only deletes
>> the most recently allocated cma_kobj, not anything allocated on
>> previous iterations of the loop.
> 
> Oh, I misunderstood that destroying of root kobject will release
> children recursively. Seems not true. Go back to old version.
> 
> 
> index 16c81c9cb9b7..418951a3f138 100644
> --- a/mm/cma_sysfs.c
> +++ b/mm/cma_sysfs.c
> @@ -80,20 +80,19 @@ static struct kobj_type cma_ktype = {
>  static int __init cma_sysfs_init(void)
>  {
>         unsigned int i;
> +       int err;
> +       struct cma *cma;
> +       struct cma_kobject *cma_kobj;
> 
>         cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
>         if (!cma_kobj_root)
>                 return -ENOMEM;
> 
>         for (i = 0; i < cma_area_count; i++) {
> -               int err;
> -               struct cma *cma;
> -               struct cma_kobject *cma_kobj;
> -
>                 cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
>                 if (!cma_kobj) {
> -                       kobject_put(cma_kobj_root);
> -                       return -ENOMEM;
> +                       err = -ENOMEM;
> +                       goto out;
>                 }
> 
>                 cma = &cma_areas[i];
> @@ -103,11 +102,21 @@ static int __init cma_sysfs_init(void)
>                                            cma_kobj_root, "%s", cma->name);
>                 if (err) {
>                         kobject_put(&cma_kobj->kobj);
> -                       kobject_put(cma_kobj_root);
> -                       return err;
> +                       goto out;
>                 }
>         }
> 
>         return 0;
> +out:
> +       while (--i >= 0) {
> +               cma = &cma_areas[i];
> +
> +               kobject_put(&cma->kobj->kobj);
> +               kfree(cma->kobj);
> +               cma->kobj = NULL;
> +       }
> +       kobject_put(cma_kobj_root);
> +
> +       return err;
>  }
>  subsys_initcall(cma_sysfs_init);

Since we don't care about the order in which kobjects are put, I'd write it in this way, which I think looks cleaner:

static void cma_sysfs_cleanup(struct kobject *cma_kobj_root)
{
	struct cma *cma = cma_areas;
	unsigned int i;

	for (i = 0; i < cma_area_count; i++, cma++) {
		if (!cma->kobj)
			break;

		kobject_put(&cma->kobj->kobj);
	}

	kobject_put(cma_kobj_root);
}

static int __init cma_sysfs_init(void)
{
	struct kobject *cma_kobj_root;
	unsigned int i;

	cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
	if (!cma_kobj_root)
		return -ENOMEM;

	for (i = 0; i < cma_area_count; i++) {
		struct cma_kobject *cma_kobj;
		struct cma *cma;
		int err;

		cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
		if (!cma_kobj) {
			cma_sysfs_cleanup(cma_kobj_root);
			return -ENOMEM;
		}

		cma = &cma_areas[i];
		cma->kobj = cma_kobj;
		cma_kobj->cma = cma;
		err = kobject_init_and_add(&cma_kobj->kobj, &cma_ktype,
					   cma_kobj_root, "%s", cma->name);
		if (err) {
			cma_sysfs_cleanup(cma_kobj_root);
			return err;
		}
	}

	return 0;
}
subsys_initcall(cma_sysfs_init);
