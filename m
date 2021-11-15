Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6619B4524DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 02:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351705AbhKPBp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 20:45:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50904 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237008AbhKOSbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637000917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aK6hdSkba46cIWzDDwDuhdoY6SKI2x0eiy91mL63vTY=;
        b=AkPAJiETYHmxSJnHkAipzkjOJWZZH/JzEPnwR+tWmMw+hoUi5cyCMVomV5QWs1VvS4eveZ
        ktbwLHcgB8ox0Ly1BXFZcxVM3suhnZv8hFp63BZqrsS1tsmBKFAX3ICDi4btAX24uWJ/s8
        MzH3IjBVSwWcko1Eoy0gcKPMMvI5d5E=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-jpBX9AJbOGWhlwh9awxqpg-1; Mon, 15 Nov 2021 13:28:36 -0500
X-MC-Unique: jpBX9AJbOGWhlwh9awxqpg-1
Received: by mail-pl1-f199.google.com with SMTP id p16-20020a170902e75000b0014271728fd6so6533775plf.18
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aK6hdSkba46cIWzDDwDuhdoY6SKI2x0eiy91mL63vTY=;
        b=EMrRal9j6yB/7skRtwL6+BJ+9xrqpS0ZBu0fZ5fv04CjA/JfA8qrW6Lvq7f+DA/jPQ
         HtS1Qp7au7+E4Zmfj7L+vUX2v4CyVpOT+J85ATykQFeMk8+79sCoH9UpvizN9ojbm7vu
         w0c2ceb2M2W72JelS2VYtCYYQSrKF5K4OIPPbHgV/Ux1OfQGTaZMhUz1wGkVA1yXzegT
         MVUxM3JsLIcoogO8IyJ8GI9flltX0/563g7QW3SP5fQEr5SxmOQifCb7dx7DPlA+EHaj
         DH6WSooxssMETJrqt0BmKt72lwvjMPELJqzotE6RF06ql7w6q/vell259b/EviO2au9v
         bQFA==
X-Gm-Message-State: AOAM53143WCMkAp62H8Z4aum5V0UCGBOUBCW5MtrprnnX3etEKobkM9Y
        Sn9EasuWI+XjWXgwpXIVwFI/POvBQU9Pd2Fy2hRMmR0BpXCgTLz6o+7svf5pZKVbeazmAoE3PhC
        GGjADQ4Piyh2dr7dTDzaXBu74jHMvrJH34RI6mZe06PHkN7sIqeHcCcDp9A4eNS7xo7UamVg=
X-Received: by 2002:a17:902:db0e:b0:142:13e4:b456 with SMTP id m14-20020a170902db0e00b0014213e4b456mr37967740plx.43.1637000914902;
        Mon, 15 Nov 2021 10:28:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzoa4unXYJvqaLuNm3SXfxeoZm0u9FN99pjwP+rVREsW6clf0JQsu6KT/A37FXckA140Y8vFg==
X-Received: by 2002:a17:902:db0e:b0:142:13e4:b456 with SMTP id m14-20020a170902db0e00b0014213e4b456mr37967698plx.43.1637000914561;
        Mon, 15 Nov 2021 10:28:34 -0800 (PST)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i127sm15204292pfe.2.2021.11.15.10.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 10:28:34 -0800 (PST)
Subject: Re: [PATCH] fpga: dfl: pci: generalize find_dfls_by_vsec()
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211113221252.4062704-1-trix@redhat.com>
 <20211115012516.GA288162@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <f645abbe-230c-b3b8-de6c-6b8a605535f4@redhat.com>
Date:   Mon, 15 Nov 2021 10:28:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211115012516.GA288162@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/14/21 5:25 PM, Xu Yilun wrote:
> On Sat, Nov 13, 2021 at 02:12:52PM -0800, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> find_dfls_by_vsec() is a general dfl function.
>> Although dfl has multiple vendors, only Intel is supported.
>> Move vsec and vendor id to an array variable.
>> Other vendors can append the array to enable their support.
> As Hao mentioned, DVSEC could be a better solution if DFL should be
> present in components by a variety of vendors. This is not finally
> determined, but I think we should not add new features for VSEC now.

Can you expand what you mean by this ?

I am considering the n5010 usecase, the vendor is not intel and will go 
through this dfl function and always fail.

This is broken.

Either the function should be generalized or moved to an intel specific 
call.

Tom

>
> Thanks,
> Yilun
>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/fpga/dfl-pci.c | 31 ++++++++++++++++++++++++-------
>>   1 file changed, 24 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
>> index 4d68719e608f..9dc0815c8274 100644
>> --- a/drivers/fpga/dfl-pci.c
>> +++ b/drivers/fpga/dfl-pci.c
>> @@ -136,19 +136,36 @@ static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
>>   	return table;
>>   }
>>   
>> -static int find_dfls_by_vsec(struct pci_dev *pcidev, struct dfl_fpga_enum_info *info)
>> +struct dfl_vsec {
>> +	u16 vendor;
>> +	u16 id;
>> +};
>> +
>> +static struct dfl_vsec vsecs[] = {
>> +	{ PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_DFLS },
>> +};
>> +
>> +static int find_dfls_by_vsec(struct pci_dev *pcidev,
>> +			     struct dfl_fpga_enum_info *info)
>>   {
>>   	u32 bir, offset, vndr_hdr, dfl_cnt, dfl_res;
>>   	int dfl_res_off, i, bars, voff = 0;
>>   	resource_size_t start, len;
>>   
>> -	while ((voff = pci_find_next_ext_capability(pcidev, voff, PCI_EXT_CAP_ID_VNDR))) {
>> -		vndr_hdr = 0;
>> -		pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER, &vndr_hdr);
>> +	for (i = 0; i < ARRAY_SIZE(vsecs); i++) {
>> +		if (pcidev->vendor != vsecs[i].vendor)
>> +			continue;
>> +
>> +		while ((voff =
>> +			pci_find_next_ext_capability(pcidev, voff,
>> +						     PCI_EXT_CAP_ID_VNDR))) {
>> +			vndr_hdr = 0;
>> +			pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER,
>> +					      &vndr_hdr);
>>   
>> -		if (PCI_VNDR_HEADER_ID(vndr_hdr) == PCI_VSEC_ID_INTEL_DFLS &&
>> -		    pcidev->vendor == PCI_VENDOR_ID_INTEL)
>> -			break;
>> +			if (PCI_VNDR_HEADER_ID(vndr_hdr) == vsecs[i].id)
>> +				break;
>> +		}
>>   	}
>>   
>>   	if (!voff) {
>> -- 
>> 2.26.3

