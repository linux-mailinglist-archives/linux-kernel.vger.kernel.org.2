Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD8B37A753
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 15:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhEKNLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 09:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230494AbhEKNLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 09:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620738641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6HCQfvoIASrghQvvK7Is6JLJJjGZ2bT2esu83liAjqc=;
        b=V8jTXsn1SN/bm3DX1iZl/EcgsdUcqjmBOreEiEs+j6xQ21xHYtpglrJffTlsAunn6iWXm3
        m3d+BNC4yQR2V5f0jTKrnVi+3zscji58EPOaFNmxIFLMPksZf/6LEvq/PrbF8Sp47BGr8d
        bah8k55espKGyE6cshIeR6H25Cs6a1k=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-tVROUhG2PuiX9yJWLNBhiw-1; Tue, 11 May 2021 09:10:40 -0400
X-MC-Unique: tVROUhG2PuiX9yJWLNBhiw-1
Received: by mail-qv1-f71.google.com with SMTP id s15-20020a0cdc0f0000b02901e9373e40e2so4079496qvk.17
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 06:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6HCQfvoIASrghQvvK7Is6JLJJjGZ2bT2esu83liAjqc=;
        b=iLIyBk4ZCTYAYtG32i1ldaGhgY5cSm/uPcpWyemgG5DEnYhoHZpoBq8ysv7GFLQG+E
         /CEpH1x295VuqQXExd2+hYOHC8eYkomyqh46FotdSIS2+lgPEwsroLVhz92mDarEyCHJ
         pr+tNdjocprzz6Jbz23Xz2nHZJ3fXZoblGXciFwocW0CTw85GoHtRe7tEbpdKxvPmNnC
         PouScC4PbPMr5Ta7kE31f3dEsrBG98X+iG4TaMaqoFXyb3UWcMfmbIcNu8fIuPhiZluQ
         WSHPIRVxxCi+tppOPnL5VTc0qPzNkHTxbsLFdVRZhB4HAQV2ka/BKPzp7Ko2QqPdtlh+
         tTVw==
X-Gm-Message-State: AOAM531Aoic1zkfwo/jlIHr0MMzBOCzXKTVuXsFmYDCyt0IIAPzPelSx
        IbgTv8yAQUQH0oPDVXvH7H97Uqo53jB/+2ELnWV+04AR97vAziutIaIUZcn/eG2bgpyC0+QIN8U
        G8KVED2wnANDrXNreMdQ1tdnLb7ACtWnhLlwHXsJQ4NuGPROONJeJr8peEmIeWO/RxYFc3UY=
X-Received: by 2002:ac8:a83:: with SMTP id d3mr28224434qti.91.1620738639440;
        Tue, 11 May 2021 06:10:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEZ5tNPYrjIraCKXmdZ443CE4WBgkEGbd/ff83gpIz8ttT9XvzVyRKWhgF3tZNB7YIa9RPZw==
X-Received: by 2002:ac8:a83:: with SMTP id d3mr28224415qti.91.1620738639193;
        Tue, 11 May 2021 06:10:39 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a195sm13548173qkg.101.2021.05.11.06.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 06:10:38 -0700 (PDT)
Subject: Re: [PATCH v4] HID: ft260: improve error handling of
 ft260_hid_feature_report_get()
To:     Michael Zaidman <michael.zaidman@gmail.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-i2c@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210511101208.16401-1-michael.zaidman@gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <30c2857d-5094-402e-25a8-48f5be83fa3f@redhat.com>
Date:   Tue, 11 May 2021 06:10:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210511101208.16401-1-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generally change is fine.

a nit below.

On 5/11/21 3:12 AM, Michael Zaidman wrote:
> Fixes: 6a82582d9fa4 ("HID: ft260: add usb hid to i2c host bridge driver")
>
> The ft260_hid_feature_report_get() checks if the return size matches
> the requested size. But the function can also fail with at least -ENOMEM.
> Add the < 0 checks.
>
> In ft260_hid_feature_report_get(), do not do the memcpy to the caller's
> buffer if there is an error.
>
> ---
> v4   Fixed commit message
> ---
> v3   Simplify and optimize the changes
> ---
> v2:  add unlikely()'s for error conditions
> ---
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
> ---
>   drivers/hid/hid-ft260.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 047aa85a7c83..7f4cb823129e 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -249,7 +249,10 @@ static int ft260_hid_feature_report_get(struct hid_device *hdev,
>   
>   	ret = hid_hw_raw_request(hdev, report_id, buf, len, HID_FEATURE_REPORT,
>   				 HID_REQ_GET_REPORT);
> -	memcpy(data, buf, len);
> +	if (likely(ret == len))
> +		memcpy(data, buf, len);
> +	else if (ret >= 0)
> +		ret = -EIO;
>   	kfree(buf);
>   	return ret;
>   }
> @@ -298,7 +301,7 @@ static int ft260_xfer_status(struct ft260_device *dev)
>   
>   	ret = ft260_hid_feature_report_get(hdev, FT260_I2C_STATUS,
>   					   (u8 *)&report, sizeof(report));
> -	if (ret < 0) {
> +	if (unlikely(ret < 0)) {
>   		hid_err(hdev, "failed to retrieve status: %d\n", ret);
>   		return ret;
>   	}
> @@ -720,10 +723,9 @@ static int ft260_get_system_config(struct hid_device *hdev,
>   
>   	ret = ft260_hid_feature_report_get(hdev, FT260_SYSTEM_SETTINGS,
>   					   (u8 *)cfg, len);
> -	if (ret != len) {
> +	if (ret < 0) {

nit: should be consistent and use unlikely(ret < 0) for this and other 
similar checks.

Tom

>   		hid_err(hdev, "failed to retrieve system status\n");
> -		if (ret >= 0)
> -			return -EIO;
> +		return ret;
>   	}
>   	return 0;
>   }
> @@ -776,8 +778,8 @@ static int ft260_byte_show(struct hid_device *hdev, int id, u8 *cfg, int len,
>   	int ret;
>   
>   	ret = ft260_hid_feature_report_get(hdev, id, cfg, len);
> -	if (ret != len && ret >= 0)
> -		return -EIO;
> +	if (ret < 0)
> +		return ret;
>   
>   	return scnprintf(buf, PAGE_SIZE, "%hi\n", *field);
>   }
> @@ -788,8 +790,8 @@ static int ft260_word_show(struct hid_device *hdev, int id, u8 *cfg, int len,
>   	int ret;
>   
>   	ret = ft260_hid_feature_report_get(hdev, id, cfg, len);
> -	if (ret != len && ret >= 0)
> -		return -EIO;
> +	if (ret < 0)
> +		return ret;
>   
>   	return scnprintf(buf, PAGE_SIZE, "%hi\n", le16_to_cpu(*field));
>   }
> @@ -940,10 +942,8 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   
>   	ret = ft260_hid_feature_report_get(hdev, FT260_CHIP_VERSION,
>   					   (u8 *)&version, sizeof(version));
> -	if (ret != sizeof(version)) {
> +	if (ret < 0) {
>   		hid_err(hdev, "failed to retrieve chip version\n");
> -		if (ret >= 0)
> -			ret = -EIO;
>   		goto err_hid_close;
>   	}
>   

