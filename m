Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89C4355D5B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 23:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243145AbhDFVBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 17:01:31 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:46011 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbhDFVB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 17:01:29 -0400
Received: by mail-pf1-f180.google.com with SMTP id i190so3059238pfc.12;
        Tue, 06 Apr 2021 14:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hfrSDSOf7dz95j1TUSui2Oqhjlqy4wI9MNl+YbgzeIo=;
        b=pc9TqzRoUz+Uk4cE20pZj/n3crOxkdUZcODnRDAi1hB0ecCut/Nhw7Opjq7qeleCu2
         PKCcaBcnl8fNVnvwO6zZCAz/m/IhlnQF1hm183oGc0iJPRSP4bB9ng5N7XnxzQIPlRhc
         IKASDcZTdliwjOY7gH5PqE2NpBT2OR+lvcMhKa83RHUKHCi44Fbmm6eSIiF9kgiaa1lG
         ZcwjHuYsyzqZBngs0Njbg4QgOGOgeywClJG1Ni+LfDs8AKcr3Rd68vIpn7g+2E/xpnMe
         GW1aimYrqhVPG5FCAgW5h0P1iV8l3w7xyAj9Cd9WKHrgC8l6x0lW0UAkr1OQuyeDuPAK
         Olsw==
X-Gm-Message-State: AOAM531AUkHMmQg+R3AFcAKIgUuVg/E6wabGG8tkgOOiHh9NW4N/aSw3
        S4fMEJUPA8eVYeXGDaJIinaLnAY4U7A=
X-Google-Smtp-Source: ABdhPJyY1l4P/y4f0g/daQn4yN3yKRPzXqq+2HUCmB8L/7Ph+u+tO0kYTu6IE7l77VSUBQGg7GBDAQ==
X-Received: by 2002:a63:fc58:: with SMTP id r24mr69382pgk.368.1617742880930;
        Tue, 06 Apr 2021 14:01:20 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:277d:764e:de23:a2e8? ([2601:647:4000:d7:277d:764e:de23:a2e8])
        by smtp.gmail.com with ESMTPSA id 12sm18703095pgw.18.2021.04.06.14.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 14:01:20 -0700 (PDT)
Subject: Re: [PATCH 03/11] block: mtip32xx: mtip32xx: Mark debugging variable
 'start' as __maybe_unused
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
References: <20210312105530.2219008-1-lee.jones@linaro.org>
 <20210312105530.2219008-4-lee.jones@linaro.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <3d04bf40-a614-18f2-b003-a9786ceca1fc@acm.org>
Date:   Tue, 6 Apr 2021 14:01:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210312105530.2219008-4-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/21 2:55 AM, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/block/mtip32xx/mtip32xx.c: In function ‘mtip_standby_immediate’:
>  drivers/block/mtip32xx/mtip32xx.c:1216:16: warning: variable ‘start’ set but not used [-Wunused-but-set-variable]

Has it been verified that the compiler is wrong, or in other words that
this patch does not suppress a useful warning?

Thanks,

Bart.
