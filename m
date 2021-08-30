Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233EE3FB911
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 17:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbhH3PhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 11:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbhH3PhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 11:37:17 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF308C061575;
        Mon, 30 Aug 2021 08:36:23 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id bi4so16555125oib.9;
        Mon, 30 Aug 2021 08:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GTNo1Wom6VjY9cXuvhXLTz44pONgpHE1+NUjnkRawY0=;
        b=EEMGlFaiCCD9fU9V1jhUlzSO59uM3a/c13cKfuCwBobaCYBrC6f/zm7nAcrI9ecM4x
         NRHmYjnuqexyiWWCcwjqpEsfh8K8DP+IIo0OnYyXvyHlHTIwkWKY4L5zRMbZCDGfKWFs
         zpSSo7OE94shjRk9NvXHCoyDOl+j+A2nfnPfr9eVykgBFjzr2Odf1IcFrDChWrSEciid
         hbvvNTPnQAdLYB+Eriq8VlUcrE0NzfAEKtHpptU/zKcA4QijxY5RZbqEnkdPAnlKmDF/
         DrgdOa0ILMR1bnZI3NXquzCauZT8xJpATOVRBH8YPNhB2bAsN5qG8/qcxLggYBZCyfy9
         QxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GTNo1Wom6VjY9cXuvhXLTz44pONgpHE1+NUjnkRawY0=;
        b=bbVUBpUn0UfCSLyLKBIlNtFlt4BlHPaKDD1QRsTxyveSxLoin0HbrngWal1/sikukO
         tuwNTK/clAsJb4KAAT49yaN9FZeCsoF7Oi7qVBteqyiAJtGgN+haS88cu5SKHcU2i+iv
         FciDDupGt61Y0E9ICkUfFR4jd/I5d27/2wdtcR3M304iE+Haq1eUWrAzQ+jwSV5dJGuH
         26Dx0D9AEEiZxMfw4w9AtYuXxRpbIvJSZvQu7yshvTMc2uRH0gvtp11JLHqQWAtFUYjW
         M7BrwPRtC4mZPEBzSXHaiBrxNXH3vM3jOuvOIout7+bGo99kC9Kxpo7xvkFWwNmsCGP3
         IjVg==
X-Gm-Message-State: AOAM533qgnuO31YRQ7xRuS/YtQrFWwj0Q3+S28dehlbUqqyQSbMdn1+v
        OkppjXyKwV91TJElQiBNAnLhr79gPZg=
X-Google-Smtp-Source: ABdhPJyd9OiEkiuq/TNlmUOjwCfxmtXBgGdJSqfTQ/jwsOdfTpEJH87800wXBIwRtZfU0t1P/fXHjg==
X-Received: by 2002:aca:1a0f:: with SMTP id a15mr15332556oia.42.1630337782951;
        Mon, 30 Aug 2021 08:36:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v24sm3288662ote.66.2021.08.30.08.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 08:36:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 4/4] hwmon: (adt7470) Use standard update_interval
 property
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210826024121.15665-1-chris.packham@alliedtelesis.co.nz>
 <20210826024121.15665-5-chris.packham@alliedtelesis.co.nz>
 <20210827212942.GA716764@roeck-us.net>
 <fe6cf9f3-f15e-065c-aaf8-cc018edf12e8@alliedtelesis.co.nz>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e467a3b2-d7c7-0920-9287-fb3e7abd5fae@roeck-us.net>
Date:   Mon, 30 Aug 2021 08:36:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fe6cf9f3-f15e-065c-aaf8-cc018edf12e8@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/21 2:09 PM, Chris Packham wrote:
> 
> On 28/08/21 9:29 am, Guenter Roeck wrote:
>> On Thu, Aug 26, 2021 at 02:41:21PM +1200, Chris Packham wrote:
>>> Instead of the non-standard auto_update_interval make use of the
>>> update_interval property that is supported by the hwmon core.
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>> ---
>>>
>>> Notes:
>>>       I kind of anticipate a NAK on this because it affects the ABI. But I figured
>>>       I'd run it past the ML to see if moving towards the hwmon core is worth the hit
>>>       in ABI compatibility.
>>>       
>> I personally don't mind (most likely no one is using it anyway), but let's
>> wait until after the upcoming commit window closes to give people time to
>> complain.
> 
> I know of one application using this sysfs entry. But it's our in-house
> environmental monitoring code so if this gets merged I'll just update it
> to use the new path.
> 
> One thought I had was we could do both. i.e. have an entry that conforms
> to the hwmon core and a backwards compatible entry that just aliases the
> new path.
> 
Now you almost convinced me to indeed reject this patch. The idea of the new API
is to simplify driver code, not to make it more complicated. If we can't simplify
the code, it is better to leave it alone.

Guenter
