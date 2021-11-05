Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03634466BF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbhKEQLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhKEQLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:11:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A0FC061714;
        Fri,  5 Nov 2021 09:09:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so3677706pjl.2;
        Fri, 05 Nov 2021 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nC6lmsSMjNxg4EdgStZMk+UHWhR3qy63zVqcB7nAXNk=;
        b=le3V2KjNyuVMkv//rlGkhAkSvF4dJAk8TZJ30eV3H1aXfYSCBcdpGBj0y2mDgJhbLT
         kEZrJ0EDdRljsMgrrxVUqf27QwDLlD7pIXBxlpsiP5hDzH8zNbMsuiNF4oA6I8OnrjBE
         oZGH4de/4hg1212xSLywWtGeMmjT4rACSBlzyA3hofPy7lwvRd35L2s5IoW1bBmFK9jA
         2gyrx4sQSZU+loTfrqvRolPbJLePIWCBOQWs0+TotF57ntPLwGgGK9/i6iwpz1hRt4zh
         hCHQjYM2sCunKU3fLnmmslPCe1mZqJMbKrFN0MRxKNTRESSdn+aOGN4WWjh9ZchLggiQ
         c75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nC6lmsSMjNxg4EdgStZMk+UHWhR3qy63zVqcB7nAXNk=;
        b=ZJefKnq/jc1d3ByV5z8g7T30yQWzsgNVeUz6aVhoO0xgsAbBCXTXGTR6ULCbAJSBTv
         4P3u5fPevNwoQzY7skHqTL8/EskqWeQFqEYTzYcl84Ja9Tthct+jOrXfwHVHMz6xpPvC
         O7mQbxf+6qLXLmPTGHCuvMEYYZXJQdLvYSV9S8wukIu1/2KEPRjrnRqRvcMLcqn20Wza
         nZ/sbNYxhYeGsVMU+jNO3STO8E4FPP21lApAAfsO3apleTpMO0kRMEPZGo2n/afcEI2I
         nuB+Wkfjbywo9f6x2LCTwuIQaqKLpDtFkOJtJZJHEAACNSjHVWPCMarxXvUnChtWWGlw
         3qQQ==
X-Gm-Message-State: AOAM531q1oyEetjyON56BaUwGGP8Wy1iBSonB4UgLPwKf0pqDy3ZIw4O
        xIZUNJNgnQ5mQ7uqk308vEEf/2QSaxY=
X-Google-Smtp-Source: ABdhPJzt5ONUdqCWVcoJC3zmSdcluEmflmg2VR+l/N95YXtU5aw6LUkenS4hYkMsKVCcm0B3WPrjFA==
X-Received: by 2002:a17:902:740c:b0:141:bf6d:7e16 with SMTP id g12-20020a170902740c00b00141bf6d7e16mr41532112pll.13.1636128547688;
        Fri, 05 Nov 2021 09:09:07 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id rm1sm8506841pjb.3.2021.11.05.09.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 09:09:07 -0700 (PDT)
Subject: Re: [PATCH 2/2] USB: ehci_brcm_hub_control: replace wIndex-1 with
 temp
To:     Greg KH <gregkh@linuxfoundation.org>,
        Haimin Zhang <tcs.kernel@gmail.com>,
        Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Haimin Zhang <tcs_kernel@tencent.com>,
        TCS Robot <tcs_robot@tencent.com>
References: <20211105083357.29715-1-tcs_kernel@tencent.com>
 <YYTwveXGgNKXCfpk@kroah.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d5b698db-5fc0-2d62-2b6e-4c0d70903fa0@gmail.com>
Date:   Fri, 5 Nov 2021 09:09:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YYTwveXGgNKXCfpk@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/21 1:52 AM, Greg KH wrote:
> On Fri, Nov 05, 2021 at 04:33:57PM +0800, Haimin Zhang wrote:
>> In function `ehci_brcm_hub_control`, like following code,  
>> it filters out the case where the upper byte of wIndex is nonzero, 
>> so it need be replaced with temp.
> 
> I do not understand this text, can you try to reword it?
> 
> And you have trailing whitespace.
> 
> And why use `?
> 
>> ```
> 
> What is this for?  Changelog comments are not in markdown format.
> 
>> 	if ((typeReq == GetPortStatus) &&
>> 	    (wIndex && wIndex <= ports) &&       // need to be replaced
> 
> What does this comment mean?
> 
>> 	    ehci->reset_done[wIndex-1] &&
>> 	    time_after_eq(jiffies, ehci->reset_done[wIndex-1]) &&
>> 	    (ehci_readl(ehci, status_reg) & PORT_RESUME)) {
>> ```
>>
>> Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
>> Reported-by: TCS Robot <tcs_robot@tencent.com>
> 
> Again, lines need to be in different order, and your from: line is not
> correct.
> 
> Also, you need an individual email address, not a group email alias for
> your contributions.  We work with individuals, not groups.

Also, would you mind copying the people who are remotely involved with
this piece of code, like Al? Thank you
-- 
Florian
