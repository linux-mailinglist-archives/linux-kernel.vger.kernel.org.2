Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA14430FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 07:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhJRFQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 01:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJRFQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 01:16:22 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11226C061745
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 22:14:12 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso990159ota.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 22:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=itxP+MITBQYLv6IpaiEtXRD3Z1f5f4njE+wwLqkCTAY=;
        b=xF/Lpd9eUk7JR44iFuKVSHz48WCRWecyaF/koTl7TNt2g3+g7uRGnYNJwtu8Lxpzl/
         Eftn4pMsE45y5AduBDJNiYIwBqMbD17CTV/RtQLK4ZRzavmIkL6eKBHRiqLSYEbYmkLJ
         VnZ74VZXQdx7/UsK8Hgfp9jezp0hIVe+gG87WXV20Brg+0SWMYWKU57zZ8eBJweo5qNE
         XBWU4W53Xfz2Dsve2QS47JjCtH5WPTXadLWDDTQHEol+8Kn+eA+LdHN6iHAwzCga59g4
         2u0idzRXC0N7/U1SifyUC1gG0E+sHOTU/XMpYdageWWpjrBwjiLDHSLYu0h68Uid391S
         4+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=itxP+MITBQYLv6IpaiEtXRD3Z1f5f4njE+wwLqkCTAY=;
        b=zut33GJ8pjImD2/FevNEkgfX37gmodwZT/aGwZB2gfkUdOGQrleos9T9oioZ1b7zWc
         cEMY44xTzHqWC5PMYbI++yhs5+1orQioZ+umI7r2SJb0IRqtXCB1LGRNAmCq6f+EcODK
         +ddNGjXkxIk2SoMX5y+Rt0oZgvEqZvpTaKLXQIvE5tGNZWIQrPGrf6j9sbivf9x3Fh7L
         AwjIQmyYWdlq7ltrsyyTuIGVVKUyrEMCKNlaaq+3pXk7K2TaEXZQOn5edIYLb33J+9+S
         NZXlrnhk1HSsnmPXL49xTQrN8WAwgatIYGEwFH69Fs6QgKQ8h7wVG5u7lgpJHCsvtwiX
         21gA==
X-Gm-Message-State: AOAM531UUBdH6IRUyRxd2iyC6nEj5sv/5TczCt4Aqk6FF8X8YuMnFjls
        X9y+yyUD47jTlhK02kTC2fyM/xy8L082h1YcBG8+wbZSiOY=
X-Google-Smtp-Source: ABdhPJwRa1Ny5xG04rVXxLa5jSQc+H/uM1FxpilcDlfsieb4KLEKd+5SWCvqtao0fRu0+t+ItEc7f23kucCRxU0yc3I=
X-Received: by 2002:a05:6830:2b28:: with SMTP id l40mr9876399otv.162.1634534051227;
 Sun, 17 Oct 2021 22:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211005024025.2037810-1-bjorn.andersson@linaro.org>
In-Reply-To: <20211005024025.2037810-1-bjorn.andersson@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 18 Oct 2021 10:44:00 +0530
Message-ID: <CAH=2NtxnX0eAFSRseviTm8G3=VQiYWRDsA5ZuY-_h77R9Kk7-w@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: socinfo: Add PM8150C and SMB2351 models
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 5 Oct 2021 at 08:08, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>
> Add PM8150C and SMB2351 to the list of known PMIC models.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/soc/qcom/socinfo.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 47e9ed03882a..bd80db3181df 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -102,6 +102,8 @@ static const char *const pmic_models[] = {
>         [32] = "PM8150B",
>         [33] = "PMK8002",
>         [36] = "PM8009",
> +       [38] = "PM8150C",
> +       [41] = "SMB2351",
>  };
>  #endif /* CONFIG_DEBUG_FS */

LGTM, so:
Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Regards
