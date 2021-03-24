Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E219F34827E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 21:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbhCXUDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 16:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238124AbhCXUCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 16:02:50 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B3BC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 13:02:49 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u20so153557lja.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 13:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ikmrD3MxT8nCwzKO4AmRgjhRiiwQzwvU+EZ+IDnfFKM=;
        b=h5DEGUUhyd88y0rgTYeTGggvySv93LWZvXyaJh6Qs+I2KOLuydX1/hjqDNTzm0Xcbb
         TtZPcafM7Tyqyslx7D+npdPvNKj2OaRm8PWLrvJ3hJIt3tzoNciYYNVB4SZ29gwdX0lI
         eiR/BuOgBbuIMnMcnVmAT9vn9yct7NeA73VuAeawPEtUoJQvzVR52O2bjgKBg3EQAIN2
         4ZPzXTcwe2LYcH6ZsNi0BkCl8we1Xfksf7Ik+0K1ULv6iWwl3vt+s6icQuF7iTxySHfc
         ornzz7D/85Sf0hziblEhwbdkjuilLfVTwSQ1Qxt3giVM7sFyK8GrCb8AoeL5onl6dL09
         FBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ikmrD3MxT8nCwzKO4AmRgjhRiiwQzwvU+EZ+IDnfFKM=;
        b=loxxPJr2vtNYr5gPuZfQTOTcnFVn4C/fp1u11/CUPxTS1nfY7rqmEHDfOk19o2TGML
         fyM3356axvCDS2pdiaeWMZRprHEQjUsIeTDkwJIsnURcriEmeh1IhTDWC8u6tpoeU/0o
         b/fQm03H3XApBDtM/QGWlF/Th2/y6DuT9/i3eP18gnmq6EfYAQt3/3jZAbeaScdKlZvm
         nd9a6I7Uy/z5SmYwOEOqr+0cOq+IaZbHRu+ABKOT77TMlU7z0baBzbYyMeqRkkXTT8lu
         6Tam0vZZu/LGOAUaPzJlHcIcURSKyRutVrubhFcHlt2GNMT1ae4mhqedBY4RL+BMaRg2
         24Lw==
X-Gm-Message-State: AOAM530AuxbWPPkhSLDFKWp8P6nMrMq3eg3Qgh/P5qMIJlX7AdxKlmKZ
        dPfkj7SJqP3L93kfrbz6LZI=
X-Google-Smtp-Source: ABdhPJyzk04mqnF8+gSwtdRoq+8D5BwEafKIGONJqSVvP6IlW1SAK8J9Qi/oy17u8LCAeMyOy5V6iA==
X-Received: by 2002:a2e:9244:: with SMTP id v4mr3273677ljg.196.1616616168389;
        Wed, 24 Mar 2021 13:02:48 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-60.dynamic.spd-mgts.ru. [109.252.193.60])
        by smtp.googlemail.com with ESMTPSA id z64sm318457lfa.92.2021.03.24.13.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 13:02:48 -0700 (PDT)
Subject: Re: [PATCH] mm: cma: fix corruption cma_sysfs_alloc_pages_count
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, jhubbard@nvidia.com,
        willy@infradead.org
References: <20210324192044.1505747-1-minchan@kernel.org>
 <18ee5c3e-fba2-0d8d-bd93-5fb8d0dd7a01@gmail.com>
 <89ba4c7a-42d2-5412-2367-cc1cffc1117b@gmail.com>
 <YFuZua1TIEkXtqoL@google.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <900f5707-3352-e3d1-69e8-c1f8580c0fc4@gmail.com>
Date:   Wed, 24 Mar 2021 23:02:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFuZua1TIEkXtqoL@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.03.2021 22:57, Minchan Kim пишет:
> On Wed, Mar 24, 2021 at 10:49:58PM +0300, Dmitry Osipenko wrote:
>> 24.03.2021 22:43, Dmitry Osipenko пишет:
>>> 24.03.2021 22:20, Minchan Kim пишет:
>>>>  static int __init cma_sysfs_init(void)
>>>>  {
>>>> -	int i = 0;
>>>> +	struct kobject *cma_kobj_root;
>>>> +	struct cma_kobject *cma_kobj;
>>>>  	struct cma *cma;
>>>> +	unsigned int i;
>>>
>>>>  	while (--i >= 0) {
>>>
>>> Do you realize that this doesn't work anymore?
>>>
>>>>  		cma = &cma_areas[i];
>>>> -		kobject_put(&cma->stat->kobj);
>>>> -	}
>>>>  
>>>> -	kfree(cma_stats);
>>>> -	kobject_put(cma_kobj);
>>>> +		kobject_put(&cma->cma_kobj->kobj);
>>>> +		kfree(cma->cma_kobj);
>>>
>>> Freeing a null pointer?
>>>
>>>> +		cma->cma_kobj = NULL;
>>>> +	}
>>>> +	kobject_put(cma_kobj_root);
>>>
>>
>> Please try to simulate the errors and check that error path is working
>> properly in the next version.
>>
>> Alternatively, we could remove the cma_kobj_release entirely, like Greg
>> suggested previously, and then don't care about cleaning up at all.
> 
> Does he suggested it to remove cma_kobj_release?(Initially, I did but
> was rejected from Greg)
> 

Alright, I haven't followed the previous threads fully and only saw the
reply where he suggested to removed it.


