Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF937367AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbhDVHWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:22:17 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:41859 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhDVHWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:22:16 -0400
Received: by mail-lj1-f177.google.com with SMTP id a36so39822880ljq.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pDaAFuXUEertZiBCHAp1PuYV0pRWy0jbR7PjXIJm+sE=;
        b=ayAm+pYgydMjvNwN+G2bTnVmsGYn5iFjMhWcG4E6Iggb/qrAXdNSqvOpmTCaKrkCiT
         vCxkv1uJAtsf34WRUodvXVTFBV8IEzT90CfENqyhyB72Gl57pCbysb5LK6B5IK1xh28E
         cSO9Q6HFuEEyzDMf/fIk8prSvIuoq1uaVAPW6cRN1YSMgwY7mFvXObIF/PUXK6Eij9w6
         0Hlntfu4oNnt/Ph9Wx9m/1aWrnX75p1l2rjbxsrUQr6LSFaBEAhNNSUmzVrkk2Bkr5SO
         Rnm2lcF25WJNsZnmpdQTrV6RD8TUw4zh99AtuQLRYJWG6YepLn7SdvOS45aq3MbPzpNQ
         XEIw==
X-Gm-Message-State: AOAM530eUvFIhFewzGVaO9KRY58tyv61pFojBUUxDaXRn1iXqGsRkGEs
        hxd+dW9MFan26fDx31osYoTLz85xdUw=
X-Google-Smtp-Source: ABdhPJyifRabgItOEitCRRqzrNjT2242f3UXCTuSIaLkThcXG8ZUgiGyxl/jwgQ7H7YF0Tgcnp6RvA==
X-Received: by 2002:a2e:8055:: with SMTP id p21mr1576435ljg.102.1619076100976;
        Thu, 22 Apr 2021 00:21:40 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id d15sm180968lfn.117.2021.04.22.00.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 00:21:40 -0700 (PDT)
Subject: Re: [PATCH] coccinelle: misc: minmax: suppress patch generation for
 err returns
To:     julia.lawall@inria.fr
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
References: <20210409111902.7561-1-efremov@linux.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <30d69ef1-6a6e-ee96-fa27-2d9d2ad8da48@linux.com>
Date:   Thu, 22 Apr 2021 10:21:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210409111902.7561-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On 4/9/21 2:19 PM, Denis Efremov wrote:
> There is a standard idiom for "if 'ret' holds an error, return it":
> 	return ret < 0 ? ret : 0;
> 
> Developers prefer to keep the things as they are because stylistic
> change to "return min(ret, 0);" breaks readability.
> 
> Let's suppress automatic generation for this type of patches.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  scripts/coccinelle/misc/minmax.cocci | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
> index eccdd3eb3452..fcf908b34f27 100644
> --- a/scripts/coccinelle/misc/minmax.cocci
> +++ b/scripts/coccinelle/misc/minmax.cocci
> @@ -116,16 +116,32 @@ func(...)
>  	...>
>  }
>  
> +// Don't generate patches for errcode returns.
> +@errcode depends on patch@
> +position p;
> +identifier func;
> +expression x;
> +binary operator cmp = {<, <=};
> +@@
> +
> +func(...)
> +{
> +	<...
> +	return ((x) cmp@p 0 ? (x) : 0);
> +	...>
> +}
> +
>  @pmin depends on patch@
>  identifier func;
>  expression x, y;
>  binary operator cmp = {<=, <};
> +position p != errcode.p;
>  @@
>  
>  func(...)
>  {
>  	<...
> --	((x) cmp (y) ? (x) : (y))
> +-	((x) cmp@p (y) ? (x) : (y))
>  +	min(x, y)
>  	...>
>  }
> 
