Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDFC43CE2B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242862AbhJ0QBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242884AbhJ0QBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:01:50 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479B1C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 08:59:25 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so4255033otk.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 08:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JDGhLnAjGcemyGOmhvCllnpzPG1c1ebcma9GtpslLK8=;
        b=gXvpY2rj4x+6ro0u4u+WkiU6Owx0jrPe7Oj5sXe99VRLCxTCzzNdp2L0QtH6vGPE5T
         OxFrov2Ej359v/Wsbj7BYROPEeHN9vq80ZDU7uvB7KxzxokxJ8FYg4rQIimk9JBSnIE8
         ZZIuPo/+GV2UEWwdSvRujkzdeNsdKPCp57AFefkoDXkf+cLGgbuSeUbbpFDTrXQjwv+o
         Nv8KulaLUW0sI0fLmdhzrRgLsbWLfCRGv3L/3TNvjiU3mhW5Og77m+QVcVlKWcEXSP09
         u8jGF9OkVmmy4VUsIaG9Fv5qcxS07Xq/l+8kNxjQg4V7jWNUDtdQ90wIGNrJJaGpH2G0
         kcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JDGhLnAjGcemyGOmhvCllnpzPG1c1ebcma9GtpslLK8=;
        b=73CxdWLhiXrw0s/YJG3nWzv29IP6M/ydPlN6jdZKg857n1BEViDnttZDv9RQvIkGlE
         vU80OFKeUJ03Wuo+XbRTmEBcQTXzH70T7pK7TbyiduvhCBzYB/gKLUwkcvWWhh5p1b7e
         AyiKQ9IYwWGr3n1l8JcyASPHU+lpsDiGtGS4x4bJDSZ4R+u0l5phH8WDDq6yxpyXATvN
         HuZQJYYol6FF4ktecXzCsaWHj83E6ahh6QHXPvRsLUNSAg28YJZS82++7l2xpZBGhP7b
         udODWghzB8SQu/02x0OOxEx/oO7m/5MH4hCz/Bgi9xu4k0aVfP5wmaD5YAbX9BJ3t7sC
         FO6A==
X-Gm-Message-State: AOAM532DJRW4GkGdxpdXrApW0Hhr1QHqeDLRDwQ+TuDFgVtMh2KGbHtY
        UECNYDhEv2b8/0f4gT0WNdc=
X-Google-Smtp-Source: ABdhPJxJ1qES9romQLNWwbkLhJuQ+1GVlbrTUSnpuhDk1WhYt+AqMhF7rH8bXBtdVDY2Nm56a0B8xQ==
X-Received: by 2002:a9d:6346:: with SMTP id y6mr26685096otk.154.1635350364648;
        Wed, 27 Oct 2021 08:59:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v9sm118175oth.62.2021.10.27.08.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 08:59:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix out of bounds write
To:     Harry Wentland <harry.wentland@amd.com>,
        Thelford Williams <tdwilliamsiv@gmail.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Alex Deucher <alexander.deucher@amd.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
References: <20211027143945.GA1947580@roeck-us.net>
 <8205a660-6990-9007-48c9-453117d16f72@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <fb5ee1a9-8cdb-3aab-c3ac-e4d03421fb85@roeck-us.net>
Date:   Wed, 27 Oct 2021 08:59:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8205a660-6990-9007-48c9-453117d16f72@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/21 8:22 AM, Harry Wentland wrote:
> On 2021-10-27 10:39, Guenter Roeck wrote:
>> On Wed, Oct 13, 2021 at 04:04:13PM -0400, Thelford Williams wrote:
>>> Size can be any value and is user controlled resulting in overwriting the
>>> 40 byte array wr_buf with an arbitrary length of data from buf.
>>>
>>> Signed-off-by: Thelford Williams <tdwilliamsiv@gmail.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> The fix works, but unless I am missing something it is incomplete.
>> parse_write_buffer_into_params() is called several times, and the
>> size parameter is always wrong. This patch only fixes one of several
>> instances of the problem.
>>
> 
> Patrik sent a patch that covers all cases:
> https://patchwork.freedesktop.org/patch/461554/?series=96341&rev=2
> 
> Harry
> 
Thanks!

Guenter

>> Guenter
>>
>>> ---
>>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>>> index 814f67d86a3c..9b3ad56607bb 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>>> @@ -264,7 +264,7 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
>>>   	if (!wr_buf)
>>>   		return -ENOSPC;
>>>   
>>> -	if (parse_write_buffer_into_params(wr_buf, size,
>>> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>>   					   (long *)param, buf,
>>>   					   max_param_num,
>>>   					   &param_nums)) {
>>> -- 
>>> 2.33.0
> 

