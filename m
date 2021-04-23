Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCBB369C89
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 00:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbhDWW1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 18:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbhDWW1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 18:27:04 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4106C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 15:26:26 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso13642523otp.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 15:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2DMsxpwYdYyOEHRFEw6E+dzF40YhLUxPy+t5vNNrm6g=;
        b=Kd0XHGrmBtQoFRn0+Ml3uzUxel/gaqXc8WQMlEh3mPSkt7ivKAAgp/IkUfYnzS8HeM
         CV66kZW2L5ch3mwVF1WvzOVz15bcw6FwDbgUuRJCr/G7BUDE2iBHmUZhpZomzDrNTcOX
         IViYdy7lrl5w+Rm5YvFdBvYPMbq6JqKmV9KEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2DMsxpwYdYyOEHRFEw6E+dzF40YhLUxPy+t5vNNrm6g=;
        b=pEoRMf5xT8I8uEbm2bJRuqTad+19AY5td7iGhf1RLVXPzUlkYOd/rl7nmxKujQHaog
         qjsuICq7x3c7FC6Gpo6bnJFwIdPCoreVr+Ry5yhLa/LUC6t+zjtx8WukSMA3/pcOhknQ
         pfj87nsDFMFrxcV+0rNsvZdlk0tlknKj144cvgY3ekETgZ5XoM0emSDtnLgbd5YL0cs4
         /D09pwqyBQOKOOHiDqfrUY2o19B5kJJfMPX5H/nuAgb3c4H2TfUhjSDyTsspHzHqxfqK
         +JyX3s420qon6L+91TMNDcyvXP1MgTEo/052LyO91qxvqX4VNYlVTHjjyuaRNFWVPoqF
         CzXw==
X-Gm-Message-State: AOAM531pPG2kUaBSHSEHsPWTomTYOWdLwIC0vPan1AIBvaMQI834Gblp
        pS0WUCMW3+e6x6bIKgc9QeZ11Q==
X-Google-Smtp-Source: ABdhPJwsuvyK2ZKPskJjya6yjK+ySg6Wx9fFsJOOvzCEGEukdKVpBoslg4ZKBuGt5E8Z2kGA2zzMXQ==
X-Received: by 2002:a05:6830:3497:: with SMTP id c23mr5044948otu.344.1619216786222;
        Fri, 23 Apr 2021 15:26:26 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h12sm1681724otk.55.2021.04.23.15.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 15:26:25 -0700 (PDT)
Subject: Re: [PATCH 1/2] cpupower: Fix amd cpu (family < 0x17) active state
 issue
To:     =?UTF-8?B?5b6Q56aP5rW3?= <xufuhai1992@gmail.com>, shuah@kernel.org,
        Thomas Renninger <trenn@suse.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lishujin@kuaishou.com, xufuhai <xufuhai@kuaishou.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <bf312780-dda7-d08f-6098-1d8a7d4044e4@gmail.com>
 <378e58d3-5300-1179-44bb-bc2b42a3beb0@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <87e43451-e7d3-877e-7081-92838ae699e6@linuxfoundation.org>
Date:   Fri, 23 Apr 2021 16:26:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <378e58d3-5300-1179-44bb-bc2b42a3beb0@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/21 8:27 PM, Ðì¸£º£ wrote:
> From: xufuhai<xufuhai@kuaishou.com>
> 
> For the old  AMD processor (family < 0x17), cpupower will call the
> amd_pci_get_num_boost_states function, but for the non-root user
> pci_read_byte function (implementation comes from the psutil library),
> val will be set to 0xff, indicating that there is no read function
> callback. At this time, the original logic will set the cpupower turbo
> active state to yes. This is an obvious issue~
> 
> Reproduce procedure:
> 	cpupower frequency-info
> 
> Reported-by: yangrui<yangrui@kuaishou.com>
> Signed-off-by: xufuhai<xufuhai@kuaishou.com>

Also your Signed-off-by should match the from address.
There is a mismatch between the two.

> Signed-off-by: chenguanqiao<chenguanqiao@kuaishou.com>
> Signed-off-by: lishujin<lishujin@kuaishou.com>
> Reviewed-by: Thomas Renninger<trenn@suse.com>
> ---
>   tools/power/cpupower/utils/helpers/amd.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
> index 97f2c857048e..6f9504906afa 100644
> --- a/tools/power/cpupower/utils/helpers/amd.c
> +++ b/tools/power/cpupower/utils/helpers/amd.c
> @@ -137,6 +137,13 @@ int amd_pci_get_num_boost_states(int *active, int *states)
>   		return -ENODEV;
>   
>   	val = pci_read_byte(device, 0x15c);
> +
> +	/* If val is 0xff, meaning has no permisson to
> +	 * get the boost states, return -1
> +	 */
> +	if (val == 0xff)
> +		return -1;
> +
>   	if (val & 3)
>   		*active = 1;
>   	else
> -- 
> 2.24.3 (Apple Git-128)
> 

I am seeing two patches with the same commit summary,
should these two be a singles patch?

https://patchwork.kernel.org/project/linux-pm/patch/6e35df20-753a-6c9c-8786-3fc87cdd17ba@gmail.com/

Please combine the two and send single patch if they fix the
same problem. If not, please change the commit log to reflect
the difference.

thanks,
-- Shuah


