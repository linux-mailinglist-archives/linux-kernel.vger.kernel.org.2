Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21ABD33D11C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhCPJsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:48:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40608 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbhCPJr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:47:56 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lM6It-0004pt-7t
        for linux-kernel@vger.kernel.org; Tue, 16 Mar 2021 09:47:55 +0000
Received: by mail-wm1-f72.google.com with SMTP id n17so3285655wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 02:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2EUYry3S907g8YWL61uQj0tRDRywjXdT1xr6WOEc93c=;
        b=Gog7lS7dbLBUBE1NSA2/MYunPHAptJw3x+WrHp2kC+meWWu0B9F3KgYwTcp0AF+yAw
         mY4AxovJlIPmAGPz7xC5k2AMOTDvoBUkzs4JhWbndDvFifPgQIF61QxUoD/I8+nxKSds
         c4mq/UnKuAr+N5O8AUW6icRZv3OqyzCC0fBcgVyhJ7Bx/hCALB7pHZzLCQLlqk4w7HGb
         8ymCMKNHzohVzusdbR6eZ1VmbmxkgnMQDD7N+uFgL2O82KLuao5iohtfi8nVULiZrP1O
         /xIxuHgUj3Dyqy6Y4xdqSIfsqA3snPvgB+Qn9PXpJ3ftpdpbS/C4uI4jtKAJ5uEapqKo
         BSxQ==
X-Gm-Message-State: AOAM532woGNLnSXjUgzUBWP2Qd9/c4KGIiCMKuydyisJ1eIpCPq4lvg3
        ybyWb2cCZTCASoafhx9KG/n9Aa1Ifsdbj4rYJWuggnRvF+NRs61GUJe5AeDJ2D7pMhyG6zqXH0R
        Edm4t/DW5ghpawAYMht7puJslCYRkXW0ZndE8HvASZQ==
X-Received: by 2002:a7b:c087:: with SMTP id r7mr3882591wmh.110.1615888074744;
        Tue, 16 Mar 2021 02:47:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytTnmWAJ7jnl76YAjx2tRRe7lUDpiro5vx/wmtKCfkkbk7WR4VKmHGo6LcdBf+DR9Aw0OwHg==
X-Received: by 2002:a7b:c087:: with SMTP id r7mr3882575wmh.110.1615888074578;
        Tue, 16 Mar 2021 02:47:54 -0700 (PDT)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id a6sm2864898wmm.0.2021.03.16.02.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 02:47:54 -0700 (PDT)
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <7f348e4c-3051-13cf-d461-eeda0ef53fdd@canonical.com>
Date:   Tue, 16 Mar 2021 10:47:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFB0OcBg3Vj555eA@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2021 10:02, Johan Hovold wrote:
> On Mon, Mar 15, 2021 at 07:12:12PM +0100, Krzysztof Kozlowski wrote:
>> Since interrupt handler is called with disabled local interrupts, there
>> is no need to use the spinlock primitives disabling interrupts as well.
> 
> This isn't generally true due to "threadirqs" and that can lead to
> deadlocks if the console code is called from hard irq context.
> 
> Now, this is *not* the case for this particular driver since it doesn't
> even bother to take the port lock in console_write(). That should
> probably be fixed instead.
> 
> See https://lore.kernel.org/r/X7kviiRwuxvPxC8O@localhost.

Thanks for the link, quite interesting! For one type of device we have
two interrupts (RX and TX) so I guess it's a valid point/risk. However
let me try to understand it more.

Assuming we had only one interrupt line, how this interrupt handler with
threadirqs could be called from hardirq context?

You wrote there:
> For console drivers this can even happen for the same interrupt as the
> generic interrupt code can call printk(), and so can any other handler
> that isn't threaded (e.g. hrtimers or explicit IRQF_NO_THREAD).

However I replaced here only interrupt handler's spin lock to non-irq.
This code path will be executed only when interrupt is masked therefore
for one interrupt line there is *no possibility of*:

-> s3c64xx_serial_handle_irq
   - interrupts are masked
   - s3c24xx_serial_tx_irq
     - spin_lock()
                       -> hrtimers or other IRQF_NO_THREAD
                          - console_write() or something
                            - s3c64xx_serial_handle_irq
                              - s3c24xx_serial_tx_irq
                                - spin_lock()


Best regards,
Krzysztof
