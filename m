Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096433E1219
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbhHEKIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:08:16 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:39691 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbhHEKIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:08:11 -0400
Received: by mail-qk1-f170.google.com with SMTP id x3so5666430qkl.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 03:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BgKdFE0vGQVPJxa/hxgCIV92XvRlmWHmQs+8hZ4rLCM=;
        b=XLaLj8iVrh8ePPTtm1OhH7L5q3kRtemfOmqLf1Cxzia3WroFIJcrWOgLNob98hdrAi
         BJY4AHtVKi+anDpmMW/UjmEWR2ijTFqfoXlmgXl2ty5m+pVFp/Il8QaOGEhKATNHxgxh
         vUUXUGrVlZ/K032+wTusvGPpshwXYIgfQipZcE3QRbGNloKf9co3rVbLfoxMqgR2kfKB
         kQrnyuhxTFoqs89uk63odhx0QJSjrI4uDdS0tlgKNlf1IKOtJDvD0SHLP7HswyYn8hLr
         LwXyJdAVei9MWjK9WiNJPbjG9KA3G0slkzX/bjO1r2/ie13QcuSNeJIyVBVjfkJUg253
         EqQA==
X-Gm-Message-State: AOAM53235KXIO01w5wYkv5MOgCwA4XLAX4DdEMvMI+zI9G4AEoVxi6AO
        +TxjEjxNbaVbkD93LlTvojdk4ObfeVU=
X-Google-Smtp-Source: ABdhPJy/zGi8yLdv+kWEZaFUANkNBcK1RcK0BY6S4OaxGh9FCIl6mQEQZIrcNdStl+gpzpQ4Dv97WA==
X-Received: by 2002:a37:9dcd:: with SMTP id g196mr2956011qke.99.1628158076768;
        Thu, 05 Aug 2021 03:07:56 -0700 (PDT)
Received: from [10.10.132.158] ([83.149.199.249])
        by smtp.gmail.com with ESMTPSA id b66sm367820qkf.135.2021.08.05.03.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 03:07:56 -0700 (PDT)
Subject: Re: [RESEND] coccinelle: api: rename kzfree to kfree_sensitive
To:     Weizhao Ouyang <o451686892@gmail.com>, Julia.Lawall@inria.fr,
        Gilles.Muller@inria.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
References: <20210805095822.1732125-1-o451686892@gmail.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <3cb9caa9-b7d3-5b1b-7020-63d72506c7c7@linux.com>
Date:   Thu, 5 Aug 2021 13:07:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805095822.1732125-1-o451686892@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/5/21 12:58 PM, Weizhao Ouyang wrote:
> Commit 453431a54934 ("mm, treewide: rename kzfree() to
> kfree_sensitive()") renamed kzfree() to kfree_sensitive(),
> it should be applied to coccinelle.
> 
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Acked-by: Denis Efremov <efremov@linux.com>

> ---
>  scripts/coccinelle/api/kvmalloc.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/coccinelle/api/kvmalloc.cocci b/scripts/coccinelle/api/kvmalloc.cocci
> index c30dab718a49..5ddcb76b76b0 100644
> --- a/scripts/coccinelle/api/kvmalloc.cocci
> +++ b/scripts/coccinelle/api/kvmalloc.cocci
> @@ -79,7 +79,7 @@ position p : script:python() { relevant(p) };
>    } else {
>      ... when != krealloc(E, ...)
>          when any
> -*   \(kfree\|kzfree\)(E)
> +*   \(kfree\|kfree_sensitive\)(E)
>      ...
>    }
>  
> 

Regards,
Denis
