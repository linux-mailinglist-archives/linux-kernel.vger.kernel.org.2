Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C531D394022
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbhE1Jja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbhE1Jj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:39:26 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA46DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:37:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r13so1262326wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KPqfF9v98Z+vpq8UQ29zY4EAgYsjZ5t8dFmFrpzIpVo=;
        b=gonixLN2wafAthF+z4u+oCstGF7DBoRec+F43qQSCrVQb8UxPdHJseAH76+WFAGXJX
         5rXNTqIQmxaJ+ZnPd5Y6SJB465YevWTnAv6RaKG88oEctjs4RF5ywpYPXboYfHUlP5hc
         ZqaStmCMF8MTG0ekPm1b/qS93ZxQM8gGuC3OyDQSANx2calBR1kjYtg20Z3/q++67MD8
         H5WkxTKI/4/IbLj2BiHfQ9Qauo0GuUEO1OU3h9POlcf+JYgK1iSpnGV66vhTgNaqujt9
         TC6YmJuY2OHQedDqTQ6LCM+vEuxn/jbGg8mvo50mTDEmtPUzWD+KXYHr2d3j2vxkR3Q/
         uI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KPqfF9v98Z+vpq8UQ29zY4EAgYsjZ5t8dFmFrpzIpVo=;
        b=AgKAi6tRgWJntOiziZvgQL1xKOUV3Hkna/2snStKnExXZzG5wyvQyD6DQgwDxtJNW0
         3x3hBhDYddDZL4phr5hUGShWEj7KSW5ZZ22xXyLlo/g+YMxvv/YiYTyJ6Zx4nIop91DK
         /1X4Cz/Z5dGHkhIJ0WQ1dUVZD5EbsSrQd0Hr0wbGk1vH0Q3dGLm0fePh0YYe3GQMj4bn
         wEuOZwoEc8LmV5Do3xOtg4f+GjWjk2Eajmp0BD7p45b+qvZMRYJXsIjcJ1TK5XRcJztb
         Ui/v6nB3EEvzbLCO5Ns05oCKoZZ861RR9OtbduHWETdNl6W9NFGmvX+ua+A8j4x4ng4t
         spTA==
X-Gm-Message-State: AOAM530YXaeTAqtutN/IwXsvqPWTCcs/p37ALGGc8LTQ9k9F7XZi1tsm
        0nufNJ+Ub0hPoU4GSKRQVLY0MfWAhINfa+cs
X-Google-Smtp-Source: ABdhPJwhnfZCozt9bOsGyR9qUQAdYWoOtGkDcO6c93JFf7ovj2AHK2p8Juptx4CAyc1NoqNF/WiNoA==
X-Received: by 2002:a7b:c304:: with SMTP id k4mr12763944wmj.68.1622194669024;
        Fri, 28 May 2021 02:37:49 -0700 (PDT)
Received: from ?IPv6:2a00:1098:3142:14:8130:4d4f:4238:e763? ([2a00:1098:3142:14:8130:4d4f:4238:e763])
        by smtp.gmail.com with ESMTPSA id b135sm4861885wmb.5.2021.05.28.02.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 02:37:48 -0700 (PDT)
Subject: Re: [PATCH v2] usb: dwc2: Fix build in periphal-only mode
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Sasha Levin <sashal@kernel.org>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210528091349.2602410-1-phil@raspberrypi.com>
 <YLC2iPPEOCJuElIR@kroah.com>
From:   Phil Elwell <phil@raspberrypi.com>
Message-ID: <e2595559-d14f-973d-732c-2c91be57cc4b@raspberrypi.com>
Date:   Fri, 28 May 2021 10:37:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLC2iPPEOCJuElIR@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 28/05/2021 10:23, Greg Kroah-Hartman wrote:
> On Fri, May 28, 2021 at 10:13:50AM +0100, Phil Elwell wrote:
>> The bus_suspended member of struct dwc2_hsotg is only present in builds
>> that support host-mode.
>>
>> Fixes: 24d209dba5a3 ("usb: dwc2: Fix hibernation between host and device modes.")
>> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
>> ---
>>   drivers/usb/dwc2/core_intr.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> v2: Correct commit hash used in the Fixes line.
>>
>> diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
>> index a5ab03808da6..03d0c034cf57 100644
>> --- a/drivers/usb/dwc2/core_intr.c
>> +++ b/drivers/usb/dwc2/core_intr.c
>> @@ -725,7 +725,11 @@ static inline void dwc_handle_gpwrdn_disc_det(struct dwc2_hsotg *hsotg,
>>   	dwc2_writel(hsotg, gpwrdn_tmp, GPWRDN);
>>   
>>   	hsotg->hibernated = 0;
>> +
>> +#if IS_ENABLED(CONFIG_USB_DWC2_HOST) ||	\
>> +	IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)
>>   	hsotg->bus_suspended = 0;
>> +#endif
>>   
>>   	if (gpwrdn & GPWRDN_IDSTS) {
>>   		hsotg->op_state = OTG_STATE_B_PERIPHERAL;
>> -- 
>> 2.25.1
>>
> 
> I do not understand, the field in the structure is present for all, why
> is this crazy #if needed here?
> 
> I see that the commit you reference here did add the new line to set
> bus_suspended, which seemed to be the point here.  Why will the #if
> values matter here?

Sorry to waste your brain cycles on this. There is a problem, but it only exists 
in branches where the blamed commit (24d209dba5a3) has been back-ported as a 
Fix, because it depends on commit 012466fc8ccc which isn't a Fix and therefore
hasn't been back-ported. Sadly 012466fc8ccc doesn't back-port cleanly on its own 
- either more cherry-picks or a temporary patch like mine will be needed.

Phil
