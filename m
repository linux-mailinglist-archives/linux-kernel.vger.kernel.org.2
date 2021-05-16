Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61520382062
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 20:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhEPSeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 14:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhEPSeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 14:34:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7539DC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 11:33:01 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d11so4129424wrw.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 11:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mp4ngGM9ljz5IG8vSBHzArz2DW08hhGqygQQhBNze2E=;
        b=CUyD2Le0WX6DqokVANZboqbAZaK9Z/TKh23Tw8wOSQMRwnJT+q3Xzdsc4sq8H/Ldwh
         fiFZNbNAN8UMLymdzeX9F3pmlgK7RBvDQsdiNFtwQZevCB+dvY9tMF8Qz0DKRB3eFKzX
         v4LpJAzwC2x2mCqchiQY1dReePQLeHj8wZogWFhXX/Cj1+WuCOQLDSw2gpz+9sKY2ZUc
         joA1fIWrcBBsHhNAvS+JtZR1j2LQMKbzvhxgrOVpU3YCwG/3zldtuuA6LP5uXjqCVhoc
         IRMHc2xebwXD3922gKczIJV+GjGPuL07HH/hOmqewxh+Lg8JJZqZAMvoNFTbqWaw4uzQ
         DBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mp4ngGM9ljz5IG8vSBHzArz2DW08hhGqygQQhBNze2E=;
        b=fLpP5qlwC97jrQHm/oVHOyHZa/dLl1VCYsVFiCXzGouSpEc8FdhBuOi7PMhIeNQAfG
         ikRSWcvsos1OpNZ8Qn0RcUEX/64vo/aQW3KgpwdAQZ6uJBCwW1krA8lPBBv/9qj0+PgG
         At0xhpb13W/vLpZMohVYv0F62mAc1G9M6AWYXIt//IL2krmYlBcoG0f3102hjplMdlQO
         Ozm0/VfC6CjhQM7bWwqwX1uC4A+afJzEGW5y6iNXZCtkTm3bD5XwSb9xNtpdeYwInR+f
         OrPEoOXh9Wbo3MwoRFJHtzyhCYbOSO7C1Nl0jiKAEl4rt1FYQFHdPkKo8DHOaQB6dnky
         qP+g==
X-Gm-Message-State: AOAM533wcpJIuxBOw+07dYHaQ6ifTTVBCA+Q7ZQ8pMlw7oUwsCnn/qhn
        ih9hdcJwe3xiX0CL933O24wHtw==
X-Google-Smtp-Source: ABdhPJzTEREHMSHj7WA7plAa8A8Nlx5M1YVfjI7BaPfwY2dDCZy9u1+NEmfQNKw1fgjC1dad9KDGlw==
X-Received: by 2002:adf:d231:: with SMTP id k17mr16061085wrh.78.1621189980193;
        Sun, 16 May 2021 11:33:00 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id 61sm15256051wrm.52.2021.05.16.11.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 11:32:59 -0700 (PDT)
Date:   Sun, 16 May 2021 20:32:56 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mjpeg-users@lists.sourceforge.net
Subject: Re: [PATCH v3 05/16] docs: driver-api: media: drivers: zoran.rst:
 replace some characters
Message-ID: <YKFlWNrrVGnPswon@Red>
References: <cover.1621159997.git.mchehab+huawei@kernel.org>
 <fb2e971bc2fa4ed1e6f0d5aae6260191ff64c883.1621159997.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb2e971bc2fa4ed1e6f0d5aae6260191ff64c883.1621159997.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sun, May 16, 2021 at 12:18:22PM +0200, Mauro Carvalho Chehab a écrit :
> The conversion tools used during DocBook/LaTeX/html/Markdown->ReST
> conversion and some cut-and-pasted text contain some characters that
> aren't easily reachable on standard keyboards and/or could cause
> troubles when parsed by the documentation build system.
> 
> Replace the occurences of the following characters:
> 
> 	- U+00ad ('­'): SOFT HYPHEN
> 	  as ASCII HYPHEN is preferred over SOFT HYPHEN
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/driver-api/media/drivers/zoran.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/media/drivers/zoran.rst b/Documentation/driver-api/media/drivers/zoran.rst
> index 83cbae9cedef..b205e10c3154 100644
> --- a/Documentation/driver-api/media/drivers/zoran.rst
> +++ b/Documentation/driver-api/media/drivers/zoran.rst
> @@ -319,7 +319,7 @@ Conexant bt866 TV encoder
>  ~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  - is used in AVS6EYES, and
> -- can generate: NTSC/PAL, PAL­M, PAL­N
> +- can generate: NTSC/PAL, PAL-M, PAL-N
>  
>  The adv717x, should be able to produce PAL N. But you find nothing PAL N
>  specific in the registers. Seem that you have to reuse a other standard

Acked-by: Corentin Labbe <clabbe@baylibre.com>

Thanks
