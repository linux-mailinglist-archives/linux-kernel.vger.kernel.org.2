Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FD1327548
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 00:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhB1Xjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 18:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhB1Xjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 18:39:42 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC435C061756
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 15:39:01 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d2so10495104pjs.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 15:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x1uTxHZvnykz36Aw0bL/yt/Yp4aJN2LGfaSItobB/8A=;
        b=bE3kl+AyYosxWjfo5BFJ5eejTrdJwYTe6QVO/Zt6rBWRIububXeGwXdCmd7M/3x12n
         E0vDdBKNvAwyv20Xj5AgZPBdrDM/j95M9g6UUpnmZVGPkSxKPkMzTeAu3EW7Mnzat1ip
         soVimXtjXkLB2FXbrQdbZjQiMK01pxGTI+GKVTg4b0kZitXMlDs9M6nRZfZTiRiYMzmj
         xWe56GsTdPjBN0mmMidGKxZ+32sJqil7R2m6w5bPbUUvRpz+Skcas0Csc47n0EJ8ItvG
         9ppb0NPYMeX67x9i9eTVh4TUsrwoy2a9PVB1z5ZdO1paVXPU4xYe3I3+0NQJ3WNMYJqe
         IGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x1uTxHZvnykz36Aw0bL/yt/Yp4aJN2LGfaSItobB/8A=;
        b=V7NAB8dpGlqRg+HdLbuLelsgKqymYaaIqUXrCwysR3pXLrfCkPnittYkHdsR5fojCN
         yJDh/WCM2nmJB/AYZPZvWCmlGgfuVw5I8aTDksRNZOx3zxLvV5CpUNINuzpEunwCc3BD
         FmwLCFO99B91dNN/5rdseG0tXoUvV/SUIzjrDUKa0Z96Ic/TYXOfGY7F1TFpmIxSAhq3
         qJvWwNtMPRst6J+vKHnVdDOZtqNh9HGuwFJP5l82qUC8kb37QLGlfqh9/9mHdpJKvOAS
         eU7NYPux/qY2RmelvI8VVoVhLNhyB6z7w0xfL560HK/pRz0WT1gNIhSVNOUQi0bCO55Z
         rzjA==
X-Gm-Message-State: AOAM533VdeNn1aRWl5ITTKjXKEg6It07vzDtG3Wh07GHiBH2kC6Z/Jsj
        3LChToJPXCFcAk1NHXPnFAIjmRNLm57j6A==
X-Google-Smtp-Source: ABdhPJxbBWj3EcABpsuTtXDvujkPgINeUUJDaXCPH265T/laVmNhH9btA76hOXdWhe8yLPW/Y80STw==
X-Received: by 2002:a17:90a:9f48:: with SMTP id q8mr10176160pjv.53.1614555541120;
        Sun, 28 Feb 2021 15:39:01 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d11sm2563752pjz.47.2021.02.28.15.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 15:39:00 -0800 (PST)
Subject: Re: [PATCH RESEND] ide/falconide: Fix module unload
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <63369c9b96673442a4bd653fe92acda99172123a.1605847196.git.fthain@telegraphics.com.au>
 <alpine.LNX.2.23.453.2101031017290.12@nippy.intranet>
 <5d7fd7bb-1bb8-a21c-61d8-4d1046f92ca8@kernel.dk>
 <d92db64-cfb8-9640-35a4-4f864dfc99a2@telegraphics.com.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ec29f009-ba3a-29bb-196d-a8893ed880a0@kernel.dk>
Date:   Sun, 28 Feb 2021 16:38:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d92db64-cfb8-9640-35a4-4f864dfc99a2@telegraphics.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/21 5:19 PM, Finn Thain wrote:
> On Sun, 3 Jan 2021, Jens Axboe wrote:
> 
>>>
>>> This patch was sent in September and subsequently resent in November. 
>>> I've since learned that the maintainer has been ill. What's the best 
>>> way forward for fixes like this?
>>
>> I can queue it up.
>>
> 
> That would be great.

I did, and then I forgot to push it out... I'll do that tomorrow.

-- 
Jens Axboe

