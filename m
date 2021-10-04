Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC324217DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 21:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhJDTqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 15:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbhJDTqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 15:46:38 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59096C061749
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 12:44:49 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 24so23153005oix.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 12:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5lPwZ+iwsuPnoAxmrkeLnm/5OtvoYrkkwPtp9yTV4PE=;
        b=hgF1ZS5hnGhwUx2jX7oe2GHCphP61nmlCP4jO1u7qYsCENPZl9Qq27TGGNB+bkKiac
         jdQn2fj8+mXEEmTTF6pL+5RGN3fhZ9Mc5u6QUYrdVHMefiUrfQvD3gfU4n6+G0lQThA5
         g+MynwqkJ3Y7M+fZUlMYwhxFJU8oRv1d5a5USP7B1XsA0TjlUPEtd2l2VyabrC8owMJT
         1ae6r6JkuwqaaK5hC6lHMiG4iAM7Umrh2CRIEjUwLH0VH0mt7+X76isPUD6aUXldQV1j
         KvISpuM2NO8ZbrBKQyIohf6z9eiKHATGZe2xJACeqb2PiuDlaYzUnn5XiXQM9Gi3hMRT
         5WDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5lPwZ+iwsuPnoAxmrkeLnm/5OtvoYrkkwPtp9yTV4PE=;
        b=bDM3G+ZojBgf+SGbPyoLVNtnXtt8FD0kCMpSdii+VlsVaB4nfqT/Pke+gQwJ3YOmqV
         rttw7Qby8jPg9fR08k6BJT2Xvn/lY8X7ttP0Wjg0/V+T8PRv4kYdHZ145sZnne7j0QJo
         fE4Lxs8IsQzErvez1pnz5m/6T0iyiSNETIU4kta8doWdCuuKjW/c/Hb9XHFOt+mVD8/q
         Aj7Vk1hAWwGkYS585howC4ig2fjeL3vXutVu59RMparVyl662ejorE8fQnBIrJOgY5R9
         QHHa95E4tHREXgdaO3NSE5LA58LVpntJSbYAx5ETyShuNAmT/Mp4Z+T8ws4Y7kfro2uA
         9/+g==
X-Gm-Message-State: AOAM532bh8sjQ9p8gcLhyXV/4jxbAuWoysPeTMtVwwOjM9AXJV+c072l
        K3lwK2ysBxYXiBJhJ4rw7Qa9/A==
X-Google-Smtp-Source: ABdhPJwI92lYk3R3FU/4z6wR+/EiRyFE+2CPENxQiTRDE+M3rjZ6qwYRkxV0gelImXKGjpQ2x+ZpAQ==
X-Received: by 2002:aca:f0c3:: with SMTP id o186mr13729435oih.37.1633376688632;
        Mon, 04 Oct 2021 12:44:48 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id j10sm2972251oog.39.2021.10.04.12.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 12:44:48 -0700 (PDT)
Date:   Mon, 4 Oct 2021 12:46:31 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mianhan Liu <liumh1@shanghaitech.edu.cn>
Cc:     Andy Gross <agross@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next -v2] ./drivers/bluetooth/btqcomsmd.c: remove
 superfluous header files from btqcomsmd.c
Message-ID: <YVtaF1YD/T9r8Ucy@ripper>
References: <20210928200811.22059-1-liumh1@shanghaitech.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928200811.22059-1-liumh1@shanghaitech.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Sep 13:08 PDT 2021, Mianhan Liu wrote:

If you run a "git log --oneline -- drivers/bluetooth/btqcomsmd.c" you
will see that the appropriate prefix would be "Bluetooth: btqcomsmd: "

In other words, a better $subject would be:

[PATCH v2] Bluetooth: btqcomsmd: remove superfluous includes

> btqcomsmd.c hasn't use any macro or function declared in linux/of.h
> and linux/slab.h.
> Thus, these files can be removed from btqcomsmd.c safely without
> affecting the compilation of the ./drivers/bluetooth module
> 
> Signed-off-by: Mianhan Liu <liumh1@shanghaitech.edu.cn>
> 
> ---

Here is an excellent place to state "Changes since v1" and mention that
you no longer remove btqca.h and you added your S-o-b.

>  drivers/bluetooth/btqcomsmd.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
> index 2acb719e5..e556d96a4 100644
> --- a/drivers/bluetooth/btqcomsmd.c
> +++ b/drivers/bluetooth/btqcomsmd.c
> @@ -5,9 +5,7 @@
>   */
>  
>  #include <linux/module.h>
> -#include <linux/slab.h>
>  #include <linux/rpmsg.h>
> -#include <linux/of.h>
>  

This looks reasonable.

Regards,
Bjorn

>  #include <linux/soc/qcom/wcnss_ctrl.h>
>  #include <linux/platform_device.h>
> -- 
> 2.25.1
> 
> 
