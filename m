Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D908418474
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 22:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhIYUgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 16:36:08 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:43850 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhIYUgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 16:36:06 -0400
Received: by mail-ed1-f42.google.com with SMTP id v10so46155381edj.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 13:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7jUS0GLT445lz4KmtO0kmuQ8GSyq5Ff6GXWpF8lD5nc=;
        b=F+PJ200h+nlI0pruUfDoZ6AR8J8aGADoy0L71a1abUJQwPmW2mKzC2twWe16+VRtqW
         NQJz5/rT/fJwxRRCsvnDj4cLHVOQ4rl8nZeweeXkb9Y5rKCBsMPppVl9vpoWadKDCLzj
         9T5SiOltHtYsXnmvwHJPF6xx89QyJVvxiszOj4aCw21y/wH7O8z/cl/iJxN3NzKMGWJq
         jL7adQfZqCKELOISxgW+WpCO21/ufuP8tVw4gmJaAWQOk8uOBqnVmNKFNBrwjnHKBVIO
         JBy6XtepiFvgjW0wC+yPoLsfU28CmPRx4dlp0sQ2LfUwX/GH8CmcmCOx43WPthTazsgE
         9KTQ==
X-Gm-Message-State: AOAM531/LtHdzi9nd9zhwHvbxmEIaC6errvYrBubs+X1v4MTkVEeMBO9
        f46vXNhpzmeyF3pN9QEdNx4=
X-Google-Smtp-Source: ABdhPJwaOm0+xy1Zr9WbaCpqgIXxryMm7ICNu1xVqv7gflMg/PmYEJycyTo454TfKk+xO8OveX/PCg==
X-Received: by 2002:a50:e0cf:: with SMTP id j15mr13521451edl.23.1632602070768;
        Sat, 25 Sep 2021 13:34:30 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il. [109.186.240.23])
        by smtp.gmail.com with ESMTPSA id 6sm6681227ejx.82.2021.09.25.13.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Sep 2021 13:34:30 -0700 (PDT)
Subject: Re: [PATCH] Urgent bug fix causing Apple SSDs to not work.
To:     Keith Busch <kbusch@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Aditya Garg <gargaditya08@live.com>, "axboe@fb.com" <axboe@fb.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "james.smart@broadcom.com" <james.smart@broadcom.com>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trivial@kernel.org" <trivial@kernel.org>
References: <PNZPR01MB4415600ACD3C8D9944F15058B8A59@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <CAHk-=wgML11x9afCvmg9yhVm9wi5mvnjBvmX+i7OfMA0Vd4FWA@mail.gmail.com>
 <20210925195425.GB116968@dhcp-10-100-145-180.wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7e75e292-3073-f1f9-287a-badf92c8e4e8@grimberg.me>
Date:   Sat, 25 Sep 2021 23:34:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210925195425.GB116968@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> From: Aditya Garg <gargaditya08@live.com>
>>> Date: Fri, 24 Sep 2021 15:36:45 +0530
>>> Subject: [PATCH] Revert nvme to 5.14.5 to fix incompatibility arised in Apple SSDs.
>>> Fixes: e7006de6c238 (nvme: code command_id with a genctr for use-after-free validation)
>>
>> I think we need to hear more about the problem than just revert a
>> commit like this randomly. That commit has already been picked up for
>> -stable,
>>
>> What are the exact symptoms, and which Apple SSD is this?
>>
>> I do find this:
>>
>>    https://lore.kernel.org/all/cjJiSFV77WM51ciS8EuBcdeBcv9T83PUB-Kw3yi8PuC_LwrrUUnQ3w5RC1PbKvSYE72KryXp3wOJhv4Ov_WWIe2gKWOOo5uwuUjbbFA8HDM=@protonmail.com/
>>
>> which instead of a revert has an actual patch. Can you try that one?
>>
>> Keith Busch replied to that one, saying that the Apple SSD might not
>> be spec compliant, but hey, what else is new? If we start demanding
>> that hardware comply with specs, we'd have to scrap the whole notion
>> of working in the real world. Plus it would be very hypocritical of
>> us, since we ignore all specs when we deem them too limiting (whether
>> they be language specs, POSIX OS specs, or whatever).
> 
> Right, we have a lot of quirks for the apple controllers, what's one
> more? :)
> 
> Could the following patch be tried? I'm basing this off the 'lspci' from
> Orlando, but I'm assuming the previous model has the same limitation,
> too.
> 
> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7efb31b87f37..f0787233557f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -979,6 +979,7 @@ EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
>   blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
>   {
>   	struct nvme_command *cmd = nvme_req(req)->cmd;
> +	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
>   	blk_status_t ret = BLK_STS_OK;
>   
>   	if (!(req->rq_flags & RQF_DONTPREP)) {
> @@ -1027,7 +1028,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
>   		return BLK_STS_IOERR;
>   	}
>   
> -	nvme_req(req)->genctr++;
> +	if (!(ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN))
> +		nvme_req(req)->genctr++;
>   	cmd->common.command_id = nvme_cid(req);
>   	trace_nvme_setup_cmd(req, cmd);
>   	return ret;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9871c0c9374c..b49761d30df7 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -86,6 +86,12 @@ enum nvme_quirks {
>   	 */
>   	NVME_QUIRK_NO_DEEPEST_PS		= (1 << 5),
>   
> +	/*
> +	 * The controller requires the command_id value be be limited to the
> +	 * queue depth.
> +	 */
> +	NVME_QUIRK_SKIP_CID_GEN			= (1 << 6),
> +
>   	/*
>   	 * Set MEDIUM priority on SQ creation
>   	 */
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b82492cd7503..d9f22ed68185 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3369,7 +3369,10 @@ static const struct pci_device_id nvme_id_table[] = {
>   	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
>   		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
>   				NVME_QUIRK_128_BYTES_SQES |
> -				NVME_QUIRK_SHARED_TAGS },
> +				NVME_QUIRK_SHARED_TAGS ,
> +				NVME_QUIRK_SKIP_CID_GEN },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2006),
> +		.driver_data = NVME_QUIRK_SKIP_CID_GEN },
>   
>   	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
>   	{ 0, }
> --
> 

Exactly the patch that I was going to propose. The only downside
is that we need to access the controller in the hot-path...
