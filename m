Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE453144E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhBIA05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhBIA0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:26:42 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EFCC061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 16:26:02 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id l5so658546ooj.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 16:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=geDPyuQrhQqGciyT8KbCFy+HStqkc+qlNKx860u+QQM=;
        b=VnMO4QIgivtfjgv9F7XjowfcSbqutW48OQDTquhpDAwGqxyGqqkmf4VDIDC8SsJmDT
         wJkbF/AFGwSS++PPBMuWbjAPzVrWXOaFut5JpBWAmlbJtylIw+XrYFWSncn4m4FydlrA
         5j7jQheue3Jw2LkfzbuCf/rRaJHV39WBC/Hz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=geDPyuQrhQqGciyT8KbCFy+HStqkc+qlNKx860u+QQM=;
        b=XUP0csjzSu/AzZrV1tBBWPv1VBt92L/2Mf6EXthXbgtE6ryuYiIS8TbGSDdZlIgCdz
         eZ4hie8pBOGf+myJQI1c59QwLE2JQ4ROdXkPrbRYKeen/v+4WImM75lYyCS4rc3P+28w
         b1V4uuLBNXRNFpvDIpo5UeBhO9k5jHoxHe0i72f+54vO9AB9w0SgUHQhZ7LI5dzSFhA8
         tTw4lkP7bxzyGo0RGiqTLrt5VO3c8ecVDvCspxydZiJ2V3JwWHIjgqYFd9nrLG3eB3Uf
         cI97zF4s6nsUJ9EwLz8e2jzEs9J+k8gqxhjxq8yFB4RXrtdoGwKQQuyw+Q8TYEFxFVQO
         SmVQ==
X-Gm-Message-State: AOAM530hWmO4QeQ+pPADl2wD5dXnWECQ7IEBRiQK61dS1UkJ9m3Cod+o
        aZ5j3yX4aQgprgLgqenKCc9gD8asrWNIwA==
X-Google-Smtp-Source: ABdhPJxhacjnA1yueduYkm4BMZau0fWMW54sMmfzHyHfFjbsXgMEvGRakjUuGHekSuXIhr0p7mLUkg==
X-Received: by 2002:a05:6820:255:: with SMTP id b21mr14361339ooe.0.1612830361464;
        Mon, 08 Feb 2021 16:26:01 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g11sm4040413oif.9.2021.02.08.16.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 16:26:00 -0800 (PST)
Subject: Re: [PATCH] selftests/timens: add futex binary to .gitignore
To:     Tobias Klauser <tklauser@distanz.ch>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201218165651.4538-1-tklauser@distanz.ch>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <76b61adc-f585-3891-024d-2c496877a89a@linuxfoundation.org>
Date:   Mon, 8 Feb 2021 17:26:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20201218165651.4538-1-tklauser@distanz.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/20 9:56 AM, Tobias Klauser wrote:
> Add the futex test binary introduced by commit a4fd8414659b
> ("selftests/timens: Add a test for futex()") to .gitignore.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>   tools/testing/selftests/timens/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
> index 2e43851b47c1..fe1eb8271b35 100644
> --- a/tools/testing/selftests/timens/.gitignore
> +++ b/tools/testing/selftests/timens/.gitignore
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   clock_nanosleep
>   exec
> +futex
>   gettime_perf
>   gettime_perf_cold
>   procfs
> 

Thank you. Applied to linux-kselftest next for 5.12-rc1

thanks,
-- Shuah
