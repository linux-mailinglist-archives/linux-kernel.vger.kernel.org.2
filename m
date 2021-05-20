Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A6B389D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 07:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhETFZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 01:25:39 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:37396 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhETFZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 01:25:38 -0400
Received: by mail-wm1-f48.google.com with SMTP id f19-20020a05600c1553b02901794fafcfefso3950770wmg.2;
        Wed, 19 May 2021 22:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lFsvoCkU9zQjo7Svj5G5k4DUPYp2NU7fos0X3OEtvpQ=;
        b=NWTNLA8psn359D+d8i94TFdHpY2QtJlfmw4Yvt20OVIlGgJzQVV02XM00nFj1T8Pvr
         3ThjwfFWFGULYE7rAK+Vr3Ap/z8u+2yUElxrWvg+qcbgHWqR4gNkDlb4o6G6uOy7WK1f
         ncn9QoguChn35rAxYB4/sIeDsY+ndS90i8q5/+O1s3sBc7ZGxO2TFLwjCWIVnTMkDwlF
         LRFNTmU0qdx4cvZEz1oxVdwmRgUFwiEHSaE1uVbym5Zq6Q0GD0uxvNJQzXCja1D4mC7V
         TH+nhVFcJrrUb6mX8R3ZyAAiJi2S/q6UvdeI1D1d4S6oSxJAKY1VyK9gOzA/lYFZXFCU
         d+UQ==
X-Gm-Message-State: AOAM533UCJXbLyPSmsyD6GtvgHDIHkMeVr+QqYvTCTllfmT6q6uwANjU
        kAm3zfCIBBcvKiqNUI5a/7I=
X-Google-Smtp-Source: ABdhPJwN1AJlH1oTPvwkZwtZxul6M9lJoO1Ot1z9kwebbxqx175nN7692CsdnxvBrcF0kKH719VSBA==
X-Received: by 2002:a05:600c:19c8:: with SMTP id u8mr2149681wmq.25.1621488256924;
        Wed, 19 May 2021 22:24:16 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id g206sm7863810wme.16.2021.05.19.22.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 22:24:16 -0700 (PDT)
Subject: Re: [PATCH] Documentation: checkpatch: Tweak BIT() macro include
To:     Andrew Jeffery <andrew@aj.id.au>, linux-doc@vger.kernel.org
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, joe@perches.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
References: <20210520015704.489737-1-andrew@aj.id.au>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <7a14c4ea-46ef-a615-a109-1b9777c507cd@kernel.org>
Date:   Thu, 20 May 2021 07:24:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210520015704.489737-1-andrew@aj.id.au>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 05. 21, 3:57, Andrew Jeffery wrote:
> While include/linux/bitops.h brings in the BIT() macro, it was moved to
> include/linux/bits.h in [1]. Since [1] BIT() has moved again into
> include/vdso/bits.h via [2].
> 
> I think the move to the vDSO header can be considered a implementation
> detail, so for now update the checkpatch documentation to recommend use
> of include/linux/bits.h.
> 
> [1] commit 8bd9cb51daac ("locking/atomics, asm-generic: Move some macros from <linux/bitops.h> to a new <linux/bits.h> file")
> [2] commit 3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO")
> 
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Acked-by: Jiri Slaby <jirislaby@kernel.org>

Thanks.

> ---
>   Documentation/dev-tools/checkpatch.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index 51fed1bd72ec..59fcc9f627ea 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -472,7 +472,7 @@ Macros, Attributes and Symbols
>   
>     **BIT_MACRO**
>       Defines like: 1 << <digit> could be BIT(digit).
> -    The BIT() macro is defined in include/linux/bitops.h::
> +    The BIT() macro is defined via include/linux/bits.h::
>   
>         #define BIT(nr)         (1UL << (nr))
>   
> 


-- 
js
suse labs
