Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F8C3D13ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 18:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbhGUPis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 11:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhGUPir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:38:47 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB70C061757
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 09:19:24 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id a17-20020a4ad5d10000b0290263c143bcb2so676368oot.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 09:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V68QkkCRxVc1i8IofVKRhJiTH9nwdrtSj5K+hf6SL3A=;
        b=QmDN9hS4Aq/Di8SdCrH1vSQoFJ/Q/xVzyRhfkzJ22KWmfjcK0eH7T3dVqpvIG5LNMj
         6z6bK8tU33NlW6ci8Z53KcDlDdQVCly4q0vvcMPysc+SDXFkl9kJzd0uPnEJcuDt8etH
         xOJJRx5ljPtZ6z1WK7Z/wtV/ZTttvNoDU6ZTeVCVaa6KtRehPQi6mx8sWraywkqUwYHL
         PaWpU8RB9/rtkKEcq9c0+G+K+DHpoCoQK+HwG9Brxok5ZJWQEpABRdopI4zB3aF4miye
         JtfA69zuK+3fIlYfkTwiacsDcw4lXdeLOR8uPA/lSDPuGQ1VubBUIqn62kx+5pSJBnYI
         H8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V68QkkCRxVc1i8IofVKRhJiTH9nwdrtSj5K+hf6SL3A=;
        b=MjS4+kGD/MO2JzLO3xfHpLO08c/CWKjeOyPp+79LTJnWCKvEzS1eMZn2OO9oNSEYiT
         0bn/vxOvyH+EXtsyj2Jjx/zSpm8nJSSyCVzpwHsgG4gXbxfQyoxnvrTYoQPb6LqVSPkc
         Gj7Fg51qE9isNWZj4suU28rBckvOJvJVz1kF065a44/breTUjDNAz/OU2yfCkesgEwZA
         J2g36GlwH4AY+QpuhtjmaERZZEmv8xk6+4SP83m2h7eobrbAvMRP72bWBWNPVrstMtbZ
         HPfVpnR2mE0XxYwGuDRhNOT3nEU+TVAUy8W+FSzvDwX4kIVjQPj01WP+JAbyWynjUR3O
         UVJA==
X-Gm-Message-State: AOAM530AXSOczf6CHwgxQhweZPL1XQa3tKZj1Q9po984tujyv6dP9XMu
        o+YQ9FcUOx3y7Bhd5KOxjkNYnt4tigUeNQ==
X-Google-Smtp-Source: ABdhPJxmd0ZvNnZChBwQgLueHKEhcVNjoVwuJY0/yhCLS27KajUWC8Yf9bCfh+Tqd9dxrZ2pLjJjyQ==
X-Received: by 2002:a4a:c3c1:: with SMTP id e1mr22457265ooq.93.1626884363447;
        Wed, 21 Jul 2021 09:19:23 -0700 (PDT)
Received: from [192.168.1.170] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p4sm4478415ooa.35.2021.07.21.09.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 09:19:23 -0700 (PDT)
Subject: Re: [PATCH] block/bfq: the delta_from_first should be ns rather than
 us
To:     Paolo Valente <paolo.valente@linaro.org>,
        liubaozhu <liubaozhu@uniontech.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210721063047.92122-1-liubaozhu@uniontech.com>
 <3A3B282C-FA5D-43F3-9C78-5E257C93A835@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fd992897-2ef6-f574-eb07-5223fc6b1af5@kernel.dk>
Date:   Wed, 21 Jul 2021 10:19:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3A3B282C-FA5D-43F3-9C78-5E257C93A835@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/21 1:54 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 21 lug 2021, alle ore 08:30, liubaozhu <liubaozhu@uniontech.com <mailto:liubaozhu@uniontech.com>> ha scritto:
>>
>> In the block/bfq-iosched.c,the function bfq_update_peak_rate(),
>> bfqd->delta_from_first = now_ns - bfqd->first_dispatch,
>> according to the subtraction operation here,now_ns is ns,
>> and bfqd->first_dispatch is also ns,so bfqd->delta_from_first should be ns.
>>
> 
> Correct!
> 
> Acked-by: Paolo Valente <paolo.valente@linaro.org <mailto:paolo.valente@linaro.org>>

Just pick this up for your 5.15 series and include it in that.

-- 
Jens Axboe

