Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6763A76EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 08:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhFOGPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 02:15:33 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:37408 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhFOGP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 02:15:29 -0400
Received: by mail-lj1-f182.google.com with SMTP id k8so6465914lja.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 23:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Qpjst8fUK2jK/roldcWP3QnKsbToK1R2ztKok4xwGQ=;
        b=FO7OyLBUqH9lVESxRW/FhgL+Bzro1rII7fOPt6HBd43A1JAmnAPYGDgO1GuvvatCpg
         1/xoUNV1rVZfjcqEerMYcZUgNAqUiMeyZuz97Kuhjao1HC5ozkBXMTIGR07Hxx9SONE5
         //7KOACDA+bpgyKJnXd/Uy96NTOE+v/PWygxbGHVifQAehWPh98aZXmUn3du3Clhik8C
         /fATFJ/Xtnb7CrIafQ3NRQc0JTckau0Bhyx2wVXsp0E5Jl6o8RqhSFWKst9evynLrON8
         3XF21CVuXLbZBg0g4sJ7ObrnaWr7tnbPCJefj027brgRT50rI+Lsu4JQfUVwe4H5Xa4Y
         2pmw==
X-Gm-Message-State: AOAM533Ti713L6asz87K7XQe46BdBBNDUvoh52MNPZGM8cGch4MT2acJ
        Y4xC5WQ2lBIqQ3fqHe+ZUw34I1vbcvM=
X-Google-Smtp-Source: ABdhPJy61jxmtBw0XcLrWVfWzZx3LpWmvmn1dWxC7JwkwTxy+YmL+tnJbTP9tl1DCKT/ec+kVBvCWw==
X-Received: by 2002:a05:651c:1202:: with SMTP id i2mr16183629lja.323.1623737603819;
        Mon, 14 Jun 2021 23:13:23 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id h12sm2049998ljg.59.2021.06.14.23.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 23:13:23 -0700 (PDT)
Subject: Re: [RESEND PATCH] coccinelle: misc: minmax: suppress patch
 generation for err returns
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
References: <20210428060350.57661-1-efremov@linux.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <6296d731-60d3-1ceb-226d-ded9d2d5a1f9@linux.com>
Date:   Tue, 15 Jun 2021 09:13:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210428060350.57661-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On 4/28/21 9:03 AM, Denis Efremov wrote:
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
