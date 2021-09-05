Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84B8400E9F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 09:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbhIEH44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 03:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhIEH4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 03:56:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944E7C061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 00:55:52 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i3so2259638wmq.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 00:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y+rK5DuvhxVwRtS3sArMrVdmfKfsYPeSxUMrQtQ8RKA=;
        b=NymRjouTjiSsvoj8n3DXDlAaIXMF2oTGhpHn3rqi0OyG5Qn3VV49D/xgLppDJptArq
         8B20HykJFHhSMB5mASLU6vAHqjdl17E+RoTWuLeZMKAXnXU4WgkMjc7fFqHYsMrgyyO1
         fp9N1dJiz3h/nooRjW6Q7MXQYI/5xeE6thWE3i4P32YpNZ5fPycYQFf7t4IM0V2lPNHT
         SEfV4g7zxZZzes6MXQd5aHszwftB+oeHQxTEwyvzClIZZ5qFnWZwMtMWvzLSLogqHub2
         S+G80+1DWf/QCt6MnVuGzbawm/H7A2jPbpVE/WNVEjP2l2+RJ+EtCRddK+2dYJa4sxmn
         36NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y+rK5DuvhxVwRtS3sArMrVdmfKfsYPeSxUMrQtQ8RKA=;
        b=R/v6TlzMFLowWJuqlnap780vughc9oQLgcv3W2snzpgDKmgateC1AviPsQXKGuuRhb
         H2TZI/RRnfrlCXYXM4CzUsfwxakFIy0KnC2AV8lp0UpnwLhwDDoCo8NKgQ2KDpiYmcsS
         5eDOQVS7nossBTsSWKzNGN3gJ5oz0HXBme8vpfVPo9wznEjltXH8YVZrB4RExkb2GHFe
         GYR9OGwM0jbNVVaY4dO/jXVMaTWcBqJmAHcFw/DUrPstD/9+DKKZfAri+s7fmWVRzXIM
         vKTLPv8H8CmP0XpWF7Qp+o2o9QhsWsHvIjK7OklIh82I9VeLh2c/WhBgUuAQPMHhmJpi
         QEpw==
X-Gm-Message-State: AOAM531XIh6h9dF5MIl8MAfw6Gw2uImSYwS4rryDQcVe5EH6b9wLMznQ
        eBvb+2eHd5cBql6UA2IWNoU=
X-Google-Smtp-Source: ABdhPJznRZcl0pp+K61vAQgAo3gWm12zlOxRHyvKbX2S7y3CaGR2xyy+Ao484odxRlyojDvfbzcZzQ==
X-Received: by 2002:a05:600c:1990:: with SMTP id t16mr6065013wmq.45.1630828551120;
        Sun, 05 Sep 2021 00:55:51 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::dc38? ([2a02:8108:96c0:3b88::dc38])
        by smtp.gmail.com with UTF8SMTPSA id l26sm3923669wmi.13.2021.09.05.00.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 00:55:50 -0700 (PDT)
Message-ID: <41f6eb79-c943-c8b4-78d9-cc10e8ffa7ea@gmail.com>
Date:   Sun, 5 Sep 2021 09:55:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] staging: r8188eu: core: remove condition never execute
Content-Language: en-US
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YTNrjG1y05ByN54+@user>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <YTNrjG1y05ByN54+@user>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/21 14:50, Saurav Girepunje wrote:
> Remove condition which never get execute.
> as pattrib->mdata is always zero before if condition check.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index 4178b3c1ff57..f314f55997bf 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -5669,9 +5669,6 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
>   	else if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE)
>   		SetToDs(fctrl);
> 
> -	if (pattrib->mdata)
> -		SetMData(fctrl);
> -
>   	qc = (unsigned short *)(pframe + pattrib->hdrlen - 2);
> 
>   	SetPriority(qc, tid);
> --
> 2.32.0
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
