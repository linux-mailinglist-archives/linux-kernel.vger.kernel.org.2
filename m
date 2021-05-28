Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBED839409D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbhE1KFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbhE1KFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:05:47 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AE5C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 03:04:13 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso6472104wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ckOObMzV694yTlqT8Qd5JVn5HHnfJhdgFq4myvYrU2w=;
        b=CN5a0pQ6ElM6esNnfNnBmKj3ULESGLnIf3e+kTaLkeujbaEIIl9XrNWVJwOwll/ksX
         TTTksQgkI7Z+nOaHVm9taRn1iU/1o6SJhm3rc5+lAr7h4R6mAXS6J4L2L2PC0MGYOKmr
         pOV5bKU0B6U4pqN/zwBi0vHaYbH+x5FJiMgYHyczLHiOG5wDRaxQKgR+bdnOkyiVGihZ
         kz3xL1mUeXWvxsb1dyDQi7UnhgzwzaWOnJ9uuOQ40xZVs5C2sM6Q6xtmsJ1PRCXqfMEV
         pcwq9TK7EW4BlFnzphloho+JjidHSojPotIy3+rmQzIQJdX6PzjZbs0A6kUWpdhbWNZv
         gQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ckOObMzV694yTlqT8Qd5JVn5HHnfJhdgFq4myvYrU2w=;
        b=fJhXVYZmqwLBhjc+0LPyvzAy2HrZpP1xyZK5DRUsq3X+fwxPZnGBIIuSU610rnWt7y
         xu2acFSFqzBB8l3LcTLsmYz6WWexREBRSry+/NG7lAUAJ4aCgODO7A0M4t4T0DEH7JOW
         pCZ2zWZVCLAL1lnSTPDofLcjS3vLDi1XAy6MJTo4ph+WL4qwitNPTXQogjT6tIGKcj7O
         DW460uUmu7rN3tBVHENYtQBji/hvjKP6lFucBTr+tMzJ9SAq1bVWzmcBDn1lF85GJNSP
         bitqZzIVPSXEmBjVyPL0XcwKwc3BpCa6xYXVhw4k1fWwdB27QiAm58xf4b/z32kXk1tX
         4vkg==
X-Gm-Message-State: AOAM533axTQtMkpiEow4C8P0gGfrKozAg5fQv3edpZsk0BPpIB7YB+T9
        RUdP2zRum6+ZlsKfZCqZDms0vcJRD+qibEeg
X-Google-Smtp-Source: ABdhPJznf0TwuoInMEJ8dprr9ERf4J8IJCABg8ms00LigKljWDX7VloLLz02wsl4jKDCAgTMjZF3tw==
X-Received: by 2002:a05:600c:4f8b:: with SMTP id n11mr7780484wmq.11.1622196250857;
        Fri, 28 May 2021 03:04:10 -0700 (PDT)
Received: from ?IPv6:2a00:1098:3142:14:8130:4d4f:4238:e763? ([2a00:1098:3142:14:8130:4d4f:4238:e763])
        by smtp.gmail.com with ESMTPSA id p6sm2127133wrf.51.2021.05.28.03.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 03:04:09 -0700 (PDT)
Subject: Re: [PATCH v2] usb: dwc2: Fix build in periphal-only mode
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Sasha Levin <sashal@kernel.org>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210528091349.2602410-1-phil@raspberrypi.com>
 <YLC2iPPEOCJuElIR@kroah.com>
 <e2595559-d14f-973d-732c-2c91be57cc4b@raspberrypi.com>
 <YLC9I6vKh9z7LTke@kroah.com>
From:   Phil Elwell <phil@raspberrypi.com>
Message-ID: <d577970e-7b86-1b1b-b31a-e432f1dc1c64@raspberrypi.com>
Date:   Fri, 28 May 2021 11:04:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLC9I6vKh9z7LTke@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/2021 10:51, Greg Kroah-Hartman wrote:

> On Fri, May 28, 2021 at 10:37:48AM +0100, Phil Elwell wrote:
>> Hi Greg,
>>
>> On 28/05/2021 10:23, Greg Kroah-Hartman wrote:
>>> On Fri, May 28, 2021 at 10:13:50AM +0100, Phil Elwell wrote:
>>>> The bus_suspended member of struct dwc2_hsotg is only present in builds
>>>> that support host-mode.
>>>>
>>>> Fixes: 24d209dba5a3 ("usb: dwc2: Fix hibernation between host and device modes.")
>>>> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
>>>> ---
>>>>    drivers/usb/dwc2/core_intr.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> v2: Correct commit hash used in the Fixes line.
>>>>
>>>> diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
>>>> index a5ab03808da6..03d0c034cf57 100644
>>>> --- a/drivers/usb/dwc2/core_intr.c
>>>> +++ b/drivers/usb/dwc2/core_intr.c
>>>> @@ -725,7 +725,11 @@ static inline void dwc_handle_gpwrdn_disc_det(struct dwc2_hsotg *hsotg,
>>>>    	dwc2_writel(hsotg, gpwrdn_tmp, GPWRDN);
>>>>    	hsotg->hibernated = 0;
>>>> +
>>>> +#if IS_ENABLED(CONFIG_USB_DWC2_HOST) ||	\
>>>> +	IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)
>>>>    	hsotg->bus_suspended = 0;
>>>> +#endif
>>>>    	if (gpwrdn & GPWRDN_IDSTS) {
>>>>    		hsotg->op_state = OTG_STATE_B_PERIPHERAL;
>>>> -- 
>>>> 2.25.1
>>>>
>>> I do not understand, the field in the structure is present for all, why
>>> is this crazy #if needed here?
>>>
>>> I see that the commit you reference here did add the new line to set
>>> bus_suspended, which seemed to be the point here.  Why will the #if
>>> values matter here?
>> Sorry to waste your brain cycles on this. There is a problem, but it only
>> exists in branches where the blamed commit (24d209dba5a3) has been
>> back-ported as a Fix, because it depends on commit 012466fc8ccc which isn't
>> a Fix and therefore
>> hasn't been back-ported. Sadly 012466fc8ccc doesn't back-port cleanly on its
>> own - either more cherry-picks or a temporary patch like mine will be
>> needed.
> So should we revert this commit from the stable releases where it showed
> up?  Which ones specifically?
>
> If so, please let me and stable@vger.kernel.org know and we can take
> care of it there.

Reverting back-ports of 24d209dba5a3 would be sufficient, although you are then 
left with the problem that 24d209dba5a3 was intended to address.

I'll email the stable list.

Phil

