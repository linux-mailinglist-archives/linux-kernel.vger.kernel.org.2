Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1B44369D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 19:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhJUR5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 13:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbhJUR5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:57:46 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B9EC0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 10:55:30 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id y67so2063766iof.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2LtkF/468p93Y4YoTGIHUn5Ubw3qEnn8ZhP9111mEls=;
        b=X/JmnOR/qbdUlbj2jQFETd5boe5ncFPn05fdeq4gJ5mtxo14/HKHAjG2nJUb/nLG3P
         irihOf2cNrOT93p2TbTfrGdyu9G2GFbmlfTMRYlo7oy2jU4MVqE4oS4ZJs6BkaU7G0ok
         UkjkEoI8Wi6Gjw6p3N8H0JUeDE+aCJ2cQch0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2LtkF/468p93Y4YoTGIHUn5Ubw3qEnn8ZhP9111mEls=;
        b=odQ2TT+E2/0E65cFrW00lnXl1Ow6m0rB2E7FFF0ieQE3Kd3Ick1XJFwz/B2rjF4ZAy
         WHw/dxRBYoZbyl3xywPtGnmrKcncr8ifycIGJMLgD3sOZhF+7IfgIliFqSfby5XByslS
         bgrPTLnKoav1KqXdi4q0WR3fDz9mE5URKnX3aEZC1ieFOwqSXll9PgEWzLi0kV5t7KgR
         1Zyf+BzSEttAKFch8MSGL/qyu4k0vQq94Biol8FtDsAdY19uqPcaHdLQBtplZ0j2xXW/
         B2Ii9nYHjBcyd0RBlo6EcGN0M4e7Bhb47bbLiv+Qo50R1Eyqr0UKPMxMGx2w+C47QCJ3
         bAMA==
X-Gm-Message-State: AOAM530w0Xb5/rbp+GUrJHEaYJIX6X6lnO6n/L49oKdSgbiQTFMMiCeu
        rwDzJQTwhM7PE5rWLhxV5wysuw==
X-Google-Smtp-Source: ABdhPJy+Wc9KJqoNlxn4zBV85qrxZqyAU6YUhnEumlEloTAcXF62H2S8Zf8JHrR/fQ1l/G0gb2qcDw==
X-Received: by 2002:a05:6602:2d81:: with SMTP id k1mr5077114iow.87.1634838930227;
        Thu, 21 Oct 2021 10:55:30 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c5sm3018346ilq.71.2021.10.21.10.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 10:55:29 -0700 (PDT)
Subject: Re: [PATCH] selftests: kvm: fix mismatched fclose() after popen()
To:     pbonzini@redhat.com, shuah@kernel.org
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211021175335.22241-1-skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <407e0a02-f7c3-f429-6e7d-3a60a14e09fa@linuxfoundation.org>
Date:   Thu, 21 Oct 2021 11:55:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211021175335.22241-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/21 11:53 AM, Shuah Khan wrote:
> get_warnings_count() foes fclose() using File * returned from popen().

Oops should have been "does". Sending v2 with that change now.

> Fix it to call pclose() as it should.
> 
> tools/testing/selftests/kvm/x86_64/mmio_warning_test
> x86_64/mmio_warning_test.c: In function ‘get_warnings_count’:
> x86_64/mmio_warning_test.c:87:9: warning: ‘fclose’ called on pointer returned from a mismatched allocation function [-Wmismatched-dealloc]
>     87 |         fclose(f);
>        |         ^~~~~~~~~
> x86_64/mmio_warning_test.c:84:13: note: returned from ‘popen’
>     84 |         f = popen("dmesg | grep \"WARNING:\" | wc -l", "r");
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>   tools/testing/selftests/kvm/x86_64/mmio_warning_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
> index 8039e1eff938..9f55ccd169a1 100644
> --- a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
> @@ -84,7 +84,7 @@ int get_warnings_count(void)
>   	f = popen("dmesg | grep \"WARNING:\" | wc -l", "r");
>   	if (fscanf(f, "%d", &warnings) < 1)
>   		warnings = 0;
> -	fclose(f);
> +	pclose(f);
>   
>   	return warnings;
>   }
> 

thanks,
-- Shuah
