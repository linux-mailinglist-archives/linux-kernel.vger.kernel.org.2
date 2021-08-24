Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8123F60B4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbhHXOly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237824AbhHXOlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:41:53 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1707C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:41:08 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id g9so26648814ioq.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ESf4F3FzREnNXnHRptficZqDb9QX9TZxnF/j1oA0PVc=;
        b=BRhUuPYTbFMaTDz08ZYIBu0n7s2FTa5SkwhZTi8btNkZUHdeLS8WBpbAiS9AmLfd8F
         gtJ3GVTkRhdr0B18AyUP8Ej1ZwWg1bb4+ipjlyeW2ewWWrvTOpzkmRLLWPW3awzTIIca
         n9JIRZqfMfxp341z39mr98XC4QeKsrO3+f1pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ESf4F3FzREnNXnHRptficZqDb9QX9TZxnF/j1oA0PVc=;
        b=JaJvEPn43WDBRvbnpqtPvOuEYsjqOsXG3PaOU94DygnQdRmRubNydBzQX3kNNv8DVQ
         /YZSwRX4hzPXAzfQG05SV78j8zVz8WHcQjUzAiYke7uMg3d2qJTWkuX+CvPkhT80f5/5
         uc//udsRrDIe+ON9qMc7fZ9Sr3+NFHy4HfyBBf03Geh4DSL8YGDgPpFsGSm8Lrxbtj2Y
         zdcroCQ+PobUJI4QjSu7OtbcFzyZOuAjoRCz9BFJNRGVSuoz9LiqMEw6Q9tYfU31QaQu
         +Wk6vUVP5m2pdk0P9W+C2y6669MfULsqcQLaS+p77/lflnBxOrBV5o3/I2G6h7W0Ehoz
         bJig==
X-Gm-Message-State: AOAM532wdE/Z0Qsc3UYdFIvovx9T8bcEn9he4iO2NgsoJyLN/cXh5tsh
        6fDkvNE4w78z1uL5vXhC2Csl1w==
X-Google-Smtp-Source: ABdhPJw8Y2SS+wEpAjY3wsltZG4IacYAkBzd7VPVJ8MdJMZpPGoTs/8iQEa8N7g0Pco/+HlqcrsMrw==
X-Received: by 2002:a5d:8744:: with SMTP id k4mr32135949iol.9.1629816068411;
        Tue, 24 Aug 2021 07:41:08 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h10sm9875020ilj.71.2021.08.24.07.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 07:41:08 -0700 (PDT)
Subject: Re: [PATCH linux-next] tools:mount: Remove unnecessary conversion to
 bool
To:     CGEL <cgel.zte@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210820033241.13136-1-jing.yangyang@zte.com.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <02237efa-5159-f95d-43c9-389a95803a50@linuxfoundation.org>
Date:   Tue, 24 Aug 2021 08:41:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210820033241.13136-1-jing.yangyang@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/21 9:32 PM, CGEL wrote:
> From: jing yangyang <jing.yangyang@zte.com.cn>
> 
> Suppress following warning from coccinelle:
> 
> ./tools/testing/selftests/mount/unprivileged-remount-test.c:285:54-59: WARNING conversion to bool not needed here
> ./tools/testing/selftests/mount/unprivileged-remount-test.c:207:54-59: WARNING conversion to bool not needed here
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
> ---
>   tools/testing/selftests/mount/unprivileged-remount-test.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
> index 584dc6b..bc802f6 100644
> --- a/tools/testing/selftests/mount/unprivileged-remount-test.c
> +++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
> @@ -204,7 +204,7 @@ bool test_unpriv_remount(const char *fstype, const char *mount_options,
>   		if (!WIFEXITED(status)) {
>   			die("child did not terminate cleanly\n");
>   		}
> -		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
> +		return WEXITSTATUS(status) == EXIT_SUCCESS;
>   	}
>   
>   	create_and_enter_userns();
> @@ -282,7 +282,7 @@ static bool test_priv_mount_unpriv_remount(void)
>   		if (!WIFEXITED(status)) {
>   			die("child did not terminate cleanly\n");
>   		}
> -		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
> +		return WEXITSTATUS(status) == EXIT_SUCCESS;
>   	}
>   
>   	orig_mnt_flags = read_mnt_flags(orig_path);
> 

We can't accept this patch. The from and Signed-off-by don't match.

thanks,
-- Shuah
