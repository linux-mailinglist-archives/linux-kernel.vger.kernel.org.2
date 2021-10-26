Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A4743B892
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbhJZRtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbhJZRtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:49:52 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C473C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:47:28 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id w15so108803ilv.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C9tFGpLMa5xrDmXDxO7ju81p1Vqq09mwTmj1zWjZSPA=;
        b=WrpIcyns/rrvy6sy/Uu4SBiLUFp4VSA19rXS16RPf7+hIvg2l9cLNyCz8gUu9s1s4I
         EZmCdP3BHLTSNgYGw8rynX43/r0qkv7Dv8M/hYGXq4ym2mR/A7DYzukfrShsqYIrj6NS
         uDb9JzSmUZaovLW0n2H5mJMXIGUNz/ao41mCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C9tFGpLMa5xrDmXDxO7ju81p1Vqq09mwTmj1zWjZSPA=;
        b=vAW3NTwTqaWMTvz8ftuC9ifFfP/ADrhYVuHDEBvvXtzlf0eqfqh1nheOKDa/bEAGmh
         vbwsbEO2DEE2WVbqHNff4yh+MtvQl+4y0FMr1f/5ILlpFMvxIgxZ7u4Y/roY43/58JM4
         fKDdQndfoJM+p3rfKIq2Pf2zfhNGHnDrqLGMiUYwJQc+wZEhb84gt2ku7rdK16D6av0e
         QMcu0fF1RN5XAqe0USoESgerZa0MczGjR51526FfrubT1LX8fKIOfakg79KJ43QrVbDn
         nsxtNWVxGQ9rpc3QzPRBKRcG9KRoqpdM4unvGlj2vgNHLKoE1ZVMx0Qi/KFLEEdMNL16
         4Gpg==
X-Gm-Message-State: AOAM532juVKqpKS3j0eNLzELfniQKQT+X7pv/vS6Lu/cgyLsRrt7VO/o
        KArvMUZHsFd0YyW2H0bbHgspE9GExPbZ4w==
X-Google-Smtp-Source: ABdhPJyZfrtMqU0bdcrMtX289RaYYgKkZvZ/cXE7jIlL4iq8P59U1UkVLcFOaycwBEOBddApgReW4w==
X-Received: by 2002:a92:ca07:: with SMTP id j7mr15141191ils.119.1635270447357;
        Tue, 26 Oct 2021 10:47:27 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r24sm10467666ioa.5.2021.10.26.10.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 10:47:26 -0700 (PDT)
Subject: Re: [PATCH] selftests/bpf: fix fclose/pclose mismatch
To:     Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211026143409.42666-1-andrea.righi@canonical.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ce41c5da-2952-e800-54be-51cbcc7a0ada@linuxfoundation.org>
Date:   Tue, 26 Oct 2021 11:47:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211026143409.42666-1-andrea.righi@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/21 8:34 AM, Andrea Righi wrote:
> Make sure to use pclose() to properly close the pipe opened by popen().
> 
> Fixes: 81f77fd0deeb ("bpf: add selftest for stackmap with BPF_F_STACK_BUILD_ID")
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>   tools/testing/selftests/bpf/test_progs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index cc1cd240445d..e3fea6f281e4 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -370,7 +370,7 @@ int extract_build_id(char *build_id, size_t size)
>   
>   	if (getline(&line, &len, fp) == -1)
>   		goto err;
> -	fclose(fp);
> +	pclose(fp);
>   
>   	if (len > size)
>   		len = size;
> @@ -379,7 +379,7 @@ int extract_build_id(char *build_id, size_t size)
>   	free(line);
>   	return 0;
>   err:
> -	fclose(fp);
> +	pclose(fp);
>   	return -1;
>   }
>   
> 

Thank you for the patch. The return logic could be simpler
doing out handling common for error and success path with
just one call to close. Not related to this change though.

Adding bpf maintainers to the thread

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
