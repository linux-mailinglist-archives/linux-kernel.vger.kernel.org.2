Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3527C368EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241391AbhDWISc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:18:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38480 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWISb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:18:31 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lZr0c-0008WM-AS
        for linux-kernel@vger.kernel.org; Fri, 23 Apr 2021 08:17:54 +0000
Received: by mail-wr1-f72.google.com with SMTP id t18-20020adfdc120000b02900ffe4432d8bso14831991wri.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 01:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dfitj2t8+UF1lzcZUDbgPADbt6NqjwZhyEWRJUlw7GU=;
        b=YGeXqfDc0B3pPHGCflnenemgJrUtMSo3eFhxnM/3ZGd3r288W73HTC6wUayeCLO0kN
         yZ+WQ0CHyWCNOcFC1C/XlmYhAELUIUKRduacamLGy4/xCCHyGRtIs090Vzt8xQOGeKhR
         dxuv4QyknExqBcxAowvDQ/CUuaXw91CLlAxGURBIN7LaUM/PoBPKrVCjHQ+ZPs1hTXUQ
         cKiQ4Okc3YFOyVMMTRG5Qaksvfqp2xu5AZGJ5kjxQ/4pMUaaUkvXVxiRM+2/D0q5k/NR
         GkPBbf9oJaMN0m6PsPWxMoGoBkmDALnJXA4ITX9a8z4GgBoZSGoIefQLE+DB0y2et71Q
         UnWg==
X-Gm-Message-State: AOAM531djNvC25HJExG0gIqSAMnAAB3889QVimiafBbrcu9khgN/aaiu
        Rj/Mb1U5Gx1H2KD4YH7fawfyR45ivjEC/GLg43tVNr15DUxdaepZYfrv3WlavzId2qGyPDhWE95
        dUNn90sS9cyrODRmaI/G1rWp+8uU+NVmnzyUDaEcZVQ==
X-Received: by 2002:a5d:47c1:: with SMTP id o1mr3108774wrc.216.1619165872754;
        Fri, 23 Apr 2021 01:17:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYL7rl8v05EIkruUMxZubbSmhvjXfTCb2+DkYFLJztLeUtCLJWinJXhKhzswFfeNF1Qp0hTw==
X-Received: by 2002:a5d:47c1:: with SMTP id o1mr3108760wrc.216.1619165872623;
        Fri, 23 Apr 2021 01:17:52 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id a142sm10217492wmd.7.2021.04.23.01.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 01:17:51 -0700 (PDT)
Subject: Re: [PATCH 009/190] Revert "media: s5p-mfc: Fix a reference count
 leak"
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Julia Lawall <julia.lawall@inria.fr>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-10-gregkh@linuxfoundation.org>
 <b43fc2b0-b3cf-15ab-7d3c-25c1f2a3e658@canonical.com>
 <YIJy6AnG6QBlkV/5@kroah.com> <20210423100727.5a999c2e@coco.lan>
 <02966f20-342d-cf21-8216-d364b67753b7@xs4all.nl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ed2859a3-0051-5ef4-483c-9abd4fa81b22@canonical.com>
Date:   Fri, 23 Apr 2021 10:17:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <02966f20-342d-cf21-8216-d364b67753b7@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2021 10:10, Hans Verkuil wrote:
> On 23/04/2021 10:07, Mauro Carvalho Chehab wrote:
>> Em Fri, 23 Apr 2021 09:10:32 +0200
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
>>
>>> On Fri, Apr 23, 2021 at 09:04:27AM +0200, Krzysztof Kozlowski wrote:
>>>> On 21/04/2021 14:58, Greg Kroah-Hartman wrote:  
>>>>> This reverts commit 78741ce98c2e36188e2343434406b0e0bc50b0e7.
>>>>>
>>>>> Commits from @umn.edu addresses have been found to be submitted in "bad
>>>>> faith" to try to test the kernel community's ability to review "known
>>>>> malicious" changes.  The result of these submissions can be found in a
>>>>> paper published at the 42nd IEEE Symposium on Security and Privacy
>>>>> entitled, "Open Source Insecurity: Stealthily Introducing
>>>>> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
>>>>> of Minnesota) and Kangjie Lu (University of Minnesota).
>>>>>
>>>>> Because of this, all submissions from this group must be reverted from
>>>>> the kernel tree and will need to be re-reviewed again to determine if
>>>>> they actually are a valid fix.  Until that work is complete, remove this
>>>>> change to ensure that no problems are being introduced into the
>>>>> codebase.
>>>>>
>>>>> Cc: Qiushi Wu <wu000273@umn.edu>
>>>>> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
>>>>> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>> ---
>>>>>  drivers/media/platform/s5p-mfc/s5p_mfc_pm.c | 4 +---
>>>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>>>   
>>>>
>>>> This looks like a good commit but should be done now in a different way
>>>> - using pm_runtime_resume_and_get().  Therefore I am fine with revert
>>>> and I can submit later better fix.  
>>>
>>> Great, thanks for letting me know, I can have someone work on the
>>> "better fix" at the same time.
>>
>> IMO, it is better to keep the fix. I mean, there's no reason to
>> revert a fix that it is known to be good.
>>
>> The "better fix" patch can be produced anytime. A simple coccinelle
>> ruleset can replace patterns like:
>>
>> 	ret = pm_runtime_get_sync(pm->device);
>> 	if (ret < 0) {
>> 		pm_runtime_put_noidle(pm->device);
>> 		return ret;
>> 	}
>>
>> and the broken pattern:
>>
>> 	ret = pm_runtime_get_sync(pm->device);
>> 	if (ret < 0)
>> 		return ret;
>>
>> to:
>>
>> 	ret = pm_runtime_resume_and_get(pm->device);
>> 	if (ret < 0)
>> 		return ret;
> 
> That's my preference as well.

It won't be that easy because sometimes the error handling is via goto
(like in other patches here) but anyway I don't mind keeping the
original commits.

Best regards,
Krzysztof
