Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879D543E704
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 19:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhJ1RS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 13:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhJ1RS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 13:18:57 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE253C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:16:30 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id y128so9236322oie.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XOqfT2s6CQdY65m3hTpdBG90eDfNHf8fN3lL5R2nBS4=;
        b=GftxOqFNx9PRz5dMUH70l03gjTwmp3qQOBHiUAJMTTkdg916tpBxNqPvVNsq+T3MGf
         WBCdseFkftAAIXCZCH3Ii2i3DnON3Z0GTFj7RoX2V7XLeg6ecvDOaq+wV03bhFX61p8V
         +g+YjIclrRdwh/qmQO2cMUsF29aQRtqmVOAyAGcP8Loj9M52LSdLKeK3GRuGk3oZ/Tug
         qVyattrhtFXvTzHZPMhKzZ7eZoqeaeGt4dWsVKNnJzX7LSiMCUtElIHjMLnPAkjulSWK
         Cdd7j35IhK19Jopp88PVvtPg9oe+EwM40qHoQ8ZFiSewrS9e1HJ3eu6e4jskQArrkjgn
         sUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XOqfT2s6CQdY65m3hTpdBG90eDfNHf8fN3lL5R2nBS4=;
        b=0VvPNI/9n5o44D2GLHPYTljMPpc+aHKbZXscOSjGGk+XvNiG6l3frZ7jqE3qZdRuv+
         3vgR7CW4PRnFET53hi+HpLkDCNsaN0kwsg7A0kf71D30ATlO7iE3fe5wsXrmZfhbs9sB
         QMNaPG3xgjMhIYLveusNi4wGuWERoxx+z0P6y8wj1ISq7FzXsyQJxMakMxm4WjEsSyDc
         V5LVPvC4XBlZqRxpBtToFuYZg4rDtdCAx+JcvtrlPnVVYCQarlpfnUa/hQYUlzZWir3u
         wghgSU7EsCXbGOxqJfke29BpWt4sD7kHKATtoEOHD1vlnllAOzT6F7SCfDYJddxwaGHg
         /mmg==
X-Gm-Message-State: AOAM5331GJKbvNcNHsm/o2nu/Z8YyrVnuaPdv6lFQtLoUUzE1qHT4FNr
        /e6QDX4Fw+1u/VbV8FM7XAY=
X-Google-Smtp-Source: ABdhPJz+UVa4pv14SKm81UTlNKXujnQ/tVsyaHI+I2Gh99EpIjSRkoOh++RGBwa3BsbcCYZew0ep0Q==
X-Received: by 2002:a05:6808:1cc:: with SMTP id x12mr9442423oic.88.1635441390191;
        Thu, 28 Oct 2021 10:16:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c5sm1290529oiw.13.2021.10.28.10.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 10:16:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v1 1/1] delay: Replace kernel.h with the necessary
 inclusions
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211027150324.79827-1-andriy.shevchenko@linux.intel.com>
 <20211028153055.GA440866@roeck-us.net> <YXrIlT+2llnwgRpj@smile.fi.intel.com>
 <20211028162810.GB470146@roeck-us.net> <YXrUu8swbM3BL/4C@smile.fi.intel.com>
 <YXrVO57eLx8gkWHW@smile.fi.intel.com> <YXrXOLgjCNOUpsPK@smile.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a3fc2f44-efa2-ff36-3c1d-1d0d5254fd2a@roeck-us.net>
Date:   Thu, 28 Oct 2021 10:16:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXrXOLgjCNOUpsPK@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

I am currently running a bisect on the parisc failure. You are right, h8300
looks suspicious as well. I'll bisect that as well after the parisc bisect
is complete. I'll let you know once I have results.

Guenter
