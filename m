Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D69835B4B0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 15:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhDKNmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 09:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbhDKNmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 09:42:33 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6354FC06138B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 06:42:17 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id c18so8698123iln.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jHOs/GUNj1A6ya3vcccNEUycGjR7OVNzCp35FYh45a8=;
        b=L1RRQYC6N+Dgp4DoT7PRd517GDpNGGbtDzuZ9+qO0iXUwrd8RL0nk3BAmjHcOFMh/L
         F58/rFW3gpuUbxOkb+NQDUNqI2Vd3qUINmwa5K/XHJOSyBC/3TDhRtaAwfXQ8f+4KIgh
         LpKNRLly3IdatiwMfBXxgTcaR9FmlXDegyQSTfY5RJK5ZnCjwxxmIhR2c9nduL13eZcK
         Habfk+eVF9R1w+FVnmdaQZYrgeDP17L4nvzNJZkJf2TqBDyeu/jllBXzntrXHxyerbBl
         1+8r/iPAfKIviGsRx5iRDGpav4ASk2kzYQF0pnuXTf0wj5+r7wyM4BBuFE30AeOpbs3R
         83Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jHOs/GUNj1A6ya3vcccNEUycGjR7OVNzCp35FYh45a8=;
        b=qC0+B92pITUHDDyEFG20Gy/CWthjchhijb8iBc7BJLWP5V+QoR3jWCu7eA5moeTLwB
         NFtYy8e7JUDCnj68YzXULD7x9ILq6p6dyIl0OHHArgTmdVI+eznJ3QqkidvkY1GcxTOc
         az4/jg6SL4xlPAXAWEsW4N2KdfuZYAsy5oi3/UpH0e0WKLjyxHI1fuAZsS58kTgaijd7
         tRBW3XGIm8kum9I9pbxXXi9LsODJ2Yb9AsKBqmyDyEGe/6w1LwNd/lv6JG5+jrYcNlpk
         wq83lx0QWwQxAVPwaTtkt+dmoDR5Y/+ow0NwZzyixE3GAdXR/H/hNl6eis9+ZFEaxgwr
         Vnmw==
X-Gm-Message-State: AOAM532RKT2eJ2kS0ZZ57JvWOoOtCeh9CMraYBl+gA+2NLRR0iKfy1iE
        Mui9n/ujBgVzr4KJquLqS5J4BxFd3d2q9A==
X-Google-Smtp-Source: ABdhPJxuBaDdJ7m0Z1ESomTiIQVbmHZfCmZCK7Lzg4DEFwh75H0k+WYobd4D4EFPi3LJyDoysVg5gg==
X-Received: by 2002:a05:6e02:20c5:: with SMTP id 5mr1869932ilq.14.1618148536684;
        Sun, 11 Apr 2021 06:42:16 -0700 (PDT)
Received: from [192.168.20.93] ([64.118.8.63])
        by smtp.googlemail.com with ESMTPSA id b9sm4186165iof.54.2021.04.11.06.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Apr 2021 06:42:16 -0700 (PDT)
Subject: Re: [PATCH net-next 4/7] net: ipa: ipa_stop() does not return an
 error
To:     Leon Romanovsky <leon@kernel.org>
Cc:     davem@davemloft.net, kuba@kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210409180722.1176868-1-elder@linaro.org>
 <20210409180722.1176868-5-elder@linaro.org> <YHKYWCkPl5pucFZo@unreal>
 <1f5c3d2c-f22a-ef5e-f282-fb2dec4479f3@linaro.org> <YHL5fwkYyHvQG2Z4@unreal>
From:   Alex Elder <elder@linaro.org>
Message-ID: <6e0c08a0-aebd-83b2-26b5-98f7d46d6b2b@linaro.org>
Date:   Sun, 11 Apr 2021 08:42:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YHL5fwkYyHvQG2Z4@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/21 8:28 AM, Leon Romanovsky wrote:
>> I think *not* checking an available return value is questionable
>> practice.  I'd really rather have a build option for a
>> "__need_not_check" tag and have "must_check" be the default.
> __need_not_check == void ???

I'm not sure I understand your statement here, but...

My point is, I'd rather have things like printk() and
strscpy() be marked with (an imaginary) __need_not_check,
than the way things are, with only certain functions being
marked __must_check.

In my view, if a function returns a value, all callers
of that function ought to be checking it.  If the return
value is not necessary it should be a void function if
possible.

I don't expect the world to change, but I just think the
default should be "must check" rather than "check optional".

					-Alex
