Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FDF3F60AD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbhHXOlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237956AbhHXOlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:41:07 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3987C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:40:23 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e186so26600963iof.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MlxQ/FXwdBOfX5eLPJCYquGl9l7ouOdRIS8ahpzDdNo=;
        b=Kle4Ul3Djry6em/SvyRGFcj5kbH6ZcsFWrY3XTFBxaevzheGuFx+aHitt121nBM5zm
         WC8LJnCcJDUnzo9AT2N+5Y9mPJ4RgYcRoRhT6PDjT31LMbvNMzJift4T6t0HLgsKM2e/
         XQIlAsDzvJB+HtX0ILdz50Q3dNv3oBrsXf/zU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MlxQ/FXwdBOfX5eLPJCYquGl9l7ouOdRIS8ahpzDdNo=;
        b=FsI+m2nTfo1r5b9wKtuuT9+7J3rYN24/uKfgJtU8QKOQYxhP9+kfAZtzAzZ4a4qgjA
         vVcruCORwYOL8z5k8YxYjF9BzdgsdxqtWGE2Ied32zdEg9FUt+ls0cQ//t0IKZwbeuHb
         2c/xig2KUNtwagB2M5BwTiII0o44+trSQv0RgvNF8XXMrDTWmaB8Z5AUGZIrkXChAX3N
         7eDW1orIkHZp0YfcRhzKYIAi5glBi4v0CP9hMAf2iIxuiF94cgoiKOuV6lE1oMVNPAXy
         Z1Y/O8KkIu8ztgkAx9nQyJQvgRWt0rD09uIRSYkh/jA9Pz6NCZCxfTJd7LXdakrr9Dqv
         7SoQ==
X-Gm-Message-State: AOAM532EhLh7QlUPKh013fdpZvU44cJJ5Zcjctl8PZZRCbJm5CrbqvHQ
        kOLPBPP+PXSaW7iCkN4xAjkHJA==
X-Google-Smtp-Source: ABdhPJzoFdwhVYDK/nXholA1lAkn+/F3l/iFm8wLNNplf9lVgIfHDTSU79VUNkzsfmoUsBaYq8KWsw==
X-Received: by 2002:a5d:928c:: with SMTP id s12mr31161317iom.151.1629816023338;
        Tue, 24 Aug 2021 07:40:23 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k7sm9990002iok.22.2021.08.24.07.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 07:40:22 -0700 (PDT)
Subject: Re: [PATCH linux-next] powerpc/tm: remove duplicate include in
 tm-poison.c
To:     cgel.zte@gmail.com, mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, shuah@kernel.org,
        yong.yiran@zte.com.cn, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
References: <20210805065255.628170-1-yong.yiran@zte.com.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c5e9900b-1c2d-8e72-ad83-a6024b876fd2@linuxfoundation.org>
Date:   Tue, 24 Aug 2021 08:40:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210805065255.628170-1-yong.yiran@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/21 12:52 AM, cgel.zte@gmail.com wrote:
> From: yong yiran <yong.yiran@zte.com.cn>
> 
> 'inttypes.h' included in 'tm-poison.c' is duplicated.
> Remove all but the first include of inttypes.h from tm-poison.c.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: yong yiran <yong.yiran@zte.com.cn>
> ---
>   tools/testing/selftests/powerpc/tm/tm-poison.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/powerpc/tm/tm-poison.c b/tools/testing/selftests/powerpc/tm/tm-poison.c
> index 29e5f26af7b9..27c083a03d1f 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-poison.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-poison.c
> @@ -20,7 +20,6 @@
>   #include <sched.h>
>   #include <sys/types.h>
>   #include <signal.h>
> -#include <inttypes.h>
>   
>   #include "tm.h"
>   
> 

We can't accept this patch. The from and Signed-off-by don't match.

thanks,
-- Shuah
