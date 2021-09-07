Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB09402D70
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345579AbhIGRIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:08:05 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49976
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345130AbhIGRIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:08:04 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3851A3F046
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 17:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631034417;
        bh=VG0JhmyVLkk6Ofw6jiVRBn2qayN7edeiW2niGR0upjE=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=DW9tvDKCIFDG49oCgdTZGYsao7WHQCFCyDvehY118aOJ24awi4yK43QaQ68ljseDq
         72WKRLcwYHOujiFHJ428KRFtU8p4aJgGVCzfMIVfQkOq/N+63MdzMob6Qc8GSGyl1q
         U8PpPEgklRs6+n22GNtH3S4RuyJi90x7jJDqqa1XHwhnsbRzgBKDEO1J4vyhUAktb7
         r5IxAjGVg0wmgBn+WCGnqu0/2+p+7vLVAEWvm3E9ZKHu2e9kDIAOvoFCREfJRnxQrL
         vGN1vYKTlRJUN/li7EdJ7gNa50yClNRZElbF8Gjo17bKiGzWZodss00CzcanMb4EqL
         7Tn8Uu4pHtWqA==
Received: by mail-wm1-f69.google.com with SMTP id p11-20020a05600c204b00b002f05aff1663so1349085wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 10:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VG0JhmyVLkk6Ofw6jiVRBn2qayN7edeiW2niGR0upjE=;
        b=BKGOLQJkn/tLIKyZ2qHO2Eq0WOGe+TMgKipwcrkaQrKcrnDhD77Iry5KvNDAekdokq
         CZ+2Yl/M8sNSdIzwnl65oPJaZ6/U0Nv/qaAQwPuF9YaO0o0fzudqoXibARzyENwwFpIE
         PvDgRM93VkgwyE/a9/SPMgGuxCZ1eyROsP0bNqi+sZC4x6XrjVDc1TRNtV0ruyrDG94X
         xpc2GjEb0jfvYxRZJU6ScmDed/vkcA0ZC6XcNr8m/M79Wf8rnirIubD6YhYeLEY4dMWC
         eJeivNiQTvOCQoB9lagt4bUSqtOVngTNsDp+iLKnUSvPZG+3FxV5MZHH+hYitMEtv5sT
         8fyg==
X-Gm-Message-State: AOAM5310TSTn66z7GPa+X45IxwNNNEtmUHVcB7207o0aeRW92q6OG2S6
        hQq8Zydg9Y3PEJvO4Kr74X4sDR5zZdNPwAszWfWB/TfKfSXjwLRwM493D5FONnVq7z8z3bJgeU8
        r+pthaJuxNBSyIkAWDLUmY2hzKSrx0XHXS0a6h8LlAw==
X-Received: by 2002:a05:6000:186:: with SMTP id p6mr20176892wrx.210.1631034416930;
        Tue, 07 Sep 2021 10:06:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE/K0JY0VlMzZwE0MrSbz25moOxrUCE+1AcR5gJXHm/zeMeF7W8lJAkFYZcpZ3SugSoUEeOg==
X-Received: by 2002:a05:6000:186:: with SMTP id p6mr20176851wrx.210.1631034416728;
        Tue, 07 Sep 2021 10:06:56 -0700 (PDT)
Received: from [192.168.3.211] ([79.98.113.47])
        by smtp.gmail.com with ESMTPSA id w29sm11722496wra.88.2021.09.07.10.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 10:06:56 -0700 (PDT)
Subject: Re: [PATCH 05/15] nfc: pn533: drop unneeded debug prints
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
References: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
 <20210907121816.37750-6-krzysztof.kozlowski@canonical.com>
 <35626061-ff2e-cb01-21ff-87a6f776dc28@canonical.com>
 <20210907100310.0cdec18b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <f6677c91-30ba-132d-20d2-0ec7edf40025@canonical.com>
Date:   Tue, 7 Sep 2021 19:06:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907100310.0cdec18b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2021 19:03, Jakub Kicinski wrote:
> On Tue, 7 Sep 2021 18:05:25 +0200 Krzysztof Kozlowski wrote:
>> On 07/09/2021 14:18, Krzysztof Kozlowski wrote:
>>> ftrace is a preferred and standard way to debug entering and exiting
>>> functions so drop useless debug prints.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>> ---
>>>  drivers/nfc/pn533/i2c.c   | 1 -
>>>  drivers/nfc/pn533/pn533.c | 2 --
>>>  2 files changed, 3 deletions(-)
>>>
>>> diff --git a/drivers/nfc/pn533/i2c.c b/drivers/nfc/pn533/i2c.c
>>> index e6bf8cfe3aa7..91d4a035eb63 100644
>>> --- a/drivers/nfc/pn533/i2c.c
>>> +++ b/drivers/nfc/pn533/i2c.c
>>> @@ -138,7 +138,6 @@ static irqreturn_t pn533_i2c_irq_thread_fn(int irq, void *data)
>>>  	}
>>>  
>>>  	client = phy->i2c_dev;  
>>
>> This line should also be removed (reported by kbuild robot).
>>
>> I will send a v2.
> 
> Dave marked the series as Deferred (although this patch is Changes
> Requested, I'm guessing you did that, if so please don't change patch
> states in netdev pw)

Yes, that was me. Sorry for disturbing the process.

>, please hold off:
> 
> 
> # Form letter - net-next is closed
> 
> We have already sent the networking pull request for 5.15
> and therefore net-next is closed for new drivers, features,
> code refactoring and optimizations. We are currently accepting
> bug fixes only.
> 
> Please repost when net-next reopens after 5.15-rc1 is cut.
> 
> Look out for the announcement on the mailing list or check:
> http://vger.kernel.org/~davem/net-next.html
> 
> RFC patches sent for review only are obviously welcome at any time.

Sure, I'll wait till end of merge window.


Best regards,
Krzysztof
