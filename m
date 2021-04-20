Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C475B365A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhDTNkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhDTNkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:40:14 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5363DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 06:39:42 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m6-20020a17090a8586b02901507e1acf0fso4978409pjn.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=TURTItiC11pYJkHH0o60oVDJd9t7nZnMGY6KOaMv0x8=;
        b=Q0KZ/CgO0atEEVB5+kdaU85+Ez9w8l3FfaUdYoVjOm24ogeB0yjmvrZJfZIIFYiZ31
         7SzOTxW93CsA/VurWzRe/p+stm3zhWLCRr9vSGuFgfLeeRE8qmx3PYlrQ37jTjhVpZcP
         ChFUo+L1SlO3uP1OjBg75o4CiGvENKgbc8YyXexwihiEI4OelSd2CB5uyC85dzcpssAK
         MKZ6+DBu1GbjBHYu9+tUitpJPyWYKf752YvZ0v34aHr/SwgQs7WUNmEA0pc1sNA5QQyh
         RN1MkkJxhYVPZlpRpHdfXFSDiQlb7Xg3L3zpN1fimFGA55RwRVUwCfr1U9FGRFVZOgne
         F6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=TURTItiC11pYJkHH0o60oVDJd9t7nZnMGY6KOaMv0x8=;
        b=AMN9kkoCjDPhFrn12nL5NPZQfYJL15HAl5/O52OqPmsKLBh9bWkvbXE8TDlo/MvVLt
         Po9huakaAMtggnB0appoB6xdXEEte21Mh2Cq/wzNFTu7sruDrYF/ZjLCTsxLYcQJJRqn
         m9UnEQi3sK0W68u/DIu9dgaXhhLiz9lz8CSGmY2r7xZn+PkaXD63FFCA7BIiwBV9ZdTG
         QcC3+JeQq7UxzD0nyu3xuiST85Vp9r5xy8nEBJfntUInKPs+qeny8xFnRmgxfaCkR0LR
         RYjD/JM1ZT+rjR09xL626zOjPdkA5IudMyVcYtTUHiBHOaf2oicf1GY87ZCBbgKK4W1/
         jQOg==
X-Gm-Message-State: AOAM533ljdmi1cAr/3AH/e1QGKKyHQrLMHZ1xWuObCPW4dVqAiFCaK3Z
        B0ktdo/3S/BClrK3LNIhY5oEaQ==
X-Google-Smtp-Source: ABdhPJyq1D2Qx4Ck1SQz7xViLpO7AenHi/QoGKVS5uRZR4YBKnTpewlHOu2NvtCQ+NS29fMMriA/2g==
X-Received: by 2002:a17:90a:7893:: with SMTP id x19mr5223666pjk.3.1618925981881;
        Tue, 20 Apr 2021 06:39:41 -0700 (PDT)
Received: from localhost ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id jx20sm2591668pjb.41.2021.04.20.06.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:39:41 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     Ira Weiny <ira.weiny@intel.com>, Wan Jiabing <wanjiabing@vivo.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH] libnvdimm.h: Remove duplicate struct declaration
In-Reply-To: <20210419160411.GG1904484@iweiny-DESK2.sc.intel.com>
References: <20210419112725.42145-1-wanjiabing@vivo.com>
 <20210419160411.GG1904484@iweiny-DESK2.sc.intel.com>
Date:   Tue, 20 Apr 2021 19:09:35 +0530
Message-ID: <874kg1yt0o.fsf@fossix.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ira,

Ira Weiny <ira.weiny@intel.com> writes:

> On Mon, Apr 19, 2021 at 07:27:25PM +0800, Wan Jiabing wrote:
>> struct device is declared at 133rd line.
>> The declaration here is unnecessary. Remove it.
>> 
>> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>> ---
>>  include/linux/libnvdimm.h | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
>> index 01f251b6e36c..89b69e645ac7 100644
>> --- a/include/linux/libnvdimm.h
>> +++ b/include/linux/libnvdimm.h
>> @@ -141,7 +141,6 @@ static inline void __iomem *devm_nvdimm_ioremap(struct device *dev,
>>  
>>  struct nvdimm_bus;
>>  struct module;
>> -struct device;
>>  struct nd_blk_region;
>
> What is the coding style preference for pre-declarations like this?  Should
> they be placed at the top of the file?
>
> The patch is reasonable but if the intent is to declare right before use for
> clarity, both devm_nvdimm_memremap() and nd_blk_region_desc() use struct
> device.  So perhaps this duplicate is on purpose?

There are other struct device usage much later in the file, which doesn't have
any pre-declarations for struct device. So I assume this might not be on
purpose :-)

On a side note, types.h can also be removed, since it's already included in
kernel.h.

Santosh

>
> Ira
>
>>  struct nd_blk_region_desc {
>>  	int (*enable)(struct nvdimm_bus *nvdimm_bus, struct device *dev);
>> -- 
>> 2.25.1
>> 
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
