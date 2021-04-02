Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEC9353102
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 00:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbhDBWYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 18:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhDBWYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 18:24:38 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1158AC061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 15:24:37 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id d10so5662663ils.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cfAC5/0xb+Ob/94h/cPLZqxJqw6PTF1yrJT99k9yIrA=;
        b=f7iLkMD4V3aaQ9z58wMRUgiRX9NOAwSNtAUQaOoZ2LQBaf+2kxAjGSunXzqJUaiCYy
         7KqTFfetLZhQzB2SksowbUue4OPkDu4YNFlYQ8coC8Y5/eDxz8p9J+Pc8xsC0OqWD44c
         BAjtl+Or1Bqrenlh8uao02NOT/7cfRdJkKV2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cfAC5/0xb+Ob/94h/cPLZqxJqw6PTF1yrJT99k9yIrA=;
        b=CvMQFP0rs2DDU4Sh8/0LikvnPVeqfxJP/02iBZ32iR1mHGB6r9uib7ZUvKGDFVEiio
         qBK3lf1m2VFWhUnD3/3YkNDcKgoZj0hR945tKyJxbcMA4o891KlTtkTxikfSIhRJQ6AI
         n9sGnHyAoPGhvOUfC36EpEQzj0R/I3uAxt3cXbcgZumG78IQeO4vMxFbdNoykiA/3gJs
         N6cPZe1rzQMKFkhmesKqw/CDzZFaLEaE+h0GO0xsDcLGgU33NZJXHIgzPmEu2gsMVlby
         YuHUiWEXu125PEP4W0wsU7x89E7/soJSWAIRC3T2XKToHmsLYR576YwRRmX2d17EC2y9
         CjfA==
X-Gm-Message-State: AOAM5315f7mPIS0KuKuitJQYpkpe6vq8hkXfsRNtZuj+9dd0XqAmmD4z
        gINyh1KhKSw4yaqL9S02cpWDKg==
X-Google-Smtp-Source: ABdhPJyVIrAPQpIxRXmjmHQjE2YcFo7ZTjhqOd5uEeL0wph2NJoVYiyBQKvoqKz5rJDgfrWjFJZHjg==
X-Received: by 2002:a92:c7a6:: with SMTP id f6mr6515299ilk.55.1617402276371;
        Fri, 02 Apr 2021 15:24:36 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p4sm952525ile.57.2021.04.02.15.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 15:24:36 -0700 (PDT)
Subject: Re: [PATCH] firmware_loader: Remove unnecessary conversion to bool
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1613639529-41139-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <27640831-b996-93f0-4a4f-5b5d2ae24554@linuxfoundation.org>
Date:   Fri, 2 Apr 2021 16:24:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1613639529-41139-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/21 2:12 AM, Jiapeng Chong wrote:
> Fix the following coccicheck warnings:
> 
> ./tools/testing/selftests/firmware/fw_namespace.c:98:54-59: WARNING:
> conversion to bool not needed here.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   tools/testing/selftests/firmware/fw_namespace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
> index 5ebc1ae..0e393cb 100644
> --- a/tools/testing/selftests/firmware/fw_namespace.c
> +++ b/tools/testing/selftests/firmware/fw_namespace.c
> @@ -95,7 +95,7 @@ static bool test_fw_in_ns(const char *fw_name, const char *sys_path, bool block_
>   		}
>   		if (block_fw_in_parent_ns)
>   			umount("/lib/firmware");
> -		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;

This looks right to me. test_fw_in_ns() returns true or false and
test_fw_in_ns() callers print appropriate message.

I don't think this patch is necessary.

thanks,
-- Shuah
