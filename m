Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FE743B91A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 20:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbhJZSNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 14:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238100AbhJZSNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:13:43 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D36C061348
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 11:11:19 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j10so209094ilu.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 11:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ec0ioldJ1MBK4OIaEodzymVJ5K5JCkhpNEzS0/+6PX8=;
        b=XENdqGEOI6q/3fTuCm1zORtXhArpH26Og19ebJ3o0efUBrBil9QnMWHr6RsFUMQXoG
         Ik/7XiVDMxBMnNFacFpI/9OqPplMtgo0KQXhADaZpkyaUCpwpJSNBmDkp5MHASD37jeZ
         YTOcehkIllzDGzkRAwoiIlVBbZ9JahIrAS5bZ+YI5kvFQ3RppxwOhHXUaehovNOtZKUE
         fBpZLw3qbczqBYD0gK8VziXzoXzBpM0lQzmV7ulpaqLyA+2G9kwzW/CDJu47L2AcNzU0
         ovWQWPO1Zd2xj/jmkuR7jmV0i3hhtDFbk/fXZKFx7LDVNUAJn00Q962bsC3KRK4OLmwY
         nL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ec0ioldJ1MBK4OIaEodzymVJ5K5JCkhpNEzS0/+6PX8=;
        b=q3CWi3JdQrCt1o94vB/KO2B9A1qMYwNZXQ2Nk7fOoV9YlGKO4B9LSRdNDOMRXFqZxh
         WYgNNNMQSgcc6RsSGiH19/odttQJyKsx0ok6PTsd56/CaUxmactgCUZKUeCt5DzR4z/X
         FFMnGrW5jJMea3KbGo147HwcCzZ828r+Q9ZBXsJf+w4fUL4sfJh5jI6KAN6Ka2jtOK/v
         wjCA1HsS3BwXBfgDQGMitC6bheB6UHxMaFYaTRHeo1m/TNhLIxQXna7hEY+PoNLRm4Yr
         Ofh4NT5plIEXua4Hrd2h2nME1ImNOo64ohTm5Pqx0HKG1xmM6JYujzUQphYr05XrMkJ9
         Mjlg==
X-Gm-Message-State: AOAM5310CvP2zRnqCgemH033KyJZuwWrO0+DHs7EhY3kth5eS3grw71q
        LLyaZZzqRz8iR+YjBPhAnnZga03zd0HCSA==
X-Google-Smtp-Source: ABdhPJyBBRZz81aeo9jQ0KExdvISBeYDtg0EGuoaiipzzQglxYC3kuSjoUIy9vVK3zvin+lcCvoTpA==
X-Received: by 2002:a05:6e02:18cf:: with SMTP id s15mr10944331ilu.198.1635271879075;
        Tue, 26 Oct 2021 11:11:19 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g13sm10272017ilc.54.2021.10.26.11.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 11:11:18 -0700 (PDT)
Subject: Re: [PATCH] mm: move more expensive part of XA setup out of mapping
 check
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <49f67983-b802-8929-edab-d807f745c9ca@kernel.dk>
 <YXhEAZMf9Qrsev82@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6a9e41c1-0608-1ba8-788e-8aa402d8a0cb@kernel.dk>
Date:   Tue, 26 Oct 2021 12:11:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YXhEAZMf9Qrsev82@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/21 12:08 PM, Matthew Wilcox wrote:
> On Tue, Oct 26, 2021 at 10:01:20AM -0600, Jens Axboe wrote:
>> The fast path here is not needing any writeback, yet we spend time setting
>> up the xarray lookup data upfront. Move the part that actually needs to
>> iterate the address space mapping into a separate helper, saving ~30% of
>> the time here.
> 
> No objection to this patch, but it did remind me that I never saw an answer to
> https://lore.kernel.org/all/CAHk-=wg_-EwefQ_3Osz4iJxTrTk3tfrV53Z7-jaGg=tm9i5TXg@mail.gmail.com/
> (and nor did lore)

Totally missed that, and yes there could be cases where that lookup is
going to be way too slow. I'll take a look.

-- 
Jens Axboe

