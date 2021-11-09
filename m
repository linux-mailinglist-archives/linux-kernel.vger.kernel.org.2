Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7B344B0C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 16:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhKIP6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 10:58:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45198 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235673AbhKIP6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 10:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636473348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=092jXrjG6aXn/vWwaks6dcvd07r8lEtW9Tr7OesikpI=;
        b=A32GIXD+mk6rBEG9IFiDDCvqdyITRJP8njpptWoKLaFIGh0JE6ZEGKMfIiSM5CbgAwzklY
        kWwAlYRXzzRrRExTvyLa2rTSbnkK4ZCX2czBgQbkxJepYOMWcg6j0cpHRttRC0gB1xQWzY
        Xn2nFSl7OhqOejcfglpK+OeLw19zk/c=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-gmxVbXb3OYSQ7aquoOrx2A-1; Tue, 09 Nov 2021 10:55:47 -0500
X-MC-Unique: gmxVbXb3OYSQ7aquoOrx2A-1
Received: by mail-ot1-f72.google.com with SMTP id o24-20020a9d5c18000000b0055bd38a039eso8262323otk.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 07:55:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=092jXrjG6aXn/vWwaks6dcvd07r8lEtW9Tr7OesikpI=;
        b=5768+aLv8N0Wxf6JlpWHLMayoHO1rMYNFqfUo/lWQkPLgW2aN3g3sHO+BsTHi6dh0O
         KGd6sU+evZyMZyLL/s+xfqPb+m/v3RHNxtEscvIHc9xzC7LcWDfr+CB/28YPLSGpAfRg
         2ADhKc2pw/YszMR1gTM9xY6DlsblRzb61lvqfiBd/pqleITjTJUPFtY8uhd5Evbal7TI
         ZqoDkXQWITHhuqRiksFV/GI3hvtQ6HvBNSbF/vtu8TR18o+180OmGw6p6uTqdhdXJCQT
         Y7gwmq8kCu2jmu3YHYhKyL1GrOdd5DQgzAY5T1zgNulZyn1Vas5P90MzM3WdhLqYDavL
         +WGg==
X-Gm-Message-State: AOAM533iT4zmUjsI5WCGwYt5gPgWmmyjBBEdEqOK8KLzJsJqkWPCwvbT
        e0EPvONmcCHrKXdTbSCbTTbfMBSCfkhKU0OinbKWgqQu2+gCAx2byWB8SJaRe/UnMA5mhyiCErM
        fLneP68WtdEY+LP4w2q9/U7DN
X-Received: by 2002:a05:6830:22cd:: with SMTP id q13mr6904874otc.253.1636473345732;
        Tue, 09 Nov 2021 07:55:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQo4jR23AuwnL+N7D+ok//ZOzG7nGQaLTQNdUkL9BZyvZ9nCYIfb+nbiE+QDoh+/Urc4/TnA==
X-Received: by 2002:a05:6830:22cd:: with SMTP id q13mr6904853otc.253.1636473345548;
        Tue, 09 Nov 2021 07:55:45 -0800 (PST)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u132sm7233433oib.50.2021.11.09.07.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 07:55:45 -0800 (PST)
Subject: Re: [PATCH v1 1/1] fpga: dfl: pci: Use pci_find_vsec_capability()
 when looking for DFL
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
References: <20211109154127.18455-1-andriy.shevchenko@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <8ccc133a-fb47-4548-fee3-d57775a5166d@redhat.com>
Date:   Tue, 9 Nov 2021 07:55:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211109154127.18455-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/9/21 7:41 AM, Andy Shevchenko wrote:
> Currently the find_dfls_by_vsec() opens code pci_find_vsec_capability().
> Refactor the former to use the latter. No functional change intended.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/fpga/dfl-pci.c | 17 +++++------------
>   1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 4d68719e608f..52b5e94db9c3 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -27,7 +27,7 @@
>   #define DRV_VERSION	"0.8"
>   #define DRV_NAME	"dfl-pci"
>   
> -#define PCI_VSEC_ID_INTEL_DFLS 0x43
> +#define PCI_VSEC_ID_INTEL_DFLS	0x0043	/* FPGA Device Feature List */
>   
>   #define PCI_VNDR_DFLS_CNT 0x8
>   #define PCI_VNDR_DFLS_RES 0xc
> @@ -138,19 +138,12 @@ static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
>   
>   static int find_dfls_by_vsec(struct pci_dev *pcidev, struct dfl_fpga_enum_info *info)
>   {
> -	u32 bir, offset, vndr_hdr, dfl_cnt, dfl_res;
> -	int dfl_res_off, i, bars, voff = 0;
> +	u32 bir, offset, dfl_cnt, dfl_res;
>   	resource_size_t start, len;
> +	int dfl_res_off, i, bars;
> +	u16 voff;
The later use of voff in pci_read_config_dword is of type 'int', it may 
be better to keep voff as an int.
>   
> -	while ((voff = pci_find_next_ext_capability(pcidev, voff, PCI_EXT_CAP_ID_VNDR))) {
> -		vndr_hdr = 0;
> -		pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER, &vndr_hdr);
> -
> -		if (PCI_VNDR_HEADER_ID(vndr_hdr) == PCI_VSEC_ID_INTEL_DFLS &&
> -		    pcidev->vendor == PCI_VENDOR_ID_INTEL)
> -			break;
> -	}
> -
> +	voff = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_DFLS);

This may be a weakness in the origin code, but intel isn't the exclusive 
user of DFL.

Tom

>   	if (!voff) {
>   		dev_dbg(&pcidev->dev, "%s no DFL VSEC found\n", __func__);
>   		return -ENODEV;

