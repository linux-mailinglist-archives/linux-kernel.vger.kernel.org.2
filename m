Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D0433E8B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 06:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhCQFEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 01:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhCQFEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 01:04:48 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB49C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 22:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ybbA4Qi9mtcUePCf0pVWByz7C3Rp/x6OKM+5Ccd/J+I=; b=QvKt3HZUTI7fND+CVc0p9jUW1E
        kDoMcjUb28gm5orH9Yf748KWyxXYhXjAiCxgrz99Mn3pbYNb5YB5kPOAo62NriLHCS5QY2Vm8VkG+
        FKEvR7HSwhaePuVvcCFDiwTEp53L4xkHNYS0jI9+rosUq4Wbb7Y/HjF5g8VgQWm9XpYih36OOFHoG
        Ejb+qGGb/Mvfwk+B32WQnCNKN8gVAQLyR04CSYIrZ/3+qiUYYT84lvG7yGXlAtj/j5iAcB0OxrKD2
        hhpgWNhCJ79uRoBIIwGIB3fettobGivoy19AlAO2j8XdYrgHXILCSzX6BV3fjBDUsdHaT2aOqC/En
        kNzc2J0A==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMOMH-001bQq-H8; Wed, 17 Mar 2021 05:04:37 +0000
Subject: Re: [PATCH] iio:imu:mpu6050: Modify matricies to matrices
To:     Guoqing chi <chi962464zy@163.com>, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, chiguoqing@yulong.com
References: <20210317024102.419-1-chi962464zy@163.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <23d4b482-212f-dde5-dc83-7401b14f3638@infradead.org>
Date:   Tue, 16 Mar 2021 22:04:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317024102.419-1-chi962464zy@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 7:41 PM, Guoqing chi wrote:
> From: Guoqing Chi <chiguoqing@yulong.com>
> 
> The complex number of "matrix" is "matrices".

(I would say that the plural of matrix is matrices.)

> 
> Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
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

