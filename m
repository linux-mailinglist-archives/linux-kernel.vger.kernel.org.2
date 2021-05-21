Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D41238CB69
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbhEUQ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234189AbhEUQ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621616216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NBEhSmItW1IYNtD9GY2PDr4mhgfEoe+usv31WhGIy1Q=;
        b=Xtw5CJvlhY3j3h7OJZ7cuEI/YQBLWSAieZU77678FkuujVO+Kp30BOI3WIbt57Huvf6Cru
        dEScFyvwzrMpvRp78aCDHJ75/fm25qBYA7C1597UoJl0UEmZWI2qjdUXJu4b0OFy8FaNp1
        NAbwaH9SYiFeqNF7FnfXLGR3pbwMgxo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-vKAwC29XMraZ62vm9oAmqg-1; Fri, 21 May 2021 12:56:54 -0400
X-MC-Unique: vKAwC29XMraZ62vm9oAmqg-1
Received: by mail-ed1-f69.google.com with SMTP id u6-20020aa7d0c60000b029038d7337e633so5466568edo.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 09:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NBEhSmItW1IYNtD9GY2PDr4mhgfEoe+usv31WhGIy1Q=;
        b=UWW0JDxkv/JKmmk3leup7x1lVftBGCo1Q1kaO4WBPNKBPGnOz2LuLJuWHx4pEBbB/U
         ONuZDrJl+73PLNb+Q8b1W7u/xhP+UjZkQlY7aLUXv+zzWiRtfjI63zRlDUcJU6yfEjyq
         ouPgPAPjWCuoxtvf82QxLxYu2BOQQHLR/rnNd+YbMQrd7/yxirpncG9H8+zIA/QgRr1O
         L0WaDZiTtQMM+F7F/0BZ4eH4QjHp0SekoIvacFMFl/3qAgzu9rSyzHw0r1AWZYvNd5gI
         9LdQfJ8j5Pb3rlqiSNzkqwJo6bHD3GlFS0IDo8wPnsImYjDtzjq6rz7ih/C0Y2da/RCL
         z25A==
X-Gm-Message-State: AOAM531uKAgn7QRuzfVL2FSY9rsp40rpvRmrQYR6miKmAzNkpSAfsTND
        uGlG72GJvvUYTyT61kq1SXQAtoNmw1ZlMwfXeVUNXE6tMyzEuIzqp6y9vFv5TTv7XeBtQYUdarn
        pzX8OhMIRFXUFd98diKRLvF93
X-Received: by 2002:a17:906:d7ac:: with SMTP id pk12mr11553239ejb.143.1621616213248;
        Fri, 21 May 2021 09:56:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCWCDVomytJPfa86MwluYPw4QKWppPo0ioZ/nqTfx41wEQP0/qPljMMPxW+0CBwRb6um6ctQ==
X-Received: by 2002:a17:906:d7ac:: with SMTP id pk12mr11553223ejb.143.1621616213110;
        Fri, 21 May 2021 09:56:53 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id d25sm3878425ejd.59.2021.05.21.09.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 09:56:52 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] platform/x86: Add PWM platform data for Merrifield
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-pwm@vger.kernel.org, Mark Gross <mgross@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>
References: <20210521135516.64727-1-andriy.shevchenko@linux.intel.com>
 <CAHp75VcS5UBeJ9eq3dv_8EHwfjdBSBbC4kdmuKyrxCPj+gQ5hA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e0e58e79-318c-8251-0d01-9abd754dde80@redhat.com>
Date:   Fri, 21 May 2021 18:56:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VcS5UBeJ9eq3dv_8EHwfjdBSBbC4kdmuKyrxCPj+gQ5hA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/21/21 4:02 PM, Andy Shevchenko wrote:
> On Fri, May 21, 2021 at 4:55 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> PWM is not functional since it requires pins to be muxed and configured
>> properly. Add pinctrl mapping to platform initialization code. The pins will
>> be configured properly whenever PWM driver is probed successfully.
> 
> Sorry guys for the noise, this has been mistakenly out here.
> Nothing really for upstream.

Ok, I've dropped this from my patch-queue now.

Regards,

Hans

