Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD65E33F526
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhCQQKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhCQQKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:10:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC27C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=OegbBuCs7g0rrwuCi6jze6s2GTCQRVv+NrnCbww/Xa4=; b=fQ1kHxZtT+zE1J9uwzareUsWZI
        Vwd13/JnWWJcpr0N/2i6QvBr4/YGljPxDUFAYPf7ulHLtxZH0YZNy0jouF51iVwjZ7UkMmyogBlR6
        i6KOXTLuo3FYDFIkLlWxedUbiR4Pi9SXPERFRt4Dx0eXcpVXflvq+SmKa3DaSqBcjfhTG2YE8k867
        m9J7pt3Pgz4Eo9rnH9wBYTQ6Tk2B6ZwqZtl8wDlIQeHh54MN/7udzGLU3PVYmtFUINqkGpyqHQQ9Y
        Gur35J250iPqUYoF/txFGdLo4ktqc/WmanqvZqPiQwOK8kHuR131BGgYwtqUr1AsjIwhj1qLq3Qo1
        BE1ajXKA==;
Received: from merlin.infradead.org ([2001:8b0:10b:1234::107])
        by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
        id 1lMY91-003ROr-S9
        for linux-kernel@vger.kernel.org; Wed, 17 Mar 2021 15:31:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=OegbBuCs7g0rrwuCi6jze6s2GTCQRVv+NrnCbww/Xa4=; b=SCN5+73p4vcA2lgsp1XzufTOqJ
        QwokuDhlITbVIeMhpYaainFhG9aTbFTiWx7ItqNV6GgWxsNcJni9h+EWOafqTy+/Ns5GVn44UhNNc
        hheYDYiyEIK3BqFcy94YKyGM/4RN32WNJyrIKYJEQP/02XC/5dcn6+OZUk4sarrnNOgEXhNL4YJ8I
        4TwsCbOleiRKSEwBR5q4O/Oeam+t+3l3U/cxQgMrX+2N+aN7E2KYpqURzxU+Fcp9KeqoRtb+XPaX8
        Y0XV4FGDugHMvCG3G9GJMKXIse8xt/bGHaXQFtulNvEB/RnIU+Mi29mRzUSVEKtPRIS3dS10pbmQP
        xBonlXyA==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMY2H-001ehA-Ha; Wed, 17 Mar 2021 15:24:38 +0000
Subject: Re: [PATCH V2] iio:imu:mpu6050: Modify matricies to matrices
To:     Guoqing chi <chi962464zy@163.com>, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, chiguoqing@yulong.com
References: <20210317061930.478-1-chi962464zy@163.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ccaa6038-0b52-9b3b-f50c-f63ddf3a8747@infradead.org>
Date:   Wed, 17 Mar 2021 08:24:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317061930.478-1-chi962464zy@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 11:19 PM, Guoqing chi wrote:
> From: Guoqing Chi <chiguoqing@yulong.com>
> 
> The plural of "matrix" is "matrices".
> 
> Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> V2:fix "complex number of" to "plural of".
> 
>  include/linux/platform_data/invensense_mpu6050.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/platform_data/invensense_mpu6050.h b/include/linux/platform_data/invensense_mpu6050.h
> index 93974f4cfba1..f05b37521f67 100644
> --- a/include/linux/platform_data/invensense_mpu6050.h
> +++ b/include/linux/platform_data/invensense_mpu6050.h
> @@ -12,7 +12,7 @@
>   *			mounting matrix retrieved from device-tree)
>   *
>   * Contains platform specific information on how to configure the MPU6050 to
> - * work on this platform.  The orientation matricies are 3x3 rotation matricies
> + * work on this platform.  The orientation matrices are 3x3 rotation matrices
>   * that are applied to the data to rotate from the mounting orientation to the
>   * platform orientation.  The values must be one of 0, 1, or -1 and each row and
>   * column should have exactly 1 non-zero value.
> 


-- 
~Randy

