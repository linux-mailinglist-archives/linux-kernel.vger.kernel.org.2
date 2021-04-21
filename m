Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154B8367385
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243262AbhDUTiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbhDUTit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:38:49 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03C4C06174A;
        Wed, 21 Apr 2021 12:38:15 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 66so4449008qkf.2;
        Wed, 21 Apr 2021 12:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZWTsx//HrJ2RHu0HgCdgSrEyArHnq9DI4QEo+WYe8fg=;
        b=e1l+mJOanxoKUOTLpnATTOFkssw9nfsmeCnl1B6/IFLbekGvdZp/G6JSrJPTMgDTI5
         b9yyDwjWLxqWh/S7zoK6lHCF92epKHBLsblU/S3wOveg2A/0pIIv7COM9tMptsC7nvuE
         rjKBZBubipYjdMm+WikyNAJFYW0aw/HdBN8VO0/ZP19HU0Oz8lm9P4hFaOfLaUGEgkw3
         47ROvJY/8krgl7j7fdkfyjqOdB1zRSgPMjg0h+QASRZ5JWUryR6ppAv6eOzU3JDN8Km2
         4z05FrM+Uu1rrhNbxADK0v4ALvpuE4ED9WLaapWb2ZsWeIlz3qVxgXHb6EGC7a5z/jeT
         gXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZWTsx//HrJ2RHu0HgCdgSrEyArHnq9DI4QEo+WYe8fg=;
        b=E7g7MBly90FFPViXpJGm3dIGglmjX92alyTgf/cWRYjuK8HQoSmWwAcQUYMU8IwFdt
         Ijg2NJFaV1YkhJ2QAgCNHNBA0Y2vX2d5irY5WGQvAaM7uGEJ5ppvEbFADjcZmuXIzUlm
         LlM1kwIypZWl02puXSm8Bprm4y9DZW4i7wM4TDKZWmc+5CO4sRNtBy6s/RTqinjJsdfY
         LZxSYeKaRGzZ81pJV0Arvhw+kMgYUdCw8KggayCQK+yKr+URby/XswIekg0nRvCngx5x
         iMUvgcTD96HMCT9J36tGe2s4CWTtbO6GJOCKt5VGzX2K2iT/0stzn9A0BLrostFA131x
         KIsQ==
X-Gm-Message-State: AOAM530aQYuIAzIvRvu3TWXaKFD5D15whes63fyOUui5bNvKsfhpWlvD
        yshunljiSX7CGr6Ccwtg7Y0=
X-Google-Smtp-Source: ABdhPJyXc+/zrC8T8zUjum69hY80LLH1bLWj/jqqP+sRkuGXVVaz6pGJd/N4yFT9D+RrWUcGiJEZqQ==
X-Received: by 2002:a05:620a:124a:: with SMTP id a10mr16376642qkl.447.1619033895142;
        Wed, 21 Apr 2021 12:38:15 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id f15sm454636qtm.49.2021.04.21.12.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 12:38:14 -0700 (PDT)
Subject: Re: [PATCH] of: overlay: Fix kerneldoc warning in of_overlay_remove()
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20210421154548.1192903-1-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <98f083c9-5e2d-6388-88f6-4883e025bebf@gmail.com>
Date:   Wed, 21 Apr 2021 14:38:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210421154548.1192903-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/21 10:45 AM, Rob Herring wrote:
> '*ovcs_id' causes a warning because '*' is treated as bold markup:
> 
> Documentation/devicetree/kernel-api:56: ../drivers/of/overlay.c:1184: WARNING: Inline emphasis start-string without end-string.
> 
> Fix this to use the normal '@' markup for function parameters.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/overlay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index d241273170fd..67c9aa6f14da 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -1181,7 +1181,7 @@ static int overlay_removal_is_ok(struct overlay_changeset *remove_ovcs)
>   * If an error is returned by an overlay changeset post-remove notifier
>   * then no further overlay changeset post-remove notifier will be called.
>   *
> - * Return: 0 on success, or a negative error number.  *ovcs_id is set to
> + * Return: 0 on success, or a negative error number.  @ovcs_id is set to
>   * zero after reverting the changeset, even if a subsequent error occurs.
>   */
>  int of_overlay_remove(int *ovcs_id)
> 

The change results in incorrect information.  I am guessing that "@*ovcs_id"
would not be valid syntax (I have not tried it).  The changed version says
that the pointer ovcs_id is changed to zero, but the actual action is to
change the value pointed to by ovcs_id is changed to zero.  Is there a
valid syntax to say this?

-Frank
