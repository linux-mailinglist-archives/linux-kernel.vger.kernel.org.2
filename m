Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE4D3457D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCWGdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:33:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14063 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhCWGdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:33:23 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4M1z2lVvzNqTS;
        Tue, 23 Mar 2021 14:30:47 +0800 (CST)
Received: from [10.174.178.163] (10.174.178.163) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 14:33:14 +0800
Subject: Re: [PATCH] mm: process_vm_access: Remove duplicate include of
 compat.h
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <kael_w@yeah.net>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210323032322.262579-1-wanjiabing@vivo.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a96d8bf1-292f-a239-fc31-1022c7c4a296@huawei.com>
Date:   Tue, 23 Mar 2021 14:33:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210323032322.262579-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.163]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/23 11:23, Wan Jiabing wrote:
> linux/compat.h has been included at line 8.So we remove 
> the duplicate one at line 12.
> 

line 12 one is added via eb351d75ce1e ("mm/process_vm_access.c: include compat.h") to fix the build error:
 mm/process_vm_access.c:277:5: error: implicit declaration of function 'in_compat_syscall'; did you mean 'in_ia32_syscall'? [-Werror=implicit-function-declaration]

There might be something wrong.

> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  mm/process_vm_access.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
> index f5fee9cf90f8..4bcc11958089 100644
> --- a/mm/process_vm_access.c
> +++ b/mm/process_vm_access.c
> @@ -9,7 +9,6 @@
>  #include <linux/mm.h>
>  #include <linux/uio.h>
>  #include <linux/sched.h>
> -#include <linux/compat.h>
>  #include <linux/sched/mm.h>
>  #include <linux/highmem.h>
>  #include <linux/ptrace.h>
> 

