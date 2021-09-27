Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B025419044
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 09:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhI0H4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 03:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbhI0H4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 03:56:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427D4C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 00:55:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i23so49827599wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DOPWv6omBO7e0UVi3IEnKh+VeK8Y3AGHKd5bdvdA0U0=;
        b=QKSeKnGY0dWJFC6FiPLVtqYrYZpcc8AT+OJ4t9+ADD8YK3IVb/4og0MYO72Az0n+yl
         TZ132pvT2UECe696svxjtX3KhmoOH8lYS7VW1QJduFqzzWPwE31GvcK7Vi1lF6WciIwT
         jry7Ayfv4QD4t/bzOLSHI0CUF72Ef5RoGGAKW05Oau0Qmhrczh1hTw36wKkNeZ+OzuOM
         0pNdW3guxXA05ruM6I9SVmzVSQ1RjYyVjZ7iZZ3LW1FetB+PoDYGF4qgnndqS1KW47N+
         Z2ZiklSOaleZk5LfN7ByUsZan0/fcoO09PwuDt1g4EUU42NTbx/sVt+AbBiqZwguVK/m
         h2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DOPWv6omBO7e0UVi3IEnKh+VeK8Y3AGHKd5bdvdA0U0=;
        b=dHD2wS/3nngKk8HosiuyTiBJCyyPCTMosWXwO7Ezb8k1ZRftDW9fZqoW4AxTReVeuQ
         6wdmwvNCWS/ce5wRtsbNySok4ViJpPKlc3A0KHVuP0yrg917iV9wAY8yDlvoJb7ShroW
         lmXN5hoUgU8q4SrfTDhlUL/zXg8CtxIMqJVHQPlt3fUKu/8a3ZAfo8EsGtbISNc2EBJd
         jWav81IwOpKvkdOAVuh7a1Hr+xTAAnx2hAuF5H+Xgc50jw89Xe2VAu1Muzzy5YPyc0Os
         4OKeEctYkXD9H85VdBVibY4vGEuthtfZbUpYK+t+OjsbOcuVuAIEFcCWYS5/hGJmQ5vb
         P6HQ==
X-Gm-Message-State: AOAM5307kN4Vvi1c1ezQjoc9gXjAlaPEP8DLJrEe6ZPTdz9geNpYlxTX
        CZbfDaRPoDF6iqSPyBwUGHPDSw==
X-Google-Smtp-Source: ABdhPJwBHtVbYJg146ExtEpMgzA7zY9013kfzoL4GImAIVZffyq/6/xajf5LUtxpd9kVEedhXgO3RQ==
X-Received: by 2002:a5d:6c6f:: with SMTP id r15mr26567091wrz.428.1632729308869;
        Mon, 27 Sep 2021 00:55:08 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:410:bb00:d99f:4811:e8ed:bd3c? ([2a01:e0a:410:bb00:d99f:4811:e8ed:bd3c])
        by smtp.gmail.com with ESMTPSA id i18sm16063614wrn.64.2021.09.27.00.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 00:55:08 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: linux-next: Fixes tag needs some work in the ipsec tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210927064921.06973f44@canb.auug.org.au>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <a3680eb9-44d0-efe9-7037-9799a66786f7@6wind.com>
Date:   Mon, 27 Sep 2021 09:55:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210927064921.06973f44@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Le 26/09/2021 à 22:49, Stephen Rothwell a écrit :
> Hi all,
> 
> In commit
> 
>   93ec1320b017 ("xfrm: fix rcu lock in xfrm_notify_userpolicy()")
> 
> Fixes tag
> 
>   Fixes: 703b94b93c19 ("xfrm: notify default policy on update")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 88d0adb5f13b ("xfrm: notify default policy on update")
> 
In fact, the sha1 comes from the ipsec tree, which is regularly rebased.
The original patch is only in this tree for now.
Steffen, maybe this fix could be squashed with the original commit?


Regards,
Nicolas
