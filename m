Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE05412B23
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244475AbhIUCIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbhIUBvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:51:50 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF67C0363DE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 16:08:08 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id x2so6106324ilm.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 16:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6nsdqj3UHDbO3giqKZCyQmFR45po2boiCmbBviozSlc=;
        b=0p+zZCBqCGtcXQqUWVQUmzHqR7f/oLGHPoU1FnYxFuhsiysrcnEBpLeJ6qIQNhWYei
         NJtWaLkEpPJusdafyD1/LbfWbNrdeEpNdHddhACIH+RgALgMVyfWU5OlnqY/KyWRANOT
         xo02k58GP+Dpsbl63sVnyMPRXi8Htk3p7gM61cvNv8b4JRxI0AgSGkW+VdeC/PEvQkgq
         sH1MIdoUkvggXCRTI77mFgKtanO27qcYtVruyYxfFH/Ywrk87W6D2O10Pisy/qD93le/
         +8fLshkXRz93aCE7GtfU3LiiGmTue3girs11cHMR8IKMy50VO7GO7CadfMt4Fm+m5YMq
         9l3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6nsdqj3UHDbO3giqKZCyQmFR45po2boiCmbBviozSlc=;
        b=e/EiSBU/Gb2WhexKGL5RqDbPnT8jOkVvybS4b0ZM6TjxR9ugr7bzaTsaORGaU+Zz/n
         u0vuKsdQ4HjWjKxr8Unxm9mtYvlz1/VlooYctotsVS5HYlcB867Kbz9dUqbAmV57IGR+
         9w/RfCjPo0rjOg6QpbhULpR7DE/QcdlMCyvTt+ulMRTi37pQVsERlXi64CBadW1Av0tS
         9/0iZdyTSyKjjNnmvMEB03CEr2OIoOdDSyA9vU4oT8dhzZ0XeoGJFcb1cQOgNHSk8QZU
         OpX8myLdLK6gfr4lw53x+7dOw9H1MhWuyuttTnxpkJzS9cCCPZ0ICx0so/z4I8l1IBK3
         pD4Q==
X-Gm-Message-State: AOAM531RhYT6/zIGWDZfg089OX/yiq972fpXP6A3nu0zBddjnWcWTT6o
        aB3Rgm7Z/SCvCiHYWKcTjCohoA/wOMSGAA==
X-Google-Smtp-Source: ABdhPJyWJswT76DlW9F8kqRCuz6bnBO3G6KG75a2BeFNfZTl0MIwdiG0J8JUkJaQDGiIljlc2b22sQ==
X-Received: by 2002:a05:6e02:b2d:: with SMTP id e13mr6149731ilu.154.1632179287162;
        Mon, 20 Sep 2021 16:08:07 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o11sm9147672ilq.12.2021.09.20.16.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 16:08:06 -0700 (PDT)
Subject: Re: [PATCH] [RFC] io_uring: warning about unused-but-set parameter
To:     Arnd Bergmann <arnd@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210920121352.93063-1-arnd@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5458ee0e-573c-fbc4-5cdd-5f319f78e3cb@kernel.dk>
Date:   Mon, 20 Sep 2021 17:08:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210920121352.93063-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 6:13 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When enabling -Wunused warnings by building with W=1, I get an
> instance of the -Wunused-but-set-parameter warning in the io_uring code:
> 
> fs/io_uring.c: In function 'io_queue_async_work':
> fs/io_uring.c:1445:61: error: parameter 'locked' set but not used [-Werror=unused-but-set-parameter]
>  1445 | static void io_queue_async_work(struct io_kiocb *req, bool *locked)
>       |                                                       ~~~~~~^~~~~~
> 
> There are very few warnings of this type, so it would be nice to enable
> this by default and fix all the existing instances. I was almost
> done, but this was added recently as a precaution to prevent code
> from using the parameter, which could be done by either removing
> the initialization, or by adding a (fake) use of the variable, which
> I do here with the cast to void.

I would just rename the argument here 'dont_use' or something like that,
that should be enough of a signal for future cases that it should need
extra consideration.

-- 
Jens Axboe

