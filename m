Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648F234822D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbhCXTuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237807AbhCXTuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:50:01 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F14C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:50:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b83so33766560lfd.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O8cBTKAdHJ0ckCRthe0qr0Y/0P1LRqCmcET2CZxqc7c=;
        b=lr4xRl9TSCcUHHO5T39ojnZ/k0dwGVHT5yGCtsXyBtkK8xEctwhISxsiVnAYubdD8t
         uepXFAoTP/5QoMevBO1N3fZayc9a8oEP+4esELAAaYPuJvLGEEy/XxlGWiCGFwM93Q1F
         vnIjjGUFl+1584HRaHHhwG24dX8LTp/eTzk/kfECOpM7LEUdT51G5jOGmij7cppL3vJt
         fpzqHQxO4cQupFKSlBzx6g0vFA/UJINMBDIuyvuVfSnrNOk7H50akSE7XrWqtX/kLvU2
         ZOeIyonq2gzyMGjMKoSF8O/NgjdMsC5+PpQtf0ACtidU/Je+ff2qBXHNNoSOwbdtRWqm
         REkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O8cBTKAdHJ0ckCRthe0qr0Y/0P1LRqCmcET2CZxqc7c=;
        b=A3Bzp+kZqQssTw1R8iDvsaBdbMl/ox9KbD+0HvXiOlOoh1elkZmEKYLPpMKnv7bLHd
         Z5brsMLrJXGf1ldpo15wDYHc8pQnB+6JMTPyavwKxXBkjVcXZC2T9BPckUn9rp00sYwJ
         18bT+oLoX3a3JUzMDGIswZnW+SKpmB7L0il5plpnB+gD2bdrEHP/TeYQSYOfvhfe2lr6
         BrLTy8wAwG1Dr3OnjRxpImJ6V2HOiWeo+fA7lFX14jeYzT8tCp69SVphIHBpXI9xFIdd
         wy4KBZG5tZtLUtAtBxYN6XxgY5lrYJ/WXdk0b9ojemRl4SgZhHtW09JG1B3+N7tVhkGS
         oEVA==
X-Gm-Message-State: AOAM530iwmpgBEs0sozO5HQfYIqwFATJw96sv7GJ/3T7D0uT9jrK3D8w
        4byP0OPqtg/Pudn+5Ghm6Mc=
X-Google-Smtp-Source: ABdhPJwP5pt79NE9N+S388jRM1JPamW66D8sTd20YsY8xlbOLEn3eUK39PCoeRTzgunt3hJ8CTk3fw==
X-Received: by 2002:a19:b03:: with SMTP id 3mr2878904lfl.236.1616615399560;
        Wed, 24 Mar 2021 12:49:59 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-60.dynamic.spd-mgts.ru. [109.252.193.60])
        by smtp.googlemail.com with ESMTPSA id y10sm332353lfl.240.2021.03.24.12.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 12:49:59 -0700 (PDT)
Subject: Re: [PATCH] mm: cma: fix corruption cma_sysfs_alloc_pages_count
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        jhubbard@nvidia.com, willy@infradead.org
References: <20210324192044.1505747-1-minchan@kernel.org>
 <18ee5c3e-fba2-0d8d-bd93-5fb8d0dd7a01@gmail.com>
Message-ID: <89ba4c7a-42d2-5412-2367-cc1cffc1117b@gmail.com>
Date:   Wed, 24 Mar 2021 22:49:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <18ee5c3e-fba2-0d8d-bd93-5fb8d0dd7a01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.03.2021 22:43, Dmitry Osipenko пишет:
> 24.03.2021 22:20, Minchan Kim пишет:
>>  static int __init cma_sysfs_init(void)
>>  {
>> -	int i = 0;
>> +	struct kobject *cma_kobj_root;
>> +	struct cma_kobject *cma_kobj;
>>  	struct cma *cma;
>> +	unsigned int i;
> 
>>  	while (--i >= 0) {
> 
> Do you realize that this doesn't work anymore?
> 
>>  		cma = &cma_areas[i];
>> -		kobject_put(&cma->stat->kobj);
>> -	}
>>  
>> -	kfree(cma_stats);
>> -	kobject_put(cma_kobj);
>> +		kobject_put(&cma->cma_kobj->kobj);
>> +		kfree(cma->cma_kobj);
> 
> Freeing a null pointer?
> 
>> +		cma->cma_kobj = NULL;
>> +	}
>> +	kobject_put(cma_kobj_root);
> 

Please try to simulate the errors and check that error path is working
properly in the next version.

Alternatively, we could remove the cma_kobj_release entirely, like Greg
suggested previously, and then don't care about cleaning up at all.
