Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888993D34CC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 08:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbhGWGEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 02:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhGWGEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 02:04:07 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B4AC061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 23:44:41 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id a14so2151651plh.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 23:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JtVRhU77ke1jykJUlx44YgtyrOvEU41Pb5DTJX/92t8=;
        b=YICsHnOycxoxkOgj0f0hjRbEP9/EY2rkWi/vMtZq7CjO4baIqSowmIcWA3Httq8u0T
         9VTxJKZo/Uze4wwTZMDFowZR7eq6Xi5NGBR4XR69N0PhPkflgn9kz5ICkPWPi1UKzDGp
         M2B3tekHiBZBL23dNaDN/fjKudWdmkxIYvIrvSMQJpm2vUXfh7PjlVxD3OpUodCsj3E3
         OtIxeEVpX3fSMNV8S8PoGC/66JqXT3qxwXBNBjfyyj0/2tTanARkAuMkZBCegz5Ygqjb
         e6NDLDE4vh8wtcAEDrC0uE0EOfWYMAC+vxcxNrjV85kTVU4syxEyEikhxxv/cQWF67ny
         g/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JtVRhU77ke1jykJUlx44YgtyrOvEU41Pb5DTJX/92t8=;
        b=luN91scDeYyBY27SC4KhSMroB8GZJ9qYTWV8w9qFOyoGTQii6yKPz1NuhILaEx06XQ
         TUtqK93qglt+evzUWdTfj+e7TCyBCCxKoH+oweA6yJmGbYH9nPpSdwyQvgkbCfoplnlK
         ei3prKovDyUcHZbhz2UPxdZZWMME6rqWpb875Y/4i+Eq4pRntc/pyIAEJOag7ZcuVtZZ
         l8TBXhAN9NmlZdSjtLbgGtSmnornHkIZCd7D1E/fjCJjGtP3IHKTG1tr8/azr27ODIhB
         Z76z7AzO+LKK4w7b63ASWc2OBcOG8Sm8xGnuCuSZtW8ic30jMqtkOcrH8h7onWRGwye1
         nS1w==
X-Gm-Message-State: AOAM532HbsPEs2fR3TL9LxP3PmOMBMf6+L8l8ZW8M0x+RHiwCkmQX9u3
        Sh4Rx9mLXCnU4eGCDnyEKc0=
X-Google-Smtp-Source: ABdhPJz9iplYhIwZU1EW3jCgZDLvrZ1Zvw9a2ACvz4RyKBOSbBtaaNTJgPvIr9uWhLuDw5FJaj2vmw==
X-Received: by 2002:a17:90b:3a92:: with SMTP id om18mr3315626pjb.33.1627022681207;
        Thu, 22 Jul 2021 23:44:41 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id u14sm28466293pga.93.2021.07.22.23.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 23:44:40 -0700 (PDT)
Subject: Re: [PATCH 3/3] drm/vmwgfx: fix potential UAF in vmwgfx_surface.c
To:     Zack Rusin <zackr@vmware.com>,
        linux-graphics-maintainer@vmware.com, airlied@linux.ie,
        daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210722092929.244629-1-desmondcheongzx@gmail.com>
 <20210722092929.244629-4-desmondcheongzx@gmail.com>
 <b27a2e80-c912-15eb-e78b-c8b6f3993930@vmware.com>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <cb3ea66e-7f59-c057-06ea-7ddca4329a7c@gmail.com>
Date:   Fri, 23 Jul 2021 14:44:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b27a2e80-c912-15eb-e78b-c8b6f3993930@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/7/21 3:17 am, Zack Rusin wrote:
> On 7/22/21 5:29 AM, Desmond Cheong Zhi Xi wrote:
>> drm_file.master should be protected by either drm_device.master_mutex
>> or drm_file.master_lookup_lock when being dereferenced. However,
>> drm_master_get is called on unprotected file_priv->master pointers in
>> vmw_surface_define_ioctl and vmw_gb_surface_define_internal.
>>
>> This is fixed by replacing drm_master_get with drm_file_get_master.
>>
>> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> 
> Reviewed-by: Zack Rusin <zackr@vmware.com>
> 
> Thanks for taking the time to fix this. Apart from the clear logic 
> error, do you happen to know under what circumstances would this be hit? 
> We have someone looking at writing some vmwgfx specific igt tests and I 
> was wondering if I could add this to the list.
> 
> z

Hi Zack,

Thanks for the review.

For some context, the use-after-free happens when there's a race between 
accessing the value of drm_file.master, and a call to 
drm_setmaster_ioctl. If drm_file is not the creator of master, then the 
ioctl allocates a new master for drm_file and puts the old master.

Thus for example, the old value of drm_file.master could be freed in 
between getting the value of file_priv->master, and the call to 
drm_master_get.

I'm not entirely sure whether this scenario is a good candidate for a test?

For further reference, the issue was originally caught by Syzbot here:
https://syzkaller.appspot.com/bug?id=148d2f1dfac64af52ffd27b661981a540724f803

And from the logs it seems that the reproducer set up a race between 
DRM_IOCTL_GET_UNIQUE and DRM_IOCTL_SET_MASTER. So possibly a race 
between VMW_CREATE_SURFACE and DRM_IOCTL_SET_MASTER could trigger the 
same bug.

Best wishes,
Desmond

