Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDB534557E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 03:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCWCbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 22:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhCWCab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 22:30:31 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C97CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 19:30:29 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r17so10226267pgi.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 19:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=+YVFgC5GVnJ/gkmex9e0Xu8FuKKrJUnG/mNqLKZ4efQ=;
        b=q1ZZnEOgRoA6vhVrvNIAI7EJcROEg26OzX8dcoidZpwFFRBE8rQXORzB39Gvti6yp4
         Oz0sjk6dJWs2ptWOKRwkbLcHObrlb8t2EXIeChU+OMydz6+2JlK/mRfDg/Ox1qjVn97l
         za8Yrl0KUdvv72QlbH9wK7QLr4SiWaxFObWn5g2RQbj8EhYzjhihXoGdc2r7WFSS4Znn
         ptJ7xaYBGHRzAnUz+wVG3YziAH01HwLJvHVabHZhEYGliUti6z8EVtaVN9l28bKf3m3M
         cvSKMzpQg6AcEsu/ESJoOs96VmI9kdq93i/WnAAa/A9oIJ+c4oJCd2wEBlcYWbgTXiwZ
         9KrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+YVFgC5GVnJ/gkmex9e0Xu8FuKKrJUnG/mNqLKZ4efQ=;
        b=Uw8BKuBT+gjaT6Lksj8nQzXqVsgzK7ZnNnb6YPl/NcG0KZg/Qmvz82ta7zsLy2iNEZ
         8vDKSU8BVrl+9R9wJ1j1CyK1ItMPfRNilThX0TFOx2m4SMdd53p0OJlyMJspqTzNbPK2
         tjnk393idcXg5dDV8qcPXQR6JvrWV3RrcWw10ASOF2tHi1f59qb9+ifb8JDhvIUMqOUA
         YRnsW5/K/saz4TjGWiyECa1XCeD0kevjVIhCEegPfaL4v4sVUqMC1aNfEavjKl6n9zjQ
         cqRMW8GmmlwObAFMTeswVlHvgs+5MiH3Tdn5GDYIhQ/KuZ3GjUZ904nfsnKVOfdeJByP
         w1FA==
X-Gm-Message-State: AOAM532laClNLqVRO7BGYb7cjVs3HpVWip08hBiMbsLcKpayipzXAu5N
        Y37jT+xYnx+hcrW9gxZFHINqOA==
X-Google-Smtp-Source: ABdhPJxS3CflDvVSHKhEReY+Rutg7nyNfyIIWjMJMvFVNeEv1oUmwYvJKcraQMlHLjJ56fCdRpiBEw==
X-Received: by 2002:a17:902:b40e:b029:e6:837f:711 with SMTP id x14-20020a170902b40eb02900e6837f0711mr2672083plr.2.1616466628446;
        Mon, 22 Mar 2021 19:30:28 -0700 (PDT)
Received: from localhost ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id d5sm642135pjo.12.2021.03.22.19.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 19:30:27 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     Ira Weiny <ira.weiny@intel.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ndtest: Remove redundant NULL check
In-Reply-To: <20210322202029.GP3014244@iweiny-DESK2.sc.intel.com>
References: <1616407240-114077-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <20210322202029.GP3014244@iweiny-DESK2.sc.intel.com>
Date:   Tue, 23 Mar 2021 08:00:25 +0530
Message-ID: <87r1k61u0u.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ira,

Ira Weiny <ira.weiny@intel.com> writes:

> On Mon, Mar 22, 2021 at 06:00:40PM +0800, Jiapeng Chong wrote:
>> Fix the following coccicheck warnings:
>> 
>> ./tools/testing/nvdimm/test/ndtest.c:491:2-7: WARNING: NULL check before
>> some freeing functions is not needed.
>
> I don't think there is anything wrong with this patch specifically but why is
> buf not checked for null after the vmalloc?
>
> It seems to me that if size >= DIMM_SIZE and the vmalloc fails the gen pool
> allocation is going to be leaked.
>

If vmalloc fails, gen_pool_free will get called through ndtest_release_resource,
registered with devm_action. But we will still need to check for vmalloc fail.

I will fix that when I send my inject-error support for the driver.

Thanks,
Santosh

> Ira
>
>> 
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>> ---
>>  tools/testing/nvdimm/test/ndtest.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
>> index 6862915..98b4a43 100644
>> --- a/tools/testing/nvdimm/test/ndtest.c
>> +++ b/tools/testing/nvdimm/test/ndtest.c
>> @@ -487,8 +487,7 @@ static void *ndtest_alloc_resource(struct ndtest_priv *p, size_t size,
>>  buf_err:
>>  	if (__dma && size >= DIMM_SIZE)
>>  		gen_pool_free(ndtest_pool, __dma, size);
>> -	if (buf)
>> -		vfree(buf);
>> +	vfree(buf);
>>  	kfree(res);
>>  
>>  	return NULL;
>> -- 
>> 1.8.3.1
>> 
