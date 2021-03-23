Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF87346AF1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhCWVTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbhCWVTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:19:05 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6019DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:19:05 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z25so27515930lja.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q/Hv2aIHg4JAKeZX5bEtyhlfR532pZFH6Gq8JpGYfrs=;
        b=AykGKCzmwCD/OTQb8N2wMNlDfjjxXFR5hxmBI1h9pbEUd6BoIpScFqBflU4vrvhEn2
         m+rik5VFAvaSx+g8wbd8lentwQdcOXAI/MD8vjOPuG+SYP48vjpVcSbj0ZvVJSd2ThU6
         BiLXDal9b6HEDlRWoKfw3ud5L1tgXDSEhKeFJOJY1kTmCRQBa3ne03u2HFkudHdlpMLc
         VPw0ZuKqWDj76wjtbaZrShf4pihvolt/OiKFbbsK3Ix6VO9i8lzfLETLyG+EIRpeXv6T
         izloky1TGxj+6QZlHzOJS1BCpK+kpv4nrD1l2rpZRpYYM7DJcKV13HM5c/2Xnm/f12rN
         WwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q/Hv2aIHg4JAKeZX5bEtyhlfR532pZFH6Gq8JpGYfrs=;
        b=jA1REURUT9MFOM3D25oap+Y7CI62JzTV8n3eMKMurYN7zFW+aRmQe01foDKDn6NwRC
         Hz2BLNLemP6AkSYg7g/e1rBqMIW4h49Fhj8Asrs8bs+xApzXq7euCN/BcuAS4j5k8QZ3
         AgsyL+TxFaGpDKleBEy3Mv1qiMe0l3TRkfV08PbqT1+IdMvPlV1xKt0bbRfRl30WJN+v
         SnBuyxViX26jjnZUxMK5ta3XgQssN29aojUlkxcUWa5+Wf4xHqVCHH0wKYRQUDtHp9Ba
         yMf/Og0lJCXmPeqb0CLpXR8dYF+rqkMfW8ku0cZ/FaB95i1XJ3KgzYvPIEJ8842OGEtR
         QTeQ==
X-Gm-Message-State: AOAM532xmA+OtZI5e8kKkEdTekennUaK96FRM+9VzjyD1AduADVk6XNo
        dHC7EXLqGIHRYftI4kzWzAM=
X-Google-Smtp-Source: ABdhPJyMEFXVI3Wnlu/AMRiG90UGc3ctWqC36YOiySvjC9hcf228gR3MMXJblNutFOG9xzoPtvPg9Q==
X-Received: by 2002:a2e:919a:: with SMTP id f26mr4383249ljg.508.1616534343912;
        Tue, 23 Mar 2021 14:19:03 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-60.dynamic.spd-mgts.ru. [109.252.193.60])
        by smtp.googlemail.com with ESMTPSA id i18sm24489lfl.22.2021.03.23.14.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 14:19:03 -0700 (PDT)
Subject: Re: [PATCH v5] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        jhubbard@nvidia.com, willy@infradead.org
References: <20210323195050.2577017-1-minchan@kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <bff2b424-91f7-5748-fa27-54cc75667548@gmail.com>
Date:   Wed, 24 Mar 2021 00:19:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323195050.2577017-1-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

23.03.2021 22:50, Minchan Kim пишет:
> Since CMA is getting used more widely, it's more important to
> keep monitoring CMA statistics for system health since it's
> directly related to user experience.
> 
> This patch introduces sysfs statistics for CMA, in order to provide
> some basic monitoring of the CMA allocator.
> 
>  * the number of CMA page successful allocations
>  * the number of CMA page allocation failures
> 
> These two values allow the user to calcuate the allocation

typo: calculate

>  struct cma {
>  	unsigned long   base_pfn;
> @@ -16,6 +22,14 @@ struct cma {
>  	struct debugfs_u32_array dfs_bitmap;
>  #endif
>  	char name[CMA_MAX_NAME];
> +#ifdef CONFIG_CMA_SYSFS
> +	/* the number of CMA page successful allocations */
> +	atomic64_t nr_pages_succeeded;
> +	/* the number of CMA page allocation failures */
> +	atomic64_t nr_pages_failed;
> +	/* kobject requires dynamic objecjt */

typo: object
...
> +static void cma_kobj_release(struct kobject *kobj)
> +{
> +	struct cma_kobject *cma_kobj =
> +		container_of(kobj, struct cma_kobject, kobj);

I'd add a to_cma_kobject() helper to improve readability.

> +	struct cma *cma = cma_kobj->cma;
> +
> +	kfree(cma_kobj);
> +	cma->kobj = NULL;
> +}
> +
> +static struct attribute *cma_attrs[] = {
> +	&alloc_pages_success_attr.attr,
> +	&alloc_pages_fail_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(cma);
> +
> +static struct kobject *cma_kobj_root;
> +
> +static struct kobj_type cma_ktype = {
> +	.release = cma_kobj_release,
> +	.sysfs_ops = &kobj_sysfs_ops,
> +	.default_groups = cma_groups
> +};
> +
> +static int __init cma_sysfs_init(void)
> +{
> +	int i = 0;

unsigned int, for consistency

There is no need to initialize this variable.

> +	struct cma *cma;
> +
> +	cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
> +	if (!cma_kobj_root)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < cma_area_count; i++) {
> +		struct cma_kobject *kobj;
> +
> +		cma = &cma_areas[i];
> +		kobj = kzalloc(sizeof(struct cma_kobject), GFP_KERNEL);

Checkpatch should warn that kzalloc(*kobj, ..) is a better variant.

I'd also rename kobj to cma_kobj everywhere, for clarity.

> +		if (!kobj)
> +			goto out;
> +
> +		kobj->cma = cma;
> +		cma->kobj = kobj;
> +		if (kobject_init_and_add(&cma->kobj->kobj, &cma_ktype,
> +					 cma_kobj_root, "%s", cma->name)) {
> +			kobject_put(&cma->kobj->kobj);
> +			goto out;
> +		}
> +	}
> +
> +	return 0;
> +out:
> +	kobject_put(cma_kobj_root);
> +
> +	return -ENOMEM;

kobject_init_and_add returns a error code, it could be different from
ENOMEM. Won't hurt to propagate the proper error code.

