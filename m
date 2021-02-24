Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A06D324520
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 21:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbhBXUYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 15:24:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234496AbhBXUYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 15:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614198160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CxZTCOjkYbOnGULO11ZbBQgSUM7OFTzm0oARySokNpI=;
        b=HSIkYYc9K15dAx4DEJlpT78GNhCkJ/+lljG243P+6imK5OPw2v99TUmidZqzsePzr4I2Q+
        5mA56Reue2Wcz6fsWnMaE5gBvSc9nB7MnesC4Lq1/XF2VA8dL/po5Ht7Nm7c4iHMS6SUxA
        BFl0DE7fAoi3j5rBVxzN9uve91DiuWM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-mAMsecBBNI6vbF0uV5A_Ww-1; Wed, 24 Feb 2021 15:22:38 -0500
X-MC-Unique: mAMsecBBNI6vbF0uV5A_Ww-1
Received: by mail-ed1-f71.google.com with SMTP id f11so1518861edk.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 12:22:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CxZTCOjkYbOnGULO11ZbBQgSUM7OFTzm0oARySokNpI=;
        b=maEQw0gJsIr4lALaKgsym6oEE5wQ9kCvs+X6XrbB20AyZ8RKGRm4WOcSLIrSbZFgzK
         S2Di0z82WIgNMlVKj04K0I1+jU3LjPRV9ikO5NbIiyxCg3I/RchaBaM7wiUn7d/96Qbt
         qALpM7l2qOdEDBaAiaIjA3bWUev8snYIoyOu7jUZCdZB+ww2sGxONhPanrwybszwTzBq
         n1ltov6a4mJ4h2GAYhJnEqNVt4oVQZjLu0zQn+iJ62n79q4qeYfa9zfzMPX5PwlhwFzt
         Qn5fgbo5aJSRW7w7Q0rJ0OXkIMq2KOd6rPwV5xkSnARyQ+npXv5MnuyQTgEVC9Y2MQLL
         8QyQ==
X-Gm-Message-State: AOAM530iLYabOwN4eLcXU1BGhv+oFscV/u24XYYLmDEicjieHtU46C1l
        MtmUdMNiwwJX3v82gFuVT01hhUfTBP3UrZ/0K1TDgB26ml6aZSo95bMjqpnBQE0CFV2eJDIwBZk
        DMprt/IGpmNVVMH0YoOcxGZeY
X-Received: by 2002:aa7:cdcb:: with SMTP id h11mr33507038edw.252.1614198157105;
        Wed, 24 Feb 2021 12:22:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzq6ZhvWIl3uDmQDoot5ifJ+RyZfrotWKkmeV2nmLjUQb2TXAnkAqSnBlUK2IZEU6J/zi7nZg==
X-Received: by 2002:aa7:cdcb:: with SMTP id h11mr33507028edw.252.1614198156975;
        Wed, 24 Feb 2021 12:22:36 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id m7sm1926661ejk.52.2021.02.24.12.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 12:22:36 -0800 (PST)
Subject: Re: [PATCH V2 1/2] MFD: intel_pmt: Fix nuisance messages and handling
 of disabled capabilities
To:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20210128172846.99352-1-david.e.box@linux.intel.com>
 <20210224201005.1034005-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6d45db24-7741-1956-9cf1-35a7dec517c5@redhat.com>
Date:   Wed, 24 Feb 2021 21:22:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210224201005.1034005-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/24/21 9:10 PM, David E. Box wrote:
> Some products will be available that have PMT capabilities that are not
> supported. Remove the warnings in this instance to avoid nuisance messages
> and confusion.
> 
> Also return an error code for capabilities that are disabled by quirk to
> prevent them from keeping the driver loaded if only disabled capabilities
> are found.
> 
> Fixes: 4f8217d5b0ca ("mfd: Intel Platform Monitoring Technology support")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
> For merge in platform-drivers-x86
> 
> Based on 5.11-rc1 review-hans branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Which, assuming you did a git remote update recently is AKA platform-drivers-x86-v5.12-1 .

> Changes from V1:
> 
> 	- None. Patch 2 added.

The series looks good to me, so for the series:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Lee, since both patches touch mfd files (and patch 2 also touches files under drivers/platform/x86)
I think it would be best if you just merge the entire series.

As always I would appreciate a pull-req from you to also pull the changes
into my tree, in case further drivers/platform/x86/intel_pmt* changes
show up during this cycle.

Regards,

Hans






> 
>  drivers/mfd/intel_pmt.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mfd/intel_pmt.c b/drivers/mfd/intel_pmt.c
> index 744b230cdcca..65da2b17a204 100644
> --- a/drivers/mfd/intel_pmt.c
> +++ b/drivers/mfd/intel_pmt.c
> @@ -79,19 +79,18 @@ static int pmt_add_dev(struct pci_dev *pdev, struct intel_dvsec_header *header,
>  	case DVSEC_INTEL_ID_WATCHER:
>  		if (quirks & PMT_QUIRK_NO_WATCHER) {
>  			dev_info(dev, "Watcher not supported\n");
> -			return 0;
> +			return -EINVAL;
>  		}
>  		name = "pmt_watcher";
>  		break;
>  	case DVSEC_INTEL_ID_CRASHLOG:
>  		if (quirks & PMT_QUIRK_NO_CRASHLOG) {
>  			dev_info(dev, "Crashlog not supported\n");
> -			return 0;
> +			return -EINVAL;
>  		}
>  		name = "pmt_crashlog";
>  		break;
>  	default:
> -		dev_err(dev, "Unrecognized PMT capability: %d\n", id);
>  		return -EINVAL;
>  	}
>  
> @@ -174,12 +173,8 @@ static int pmt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
>  
>  		ret = pmt_add_dev(pdev, &header, quirks);
> -		if (ret) {
> -			dev_warn(&pdev->dev,
> -				 "Failed to add device for DVSEC id %d\n",
> -				 header.id);
> +		if (ret)
>  			continue;
> -		}
>  
>  		found_devices = true;
>  	} while (true);
> 
> base-commit: a7d53dbbc70a81d5781da7fc905b656f41ad2381
> 

