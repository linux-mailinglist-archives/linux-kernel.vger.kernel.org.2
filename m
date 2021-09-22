Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD33414D79
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 17:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbhIVPyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37778 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236486AbhIVPye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632325983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QNIWP0d0RzgTdX2p+hapRwTwiak0Hv/aQlwyrA7gHog=;
        b=Us6CdL0XydSomy+j++XZtnYVrrujDP2Pcvmuv+C6XMclDkWMX8KmVUWFvcYb7dAaYfNqbQ
        3g5eHFYNk4GFs90a5Uj2gaOZgu440hKSTQYyHlnEy74UNZT/EkWrU7lzMlzRUgAYPryqb5
        dS+DKbjAXAhI3g3Guq5GrxLp6KhJIVA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-mWqSpcnIOO6hYmOgd5ASuQ-1; Wed, 22 Sep 2021 11:53:00 -0400
X-MC-Unique: mWqSpcnIOO6hYmOgd5ASuQ-1
Received: by mail-qt1-f200.google.com with SMTP id r11-20020ac86d2b000000b002a688ea1f4bso9890817qtu.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 08:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QNIWP0d0RzgTdX2p+hapRwTwiak0Hv/aQlwyrA7gHog=;
        b=0i186jBM5ZECvs6+XuoA5avv1hWBpUL9OVMdsAU8DAb6mD9gR9EP4q9zFR0jNoFsht
         yNZNyWQbhKgyw20A3BarF9h3QgWJoBSSJUtnmcIxaHDJ8vG0NT2bXAb7eIGdpOnvEAts
         cFJRqFcVfeuUTLL+0Oh/zAf1ATumYKIaygAfveeCRopkzRuZjfazGsR2m2UubCbhOJDr
         UgtaR+PrmAxa0gM4Wzj7RCoUUhIbj6uwbVIRTDjiKCZvSSsSDNLE0A0muMaZmY4b7vzB
         PT6yDOHYJ00ASLgMgOo7zNouCcQx9C8oSvOB6PjBxcYr3R+oj1rn5pz5NLElemonMDVI
         CxpA==
X-Gm-Message-State: AOAM531LwnvL+ijP0ug4u/fEH2juSsIYj59FOWrOHuuEVSHup/kfvYnR
        /T+92MB4UUT8ZNdKx0RXFZrwPf4T6SXDwmjsdLEcauCg2cauVSlaqYKI+TyzGb/S6gGH1aWjUb5
        ywKBjALleWEq78ctZkKxE+H2p
X-Received: by 2002:a05:6214:12ec:: with SMTP id w12mr553008qvv.48.1632325980018;
        Wed, 22 Sep 2021 08:53:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlAIybjuGUN4ANXueEhN4IL/DlV0u82GnLUemzbSu3zv0XuFRCyPP4TmZELnmsssaTJlYZWA==
X-Received: by 2002:a05:6214:12ec:: with SMTP id w12mr552984qvv.48.1632325979726;
        Wed, 22 Sep 2021 08:52:59 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id v24sm2034776qkv.11.2021.09.22.08.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 08:52:59 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/ww-mutex: Fix uninitialized use of ret in
 test_aa()
To:     Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "kernelci.org bot" <bot@kernelci.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20210922145822.3935141-1-nathan@kernel.org>
Message-ID: <27e08098-83b6-2238-59c1-3b38cd042a31@redhat.com>
Date:   Wed, 22 Sep 2021 11:52:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922145822.3935141-1-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/21 10:58 AM, Nathan Chancellor wrote:
> Clang warns:
>
> kernel/locking/test-ww_mutex.c:138:7: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>                  if (!ww_mutex_trylock(&mutex, &ctx)) {
>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> kernel/locking/test-ww_mutex.c:172:9: note: uninitialized use occurs here
>          return ret;
>                 ^~~
> kernel/locking/test-ww_mutex.c:138:3: note: remove the 'if' if its condition is always false
>                  if (!ww_mutex_trylock(&mutex, &ctx)) {
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> kernel/locking/test-ww_mutex.c:125:9: note: initialize the variable 'ret' to silence this warning
>          int ret;
>                 ^
>                  = 0
> 1 error generated.
>
> Assign !ww_mutex_trylock(...) to ret so that it is always initialized.
>
> Fixes: 12235da8c80a ("kernel/locking: Add context to ww_mutex_trylock()")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1463
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>   kernel/locking/test-ww_mutex.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
> index d63ac411f367..353004155d65 100644
> --- a/kernel/locking/test-ww_mutex.c
> +++ b/kernel/locking/test-ww_mutex.c
> @@ -135,7 +135,8 @@ static int test_aa(bool trylock)
>   			goto out;
>   		}
>   	} else {
> -		if (!ww_mutex_trylock(&mutex, &ctx)) {
> +		ret = !ww_mutex_trylock(&mutex, &ctx);
> +		if (ret) {
>   			pr_err("%s: initial trylock failed!\n", __func__);
>   			goto out;
>   		}
>
> base-commit: 12235da8c80a1f9909008e4ca6036d5772b81192

I was a bit confused by this patch at the beginning and then realized 
that it was supposed to be applied on top of the tip true, not the 
current mainline kernel.

Anyway, it looks good to me

Acked-by: Waiman Long <longman@redhat.com>

