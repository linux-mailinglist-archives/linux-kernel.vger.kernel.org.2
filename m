Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D80837A80D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 15:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhEKNtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 09:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhEKNtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 09:49:32 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4500BC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 06:48:26 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id y32so15767713pga.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 06:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mo+U9QAR21yaX72b0ALo/LmNCSm3uwdtfXj48gyyn9s=;
        b=rHpv6wiFztE9P7VXL2P+E3fTJwJku3yR5LcPHyCr3OqTjbdS5jo7JCEpXkIhYPhy+2
         3R/dR3Xq9y+68SrRyHhe1uBBqGl1FBCtc98HXr3J2Yt4kPKjie0mPUeBByBgx4v0Yd8q
         GYAblKoOfaxjS/8KYACqefENPPz8pVrknqxywsz+HzK1GfpRO6OxMNpvgUB0Fq0xKdUw
         FjAwoM+qnnVc9Us2n+YBHtMZ7rKrMnoWW4k2UTdxrhIkOPq9mxxt6NjlqU/niQDDfwOm
         egXJw0csmOBjblajxkrlzSmDkKIEU8jxFUixb4ACA16gRHJ+2+G1EjjuR2b5e+kt9yQW
         0/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mo+U9QAR21yaX72b0ALo/LmNCSm3uwdtfXj48gyyn9s=;
        b=mpasNIGpYAiIb81JaCi8MrJeB3zlJCN6vP+ZMUOXd+JSV4lkfK4qgbDrfUOzYXPjc7
         nfH/0GYOkF5bcNarB3GRXuWlfcFIqM/jBYddQVpw4xYHe+xa8NlUu2lVNxzm/rw0xASQ
         Edoectn/nUaepu2jkQaw25Srkzo++Qy8HOXS6YD83Bh9W+ZMKwebBHsJtphnRJkinmkc
         /lVYpYjLcqoIv9IS73c77INVeOAeliLzcDZ0OXVhBIesbelr7Qi8XYawRvs0dmqIdYH4
         f+sQGtnbQTUWjf+2uq6i0G3Ec3q4HsEbHxPzyoxnRabM4c9wb+rWY+n/MqxL7FNwAifC
         kVFw==
X-Gm-Message-State: AOAM530aKvV5zya6XqMOej2+tEoqOGsNgMl9jDibAF65wL7psp7Ist4y
        WNLVP8XDr/IUWhdpm4ztHnUyz9FB9eNttg==
X-Google-Smtp-Source: ABdhPJzOdeKU451hMKMemeI66d1trTy70/4aIUBfcyyoHV9k1KCJ59/fvR3Ky6gc319AF7TEhidLxg==
X-Received: by 2002:a05:6a00:78e:b029:28e:62a4:5f3 with SMTP id g14-20020a056a00078eb029028e62a405f3mr30302561pfu.19.1620740905302;
        Tue, 11 May 2021 06:48:25 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id e20sm2314126pjt.8.2021.05.11.06.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 06:48:24 -0700 (PDT)
Subject: Re: [PATCH v6 0/2] fix a NULL pointer bug and simplify the code
To:     Sun Ke <sunke32@huawei.com>, josef@toxicpanda.com,
        Markus.Elfring@web.de
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20210218122620.228375-1-sunke32@huawei.com>
 <6df9a13d-b876-976f-ad48-884c88815269@kernel.dk>
 <aa80f848-c895-4478-f582-10a57a1166c3@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6ab031d5-f836-77c9-8be0-7b3e82a087a8@kernel.dk>
Date:   Tue, 11 May 2021 07:48:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <aa80f848-c895-4478-f582-10a57a1166c3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/21 12:59 AM, Sun Ke wrote:
> 
> 在 2021/2/19 9:07, Jens Axboe 写道:
>> On 2/18/21 5:26 AM, Sun Ke wrote:
>>> fix a NULL pointer bug and simplify the code
>>>
>>> v6: Just add if (nbd->recv_workq) to nbd_disconnect_and_put().
>>> v5: Adjust the title and add “Suggested-by”.
>>> v4: Share exception handling code for if branches and 
>>> 	move put_nbd adjustment to a separate patch.
>>> v3: Do not use unlock and add put_nbd.
>>> v2: Use jump target unlock.
>>>
>>> Sun Ke (2):
>>>   nbd: Fix NULL pointer in flush_workqueue
>>>   nbd: share nbd_put and return by goto put_nbd
>>>
>>>  drivers/block/nbd.c | 10 +++++-----
>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>> Applied for 5.12, thanks.
> 
> Hi Jens,
> 
> I do not see the patches merged yet, is there anything wrong?

Huh, that's very strange. Not sure what happened here, care to
resend them?

-- 
Jens Axboe

