Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E3F32FCC8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhCFTaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:30:02 -0500
Received: from mout.gmx.net ([212.227.15.18]:50547 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231440AbhCFT3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615058965;
        bh=nVW5W5QEQtfYbQWml0kYGVV/4QWg40c3mHIc4HsSoL0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=W/mLGq6besJTk53Du84rUjtGJBA3Ybms9+Jo1fsLyLtyht4Yyi+2RatMZcAcfEXvF
         W3iUrTO8+Ng7ZOqM0bKztwv3SLCvs8oBWAzif4EdGAE0gOtmkd1GRkae1/qDpJPqoL
         2cv5El6BcSYa6mu1bnRVqyjBcM/RXB4EhROF0IKY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.153.24]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MryXH-1m5jHM2mbF-00nzWB; Sat, 06
 Mar 2021 20:29:25 +0100
Subject: Re: [PATCH] arch/parisc/kernel: remove duplicate include in ptrace
To:     menglong8.dong@gmail.com, oleg@redhat.com
Cc:     James.Bottomley@HansenPartnership.com,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
References: <20210304022410.186848-1-zhang.yunkai@zte.com.cn>
From:   Helge Deller <deller@gmx.de>
Message-ID: <fb46ea24-3c5e-f992-4f33-eb00c06c8369@gmx.de>
Date:   Sat, 6 Mar 2021 20:29:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210304022410.186848-1-zhang.yunkai@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YKWoOGci7b09B19Q7X27W19H8+QYMHLMiiH5QcOnnIalWdrWv8Y
 D55lDbR33SODtOOAIyHhTwwHB2ir9FfK7b0ohN5AMWaFCplpyd6v1AkvhFGYoiCSliPjTcg
 7rPLaTHgTzo1IihJlSdEb6BEJhdswjPAA55kp6pxU9aJUZ+vUK/GslffpFMkS3kYa549m7x
 aNdDAHsCoJuVUvQi63bUA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7iMxN3hlQWM=:0xy0BJINoHvtlPTU7eA8Kz
 hj/JtKr4HPitjnvAkQ/bdQQCLwRgD+3NB8zDPCJPppiddht45ihxE4nuNV2nwuuwUL+pWl7yB
 sBhoxYxlU7TeIKHhbAHxNVsT7ppxyovLHmAO8O30FFtOmL49LtLrdrL0Nc2Ve1+T23sE97k43
 JD6TMg9lHGhn11M1lt7lh070nkMEciJCnJNL1U9PNiBm0bncr41peGocTA64uuIqUFW0B/Nxb
 Y+7zUFTa1y4iwSHWDI3tocBPs5mOKYq3/SDLSftCIYh70H9Lsv9GO5IlKe8Cf9Urm67jrNEAM
 OcifZTLCGm46wmZsXgKrNpgtzK/oTcZ7NewhF3HB+u4pecr2nKT5gjrCrYFOc1GbeGWLAljzY
 r5nE/m20n5f3DaPCvMKAQT31VkeKEQL5vEe6Iy9d7fsL/K5WUfoX4ShKUcLLcPbcGCBJYeixa
 1NwHrFq+P3Yi78hcfI1oR0lugk/zEns1mrvyLlMMc7TMrvUtbWG4BNna96EkiWdOo5MRcDrV2
 sMkQ4WKplxBPv9rX4x8fWHH7YaRBP53pxksecKSivtUMeQEsj3WUC8avjf/LInBLhXDLxXjPr
 Oo4jGpSuxZD4SUNh6c95czDWuBXJRRpNIWzTnj2RqkR3OrJm3K848cV+H6s7PwYUEn7xUPQ+G
 3zDBlt/hzaOuBIQxAsTe8sIIglz/PSUaPLnzTvR9fOn5g/YrT56vmRz7F81+RnVmlZf6dIyBv
 CgmjzSqOtthJCgxnrFB5QBZMgy3ZCF0N/zKNCZwHWdse9Ma0lEZJbCQJ2IRZwz0iQxDRLvp81
 deylq6ZwBzQ/LNwpj48XqosrTJno94nB0twHhAgCGyz4tczzGwGqSmxHWYfcNBO3kjhbfkecX
 9N+m7icK6ddWmCyNeQCw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/21 3:24 AM, menglong8.dong@gmail.com wrote:
> From: Zhang Yunkai <zhang.yunkai@zte.com.cn>
>
> 'linux/compat.h' included in 'arch/parisc/kernel/ptrace.c' is duplicated=
.
> It is also included in the 24th line.
>
> Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>

Thanks,
applied to the parisc-next tree.

Helge

> ---
>   arch/parisc/kernel/ptrace.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
> index 2127974982df..918faa95740c 100644
> --- a/arch/parisc/kernel/ptrace.c
> +++ b/arch/parisc/kernel/ptrace.c
> @@ -567,7 +567,6 @@ static const struct user_regset_view user_parisc_nat=
ive_view =3D {
>   };
>
>   #ifdef CONFIG_64BIT
> -#include <linux/compat.h>
>
>   static int gpr32_get(struct task_struct *target,
>   		     const struct user_regset *regset,
>

