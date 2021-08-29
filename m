Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03EB3FAB81
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 14:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbhH2MxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 08:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbhH2MxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 08:53:23 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A65C061756
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 05:52:31 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b10so15830348ioq.9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 05:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ElxFKhoOE+2l4ZsT/KhkpXvb6ACO/HEvPuyEWsCkQM8=;
        b=Ggg03/kfxdZN+ZLPSyer9S/ZbaQq9btIVZvpNl5xLCEFGo26Pa2LXcBYwv7Sc0ravl
         eKRaU05MQEw28Y3x4aSN5kmg4yPMFP2kZ8Gw0ylHk7Dm25lkkmo9p/z6TF5SQnhbUY8R
         DB+6ldLY+G5Ge3AumD/iQ7rCIehnFB5gJ7nri1/rSOKxdkPQB/qjWMGQaoNsdOiSXQaE
         Mn+or5B+6kNTqbe379Yk7QxwUrWtMrn5rlph+kxbW08Eh6iErNwNYYY8CVdVGrxbX/TK
         dOETcFJMa1X8DrBWm8cjtwwOfGkPmAQXQAmwMkAbZi5pKkqwQYKUqVFqOKfm3FJXS3YZ
         YPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ElxFKhoOE+2l4ZsT/KhkpXvb6ACO/HEvPuyEWsCkQM8=;
        b=nsOS9nqCITYhr8qotM3CjGBrZBltGQs9blO1P3VV0dn1Kwin6O+XlF1L3ik3yxQ7ZD
         G5u7N7mtGiCndg44xmaAEAs0i1i9pPKBqSZViv3TpeZUjsmCQ2JIxfTJco3uL/B4dAPB
         4Nm18lbRqWKscXC5+u1xmZxoU1cxfvc7u9NqHjnGSTfbdehPh5r3fOULLXksWi3RvK8A
         L1M7zvCWkjsqAqZHVVYrfssUCY9MLjCSLz6Zn3t5jTlrKo8dAh0cRQwilebY8tuy1H6z
         Ro3x230K2t8itAQaUh8ycRxqTG16yn/plGTRG/XMl4v/pQ/HP5eCISBYkM/3HzN/9wGJ
         czIQ==
X-Gm-Message-State: AOAM5336wLWIUohqc+a9RbRiVs5jawLmu1eLXwNYNexOoYWav4hnjVJd
        7UfWE34+tcMDYSR5ypQKDkLltTmF6bc+mw==
X-Google-Smtp-Source: ABdhPJz6atu6JZqEKksoXeuyPHoMtFp7ARRNfjv9p6nlbG5PW8/420blpHQWNxLcXRUGky/KqbHGiQ==
X-Received: by 2002:a05:6638:974:: with SMTP id o20mr15941659jaj.10.1630241551077;
        Sun, 29 Aug 2021 05:52:31 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id x1sm6877311ilg.33.2021.08.29.05.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 05:52:30 -0700 (PDT)
Subject: Re: [GIT PULL] Floppy patch for 5.15
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-block@vger.kernel.org,
        Linux-kernel <linux-kernel@vger.kernel.org>
References: <388418f4-2b9a-6fed-836c-a004369dc7c0@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0d3e8324-18ee-32c4-f666-21971bd8f334@kernel.dk>
Date:   Sun, 29 Aug 2021 06:52:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <388418f4-2b9a-6fed-836c-a004369dc7c0@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/21 4:08 AM, Denis Efremov wrote:
> Hi Jens,
> 
> Sorry for the late PR this time. I'll resend it later if it's too late for
> your for-5.15/drivers branch. Thanks.

Given the patch in question, let's just do it. I've pulled it, thanks.

-- 
Jens Axboe

