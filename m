Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F08407081
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 19:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhIJR12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 13:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhIJR11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 13:27:27 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F504C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 10:26:16 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id w1so2821279ilv.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 10:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iNK26dWrPEULhYjqm8ZCOu4aaN6QODbt9vLRizxo6Ww=;
        b=t3MT3TXw1gOut471cIVazKBymCH8MzxvuRD4M6lFpo9IQTSda63e9qnLCUIdMo1Mdn
         Sx2Hjm+oQmwu6HV85rTNVjChFIL77BlKR7mWuzyFYwymFTP7Mkhp4pkf5lGFy0u13Eut
         sUrf7y76d0XyylpmiX4hXTWyh1SwmyVM/nY+XtFL0q5/QUrjy6SE3ofb1xkkDKP1Txkh
         lf5S1e4Jf8bfr9mNPA5QLVlRkfn98ZC/Y3P1rrlVlrsmW6y+NnLy0mJsXbllRTJdDsyI
         ffMDfyp7DBtsKUkhJ1ugB6C8MFn8jClASIgC2ZeVv4mrkdClLWBG+an7pJLdBO4XdVsv
         S9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iNK26dWrPEULhYjqm8ZCOu4aaN6QODbt9vLRizxo6Ww=;
        b=nIEkMDnd14Y0gvhHVNUyGMns/J1+FMbHSe0EZZwMe26MgX4WxRkJYtvNqc7gcsG6hY
         m+T7VzeJNdGXVQC4acZj08PxK43VrE9pb9yXd3DY7ogyK4aYkSp8rKWgrT/9bicsV3/U
         YxEYHLL1draGCav3CkGHDlfxmhOBsazNv0tIe8vyCFpf1caM4Q9M28e/J3dVyEYiLUAZ
         9tobFSQpi1ZBQzNT0n6xsfsobSjbce96x1yMKd2lyvCe2QnpTFJCa7ZJkjmLyX34jYcm
         rYSnnJlPTg5zyFMGk3OwNALh0msUT508XVrebfBlGkmSS4E1LcIkezSl8T1WKv/w+tKg
         bj7g==
X-Gm-Message-State: AOAM532BVXPQZBL5aq+7anftvS8vuF0q5zcnXRvXMoFn0NmFTVkGJ1Sd
        ibFZohKWW0eys/538kB+dUjhbQ==
X-Google-Smtp-Source: ABdhPJzxSUfo94qrkSoHNLmjSX24/WBArv4udBmA/C98aPttZQXpjb8MmbS/6kxRiugpgj009rSE/A==
X-Received: by 2002:a92:d84a:: with SMTP id h10mr7198085ilq.48.1631294775687;
        Fri, 10 Sep 2021 10:26:15 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f5sm2924419ils.3.2021.09.10.10.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 10:26:15 -0700 (PDT)
Subject: Re: [git pull] iov_iter fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <YTrJsrXPbu1jXKDZ@zeniv-ca.linux.org.uk>
 <b8786a7e-5616-ce83-c2f2-53a4754bf5a4@kernel.dk>
 <YTrM130S32ymVhXT@zeniv-ca.linux.org.uk>
 <9ae5f07f-f4c5-69eb-bcb1-8bcbc15cbd09@kernel.dk>
 <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk>
 <f02eae7c-f636-c057-4140-2e688393f79d@kernel.dk>
 <YTrSqvkaWWn61Mzi@zeniv-ca.linux.org.uk>
 <9855f69b-e67e-f7d9-88b8-8941666ab02f@kernel.dk>
 <4b26d8cd-c3fa-8536-a295-850ecf052ecd@kernel.dk>
 <1a61c333-680d-71a0-3849-5bfef555a49f@kernel.dk>
 <YTuOPAFvGpayTBpp@zeniv-ca.linux.org.uk>
 <CAHk-=wiPEZypYDnoDF7mRE=u1y6E_etmCTuOx3v2v6a_Wj=z3g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b1944570-0e72-fd64-a453-45f17e7c1e56@kernel.dk>
Date:   Fri, 10 Sep 2021 11:26:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiPEZypYDnoDF7mRE=u1y6E_etmCTuOx3v2v6a_Wj=z3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/21 10:58 AM, Linus Torvalds wrote:
> On Fri, Sep 10, 2021 at 9:56 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>> What's the point of all those contortions, anyway?  You only need it for
>> iovec case; don't mix doing that and turning it into flavour-independent
>> primitive.
> 
> Good point, making it specific to iovec only gets rid of a lot of
> special cases and worries.
> 
> This is fairly specialized, no need to always cater to every possible case.

Alright, split into three patches:

https://git.kernel.dk/cgit/linux-block/log/?h=iov_iter

If this looks reasonable (Al/Linus), then I'll send it out officially with
git send-email as well.

-- 
Jens Axboe

