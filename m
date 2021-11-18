Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456A64553B7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 05:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242909AbhKREU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 23:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242913AbhKRETy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 23:19:54 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D9CC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 20:16:54 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id m15so4158755pgu.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 20:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WcEi1WKCV2U5xgYJMZvv856GF8dvLozL2TOif8DrYHI=;
        b=WOAODoeF1orzI+akjNjmojYl6xn/H+4SO2jLHvV5hkYYHwAX28a3RlPVyZM7eXXtNx
         Z/+ZnXFWz8zHERjZ4wumHQoj+Y3Yb5e+VRUGc2qvBkvknt53o+hv3oT1yV8FdmIahc34
         maFWqSsbXDb0/1DzvdXF3XeWI7cP+uio/XADIDNkpMKqDwvegyzwy9AbnSObTEHye6kn
         Ss5fpZ2US2nQWMjnaiQys1+N7dDGSmL/J4fTFtswXnGL70cTcHghK7F/yuCo44zxPFcg
         7S5sWhP05R1cG1ZNYrHVO//09NNNBfqQfUuPWV9OuqBeIQnmDnQ/khOo45YmQyUyo6OA
         UoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WcEi1WKCV2U5xgYJMZvv856GF8dvLozL2TOif8DrYHI=;
        b=OtVBLfj1SiQ/c9MhRlkJGfUehr7zb+/pLdcPI71itbtRYtEDYpA/4Kswpom6vin/nK
         siUoTV+ZZKQzvCeDIvy19L1FshaLyW+wN8fZJWiqyh6Yn0LK6DR6ItxHA0e36UefgaeN
         SdveO7aPAGGovETY9ebSG/l9IRH5GfdF6sSEKe0/CqlWJ0yw16T4FwoyfDNdRom+0Rds
         /WcuHAcL3AAY7yR1TJGnhqc0KYWKbm2vXi/u149yxalsnk30lHkuI5J/EIyA0Qp1ESvB
         XuKOUOmiuyX6on0sFCYGFERScUlanWvCYGOe3/wJnxl894tkT9ulKV/U/DsYO7bJsxFf
         UWbQ==
X-Gm-Message-State: AOAM533+wliyE9u2g3cvC3wZQ8UjkFlCSIQqB9ZH1U1KtwkxwxwwfaTA
        puLHKWfcdNFxZqXwKfcsGNNx
X-Google-Smtp-Source: ABdhPJztQ7H82q5d5wLTNF0WLXnjdJ90/tBKvkGibg6OUzA1MbvGAZh4QlFhV02WE3XB6er9LISXkw==
X-Received: by 2002:a63:42:: with SMTP id 63mr9126426pga.127.1637209014353;
        Wed, 17 Nov 2021 20:16:54 -0800 (PST)
Received: from [172.16.8.241] ([98.149.220.160])
        by smtp.gmail.com with ESMTPSA id w189sm1144224pfd.164.2021.11.17.20.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 20:16:53 -0800 (PST)
Subject: Re: [PATCH v2 0/2] serial: 8250_pci patches to address issues with
 pericom_do_set_divisor()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>
References: <20211117145502.43645-1-andriy.shevchenko@linux.intel.com>
From:   Jay Dolan <jay.dolan@accesio.com>
Message-ID: <89c2f319-b0b9-3c64-e9f8-6c4081cdcce4@accesio.com>
Date:   Wed, 17 Nov 2021 20:16:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211117145502.43645-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/21 6:55 AM, Andy Shevchenko wrote:
> A series patches to address three issues one customer managed to hit
> all at once.
> 
> 1) Fourth port not being setup correctly on some Pericom chips. Fix
> the entries in pci_serial_quirks array.
> 
> 2) Rewrite pericom_do_set_divisor() to always calc divisor and to use
> the uartclk instead of a hard coded value. Always calculate divisor
> without passing control to serial8250_do_set_divisor().
> 
> Jay, can you retest this, please?
I was able to verify that the fourth port was placed at the fixed 
address for the card that previously had it at the wrong offset.
I was also able to verify all of the standard baud rates for 24 and 
14.7456 MHz crystals from 50 to their respective uartclk speed on the 
oscilloscope.
> 
> Changelog v2:
> - dropped no-fixes patch, left only fixes here
> - amended refactoring of the ->set_divisor()
> - fixed Fixes tags
> 
> Jay Dolan (2):
>    serial: 8250_pci: Fix ACCES entries in pci_serial_quirks array
>    serial: 8250_pci: rewrite pericom_do_set_divisor()
> 
>   drivers/tty/serial/8250/8250_pci.c | 39 +++++++++++++++++++-----------
>   1 file changed, 25 insertions(+), 14 deletions(-)
>
