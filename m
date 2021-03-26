Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FFE34B022
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 21:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhCZUZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 16:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhCZUYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 16:24:40 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C939EC0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 13:24:39 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id k25so6683846iob.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5z34cqVEPiFQPPc+g2QanD8KGN67FfoACVpCwgARCQw=;
        b=M+5Id7U7uChU5FpwwJKBl6tSDYaRSoYYyECLMoLWvv+As3XPcwyE89uYAvJerEaSD9
         5qND+Ysx0yLbrR8QMBP9T8jtrg8a1OaDmB/1MZe4JuXptveEwUAOxtRz0hb29XY51+hc
         fGOmVonSI4KnRamBGNQcUG4iyALvSnunWh6ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5z34cqVEPiFQPPc+g2QanD8KGN67FfoACVpCwgARCQw=;
        b=dcysykv+ESj9bCc7X1fgKMGXCgwKFABcwzqG5jWIFvfDVrwVji4xRY4Vuu8hObfr3W
         vsqnn6lykFWrK4H/4u934g6yev/KX509mmYmfF9Raq82ebviuQbXCyfT8vWgF3LMZDcC
         tjNHz+9i7XdU10UiUy4jVC0fZSWTE/r6ziCovdZ2ppkGTpFxLotYhlGSphtVzwXb+Vuu
         DarzwnjsTwMhZD09rvoVw6mSwgw5OIwCWW8yJ2kec6ysEQKt3IovtCX2AIvuftDPfmAL
         daK3xuVrCRr4W5ZGJ32Fr7y4dBEonz/4+bUu93hQuT4zIfOeeCO5kh1nnCwo6zdFSFdr
         9+oQ==
X-Gm-Message-State: AOAM530hsHUKcHSI6Ml2D269sDOsAka+zYZtpDmGQBWD2XXEJoSHIDfJ
        48pfphnRMDeRRQPgxs7dvKd1uw==
X-Google-Smtp-Source: ABdhPJyM40N2kL5NOZ2ze+26oXB5bIZuQIeDezK4UbRRE39qjq3dpm6lIIxGLfOHaVFrDoQioHa3oQ==
X-Received: by 2002:a6b:c997:: with SMTP id z145mr11378763iof.36.1616790279309;
        Fri, 26 Mar 2021 13:24:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u5sm4793084iob.8.2021.03.26.13.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 13:24:38 -0700 (PDT)
Subject: Re: [PATCH] usbip: vhci_hcd: do proper error handling
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, valentina.manea.m@gmail.com,
        stern@rowland.harvard.edu, Shuah Khan <skhan@linuxfoundation.org>
References: <20210325114638.GA659438@LEGION>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b2aabe03-0cd9-fe59-5354-0596e3360402@linuxfoundation.org>
Date:   Fri, 26 Mar 2021 14:24:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210325114638.GA659438@LEGION>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 5:46 AM, Muhammad Usama Anjum wrote:
> The driver was assuming that all the parameters would be valid. But it
> is possible that parameters are sent from userspace. For those cases,
> appropriate error checks have been added.
> 

Are you sure this change is necessary for vhci_hcd? Is there a
scenario where vhci_hcd will receive these values from userspace?

Is there a way to reproduce the problem?

thanks,
-- Shuah
