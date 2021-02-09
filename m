Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D16314481
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBIAGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhBIAGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:06:35 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F15C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 16:05:54 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id d6so14522658ilo.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 16:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D+JW4r8pTJlLgsQxsftKbDGzE9cRSTF0BCzWfgQnJsY=;
        b=Sw/GSfb+67E3XTVBowZnNz8mfUQOg+op6Of9TkfDbcNN3dniq3usP+22A5adCO+9IU
         sfjAAe+XIrue1LfeWdDpAnS3y4ejnOIQNK02cOv4FMMLZ6g9JErka+dGrmcVQCqS0LC3
         mIqjupApGG6SRBj6mMKyRwENh+rgfosax00xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D+JW4r8pTJlLgsQxsftKbDGzE9cRSTF0BCzWfgQnJsY=;
        b=oK9vbQOE30gSaIgsORqPPxEg7rhjaLjpS1ZY8fnoh9J+V1wL9m6WDZISE2s0w+w+a9
         jgkEjaw1qhFpUHu6UKT7Uv0K3sfT05JotMvM4JmuPtHK9+B6hTybL/m5ZNUiJf0h+g1r
         wS2BRWkUC8nhBxiZ+vNGOE/B2M87w4VXZi2/DI5pvLx9Ia+W/ogazPuUdI2XRL8xDeFJ
         aprl7kwgFH9V7l4VBxAN6lIJnGt6Vs7XxHRuI0egHA6BuWHGtZGeN6slhc1GdP5p9dwH
         5xtM5zUezbHZP6skoRqnnoN7pN6qRvIcS7A0vzhsqofuA64k6ohcDoeIqArQlD0OtYw5
         CIQw==
X-Gm-Message-State: AOAM532zzOcV/6dbQpX5w6GXMoHnaHiG2KWgUjYf/ShgLoDG3H7GEPOu
        nt4Cvi+w73TswATD4TAEtuMjwQkfetFwWg==
X-Google-Smtp-Source: ABdhPJz8srdN1yJB3EilIXwJ8vTEW9ame8knk491Ai8fNhZX+DUsEDNr01tKzX3e8mrocPrYyVPWJw==
X-Received: by 2002:a05:6e02:1c0f:: with SMTP id l15mr17563877ilh.21.1612829153582;
        Mon, 08 Feb 2021 16:05:53 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u17sm9769398ioc.23.2021.02.08.16.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 16:05:53 -0800 (PST)
Subject: Re: [PATCH] selftests: breakpoints: Use correct error messages in
 breakpoint_test_arm64.c
To:     Tiezhu Yang <yangtiezhu@loongson.cn>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1612506839-27225-1-git-send-email-yangtiezhu@loongson.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <db7c4310-503b-f84f-99a6-0d8d58da99b6@linuxfoundation.org>
Date:   Mon, 8 Feb 2021 17:05:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1612506839-27225-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 11:33 PM, Tiezhu Yang wrote:
> When call ptrace(PTRACE_CONT, ...) failed, use correct error messages.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   tools/testing/selftests/breakpoints/breakpoint_test_arm64.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
> index ad41ea6..e704181 100644
> --- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
> +++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
> @@ -145,7 +145,7 @@ static bool run_test(int wr_size, int wp_size, int wr, int wp)
>   
>   	if (ptrace(PTRACE_CONT, pid, NULL, NULL) < 0) {
>   		ksft_print_msg(
> -			"ptrace(PTRACE_SINGLESTEP) failed: %s\n",
> +			"ptrace(PTRACE_CONT) failed: %s\n",
>   			strerror(errno));
>   		return false;
>   	}
> @@ -159,7 +159,7 @@ static bool run_test(int wr_size, int wp_size, int wr, int wp)
>   	}
>   	alarm(0);
>   	if (WIFEXITED(status)) {
> -		ksft_print_msg("child did not single-step\n");
> +		ksft_print_msg("child exited prematurely\n");
>   		return false;
>   	}
>   	if (!WIFSTOPPED(status)) {
> 

Thank you. Applied to linux-kselftest next for 5.12-rc1

thanks,
-- Shuah
