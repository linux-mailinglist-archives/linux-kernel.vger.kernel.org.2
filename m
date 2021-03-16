Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979DB33D17A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbhCPKMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:12:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41390 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbhCPKLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:11:45 -0400
Received: from mail-ej1-f72.google.com ([209.85.218.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lM6fw-0006Z2-G0
        for linux-kernel@vger.kernel.org; Tue, 16 Mar 2021 10:11:44 +0000
Received: by mail-ej1-f72.google.com with SMTP id li22so8877307ejb.18
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 03:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b0duzRCaAd6HCnqDszh8HzHViWmbH3s2/7Iw8Q+UR7g=;
        b=WG0MLUSxQ/pFEQNknjijiSG2PQGKGcq5FjuHGA6v09TulTAreQwVZWwUJzyNWPyqZ/
         1h2WPvmWTUZlbFarGgeNyTFxwlGBbo3tXMN+EoA6XYSYb5JU655K1KlKYdv0vo5fbYRf
         EalN/FhamslyFxbGjnTfNMinw6uQGbmRr2miMQd4wpXKAeVZXl1rLuWZBFXh5LPoDblR
         Hm4Zke05ypPseWqH09RCd8s1tv0L6SrhHA7HWSGSeuIW13gZ7zZIHuElcsdsh5GIN41q
         LTRstjDLMxwnxZK8EfMRVQQVs5mCfvGXq2c/6JKCU9YIwrkXywhaoSXp7nXkTj72EbB7
         caGA==
X-Gm-Message-State: AOAM530HIJO/6NVcNduXk7oyqCzXLl/4CzJrCNSYkyuAcqd8AQhrp5yG
        kqyB5sVq8ZOLhUqRM2epQUVEAByPsshmIJsR6ssRogG+s3iTcV1FatljPRETLNEnPNsiW+2WerK
        JA9yuuzdCVdMyBWOR+ENQngYELdbH8m3Dx0zlcPeBcA==
X-Received: by 2002:a17:906:9243:: with SMTP id c3mr29663331ejx.388.1615889504253;
        Tue, 16 Mar 2021 03:11:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2WvVnE529fDdG65yCEejk0MxK/8sqZnjAJjGw18sNXl1HOe3MN5ShhMd+pxFPJyRYKZpedg==
X-Received: by 2002:a17:906:9243:: with SMTP id c3mr29663314ejx.388.1615889504118;
        Tue, 16 Mar 2021 03:11:44 -0700 (PDT)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id t27sm9126163ejc.62.2021.03.16.03.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 03:11:43 -0700 (PDT)
Subject: Re: [PATCH] tty: serial: samsung_tty: remove spinlock flags in
 interrupt handlers
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcan@marcan.st, arnd@kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20210315181212.113217-1-krzysztof.kozlowski@canonical.com>
 <YFB0OcBg3Vj555eA@hovoldconsulting.com>
 <7f348e4c-3051-13cf-d461-eeda0ef53fdd@canonical.com>
 <YFCA5jFLV0Cu9YNe@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <816834ba-8dc2-05cd-9c81-a11d65980cfd@canonical.com>
Date:   Tue, 16 Mar 2021 11:11:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFCA5jFLV0Cu9YNe@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2021 10:56, Johan Hovold wrote:
> On Tue, Mar 16, 2021 at 10:47:53AM +0100, Krzysztof Kozlowski wrote:
>> On 16/03/2021 10:02, Johan Hovold wrote:
>>> On Mon, Mar 15, 2021 at 07:12:12PM +0100, Krzysztof Kozlowski wrote:
>>>> Since interrupt handler is called with disabled local interrupts, there
>>>> is no need to use the spinlock primitives disabling interrupts as well.
>>>
>>> This isn't generally true due to "threadirqs" and that can lead to
>>> deadlocks if the console code is called from hard irq context.
>>>
>>> Now, this is *not* the case for this particular driver since it doesn't
>>> even bother to take the port lock in console_write(). That should
>>> probably be fixed instead.
>>>
>>> See https://lore.kernel.org/r/X7kviiRwuxvPxC8O@localhost.
>>
>> Thanks for the link, quite interesting! For one type of device we have
>> two interrupts (RX and TX) so I guess it's a valid point/risk. However
>> let me try to understand it more.
>>
>> Assuming we had only one interrupt line, how this interrupt handler with
>> threadirqs could be called from hardirq context?
> 
> No, it's console_write() which can end up being called in hard irq
> context and if that path takes the port lock after the now threaded
> interrupt handler has been preempted you have a deadlock.

Thanks, I understand now. I see three patterns shared by serial drivers:

1. Do not take the lock in console_write() handler,
2. Take the lock like:
if (port->sysrq)
    locked = 0;
else if (oops_in_progress)
    locked = spin_trylock_irqsave(&port->lock, flags);
else
    spin_lock_irqsave(&port->lock, flags)

3. Take the lock like above but preceded with local_irq_save().

It seems the choice of pattern depends which driver was used as a base.

Best regards,
Krzysztof
