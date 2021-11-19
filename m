Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C380457177
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 16:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhKSPQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 10:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhKSPQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:16:33 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099EAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 07:13:32 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so7769718wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 07:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Aq8MAUr5E/zqmONED4b+0rr+VaYsauCwQ0XOJXYriW8=;
        b=bA4gzNWQicRtLB1C3/g+UqrMiT4uJi4p5TOoROb9cxrfgIriVV/jaoxdQSHrvGiCuH
         vvu9JwXiaGimmax6OX9MYnRC2SjGx5vgUwxarr1vryeYvywqreSZOqAh4r6eyUIHE/Rx
         CuW8OSidcCAVOh4UKhHy+yFM+ukuDYVueIittR3ZmTRRPMAeq7BykGgl9FMmXZQyXuap
         0FyjtL77Abw8heONH7bamdojjEcjStoZ7FnGSxvb+vjwuSzxYL0wtpDNSk9gyyWss8Uf
         RrWKzz6HcV2mT9LneJp5VRRaoYtHSBJyrFZ4ZPxTZq3y3tqa+v0qfLldkBoX+oreX2Nl
         +l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Aq8MAUr5E/zqmONED4b+0rr+VaYsauCwQ0XOJXYriW8=;
        b=tdX1i4HDO9G3AlLtzSsAN3FhCpFMVrBtZdfj/22RuMwAS2U8StBTjcB9foEI8Y7UJG
         SLdKE0piCv3IYsyr7v3FIKIkSPKP558N0CtDXwdhoYpYxkTyJWaQIKaMsFIanikwft/q
         tohdnV8xE4H7zvwJdNHxRd7xRdke1pdtxPdHSNdNkTcjc6ycDrRsnzSX/w6K0dZKjK/D
         z5ycMbl9j7Dhd9aWKzl6ZspuEbhyX/zk64ceLXSZAYfI6YM4ZziTkbV/NyE6vCs6Uhsr
         mUMmxcnHou6vO2WYG54iroBQvKnAAN5qydvWMiYNFVZChxa12gjnadDGAlLjP1V39n/2
         SU9g==
X-Gm-Message-State: AOAM532IpAj1pbkpoBuUca8Vj5RZT+JRn/viA7yNYSVQDJ45gT5UxRh9
        7sUS+OfuHBZytQMky0ccsyY=
X-Google-Smtp-Source: ABdhPJycoLeDwtbPB4cYIWFMIlIji2Qtpw7FDFDgXB26puvuJZxuNmoLK3dNVnF7+gvao3Eomb3NjQ==
X-Received: by 2002:a1c:a711:: with SMTP id q17mr435523wme.158.1637334810630;
        Fri, 19 Nov 2021 07:13:30 -0800 (PST)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id o12sm27445wrc.85.2021.11.19.07.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 07:13:30 -0800 (PST)
Message-ID: <c325748d-6faf-9fee-60ae-bf8b6b812c2a@gmail.com>
Date:   Fri, 19 Nov 2021 16:13:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 00/17] Add memberof(), split some headers, and slightly
 simplify code
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <YZe9yYBvE038/w90@localhost.localdomain>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <YZe9yYBvE038/w90@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On 11/19/21 16:07, Alexey Dobriyan wrote:
>> +#define memberof(T, m)   (((T *) NULL)->m)
>> +
>>  #define typeof_member(T, m)	typeof(((T*)0)->m)
> 
> No.
> 
> Your macro exists already under different name.
> 
> sizeof_member and typeof_member exist, you don't anything more.
> 

The macro memberof() exists in one file (or 2)
under the name struct_member(), IIRC.

sizeof_member(), which is actually sizeof_field, IIRC,
and typeof_member(),
make use of this construction,
but they unnecessarily repeat it,
and there are other cases where code wants exactly memberof(),
not any of its wrappers.

I think that macro makes a lot of sense.

If you prefer the name struct_member() instead of memberof(),
I'm fine with it.
I just found that name much later than writing memberof(),
and memberof() was more consistent
with the typical naming of xxxof() for similar macros.

Thanks,
Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
