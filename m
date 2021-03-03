Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62FD32C326
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355284AbhCDAHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388968AbhCCVaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 16:30:21 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49A4C06175F;
        Wed,  3 Mar 2021 13:29:36 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id e23so6296152wmh.3;
        Wed, 03 Mar 2021 13:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RHWM5gQcenxuOkY0x6Td3acOXwhJs3a6wdM3qoJf5Qc=;
        b=Mpk2VE/skjGqPta3MrNp4DGLqRCWE+N099GW6R9jUTt3MKKuG7njT6vskx8DWMwZ1p
         oTZq96hWm5zSX9nKgrKRpOU2JG8vt79w6z8fS8zkMnJC0di66MK6SZ8k8DKfi3iWXIYh
         qBAfI9gQWlDcJUvAiBFOzjSk0tuhjjdTWru7g6yrWiW9FGEWIdJpnjeX2eOeehK/Ekut
         Wl53XQ9kAuLaDB8Yy+iSfNXn+4U9yUAEhWqLQ2FOVmI50B+JTx2/ZlmRLFW/X5m40DBU
         uQHSFAsR84DRjjXdNSTeyW2WP0uniy86GzZOfmLi4HHdw0Oh9J9ijdnYT2H2ziWJm8CL
         in5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RHWM5gQcenxuOkY0x6Td3acOXwhJs3a6wdM3qoJf5Qc=;
        b=WnBbTlSUWyvVxXI9p73sR/wbwmf4/Xu7W/Wk4CaK9J0aixYW/RQpVusQem8gFDf3ci
         JN0waxmbWqV9M2+y92wOfCFqlVCcTMe/i+3PPTUrmZEi7SoPMgCmNSNoS1vfy9hAQJbk
         8WSRZFJ7PWJWBi3eA15pRJMpDKqrahy7BqQm9M9xHtT0ZBwOjOKveFmgrWZJohWQbMfv
         X85nww9eIUxIcAD24bAEO9Gs1oCTCY0DfSjZ/38EaHBrrL3UnrjGaMpwcpQMx0BDnIKg
         9upTB5x/9D2XOHRgNt5+XHPZ5mk+1O94sX6eij0+mMwHrrQxgOrGUBurUe+nshChtNiy
         ceLA==
X-Gm-Message-State: AOAM531WYYgEX0Ym0ljHzCA0rzvVGp1BTT9reaPfyZEVdbl8EYUHe6m6
        fg4SkRDl+weY0KJhQhHABGY=
X-Google-Smtp-Source: ABdhPJzJhJzmLR3kVCrW+NRdh4CAxVetKaZCJTPOZjiMUgdhly7FLobuGadSCdUJrL3lBpUFQkw2Jw==
X-Received: by 2002:a05:600c:2ca:: with SMTP id 10mr831328wmn.40.1614806975516;
        Wed, 03 Mar 2021 13:29:35 -0800 (PST)
Received: from hthiery.fritz.box (ip1f1322f8.dynamic.kabel-deutschland.de. [31.19.34.248])
        by smtp.gmail.com with ESMTPSA id s23sm6950088wmc.35.2021.03.03.13.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 13:29:35 -0800 (PST)
From:   Heiko Thiery <heiko.thiery@gmail.com>
To:     raychi@google.com
Cc:     balbi@kernel.org, colin.king@canonical.com,
        gregkh@linuxfoundation.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Heiko Thiery <heiko.thiery@gmail.com>
Subject: Re: [PATCH] usb: dwc3: Fix dereferencing of null dwc->usb_psy
Date:   Wed,  3 Mar 2021 22:29:25 +0100
Message-Id: <20210303212924.19733-1-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <CAPBYUsCPj12enyMp9AMzFEAgd5MdKh7dYN5DNFpZwofBYnjG8A@mail.gmail.com>
References: <CAPBYUsCPj12enyMp9AMzFEAgd5MdKh7dYN5DNFpZwofBYnjG8A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> On Wed, Mar 3, 2021 at 6:00 PM Colin King <colin.king@canonical.com> wrote:
>>
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Currently the null check logic on dwc->usb_psy is inverted as it allows
>> calls to power_supply_put with a null dwc->usb_psy causing a null
>> pointer dereference. Fix this by removing the ! operator.
>>
>> Addresses-Coverity: ("Dereference after null check")
>> Fixes: 59fa3def35de ("usb: dwc3: add a power supply for current control")
>
> Acked-by: Ray Chi <raychi@google.com>
>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Tested-by: Heiko Thiery <heiko.thiery@gmail.com>

>> ---
>>  drivers/usb/dwc3/core.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index d15f065849cd..94fdbe502ce9 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1628,7 +1628,7 @@ static int dwc3_probe(struct platform_device *pdev)
>>  assert_reset:
>>         reset_control_assert(dwc->reset);
>>
>> -       if (!dwc->usb_psy)
>> +       if (dwc->usb_psy)
>>                 power_supply_put(dwc->usb_psy);
>>
>>         return ret;
>> @@ -1653,7 +1653,7 @@ static int dwc3_remove(struct platform_device *pdev)
>>         dwc3_free_event_buffers(dwc);
>>         dwc3_free_scratch_buffers(dwc);
>>
>> -       if (!dwc->usb_psy)
>> +       if (dwc->usb_psy)
>>                 power_supply_put(dwc->usb_psy);
>>
>>         return 0;
>> --
>> 2.30.0
>>

Thank you.

-- 
Heiko
