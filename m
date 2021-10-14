Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB9642DF6A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 18:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhJNQrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 12:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbhJNQrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 12:47:25 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D738C061570;
        Thu, 14 Oct 2021 09:45:20 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id e63so9226017oif.8;
        Thu, 14 Oct 2021 09:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nh3Mm3sv8mmSzJBu9gFZMG8wOFsVnRxa26r4C9yDFUY=;
        b=b2hrCz/GU1eOnnrFwl90jdTLNwayM2Matms8rtgkDJHzeVW+FoPppJ53JOKCl13UZA
         AQvDi9YJjvo1hN+1SBt66Rjho4TnfVuCDBAps6IKgaBedP1xErTe5/uAIROooOdCr5B6
         IuIH/eMyGm8ZKvhmhyfA1a8V/dYr7m7+OU0KxeuAOkW3vF03KssxJcBQxM006pvjqkH6
         CdRHD2nf0/Rwp91rwsWC/W0svB8LezDXcj+COHz67Lj3+dP56jUk969d1J6PD8iWOQyQ
         6d25Rl9Wz6jse/EAKNdArjZJm0X5Prkun0Hrw9Yjx3E6+I0H3p6C/YaVYeNikphnNX5Q
         Q21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nh3Mm3sv8mmSzJBu9gFZMG8wOFsVnRxa26r4C9yDFUY=;
        b=pnjO3mrAKOD4piYj6lLBU7X7KAx36+9onZb7/Ey5ejhpvrdm+Zw8HctM2XdeSghhPI
         miOjMCta47LUpBBw9J3gAQbbnvSNbAv46lof87QxpzuKHuUXBFGst1jDc+IN7Dco0bRt
         3V3m2e0tqIJKOHuiOUQMaru/2mQId+C84ES1uE80Y3916NZDXsJWcLElvUfE9vvRtfX4
         SD4b8Vs3yHhK8vDe/jyTGpy3SMW1bl5CkfYBMufgfm3T1EhVvzFZx4riPf/5iPMA++un
         BB3inQWzUHOh9aKTaq3T1QNc+RB8bBtu4JeOUR2vpfX85gDnZlp0N6RgmfRa9y28QQOW
         qbjA==
X-Gm-Message-State: AOAM531VufS8GuWIop1FboWhxQd1PlkYBgkqse+p/SJa9gOujWLRu5x9
        Y3citeRDKDvZ3JLsiHGxR17HhsjvIg0=
X-Google-Smtp-Source: ABdhPJxUO32HngeU/SY9Z0bxU01DsSbC/nTBrZc4Ue4vdLBrsDFq86wkqr2Y9S+xY96XrflaR8Vhrg==
X-Received: by 2002:a05:6808:2310:: with SMTP id bn16mr4743054oib.159.1634229919649;
        Thu, 14 Oct 2021 09:45:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k3sm644081otn.16.2021.10.14.09.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 09:45:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v6 1/2] hwmon: (asus_wmi_ec_sensors) Support B550 Asus
 WMI.
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Denis Pauk <pauk.denis@gmail.com>, andy.shevchenko@gmail.com,
        platform-driver-x86@vger.kernel.org, Tor Vic <torvic9@mailbox.org>,
        kernel test robot <lkp@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211014072537.190816-1-pauk.denis@gmail.com>
 <20211014072537.190816-2-pauk.denis@gmail.com>
 <CAB95QAQQC6KJcbd-WhexBm=jusyoFkkB_a69RizMHpjSEbrqgA@mail.gmail.com>
 <e1a141d4-20e7-62c4-fae3-11166b8d0a66@roeck-us.net>
 <CAB95QAT44kyBR19cu6sP0kFJwFtVnmULqMzTQPArL94x2oxGkQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0df5b9c4-26fc-49f1-a5e2-748cf3f59a4d@roeck-us.net>
Date:   Thu, 14 Oct 2021 09:45:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAB95QAT44kyBR19cu6sP0kFJwFtVnmULqMzTQPArL94x2oxGkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/21 7:36 AM, Eugene Shalygin wrote:
>> The compiler aligns the data nicely anyway (it will just leave
>> a 1-byte hole where needed), so the packing is really irrelevant.
>> Apart of that, does the above suggest that some information/
>> code is now missing from the driver ?
> 
> It is perhaps an unnecessary removal which will need to be undone
> anyway when I (or others) add the south bridge voltage sensor.
> Everything is OK with that change now, but since the size of the
> address struct or union is 32 bits anyway, I would not remove that
> field.
> 

If the field is not needed now, it is better to not have it in
the first place. "We'll need it later" is all but a guarantee
for dead code, unless the patch using it is added as part of
the same series.

In other words: If there is other dead code in the patch, please
remove it now. I don't want to find it when I have a closer look
at it. If there is code which is supposed to be used later on,
either introduce it when it is needed, or introduce it with the
same patch series that uses it.

Guenter
