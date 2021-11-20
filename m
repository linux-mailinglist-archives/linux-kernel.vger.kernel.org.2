Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614C4457AB9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 04:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhKTDVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 22:21:50 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:27148 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhKTDVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 22:21:45 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HwzFq2fBbz1DJQQ;
        Sat, 20 Nov 2021 11:16:15 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 20 Nov 2021 11:18:41 +0800
Received: from use12-sp2.huawei.com (10.67.189.20) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 20 Nov 2021 11:18:41 +0800
From:   Jubin Zhong <zhongjubin@huawei.com>
To:     <lasse.collin@tukaani.org>
CC:     <akpm@linux-foundation.org>, <liaohua4@huawei.com>,
        <linux-kernel@vger.kernel.org>, <wangfangpeng1@huawei.com>,
        <zhongjubin@huawei.com>
Subject: Re: [PATCH] kbuild: Enable armthumb BCJ filter for Thumb-2 kernel
Date:   Sat, 20 Nov 2021 11:18:39 +0800
Message-ID: <1637378319-38601-1-git-send-email-zhongjubin@huawei.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <20211119214647.12932e5c@kaneli>
References: <20211119214647.12932e5c@kaneli>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.20]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If a Thumb-2 kernel will always use the ARM-Thumb BCJ filter, one can
> save a few bytes from the pre-boot code by omitting the ARM BCJ filter:
>
> --- a/lib/decompress_unxz.c
> +++ b/lib/decompress_unxz.c
> @@ -129,7 +129,11 @@
>  #	define XZ_DEC_POWERPC
>  #endif
>  #ifdef CONFIG_ARM
> -#	define XZ_DEC_ARM
> +#	ifdef CONFIG_THUMB2_KERNEL
> +#		define XZ_DEC_ARMTHUMB
> +#	else
> +#		define XZ_DEC_ARM
> +#	endif
>  #endif
>  #ifdef CONFIG_IA64
>  #	define XZ_DEC_IA64
>
>> --- a/scripts/xz_wrap.sh
>> +++ b/scripts/xz_wrap.sh
>> @@ -8,6 +8,7 @@
>>  # This file has been put into the public domain.
>>  # You can do whatever you want with this file.
>>  #
>> +. include/config/auto.conf
>
> I suggest adding an empty line before this new line so that it is
> clearly separated from the header comment.
>
>> +if [ -n "${CONFIG_THUMB2_KERNEL}" ];then
>
> I suggest adding a space after the semi-colon: ]; then
>
> With or without the above modifications:

Thanks for your advices. I will incorporate the above modifications and send patch v2.
