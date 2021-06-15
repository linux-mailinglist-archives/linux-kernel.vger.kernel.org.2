Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916B23A741F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhFOCix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:38:53 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:6365 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFOCiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:38:51 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G3ryR64tQz62vQ;
        Tue, 15 Jun 2021 09:56:15 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 10:00:13 +0800
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 10:00:12 +0800
Subject: Re: [PATCH -next] drm/nouveau/svm: Remove set but not used variable
 'ret'
To:     <bskeggs@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>
References: <20210531023811.477542-1-libaokun1@huawei.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <aff157a6-d301-fe4f-d25c-f4ea0705f5a1@huawei.com>
Date:   Tue, 15 Jun 2021 10:00:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210531023811.477542-1-libaokun1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

在 2021/5/31 10:38, Baokun Li 写道:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/nouveau/nouveau_svm.c: In function 'nouveau_pfns_map':
> drivers/gpu/drm/nouveau/nouveau_svm.c:814:6: warning:
>   variable ‘ret’ set but not used [-Wunused-but-set-variable]
>
> It never used since introduction.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>   drivers/gpu/drm/nouveau/nouveau_svm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index 84726a89e665..16fbf90f9f31 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -921,7 +921,6 @@ nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm_struct *mm,
>   		 unsigned long addr, u64 *pfns, unsigned long npages)
>   {
>   	struct nouveau_pfnmap_args *args = nouveau_pfns_to_args(pfns);
> -	int ret;
>   
>   	args->p.addr = addr;
>   	args->p.size = npages << PAGE_SHIFT;
> @@ -929,7 +928,7 @@ nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm_struct *mm,
>   	mutex_lock(&svmm->mutex);
>   
>   	svmm->vmm->vmm.object.client->super = true;
> -	ret = nvif_object_ioctl(&svmm->vmm->vmm.object, args, sizeof(*args) +
> +	nvif_object_ioctl(&svmm->vmm->vmm.object, args, sizeof(*args) +
>   				npages * sizeof(args->p.phys[0]), NULL);
>   	svmm->vmm->vmm.object.client->super = false;
>   
