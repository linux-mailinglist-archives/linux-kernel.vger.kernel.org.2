Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B819B455226
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 02:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242214AbhKRB0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 20:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhKRB0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 20:26:19 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E69AC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 17:23:20 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id h12-20020a056830034c00b0055c8458126fso8120031ote.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 17:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a2gBb51PSDI2uZh/kk0Tzm+QaarIKPnZpY56tomY9/c=;
        b=L7/XQphn9oytfiHo1dNoGGG2NLFL6122KEbhIzxD1+4DMsfoTLXzHk6LTL4hiuWcUf
         ocpX64aNys4SQUo2OdzUw0nN18tTfFv/DUAcOveK3OQpbJHVF1kA6raIFNGbby7Ggi1V
         0WZJ2cgOcMBAgGH6B//hiPDJYJ7c0SA58b/e+Ef6Li1gmEGVXFo8vQbxt/iq+dIISJW1
         /nBtLWDRr+casUf2YxAGRR81luqhdcrsmOsF2uIAFuvUW0ih5TaNkKxx1f3my3p8hsPa
         wRjYdquelf3xRPsRQqZx4HH/GGHBOoQLtMBPLA2dbbph33LQFJADZNIdznSNXWyUNGTM
         TKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a2gBb51PSDI2uZh/kk0Tzm+QaarIKPnZpY56tomY9/c=;
        b=vI7L7KLcD0JdXyQbfvpxih4IzRL/kx+S088KJl2IkSoYcimL4Obnq/R3jHc4oe1v1j
         qqa503yPs6uJesTocSXLnlxgeoeqa6ONSYT+buhEok1jsyEhUI8sUsVqe6e0eJ9EB1G9
         /2J3MlFRmtdNbhR7Mh8Re6Ru6oBqPs0/gyNLnnk8SW97bbL2s8DatM9Twu6hrHx1TxXz
         0ozzlp547Czb5HBv7fDwkN44+9E9CFNNlPKYeYHEDal8bEhVNBSuJS+MRj2vYNw/3/29
         5aKSZ6GVzGgY2A5YPvSIBA72zlTmjQYQFssa46mqFIQdoZMd6XIDYUVHbyhafQy9eWLf
         DP7Q==
X-Gm-Message-State: AOAM530fDTpUNRXD0cCHK2pqfPNphgasW0V9nFNm3uSsPNJQr5SV4UgF
        zaxwgxRj0HunMX331AQN8c0Q7g==
X-Google-Smtp-Source: ABdhPJwt5iqWyw+7+XcHVrcQ0vfSgPSyFiKkhDfr0apjKuD+xkntug2oq0SL7Glq+eCIC4elNfBvhQ==
X-Received: by 2002:a9d:2282:: with SMTP id y2mr17579213ota.151.1637198599564;
        Wed, 17 Nov 2021 17:23:19 -0800 (PST)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id s17sm304093otp.20.2021.11.17.17.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 17:23:19 -0800 (PST)
Message-ID: <0336e09d-59c4-3155-434a-0b04fda15bb6@kali.org>
Date:   Wed, 17 Nov 2021 19:23:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/scheduler: fix
 drm_sched_job_add_implicit_dependencies harder
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20211116155545.473311-1-robdclark@gmail.com>
 <CAMi1Hd0qzu1t6QeZCNgSoTrScZL0_XQnZUPkQ5y7D+oV49GREw@mail.gmail.com>
 <c7741be3-43ec-307b-f5bd-3d19725df76c@amd.com>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <c7741be3-43ec-307b-f5bd-3d19725df76c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/17/21 1:27 AM, Christian König wrote:
> Am 16.11.21 um 19:30 schrieb Amit Pundir:
>> On Tue, 16 Nov 2021 at 21:21, Rob Clark <robdclark@gmail.com> wrote:
>>> From: Rob Clark <robdclark@chromium.org>
>>>
>>> drm_sched_job_add_dependency() could drop the last ref, so we need 
>>> to do
>>> the dma_fence_get() first.
>>>
>> It fixed the splats I saw on RB5 (sm8250 | A650). Thanks.
>>
>> Tested-by: Amit Pundir <amit.pundir@linaro.org>
>
> I've added my rb, pushed this with the original fix to drm-misc-fixes 
> and cleaned up the obvious fallout between drm-misc-fixes and 
> drm-misc-next in drm-tip.
>
> Thanks for the help and sorry for the noise,
> Christian.
>
I've run into this splat on the Lenovo Yoga C630 on 5.16-rc1 - are these 
2 patches (which fix it) going to be heading to 5.16 or were they 
targeted at 5.17?

-- steev

