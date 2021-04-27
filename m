Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E97C36C71E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbhD0Nim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237977AbhD0Nik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:38:40 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E5BC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 06:37:56 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id g125so5302042iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AnOz18OxWT4XUVdfhkzmW8JPI+/UqwkBcIHUk95028k=;
        b=uKM9tI1609MLSf8/zz52XsfRUdSx4VRN6ttEaxgDhsKIxunOFHAU3DGeC48Hl1OPYQ
         aRPRJk67WKnJF5jghGQHsJNBAB1EGfTbyYTlGASVJcDY5RJF1tepyGQNyVVMMhwx8puZ
         ktLasznrF3oggQa2CGAfSAQNzMvSZaxMxgyRVO3VstoctnQko3rpWAdeUgPYTUuJv+27
         Fm3vuxXXBqLj8Niy885Jn6uZeR+NA6e3io7v4f/zmlulcCsH4m2/lDI8yxQ0pwBYj9mk
         dYLdSc7KwXQ4p9/V/qrkXNqF6N+qJ4k6pt5mu7WEK6pdIv5m9395kisskRuBycIEp/WA
         75rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AnOz18OxWT4XUVdfhkzmW8JPI+/UqwkBcIHUk95028k=;
        b=k4yFkWSabLUceNWQD3hdUSHKFkvThhymYV4RSNnnOaTzGO3UaMOryLpqCIg8ZdaXUd
         dMqMG3pfiestHVBk4Bzs/rxa5tvZIAbbPlPYDjncBRbySmjk1lmX/5zEO1uneJyj49bG
         u+n9ldNNius706iDIEAggjTnB15jpMPmQAV0lI115Tua/5RYzWh7VB+IIZ/gMtq4cXwH
         000Twn3Ue2es2mlNPVprcTh/v3CwfP8pstUJDXtcO9WYh8G1STy0OX/OM7Lg8EsdlSis
         qY+0BGP3TxaLbHpmjTWsDvTMFM9liMilYOmT3LmqI6vxt2MS0/4EsqKUuVpfTp3RqG3X
         K+iQ==
X-Gm-Message-State: AOAM5331lSOjl1BikKjq9HNTaw8OoEhM02KpVUo1hggL804+ZaYIB3aN
        izmwjTiP2EXekb+f9+J1MpzDsw==
X-Google-Smtp-Source: ABdhPJyakhyueEY60LYB8Yhdfg21cGXSyiSkw0899JiBSMGVnQjWInAQSpNfYazkZMdhTMp3GeXQAA==
X-Received: by 2002:a05:6602:3305:: with SMTP id b5mr20167742ioz.83.1619530675494;
        Tue, 27 Apr 2021 06:37:55 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j1sm8954177ioa.19.2021.04.27.06.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 06:37:55 -0700 (PDT)
Subject: Re: [PATCH 5.13] io_uring: Check current->io_uring in
 io_uring_cancel_sqpoll
To:     Palash Oswal <hello@oswalpalash.com>, asml.silence@gmail.com
Cc:     dvyukov@google.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, oswalpalash@gmail.com,
        syzbot+be51ca5a4d97f017cd50@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, stable@vger.kernel.org
References: <e67b2f55-dd0a-1e1f-e34b-87e8613cd701@gmail.com>
 <20210427125148.21816-1-hello@oswalpalash.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <decd444f-701d-6960-0648-b145b6fcccfb@kernel.dk>
Date:   Tue, 27 Apr 2021 07:37:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210427125148.21816-1-hello@oswalpalash.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/21 6:51 AM, Palash Oswal wrote:
> syzkaller identified KASAN: null-ptr-deref Write in
> io_uring_cancel_sqpoll on v5.12
> 
> io_uring_cancel_sqpoll is called by io_sq_thread before calling
> io_uring_alloc_task_context. This leads to current->io_uring being
> NULL. io_uring_cancel_sqpoll should not have to deal with threads
> where current->io_uring is NULL.
> 
> In order to cast a wider safety net, perform input sanitisation
> directly in io_uring_cancel_sqpoll and return for NULL value of
> current->io_uring.

Thanks applied - I augmented the commit message a bit.

-- 
Jens Axboe

