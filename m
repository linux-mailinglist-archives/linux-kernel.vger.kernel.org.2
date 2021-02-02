Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AD930C188
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 15:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhBBO0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 09:26:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234431AbhBBOXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 09:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612275746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C6L+kOE/7AOT3WLTSd2xPKhD0JMNSc9PBQa0gIUQv4U=;
        b=JBw8dBUfmSAIU5hmO+vljFmnPpdHaiu41TxNkQk58Dz9y+xnT//gU03YaJTih7VoY0xv6h
        8iSm9fCS2hyVsEb1hWvvctEHJuqFzcCAGokNTDEcChkYT6bO3Mfq04Km5m7wz2vStSAYZE
        QKGhlSb/pg5xPHY8ulg4HDvMXLUSzqI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-HEjhi_NyMZ6DbQUyuZ5fow-1; Tue, 02 Feb 2021 09:22:09 -0500
X-MC-Unique: HEjhi_NyMZ6DbQUyuZ5fow-1
Received: by mail-ej1-f72.google.com with SMTP id dc21so10035601ejb.19
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 06:22:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C6L+kOE/7AOT3WLTSd2xPKhD0JMNSc9PBQa0gIUQv4U=;
        b=hZWQJuLRKEOGws6eR7mMSCLtn8DseTwkmcVM4i9KKTjBX8X9kbPcL9DE6wmN70zdvT
         4ygzcofS55k9Yqsb8HTF6Kz72PhqaC4hX0PS783MuNyd9HgqutetzRbuEVd24lBPntOO
         IwJ12EZuAASAeWtndx/ClokZE+O2RxT3d8cwbnrk/0QBbkC+UG5yb0IyFFR91SEA468R
         +tRr9CgdCzCytPRoQcU4GCQsNs/5BkgyqJk8gwf22EWrSxWR3temDRG6EajSqppkuK3N
         qixPMVaCwWQ4LXi50WEE6nUWQPgC3gisxOhyl2Ma2//8JrKegJqIHxaQkqXx0rGMNwi2
         d1LA==
X-Gm-Message-State: AOAM531xniuDwg/94KYDxmiymdkpNq1yv7qvKHOIr27zEKbsKekh5ds+
        Tr8weSTTxf2G0fTOFcuLl8+xOc3PVmQR3spUnfBlUXAN2jbccKnXvh8p2cd2drBuiwtbJxgei9z
        y5PlcWU9VM+LUtXMBYe2yw7eCoi2Y0PcO9gblnaea3sZsrSdOIaFcPP2X28dKBu+wkd8l2qFGc4
        Y3
X-Received: by 2002:aa7:c3d9:: with SMTP id l25mr24753529edr.188.1612275727596;
        Tue, 02 Feb 2021 06:22:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+bTfJMAMN8jpN+U6EO9jpNDLMDM2BU0Ui5PW4QY7W2OPpO293nZNYCgnJszvOA7a1JBWKMw==
X-Received: by 2002:aa7:c3d9:: with SMTP id l25mr24753512edr.188.1612275727404;
        Tue, 02 Feb 2021 06:22:07 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id t19sm9462900ejc.62.2021.02.02.06.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 06:22:06 -0800 (PST)
Subject: Re: [PATCH] MFD: intel_pmt: Fix nuisance messages and handling of
 disabled capabilities
To:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org
References: <20210128172846.99352-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <32c18a6f-a1d9-243f-88e6-7a98b1299d87@redhat.com>
Date:   Tue, 2 Feb 2021 15:22:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210128172846.99352-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/28/21 6:28 PM, David E. Box wrote:
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

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
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

