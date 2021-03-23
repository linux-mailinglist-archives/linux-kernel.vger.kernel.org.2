Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAB6345B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhCWJps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhCWJpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:45:23 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45314C061756;
        Tue, 23 Mar 2021 02:45:23 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id z25so24735191lja.3;
        Tue, 23 Mar 2021 02:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uzZS3gbuouaMb0aQwKUk+wnYNoHawdjGYDJEn+Ti01E=;
        b=CuMYxk9uua2EDFqkfdK0Apjwmd1wXAWoekdTgXV9zgxk8CIPZNvSZmTRC5rzD8vRF8
         Y4RaU/csADxzOMkK0iTCfjP2Hge4U7sVREuftSAvjeVv16p37mQu0DE0ybOVhTh5WPUz
         6ONeLy0gAcnTd66kT8S+DqJMZjJj7qdOcOv9Kd9ofDUM/7iJ9JMl53+3D6LzJU/Lldiz
         3VeOcGjKkVzCNVmqWqMjb8VeuFL36oJuWo7P3vegKe4ZIszPeJUwNbT/vnxAnpAZ4AFZ
         Jvdk1B4yI0bKknFRUSShq+c1Wvg8P1VJ2hhPtexJUJZEJ4j78X0Lb4+80Xz+ppvT/gzu
         I+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uzZS3gbuouaMb0aQwKUk+wnYNoHawdjGYDJEn+Ti01E=;
        b=sRRl8hfterDVNbzGAAUFXwGVMXKPdQvvkElyMF6EITgelR6DHvNQF0oZaoyNcudxzW
         o0aPcNmmUEdUnGHvMjb7OqKkIjYOa5YQvfTO7Ccy19KaWE6XoDh9YFGqsmdV7rfh0CKG
         D6/HE/EbuqmGmojRvG2hZeyWYPPaNwQutU50TcPiS0AbhijVMLjwMgG0BeSb8GM6AwAS
         CAFqYO3UXYqpZniNEa5pU4QcL5ZGDB4VF56WYdAQrrk+y7nqbP8Bvx37Em2QJ4rDSBxD
         9ntmpnWVa2utXm7GIyr8DDlskXfjNlJmDBTHeMQw7OxoRPRumVXNQBROLuCv5mitYncw
         Fg1A==
X-Gm-Message-State: AOAM530KiB6iIYGSnk3VYQmnPgdcQQUMYJiZzsAmMLr45LQpYAdVgncR
        oKISMZMY24JnzKF5c3ZLfho=
X-Google-Smtp-Source: ABdhPJx+jkwGhKp9ObWDXaNpkj/W9ElDHuF8ny9OFN3+0UAmgX1evbxBuAjAQBqkCSkyuKwuzCkcvg==
X-Received: by 2002:a2e:9c8e:: with SMTP id x14mr2604023lji.312.1616492721795;
        Tue, 23 Mar 2021 02:45:21 -0700 (PDT)
Received: from [192.168.1.100] ([31.173.87.52])
        by smtp.gmail.com with ESMTPSA id a8sm2269164ljn.96.2021.03.23.02.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 02:45:21 -0700 (PDT)
Subject: Re: [PATCH v1 4/6] usb: gadget: pch_udc: Move pch_udc_init() to
 satisfy kernel doc
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20210322211149.6658-1-andriy.shevchenko@linux.intel.com>
 <20210322211149.6658-4-andriy.shevchenko@linux.intel.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <dc377e4c-d601-790c-f20b-7e89c5d4e587@gmail.com>
Date:   Tue, 23 Mar 2021 12:45:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210322211149.6658-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 23.03.2021 0:11, Andy Shevchenko wrote:

> Kernel doc and the content described by it shouldn't be teared apart.

    s/teared/torn/?

> Otherwise validator is not happy:
> 
> .../pch_udc.c:573: warning: expecting prototype for pch_udc_reconnect(). Prototype was for pch_udc_init() instead
> 
> Fixes: 1c575d2d2e3f ("usb: gadget: pch_udc: Fix usb/gadget/pch_udc: Fix ether gadget connect/disconnect issue")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
[...]

MBR, Sergei
