Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D8B368F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241669AbhDWJaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:30:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40717 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhDWJaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:30:05 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lZs7s-000644-MQ
        for linux-kernel@vger.kernel.org; Fri, 23 Apr 2021 09:29:28 +0000
Received: by mail-wm1-f71.google.com with SMTP id f134-20020a1c1f8c0000b029012e03286b7bso544203wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 02:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4yGD8wXW4VbH+CSpoulkScwFr4fnSDzCtEQr6EY1Ock=;
        b=FhdJRHiBLk0jLAVl2Ta+fI/u9bDVqXbw5uszx3PmCDvn+c/Z1wIAs13yVkItBIKAE7
         iBq7ywMb8QrYNG+j/f47Enp2R4S736tR/NKaw8+gBJrWnbyDnenGW/wzTEV1o/fEvWl+
         FMkCSCNORvKtOSQAhX++nrQj+t3EzR7UXvloy3OPBS4472jnwYovVphV+88C/AazI9/p
         tTabxW7Uyxb56/2sd0NVduwgVd/XHxTgagHTyOaLyah0BIZXSNKSAzKJb4W1kUb8zd1U
         v0JNg13hJ3FI48X3GxIgqKzid4xF7AakJFExmOzAddMEhfPCYx+b8InZryXqA+4EKMOl
         ylEw==
X-Gm-Message-State: AOAM53344pGfysAnazsQOi6Ve/piwECz0yOmzziQlybim5rKycdcyIfZ
        95U5PCZMC3Z2PQvTanFaRKz28OKFzljnGHNhjFOuOPh0rs0NLLdgefGX1sle1S9BTIN0dnBsx6L
        BsgHFDH5+nrprNQ4o1tlkmH5Fpi6g/2cAwLR3JSRdgg==
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr3111101wmq.111.1619170167192;
        Fri, 23 Apr 2021 02:29:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0SgcVRdXZgPoXOBlnEq62Ym2YHELRPwgkI/dJMrgFYVc9x9ZnwlhW0Y5lnUHvN8W/tZTuhw==
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr3111080wmq.111.1619170167055;
        Fri, 23 Apr 2021 02:29:27 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id x15sm10212479wmi.41.2021.04.23.02.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 02:29:26 -0700 (PDT)
Subject: Re: [PATCH 009/190] Revert "media: s5p-mfc: Fix a reference count
 leak"
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-10-gregkh@linuxfoundation.org>
 <b43fc2b0-b3cf-15ab-7d3c-25c1f2a3e658@canonical.com>
 <YIJy6AnG6QBlkV/5@kroah.com> <20210423100727.5a999c2e@coco.lan>
 <02966f20-342d-cf21-8216-d364b67753b7@xs4all.nl>
 <ed2859a3-0051-5ef4-483c-9abd4fa81b22@canonical.com>
 <alpine.DEB.2.22.394.2104231037400.4538@hadrien>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <2604faaf-fa29-8497-d7bd-a861b30801e0@canonical.com>
Date:   Fri, 23 Apr 2021 11:29:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2104231037400.4538@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2021 10:41, Julia Lawall wrote:
> 
> 
> On Fri, 23 Apr 2021, Krzysztof Kozlowski wrote:
> 
>> On 23/04/2021 10:10, Hans Verkuil wrote:
>>> On 23/04/2021 10:07, Mauro Carvalho Chehab wrote:
>>>> Em Fri, 23 Apr 2021 09:10:32 +0200
>>>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
>>>>
>>>>> On Fri, Apr 23, 2021 at 09:04:27AM +0200, Krzysztof Kozlowski wrote:
>>>>>> On 21/04/2021 14:58, Greg Kroah-Hartman wrote:
>>>>>>> This reverts commit 78741ce98c2e36188e2343434406b0e0bc50b0e7.
>>>>>>>
>>>>>>> Commits from @umn.edu addresses have been found to be submitted in "bad
>>>>>>> faith" to try to test the kernel community's ability to review "known
>>>>>>> malicious" changes.  The result of these submissions can be found in a
>>>>>>> paper published at the 42nd IEEE Symposium on Security and Privacy
>>>>>>> entitled, "Open Source Insecurity: Stealthily Introducing
>>>>>>> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
>>>>>>> of Minnesota) and Kangjie Lu (University of Minnesota).
>>>>>>>
>>>>>>> Because of this, all submissions from this group must be reverted from
>>>>>>> the kernel tree and will need to be re-reviewed again to determine if
>>>>>>> they actually are a valid fix.  Until that work is complete, remove this
>>>>>>> change to ensure that no problems are being introduced into the
>>>>>>> codebase.
>>>>>>>
>>>>>>> Cc: Qiushi Wu <wu000273@umn.edu>
>>>>>>> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
>>>>>>> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>>>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>>> ---
>>>>>>>  drivers/media/platform/s5p-mfc/s5p_mfc_pm.c | 4 +---
>>>>>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>>>>>
>>>>>>
>>>>>> This looks like a good commit but should be done now in a different way
>>>>>> - using pm_runtime_resume_and_get().  Therefore I am fine with revert
>>>>>> and I can submit later better fix.
>>>>>
>>>>> Great, thanks for letting me know, I can have someone work on the
>>>>> "better fix" at the same time.
>>>>
>>>> IMO, it is better to keep the fix. I mean, there's no reason to
>>>> revert a fix that it is known to be good.
>>>>
>>>> The "better fix" patch can be produced anytime. A simple coccinelle
>>>> ruleset can replace patterns like:
>>>>
>>>> 	ret = pm_runtime_get_sync(pm->device);
>>>> 	if (ret < 0) {
>>>> 		pm_runtime_put_noidle(pm->device);
>>>> 		return ret;
>>>> 	}
>>>>
>>>> and the broken pattern:
>>>>
>>>> 	ret = pm_runtime_get_sync(pm->device);
>>>> 	if (ret < 0)
>>>> 		return ret;
>>>>
>>>> to:
>>>>
>>>> 	ret = pm_runtime_resume_and_get(pm->device);
>>>> 	if (ret < 0)
>>>> 		return ret;
>>>
>>> That's my preference as well.
>>
>> It won't be that easy because sometimes the error handling is via goto
>> (like in other patches here) but anyway I don't mind keeping the
>> original commits.
> 
> I tried the following semantic patch:
> 
> @@
> expression ret,e;
> @@
> 
> -     ret = pm_runtime_get_sync(e);
> +     ret = pm_resume_and_get(e);
>       if (ret < 0) {
>               ...
> ?-            pm_runtime_put_noidle(e);
>               ...
>               return ret;
>       }
> 
> It has the following features:
> 
> * The ? means that if pm_runtime_put_noidle is absent, the transformation
> will happen anyway.
> 
> * The ... before the return means that the matching will jump over a goto.
> 
> It makes a lot of changes (in a kernel I had handy from March).  This is a
> complicated API, however, and I don't know if there are any other issues
> to take into account, especially in the case where the call to
> pm_runtime_put_noidle is not present.

Thanks Julia, looks good.

Minor notice, the drivers could cleanup also with pm_runtime_put(). This
would not be the best code, but still would work and should be correct
(decrements runtime PM usage counter and tries to suspend the device if
it is resumed/active).

Such pattern could be in entire probe like:

device_probe() {
	if (pm_runtime_get_sync())
		return -EINVAL;
	// PM runtime usage counter inbalance on errors
	...

	// suspend device
	pm_runtime_put();

	return 0;
}
	
I think this should still work fine with your pattern, so overall risk
of errors from coccicheck is small.

Best regards,
Krzysztof
