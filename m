Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A89B3472E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhCXHnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:43:31 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:40736 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhCXHnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:43:06 -0400
Received: by mail-lj1-f170.google.com with SMTP id u10so28987114lju.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 00:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FWlu5K9gEFDGnnILojK8GPw7KEusUZckkU+/bB/ppV0=;
        b=mmp12Q6BdZj6QnhVDppl5IpUHKUETUjXjydcb/8W+2pK/78NNbH7lea31BBNYt3OjN
         2CTzfQKSfSkc1GN0z8RBepjf+bA+gE3wqURG3u46OgTvGz/ZddVZ9qRhD1BJs0yk9En2
         EWwHxYWWVcksCVi1UfKZ/ZBQvDQ/FENUjjvYNiPcygO7Pt1/KoowxkbZuStgdENVXY6i
         IrdFnc54kOffQxjxsJwD89FTA9gGowW3bFCXiyw4B2gCz2KjLcMDC2GRbMwC5aXotLKL
         zK+QE0jxGv6Z8sErZFkMKIIz4e1lQxFUy/iZbQlGrtzKVzFQ4cdTmLXZyK6ayZ7lSBsD
         xYIQ==
X-Gm-Message-State: AOAM530Qvrcmcn9Wym1lE+iUEUBN8Nol02oG7iCZYhjSzy1jHg66SLWy
        3QbsbTmaXrYNCtuXjZyp2qYzfR1n8x1OpQ==
X-Google-Smtp-Source: ABdhPJwjDQuxFJVLWCu2OKlUbV5OL1DIDnyrunEpVug2wlobpe5GVKE5RJ2DJrqm8MKxF31Q0qg4+Q==
X-Received: by 2002:a05:651c:ca:: with SMTP id 10mr1252808ljr.63.1616571784781;
        Wed, 24 Mar 2021 00:43:04 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id p10sm145901lfo.293.2021.03.24.00.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 00:43:04 -0700 (PDT)
Subject: Re: [PATCH] coccinelle: misc: restrict patch mode in
 flexible_array.cocci
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
References: <20210308191215.1362498-1-efremov@linux.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <212e0bf3-0807-e2f1-a6fc-23f9e03906b2@linux.com>
Date:   Wed, 24 Mar 2021 10:43:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210308191215.1362498-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On 3/8/21 10:12 PM, Denis Efremov wrote:
> Skip patches generation for structs/unions with a single field.
> Changing a zero-length array to a flexible array member in a struct
> with no named members breaks the compilation. However, reporting
> such cases is still valuable, e.g. commit 637464c59e0b
> ("ACPI: NFIT: Fix flexible_array.cocci warnings").
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  scripts/coccinelle/misc/flexible_array.cocci | 23 ++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/coccinelle/misc/flexible_array.cocci b/scripts/coccinelle/misc/flexible_array.cocci
> index 947fbaff82a9..f427fd68ed2d 100644
> --- a/scripts/coccinelle/misc/flexible_array.cocci
> +++ b/scripts/coccinelle/misc/flexible_array.cocci
> @@ -51,21 +51,40 @@ position p : script:python() { relevant(p) };
>    };
>  )
>  
> +@only_field depends on patch@
> +identifier name, array;
> +type T;
> +position q;
> +@@
> +
> +(
> +  struct name {@q
> +    T array[0];
> +  };
> +|
> +  struct {@q
> +    T array[0];
> +  };
> +)
> +
>  @depends on patch@
>  identifier name, array;
>  type T;
>  position p : script:python() { relevant(p) };
> +// position @q with rule "only_field" simplifies
> +// handling of bitfields, arrays, etc.
> +position q != only_field.q;
>  @@
>  
>  (
> -  struct name {
> +  struct name {@q
>      ...
>      T array@p[
>  -       0
>      ];
>    };
>  |
> -  struct {
> +  struct {@q
>      ...
>      T array@p[
>  -       0
> 
