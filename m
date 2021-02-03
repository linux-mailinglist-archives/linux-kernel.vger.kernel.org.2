Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838F330DC38
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhBCOGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:06:52 -0500
Received: from mout.gmx.net ([212.227.15.15]:58803 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231744AbhBCOGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612361091;
        bh=EwqsjVej+GJZLmg7GxtJ+1+ZGj2K1+zRkchJ6wwjYO8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=D30EuHuAbKeOvqAZ9pDF5R3yDDDbD1BuZiFwhj1vt5nEuJ9sVoNgQjobTndXRnLQL
         h8xZoKLDcj3ZE5OHigj8YYXUKlFu/CVCYVW+Pvwm23GfIaI84+KH9oWQCT5SBgY4nA
         NBlqC0M8a5J5b8pLEdlG5JqLOJBw2B+w09jGhkrE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.188.146]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17UW-1m42RN14WY-012X4I; Wed, 03
 Feb 2021 15:04:51 +0100
Subject: Re: [PATCH] parisc: Replace test_ti_thread_flag() with
 test_tsk_thread_flag()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        James.Bottomley@HansenPartnership.com
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1612330032-6034-1-git-send-email-yangtiezhu@loongson.cn>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <49529a7d-a8c0-c248-6868-8280c821455d@gmx.de>
Date:   Wed, 3 Feb 2021 15:04:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1612330032-6034-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xjCXcpsBhR1johp7N02Ku5FNshQfVShjQsOMn3YfmZGf+l6P55i
 PX3UuZdQ5TSybJG21DTh3FFMKFE7bx0ty1hpHGDh2DuDw81L0wRo4q1Po4EGWnxZnYVi0pA
 KoGJ5TJVTAuUCipT7sDMvcLOzoroIbZZMQw63HGPh12jQkYcV9kbv2lSfvDY0nRDlh4h+pO
 +vHcQ/vwlVEYPbmNxVlMg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:R5EWx6/HCY0=:fysVw5iQY23fvZb7EyE9tw
 inkXO0FaMC4oJrbL+saOksTYAnb5QyY9LO3XUx0y7ZP49E3e7f+kJG77DmFgziOovGEaYI4lo
 7hDOSRZnY9ACjUbLBf+90F6qa7OQqmbEm0E8UczuKfZBiScE/IO4jRzH7JwfNeB6QVzD/oM+x
 DdfgXQ1VKxpgd0+0+IUTjjjxzTatOirgyv19dpdoaUuGOSX2WizsTd4Df4sHJNpFr7VH1LIfU
 M+nXRgPlrmjqKZVNUjilYwJek+/VFA05gVtV7T6VgMdKTJ/8LpQJWCSMIlf5F8g/agz9aEygs
 uMkDM9Y+eESWRoGqU5A3vFHuOlI4DPxGTmDatF2hcG5tdyX8Z1jCG0WNz3RdgCh+iolJPrDeG
 bX2DNP1asap61Xie4Az1+RthzhoGIN+zmpZOsU3AI8YGlwxG6LxcXa4awO1qGsXtdC4tD9W76
 8zMjHHzrS1KzNEnL1Vk4gFKYK0mMR9EoAC5xnyyWw4FezdQcBVHR/u5/r92Jgm9mh8fMBpwEe
 FNvG30A3h6j2TPzyyzPIuySBY54IRt0AlInAIPL+E9/GKoNLcXSPtfl3dT+CtaNG6Mu84zibk
 8xhju+7/Y6odx/VrJItBLoF75fNpbHKV4rZyuSBlodeDj3s+FIZSweWwAm6RL659ZPN8J7lwE
 Wpxhl5Zu21XabILPGlGq5C2YoMETZ5Ientmmbknm515874IaCBkkAkR+2T+3UjvjU+16jy1O9
 pmTPY77viI0+XhaAGf2DwLqVvE2KEJJ1T1sRwVt3GaG+8zNaffY0qc+dKAzE8Gsf8OJeGi77o
 +NPujKjc+3ExPWoBvJATYQtrRXnjIkWPwGXofbljgzsRokz58uC+rxQKdbKx+yP9dKtwbMmF7
 CNTHybWJ+1y2rDkQ115w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 6:27 AM, Tiezhu Yang wrote:
> Use test_tsk_thread_flag() directly instead of test_ti_thread_flag() to
> improve readability when the argument type is struct task_struct, it is
> similar with commit 5afc78551bf5 ("arm64: Use test_tsk_thread_flag() for
> checking TIF_SINGLESTEP").
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Thanks!
Applied to the parisc git tree.

Helge

> ---
>  arch/parisc/include/asm/compat.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/parisc/include/asm/compat.h b/arch/parisc/include/asm/=
compat.h
> index 8f33085..1a609d3 100644
> --- a/arch/parisc/include/asm/compat.h
> +++ b/arch/parisc/include/asm/compat.h
> @@ -179,7 +179,7 @@ static __inline__ void __user *arch_compat_alloc_use=
r_space(long len)
>
>  static inline int __is_compat_task(struct task_struct *t)
>  {
> -	return test_ti_thread_flag(task_thread_info(t), TIF_32BIT);
> +	return test_tsk_thread_flag(t, TIF_32BIT);
>  }
>
>  static inline int is_compat_task(void)
>

