Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33B445003B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhKOItw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:49:52 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:36120
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230060AbhKOIq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:46:29 -0500
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5AEAD3F1A1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 08:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636965808;
        bh=0oqdKTEInfxFxK9xa4c8vwLVD6X93UYR6ISSifrJI1s=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=qwOMJ+ZzpKkDSUW3m20hBbXU7FdZRXYhIxJrUHmQno8zZ1RiwC9nXpjZlOYJQ/L0p
         LDfgPc2JTiqzxXxLcZgiLEWeZcolfrdrt6mr77xVjoyK4qWxqtNAowzVa6NJq9c3Xu
         UUWCpf1Kmils2F2abnEGlssLL/yGJ1p/hHKj8Fd5L6Npp4kV5Xgakuy8zYIDS25P2x
         56+p9I9E7nY+N0bprvu1XkUX0U5Mj3hdA50kJGGPV4z0t3AishqVHla5LoWHe8Wo3/
         8SPF2jA41KTjLqi3KAb4/gqm6Y2ffDlSDmXVGrWtTnlIJAIt29T6eSTBlYJSR9hU6t
         ld+CeoQzNwatQ==
Received: by mail-lf1-f69.google.com with SMTP id g38-20020a0565123ba600b004036147023bso6499302lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0oqdKTEInfxFxK9xa4c8vwLVD6X93UYR6ISSifrJI1s=;
        b=D94zFjIA2hgE1UykPtn5up0C6I568PTLw1Ys/sV4Bifmj5C+m5tGqwLnlJ4KRmIYUZ
         4fxvThg8ka6xIHl8WGY6bvXm0PtMbENckgXqSFBreXhvC+6wTafxpyg8l5R5VRFfnAne
         +jn5uwNN6rr5RJYQ076pseM+gFOz04pfUAUzQi3hhCCJf9pQUCIlYGbRn3Hz4JGR2jNK
         rNmXuYrgFmcOMXxcLpAqeyfY6zB/noNcf4C7jWNmesyAmzQquPF6tVmqeJmOrdh4ygfy
         OWqpKDgzanwAaa0ZZJdGS51gi5NLkL7tBky0ukJAe9qoMgJyuHwzDmVhpTahgzWAy49n
         yL1g==
X-Gm-Message-State: AOAM532yhV0uv/eGx/E+HHUU1wrM0aBdHZm7Ue5iEzTdt29r3omTP08g
        Yi5oaKDDUVpne9QiGYM5JhyFL424+Bylg/H7squzv3pR1vVbOKPxgp8/D6cpGAw/jyL2tjfkrs4
        z9MZ/1A/2tv9iolurtgZnYoXorqx0HM46K11CDHAtGQ==
X-Received: by 2002:a2e:390c:: with SMTP id g12mr36658615lja.118.1636965807784;
        Mon, 15 Nov 2021 00:43:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAADM5AFPI2hdyvOqd5eY9jnktOJRIUfQWacRX0FQauEX9xiSejkjbB59+nLHMBHjzifbClQ==
X-Received: by 2002:a2e:390c:: with SMTP id g12mr36658597lja.118.1636965807598;
        Mon, 15 Nov 2021 00:43:27 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id n9sm1440454lji.131.2021.11.15.00.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 00:43:27 -0800 (PST)
Message-ID: <fa6a55a9-1c27-e9a8-739e-fd7ec34e3b76@canonical.com>
Date:   Mon, 15 Nov 2021 09:43:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] ARM: s3c: Fix typo in one comment
Content-Language: en-US
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211113031117.33727-1-wangborong@cdjrlc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211113031117.33727-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2021 04:11, Jason Wang wrote:
> The double `would' in the comment might be repeated. Remove one of them
> from the comment.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/arm/mach-s3c/mach-gta02.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c/mach-gta02.c b/arch/arm/mach-s3c/mach-gta02.c
> index 418939ce0fc3..174b2e55ea16 100644
> --- a/arch/arm/mach-s3c/mach-gta02.c
> +++ b/arch/arm/mach-s3c/mach-gta02.c
> @@ -393,9 +393,9 @@ static struct s3c2410_nand_set __initdata gta02_nand_sets[] = {
>  	[0] = {
>  		/*
>  		 * This name is also hard-coded in the boot loaders, so
> -		 * changing it would would require all users to upgrade
> -		 * their boot loaders, some of which are stored in a NOR
> -		 * that is considered to be immutable.
> +		 * changing it would require all users to upgrade their
> +		 * boot loaders, some of which are stored in a NOR that
> +		 * is considered to be immutable.
>  		 */

This is a legacy platform, bigger set of cleanups are accepted but a
patch which changes only one typo, is not. Especially that you change
here three lines for this simple one typo.

Please send a bigger cleanup for all of such issues or skip it.

Best regards,
Krzysztof
