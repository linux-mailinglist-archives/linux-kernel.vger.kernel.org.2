Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2E9405F00
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 23:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346415AbhIIVk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 17:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbhIIVk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 17:40:27 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34A2C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 14:39:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m21-20020a17090a859500b00197688449c4so2498073pjn.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 14:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DYtvq+snIbKp4Lcx4I3hM4RZ/DAIBF8w4PBOFhnFfk8=;
        b=ZtPvZQetKwcbR+FplMf8HaP38w4/ZzuU3YK/0x+w4t1qMS/jTYPikkbHFLpzC+qT6+
         6Q/H9xr1fj4c++dH6JY9PINjLQZlLyWS0zrRLPFuhrk+6+mL8nazo7+av2vmxMm2s4Ew
         l9OICkeFaAhnoHC2Dul6nGIdD2C/2yrhLXuDMSpny9qSE9WLnE2evjwaR1BLoCe4rTSU
         llKi0NCsRxhDzZvwZoaSuT5CvmYMGWFm9A0e8u7US2j1YKzGJNlh8gvSRv0WWSSqeV7g
         f0YOSLiWXamqPaIj3XuxE3qjTgRRvhFa6dGLQ9xiK4/Wpo1Zce6mX0u2AIScZoJjBI8w
         nk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DYtvq+snIbKp4Lcx4I3hM4RZ/DAIBF8w4PBOFhnFfk8=;
        b=D7Bav89+7f3FFrhLt0emJRw51Pl28ul1sqAyrWkucGjAwldLdpd0dKs09wzBQpQvpi
         RWCwqK3j2bcOSvJYyHori/tAl/RSavXySFHs/qzjWrkmoLJe6YGLh51On5CM9dYS+j2a
         f295gLUnATGTp124zat3SJLUD9zFIHiCd7Vsv8S3ARIVY+u3+bQd8qtIZOqxXHTofxqX
         Xd25VuF6E/0y2H9PGOIyvHLIdbI9qY/KMoZXe9HyyYOLc2RsiSsop45uV50N4dkGlpdP
         jF/v1puIqMb3MUzmgU0vMda6vy5NKm8uPCkMtYPASl8hnLPclXWbYUDGf6XeQRX+jDzk
         vTfA==
X-Gm-Message-State: AOAM531meARvy133zTaKY/bCGUOADwyDwrFyUREnBRG17kzf2kzQVxNz
        rgUrFQSNBnel4QbMxCPhGAbb7w==
X-Google-Smtp-Source: ABdhPJzQf3sFX91xTbQRqxoNcpNRrpYih2Pf76xgU/S+2XpBkXh06alBvvBHjke+0wjO01lCNC6XzQ==
X-Received: by 2002:a17:90a:db85:: with SMTP id h5mr5745939pjv.213.1631223557305;
        Thu, 09 Sep 2021 14:39:17 -0700 (PDT)
Received: from ?IPv6:2600:380:496f:85f0:f855:eb52:c00a:147a? ([2600:380:496f:85f0:f855:eb52:c00a:147a])
        by smtp.gmail.com with ESMTPSA id g3sm3052112pfi.197.2021.09.09.14.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 14:39:16 -0700 (PDT)
Subject: Re: [git pull] iov_iter fixes
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
 <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
Message-ID: <ebc6cc5e-dd43-6370-b462-228e142beacb@kernel.dk>
Date:   Thu, 9 Sep 2021 15:39:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/21 3:19 PM, Jens Axboe wrote:
>> That "req->result" is once again the *original* length, and the above
>> code once again mis-handles the case of "oh, the iov got truncated
>> because of some IO limit".
>>
>> So I've pulled this, but I think it is
>>
>>  (a) ugly nasty
>>
>>  (b) incomplete and misses a case
>>
>> and needs more thought. At the VERY least it needs that
>> iov_iter_reexpand() in io_resubmit_prep() too, I think.
>>
>> I'd like the comments expanded too. In particular that
>>
>>                 /* some cases will consume bytes even on error returns */
> 
> That comment is from me, and it goes back a few years. IIRC, it was the
> iomap or xfs code that I hit this with, but honestly I don't remember
> all the details at this point. I can try and play with it and see if it
> still reproduces.

OK, one that I immediately found is just doing O_DIRECT to a block
device or file on XFS. As pages are mapped and added, the iov_iter is
advanced. If we then go and submit and get -EAGAIN, for example, then we
return with what we mapped already consumed.

-- 
Jens Axboe

