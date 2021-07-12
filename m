Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5503C5FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 17:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbhGLP4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 11:56:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230187AbhGLP4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 11:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626105239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MiD9aPGHvtw35XjJa0uYpVwhy0XuXKLsygIcxjEGRTI=;
        b=T3unAS/N7TJ+SNVZ4PMN8rOPqYnyA+f7zFsXRWk9IMgRImaqjGGfO4c59PH4wHxKQXvpIl
        rLHzEWG909yKLeiji3Yb2Mql5axC+vP9cTsAM9YaKttwxYKuK5DQ5HWNPGGo9s1PlmUnIV
        r+cSszS30HevuHSUXwLuq8mltbfH9QM=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-3ka3g7l-PwWsxGQYNmp7Xw-1; Mon, 12 Jul 2021 11:53:58 -0400
X-MC-Unique: 3ka3g7l-PwWsxGQYNmp7Xw-1
Received: by mail-ot1-f71.google.com with SMTP id l7-20020a9d55070000b02904b92b8a20efso3276112oth.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 08:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MiD9aPGHvtw35XjJa0uYpVwhy0XuXKLsygIcxjEGRTI=;
        b=gDjKTt+sqJoMscFLS17Nq6TJys6w31WC1ZquW4T7+xLQTAOb4bO8qx20LWeT8zTCV8
         IFFq7EsFXL7ORHT68ZRYRoSwkMEIjLAoK+iE7ZwvmAyykIpEuj/nXxBn61BrsKBGCkkX
         89kf3gdjdOvOhfob29SuwvCwTdnQwUP7wpMuRhP021mp4jOKliDRSeCKd0urkcPfZxM/
         IlbKVxvePnrLOE7lEWfWeYBPOL2S8gSTkYV7FX9qoKEQHS6M1eBmp6tWZJsGWEGIksQz
         cX/Df+L6nQXran7rIPE7ej9PPKG2TIOp07aSjyAtpqj8qT4iH1TTe+Zpqiq4CcHv3iBW
         Hyyg==
X-Gm-Message-State: AOAM532Ww91BQx/mP5hx0CKGo91ge6ZRT75AzC5Y8jkmba2SeSXtursh
        9AxgiBMY2JYcWiAjRXhgatCt7FRah8DnN/YOjsJyMWjitUYw/MouYbioj8qSYitqxhlFgyMoJ7E
        0yyVyPBZklfMJ/Nj2ZuKUODor70gHSqSmKTZs2Z1KJpdb3aQvanMkeDoj5+VS2QEH0NpGydA=
X-Received: by 2002:aca:6203:: with SMTP id w3mr32470374oib.64.1626105237128;
        Mon, 12 Jul 2021 08:53:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBQk/PEnEo2fM/sVXfRIrtRHgEFsFKtQ4+UXomS6/twyr/Dp53uwDHYxQtwRhAssiUu2kK3g==
X-Received: by 2002:aca:6203:: with SMTP id w3mr32470342oib.64.1626105236832;
        Mon, 12 Jul 2021 08:53:56 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m19sm920356otp.55.2021.07.12.08.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 08:53:56 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] fpga: remove compat_id from fpga_manager and
 fpga_region
To:     "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Russ Weight <russell.h.weight@intel.com>
Cc:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210709134229.2510349-1-trix@redhat.com>
 <20210709134229.2510349-6-trix@redhat.com>
 <DM6PR11MB3819098B673C54530B227D4385159@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <2a3b3131-96a3-9761-f2e7-63a32fd277f6@redhat.com>
Date:   Mon, 12 Jul 2021 08:53:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB3819098B673C54530B227D4385159@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/11/21 6:40 PM, Wu, Hao wrote:
>> -----Original Message-----
>> From: trix@redhat.com <trix@redhat.com>
>> Sent: Friday, July 9, 2021 9:42 PM
>> To: mdf@kernel.org; corbet@lwn.net; Wu, Hao <hao.wu@intel.com>
>> Cc: linux-fpga@vger.kernel.org; linux-doc@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Tom Rix <trix@redhat.com>
>> Subject: [PATCH v2 4/4] fpga: remove compat_id from fpga_manager and
>> fpga_region
>>
>> From: Tom Rix <trix@redhat.com>
>>
>> compat_id is implementation specific.  So the data should be
>> stored at the implemeation layer, not the infrastructure layer.
>> Remove the compat_id elements and supporting code.
> I think current compat_id format can meet the checking requirement.
> Actually I hope other hardware which needs compatible checking
> to expose the same format compat_id. Then we can have more
> unified/common code, e.g. userspace application/lib handling.

v2 does not change the current ABI. The dfl output is the same as 
before, the other nonusers get -ENOENT.

For dfl compat_id is 2 64 bit registers.

For compat_id to be useful to the others, they need the flexibility to 
print to the sysfs in the manner that aligns with whatever their user 
library interface is, 2 64 values isn't going to work for everyone.  ex/ 
xrt likely would be a uuid_t printed out a special way. someone else 
maybe just string in the board fw, maybe some has a 8 or 256 bits of 
compat_id  etc.

as a driver region specific op, others are free to do whatever is required.

> Currently I didn't see any other usage or requirement on this part
> now, only DFL uses it.  So should we leave it here at this moment?
> I feel we don't have to change it for now to move it to a
> Per-fpga-mgr format. : )

The motivation for doing this now is the 'use standard class dev release 
.. ' patchset

I really do not like 2 register functions.

By moving compat_id, the 2 register functions reduces down to 1.

I did a poc here

https://lore.kernel.org/linux-fpga/20210709184511.2521508-1-trix@redhat.com/

Tom

>
> Thanks
> Hao
>
>> Printing out the compat_id is done with the fpga_region
>> compat_id_show() op.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/fpga/dfl-fme-mgr.c       |  7 -------
>>   drivers/fpga/dfl-fme-region.c    |  1 -
>>   drivers/fpga/fpga-region.c       |  7 +------
>>   include/linux/fpga/fpga-mgr.h    | 13 -------------
>>   include/linux/fpga/fpga-region.h |  2 --
>>   5 files changed, 1 insertion(+), 29 deletions(-)
>>
>> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
>> index cd0b9157ea6e5..8c5423eeffe75 100644
>> --- a/drivers/fpga/dfl-fme-mgr.c
>> +++ b/drivers/fpga/dfl-fme-mgr.c
>> @@ -292,7 +292,6 @@ EXPORT_SYMBOL_GPL(fme_mgr_get_compat_id);
>>   static int fme_mgr_probe(struct platform_device *pdev)
>>   {
>>   	struct dfl_fme_mgr_pdata *pdata = dev_get_platdata(&pdev->dev);
>> -	struct fpga_compat_id *compat_id;
>>   	struct device *dev = &pdev->dev;
>>   	struct fme_mgr_priv *priv;
>>   	struct fpga_manager *mgr;
>> @@ -312,10 +311,6 @@ static int fme_mgr_probe(struct platform_device
>> *pdev)
>>   			return PTR_ERR(priv->ioaddr);
>>   	}
>>
>> -	compat_id = devm_kzalloc(dev, sizeof(*compat_id), GFP_KERNEL);
>> -	if (!compat_id)
>> -		return -ENOMEM;
>> -
>>   	_fme_mgr_get_compat_id(priv->ioaddr, &priv->compat_id);
>>
>>   	mgr = devm_fpga_mgr_create(dev, "DFL FME FPGA Manager",
>> @@ -323,8 +318,6 @@ static int fme_mgr_probe(struct platform_device *pdev)
>>   	if (!mgr)
>>   		return -ENOMEM;
>>
>> -	mgr->compat_id = compat_id;
>> -
>>   	return devm_fpga_mgr_register(dev, mgr);
>>   }
>>
>> diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
>> index d21eacbf2469f..be1d57ee37666 100644
>> --- a/drivers/fpga/dfl-fme-region.c
>> +++ b/drivers/fpga/dfl-fme-region.c
>> @@ -64,7 +64,6 @@ static int fme_region_probe(struct platform_device *pdev)
>>   	}
>>
>>   	region->priv = pdata;
>> -	region->compat_id = mgr->compat_id;
>>   	platform_set_drvdata(pdev, region);
>>
>>   	ret = fpga_region_register(region);
>> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>> index 864dd4f290e3b..b08d3914716f0 100644
>> --- a/drivers/fpga/fpga-region.c
>> +++ b/drivers/fpga/fpga-region.c
>> @@ -172,12 +172,7 @@ static ssize_t compat_id_show(struct device *dev,
>>   	if (region->rops && region->rops->compat_id_show)
>>   		return region->rops->compat_id_show(region, buf);
>>
>> -	if (!region->compat_id)
>> -		return -ENOENT;
>> -
>> -	return sprintf(buf, "%016llx%016llx\n",
>> -		       (unsigned long long)region->compat_id->id_h,
>> -		       (unsigned long long)region->compat_id->id_l);
>> +	return -ENOENT;
>>   }
>>
>>   static DEVICE_ATTR_RO(compat_id);
>> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
>> index ec2cd8bfceb00..ebdea215a8643 100644
>> --- a/include/linux/fpga/fpga-mgr.h
>> +++ b/include/linux/fpga/fpga-mgr.h
>> @@ -143,24 +143,12 @@ struct fpga_manager_ops {
>>   #define FPGA_MGR_STATUS_IP_PROTOCOL_ERR		BIT(3)
>>   #define FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR	BIT(4)
>>
>> -/**
>> - * struct fpga_compat_id - id for compatibility check
>> - *
>> - * @id_h: high 64bit of the compat_id
>> - * @id_l: low 64bit of the compat_id
>> - */
>> -struct fpga_compat_id {
>> -	u64 id_h;
>> -	u64 id_l;
>> -};
>> -
>>   /**
>>    * struct fpga_manager - fpga manager structure
>>    * @name: name of low level fpga manager
>>    * @dev: fpga manager device
>>    * @ref_mutex: only allows one reference to fpga manager
>>    * @state: state of fpga manager
>> - * @compat_id: FPGA manager id for compatibility check.
>>    * @mops: pointer to struct of fpga manager ops
>>    * @priv: low level driver private date
>>    */
>> @@ -169,7 +157,6 @@ struct fpga_manager {
>>   	struct device dev;
>>   	struct mutex ref_mutex;
>>   	enum fpga_mgr_states state;
>> -	struct fpga_compat_id *compat_id;
>>   	const struct fpga_manager_ops *mops;
>>   	void *priv;
>>   };
>> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
>> index 236d3819f1c13..afc79784b2823 100644
>> --- a/include/linux/fpga/fpga-region.h
>> +++ b/include/linux/fpga/fpga-region.h
>> @@ -30,7 +30,6 @@ struct fpga_region_ops {
>>    * @bridge_list: list of FPGA bridges specified in region
>>    * @mgr: FPGA manager
>>    * @info: FPGA image info
>> - * @compat_id: FPGA region id for compatibility check.
>>    * @priv: private data
>>    * @rops: optional pointer to struct for fpga region ops
>>    */
>> @@ -40,7 +39,6 @@ struct fpga_region {
>>   	struct list_head bridge_list;
>>   	struct fpga_manager *mgr;
>>   	struct fpga_image_info *info;
>> -	struct fpga_compat_id *compat_id;
>>   	void *priv;
>>   	const struct fpga_region_ops *rops;
>>   };
>> --
>> 2.26.3

