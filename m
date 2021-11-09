Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277B244B2E0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 19:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242667AbhKISyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 13:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237935AbhKISyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 13:54:44 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F5DC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 10:51:57 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id e11so311393ljo.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 10:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RcJOxCwTS3Za1DIXebYmwbP1nNUgtXkGoDkbHuW872I=;
        b=OhQHI2GVJY5W0lErScK7eneQ/f/+RdYbeY3Y+SmN+kIDHR+iZhBRROw9jYtynPnJo7
         8SFuBzGP99E9sPLKWqLn6qJWx56bOK/QEpAF/odpjjzXVUd2Htv03o03loj7l56f4hSy
         bcUTbJoFVDbWsTyfXC8BCto5EsSTE+q6sQkzqSAZ0d8exYF3hUkXNNXnK3+bpG3XtKeu
         l9tCL6eneF+GW4zaqcRu7E46ZRZ1kmcPyctPf2Czgh1+VCN37RBX4HBNmZ2WijkDDOuF
         bGyYJsxZzDf9MARqdvrhQz32cwngT1jdLf4XzKzzw1BxbIeNg9up8CZbH1ENROB+Poji
         Kn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RcJOxCwTS3Za1DIXebYmwbP1nNUgtXkGoDkbHuW872I=;
        b=cVcHZkFiXjfIw2rnf7Cl/yZilfIYP/ux5Z5eu/9USgZMkPcs6j9pEIVyp7DrwM5iDJ
         ypHPjpCMt3/3TQ962VNQaBITiv3lPOO7b3kDAd5wHoQOcWip2d7lVohH41D7iKkqP02L
         CgDYurX4hroRsQPO8LyDDxoPVrOK3vHdIf8FchrprBRlm8qxaRgmfaOsAQNOlkvDUAeG
         mC1sm2mBwmCv+ve5KHQKWM72qnJHySW3GIeeG+C9geXLGxRyDxBxbq4Q2zir9SJJwvS/
         MmYZLBok0GOU8jS+HHT0ozOLkufuLlBDfxNQDtsnyQq0y0Pvtx9N7NGhmHT0/6SBDiob
         XPiQ==
X-Gm-Message-State: AOAM531iK/PD5PjulSAs2nG7bvm/5tSTsZTF5JYufygEXLNVPegO3/NY
        BMbEr6T9JzmOk2q5ePgynlM=
X-Google-Smtp-Source: ABdhPJxayf9eKbrNJ/FjI4DOI7nzTR9/ujN9m5MahKE+KF9yMCPcrSW/UchrHS05w8LK2eVXZZ4BwA==
X-Received: by 2002:a2e:bf18:: with SMTP id c24mr10191516ljr.408.1636483915850;
        Tue, 09 Nov 2021 10:51:55 -0800 (PST)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id z17sm95703lfd.242.2021.11.09.10.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 10:51:55 -0800 (PST)
Subject: Re: [PATCH V2 3/4] xen/unpopulated-alloc: Add mechanism to use Xen
 resource
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
References: <1635264312-3796-1-git-send-email-olekstysh@gmail.com>
 <1635264312-3796-4-git-send-email-olekstysh@gmail.com>
 <0b1837f9-57ef-8deb-df78-cb7841d93d68@oracle.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <00a9467a-3e48-9c68-1ac2-7ec2c7380d97@gmail.com>
Date:   Tue, 9 Nov 2021 20:51:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0b1837f9-57ef-8deb-df78-cb7841d93d68@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28.10.21 22:08, Boris Ostrovsky wrote:

Hi Boris

I am sorry for the late response.

>
> On 10/26/21 12:05 PM, Oleksandr Tyshchenko wrote:
>>   +static void unpopulated_init(void)
>> +{
>> +    static bool inited = false;
>> +    int ret;
>> +
>> +    if (inited)
>> +        return;
>> +
>> +    /*
>> +     * Try to initialize Xen resource the first and fall back to 
>> default
>> +     * resource if arch doesn't offer one.
>> +     */
>> +    ret = arch_xen_unpopulated_init(&xen_resource);
>> +    if (!ret)
>> +        target_resource = &xen_resource;
>> +    else if (ret == -ENOSYS)
>> +        target_resource = &iomem_resource;
>> +    else
>> +        pr_err("Cannot initialize Xen resource\n");
>
>
> I'd pass target_resource as a parameter to arch_xen_unpopulated_init() 
> instead. Default routine will assign it iomem_resource and you won't 
> have to deal with -ENOSYS.

That would be much better, thank you. Will do.


>
>
>
> Also, what happens in case of error? Is it fatal? I don't think your 
> changes in fill_list() will work.

The error is fatal as we don't have a suitable resource to allocate a 
region from, and yes, the fill_list() must not be called.


>
>
>
>> +
>> +    inited = true;
>
>
> I agree with Stefano in that it would be better to call this from an 
> init function, and you won't have t worry about multiple calls here.

Yes, that's good point, thank you. Will do.


>
>
>
> -boris

-- 
Regards,

Oleksandr Tyshchenko

