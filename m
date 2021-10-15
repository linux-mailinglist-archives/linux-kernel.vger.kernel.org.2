Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB6D42EAB5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbhJOH5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbhJOH5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:57:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7DAC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 00:55:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m22so25123371wrb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 00:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Az2xgl/hqgMdBeapdM+S02nJjvIpkUB+Xfp9egegKmk=;
        b=TuBAsa+PAiwlc3R6RMz71TDggPdL0gRU5iOxKDpcj9fsaFxF2sRxBrAu2tYSkRCWvE
         5thcX96h3Clsr9aGJMh6aIappjnXdXiCY/Cq4SF2cXuAHnzryElDFUfkJTTGtNbPWfyM
         ANYPILq8tFctt3YyII9vgcPzUeLbag+Bsu40crrmha/MIODxphP2L78VlsE57UOUNkEU
         mcMl1truMLyyrf2fTXSN2uQ1Ny9r70sUaACikT5WvHyCHiyv3LT3J+p57Pdu7YLuDKMI
         9kgMeANUW0MkC9szJdDJSfsEvGlQ96Au95kb82A7/WkrIkLpMywsMCtnap3nskRK4rat
         QwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Az2xgl/hqgMdBeapdM+S02nJjvIpkUB+Xfp9egegKmk=;
        b=t5UW4r0GfxUP1SFb2ZuL1+lxaOUuF77i0iIoQLeGEJvxWq9WgJLyLUxVlRryC5OSA0
         jOnXlecaUMGrkxB4iXcspHggZPj+RjLhpObJl0danl6+lI1f3nvOn1VATUAP339FuQ8G
         y6cH/PyVNffABl7edRUOt/UagJV4sCP1YhfIOu+GlIy56pR/FzgFAM+oGGSeO6lN2f+F
         IiR/v89u1QDUOHNjEjDdGnoKdIVHgosEzm92bl1326k4ry/YSaMe96fUUfjhbSmD/FZw
         cNl84TRC0HG84f0f1yqLsXwmH1JGpnEfN0kHCNNYEhDPN+83yjaDjrvDmKj5iAHx2geG
         arIg==
X-Gm-Message-State: AOAM530e6FOxrWqu2gJpWsNl0r43FrQhiDtRmN2rkBiERjwJCSLMt/FH
        Y6DNJzwVZWosqv1Xx/Da8HWOdvM/aKI=
X-Google-Smtp-Source: ABdhPJxv7R034R/SUDdZKI6hxGD+U1s9d3IXvIGVHhT9qiWfdnY/JRWE1BwLNYF5dZaGUqkL8lSYuA==
X-Received: by 2002:adf:a48f:: with SMTP id g15mr12003376wrb.259.1634284522895;
        Fri, 15 Oct 2021 00:55:22 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::40c9? ([2a02:8108:96c0:3b88::40c9])
        by smtp.gmail.com with ESMTPSA id p12sm849530wrr.67.2021.10.15.00.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 00:55:22 -0700 (PDT)
Message-ID: <6c637ef5-79dd-5503-d445-e7a768f528a6@gmail.com>
Date:   Fri, 15 Oct 2021 09:55:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH] staging: r8188eu: remove MSG_88E calls from
 hal/usb_halinit.c
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211015000233.842-1-phil@philpotter.co.uk>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211015000233.842-1-phil@philpotter.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/21 02:02, Phillip Potter wrote:
> Remove both MSG_88E calls from hal/usb_halinit.c, as these calls serve
> no purpose other than to print the name of the function they are in
> (_ReadAdapterInfo8188EU) on entry and on exit, with a timing of the
> function, which is better accomplished by other means. Also remove
> the jiffies assignment at the start of the function, as it is no
> longer used.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>   drivers/staging/r8188eu/hal/usb_halinit.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index f6db5b05e6e7..abbd107ad3c1 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -1073,15 +1073,9 @@ static void _ReadRFType(struct adapter *Adapter)
>   
>   static int _ReadAdapterInfo8188EU(struct adapter *Adapter)
>   {
> -	u32 start = jiffies;
> -
> -	MSG_88E("====> %s\n", __func__);
> -
>   	_ReadRFType(Adapter);/* rf_chip -> _InitRFType() */
>   	_ReadPROMContent(Adapter);
>   
> -	MSG_88E("<==== %s in %d ms\n", __func__, rtw_get_passing_time_ms(start));
> -
>   	return _SUCCESS;
>   }
>   
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
