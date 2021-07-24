Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A766D3D48BE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 19:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhGXQ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 12:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhGXQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 12:27:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A170FC061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 10:08:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c16so1173870plh.7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 10:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8Ys5RSVFUxFSyqNmFnHZsPrB+xX/xgDDGrWU0AT548A=;
        b=TaQIXCUr+InAjo8XPE/Q+gAIuo+G41Gui9wkLX+zr3b7z/2Zw8S+iD8KWVIph1lRHP
         W3uI0l1tHEtFMq0Mq2PZMbm6+iqMMj14h8PC35EtT1bBbPp8kuFGknAaCzEw5nkod+4L
         45ej7UHDra94ZFazIaQ2zjEv9NAVS/2wVIyKK5KQapG52WuTGQtZvbrB9CBXuDq4gj0s
         UBlIGiNi/LSB6xcvEfwyKNk/5tJ2iSR4B3uJxleMejZJ+3N6MTNVlNW97SOAEQQNrnMx
         4Pz9Mm8lqToIbEH7OsnDYseqcKpLOZVlqjA3wLVfuuBKKGDsA8nUzRt2oJOQotFHVq/k
         cksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Ys5RSVFUxFSyqNmFnHZsPrB+xX/xgDDGrWU0AT548A=;
        b=U4DZ2uM3yLPegwMOoA5b3FgApFuuKMAcJkEk30/Bka3iCsFeX/eO4gW9E+T5LZ0IGR
         2jFQ/IYS1voYkcTNBjE+GBNGShqU79qaJIqB9jPMsghIrA50yP4Lb5YZch2da/PLWi54
         wvCz4/vfTVv7ZN1nETAF1rrWGgu+Va8cGruyZ9aOpYID47MMJQSYnIWdKSr38PifAhua
         0MkxfsEvleTzK05MZK+/zPSMufx/p6XT7QDgvmLP7qAshTY9FfbYTMfbDMv1CGBOq6ed
         tBlmr61uKoDlQ7UEf5p0tGtk/o+jveQ/qqJJ23D+q0drGklhezSJ4oysjwbXv+nnf3Qw
         RbrQ==
X-Gm-Message-State: AOAM533lSdtqUxJ+xrx5ZfEU9y5kXNiMBcuvnK7/CVlqOkw8usehwHgg
        pf8blh8uDNmqy0rGqHFIafZQfzvRqDZuWHnQ
X-Google-Smtp-Source: ABdhPJzMs/rV8aEuR0MsWnOkFFbuu5FoDKSgnjChlMpMg4xu6KRJF83t/EPW64dkAERIo6tMapZgiw==
X-Received: by 2002:a17:90a:ce02:: with SMTP id f2mr18739529pju.232.1627146491156;
        Sat, 24 Jul 2021 10:08:11 -0700 (PDT)
Received: from [192.168.1.187] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id t3sm13272720pfd.153.2021.07.24.10.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 10:08:10 -0700 (PDT)
Subject: Re: 5.14-rc failure to resume
From:   Jens Axboe <axboe@kernel.dk>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <eeab973d-f634-a182-6d76-f3912f8cf887@kernel.dk>
Message-ID: <7df62a0a-d739-57ef-be47-2d9734a1cf7e@kernel.dk>
Date:   Sat, 24 Jul 2021 11:08:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <eeab973d-f634-a182-6d76-f3912f8cf887@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/21 9:57 AM, Jens Axboe wrote:
> Hi,
> 
> I ran into this when doing the last bit of testing on pending changes
> for this release on the laptop. Outside of running testing on these
> changes, I always build and boot current -git and my changes on my
> laptop as well.
> 
> 5.14-rc1 + changes works fine, current -git and changes fail to resume
> every single time. I just get a black screen. Tip of tree before merging
> fixes is:

Typo, 5.14-rc2 + changes. Hence the problematic change is sometime between
-rc2 and current -git.

Running a bisect now but expecting it to take all day, will report
what it uncovers.

-- 
Jens Axboe

