Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C9E43E75D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 19:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhJ1RcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 13:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhJ1RcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 13:32:15 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4E1C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:29:48 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id q124so9317455oig.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rc0B7QtW2wZY6vs+R/iCUa6VDxNK0hAXINp+oO4w5Kc=;
        b=cLAdqmic30jydkYJfV4oEI9O3cBDBjYz4pr4/u0hjRdO2e48cFaD2/6qFHl5Cu6CfQ
         RoWWoIMBnku93Og+kLZ8WeKC/0T36LCuTAGQSj8tDKRhb6h8nVGQo5LIVCdFI//3BorS
         DuOqQD4ySYKbSDllNRM4Ix8xcV/dv4ZxpmDXlkkWd2O8CCUk2LgKtcreHtrCrL5jd7Vv
         Z3QkSl/oqYDpi/ljFIlHjHZpeaQ3GMmcxpZqHjLDZb46E+E2ZrtsWO7gjaNrmtBEM8XD
         utMw+2f6IgCS7585gfdF15LqoEkTSfi/gZuh2lg4iQrOx4PKUcS5K5cHU3j+bF+Dzod6
         qEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rc0B7QtW2wZY6vs+R/iCUa6VDxNK0hAXINp+oO4w5Kc=;
        b=OAnQgmcKgVT+iVGajykN7v0t0dbmoHgmR0TX0+miKvspQsuH7xXvAbYEhZmq9tAyFm
         swM38HqFkaGDHQwb6izax0rIY/0MA2dCXJD3WXO4i6rx3z7qGVBEbQJvHkHk8Ptxb+7g
         gkE+mbyNlW8MK4BslDOtTd+Xs6amOtmGp9ftXhsCszfAlwTBkH7u74ZL911Ag1C1pe+a
         iGriRPfEp9jH4aIQlSJs7rDoB8aRtmhWoOxFxdrLVpGAEF3xWXWDdUR6EdcEXL63cNj9
         iiQ0pWhvoPbj+MsmNAKZt7QBAhHiJNloDPhtih3xEHMOquAbvzEyxi8ZiCcDiK/ugWLw
         riFg==
X-Gm-Message-State: AOAM533VdtLpnvRUqCeNscKsb4mmz6d+zIvHJS3SS8vhf942JEHcCOPb
        xab8hGHzJfjR2G/zMKuwYofWfpUOo+o=
X-Google-Smtp-Source: ABdhPJz/IdPthr4C6hNpFFccqDR0W7G+OrEqq1rwbrYk17snpEWenJqHUHMMXJIDw1cjtVf4clciqQ==
X-Received: by 2002:aca:3a06:: with SMTP id h6mr9621762oia.22.1635442187359;
        Thu, 28 Oct 2021 10:29:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b13sm1170847ooo.20.2021.10.28.10.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 10:29:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211027150324.79827-1-andriy.shevchenko@linux.intel.com>
 <20211028153055.GA440866@roeck-us.net> <YXrIlT+2llnwgRpj@smile.fi.intel.com>
 <20211028162810.GB470146@roeck-us.net> <YXrUu8swbM3BL/4C@smile.fi.intel.com>
 <YXrVO57eLx8gkWHW@smile.fi.intel.com> <YXrXOLgjCNOUpsPK@smile.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 1/1] delay: Replace kernel.h with the necessary
 inclusions
Message-ID: <c18affca-8667-0936-3de6-0335e6ecc6b4@roeck-us.net>
Date:   Thu, 28 Oct 2021 10:29:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXrXOLgjCNOUpsPK@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/21 10:00 AM, Andy Shevchenko wrote:
> On Thu, Oct 28, 2021 at 07:52:12PM +0300, Andy Shevchenko wrote:
>> On Thu, Oct 28, 2021 at 07:50:03PM +0300, Andy Shevchenko wrote:
>>> On Thu, Oct 28, 2021 at 09:28:10AM -0700, Guenter Roeck wrote:
>>>> On Thu, Oct 28, 2021 at 06:58:13PM +0300, Andy Shevchenko wrote:
>>
>> ...
>>
>>>> Build results:
>>>> 	total: 153 pass: 115 fail: 38
>>
>>>> Qemu test results:
>>>> 	total: 480 pass: 315 fail: 165
>>
>> FWIW, most of them on the first glance due to something like below
>>
>> <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>> samples/fanotify/fs-monitor.c:7:10: fatal error: errno.h: No such file or directory
>> 7 | #include <errno.h>
>>    |          ^~~~~~~~~
> 
> I have briefly looked at the logs (stdio) and potentially my patch might brake
> h8300 and parisc, the rest as pointed above (have no idea if my patch anyhow
> may be involved to that).
> 
> Hence, will sent only fix for what you bisected.
> 

The h8300 failure bisects to "irqchip: Provide stronger type checking for
IRQCHIP_MATCH/IRQCHIP_DECLARE". I'll report that as reponse to that patch.

The parisc build failure bisects to "Merge branch 'for-next/kspp' of
git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git"
which of course is always a bad sign. I may not be able to track that
down until it shows up in mainline.

Guenter
