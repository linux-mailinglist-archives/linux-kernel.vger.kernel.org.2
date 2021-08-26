Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A7C3F8E80
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 21:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243411AbhHZTN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 15:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243307AbhHZTNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 15:13:25 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2741FC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 12:12:38 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id f2so7077272ljn.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 12:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TvRTLyHaAWmLLRwS1K9bLxp8F5GC7i2/1t+y7IO7tIc=;
        b=k+Y1nZQYBlSkK/bFtUEhMIaHcLvKdJrcKmmAp3yl9DrjpSVeEUhRK4H7OYUe3D0V5l
         992lJOLIPYzY9hUc+qZI1cL8ouu73sxjG23pxM2N4JBX4XNU6am/c7w9P+AevyXpDx8J
         gcTZHV0u8o0V9Ckyov+I/Nxh3zDDO1dqV5aIDdbOHqadVabxgSbHHF1amDb2FtSEuOwu
         X8v+Ul4UP8hPt5zg5weICGsNjOWyWid1omp2E/Ko6OtJiVAbBGZWy9CkiDwimX0leOYn
         uHGpTGxHxcQ+v4H7xN5r00hF0tB5YT3MqyzAqEBp+VGe/3BOS6xnFLEaM2kWSRQqDa3i
         OSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TvRTLyHaAWmLLRwS1K9bLxp8F5GC7i2/1t+y7IO7tIc=;
        b=K6Gjc2ZZGItw80SaUdJCNnHTC4UPqdrlhaqcjZ5KiULqgsnSAJECiEK9Nq4qUsLA8Q
         ufqWym7f6Q6cik7XlrV9VyzmpcnISC0rcoVObpxfK/myMYkd+d/c5XKpgyziJJqtUaK7
         KJFpa5X4vN3yZaTWMa2/wjHgEs7xkQi0L5RrmSc8xmYXjAYxyRYL4AlE7inn9LX46Q+t
         Wm/q2hUrR1z/Y4IgynYObKU14jYMWHNqe1Wq6Hn881VBgNTr1xFlij1Ne5SahNp3VKHO
         A12yKmxRUEK+1diHvVi4g0tMlkH5KElpaeozI6L129b9lH0uMbptZLyU2cpzpIAAsdz4
         +wbw==
X-Gm-Message-State: AOAM533jtFoz40CFpjko8wktTKNEAPQ98qLlWaVZcLc5OYbbbNMU9F6Y
        uZsY1GpQf47rNiMMWsnL6yo=
X-Google-Smtp-Source: ABdhPJyFuAcZaeVh/2Yqg/K1ya/KDESnAiaINFpi+gsVe+RRig/PlCYYyuCHuoqmozO9smFgQz7/Bg==
X-Received: by 2002:a2e:b24f:: with SMTP id n15mr4547207ljm.124.1630005156491;
        Thu, 26 Aug 2021 12:12:36 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id u17sm469454lja.45.2021.08.26.12.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 12:12:36 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] staging: r8188eu: Use usb_control_msg_recv/send()
 in usbctrl_vendorreq()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20210825035311.8910-1-fmdefrancesco@gmail.com>
 <20210825035311.8910-2-fmdefrancesco@gmail.com>
 <f2360c8c-e001-70d6-daeb-03ca5b718d84@gmail.com>
 <1954117.IISOP8hFdM@localhost.localdomain>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <b5507e5b-d396-f442-591e-994e2b929397@gmail.com>
Date:   Thu, 26 Aug 2021 22:12:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1954117.IISOP8hFdM@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/21 9:56 PM, Fabio M. De Francesco wrote:
> On Thursday, August 26, 2021 8:18:23 PM CEST Pavel Skripkin wrote:
>> On 8/25/21 6:53 AM, Fabio M. De Francesco wrote:
>> > Replace usb_control_msg() with the new usb_control_msg_recv() and
>> > usb_control_msg_send() API of USB Core in usbctrl_vendorreq().
>> > Remove no more needed variables. Move out of an if-else block
>> > some code that it is no more dependent on status < 0. Remove
>> > redundant code depending on status > 0 or status == len.
>> > 
>> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>> > ---
>> 
>> FYI, I've tested this patch with TP-Link TL-WN722N v3 + qemu :)
>> 
>> 
>> Tested-by: Pavel Skripkin <paskripkin@gmail.com>
>> 
>> 
>> NOTE: I am still not able to apply 2/2, so tested tag is only for 1/2
>> 
>> 
>> With regards,
>> Pavel Skripkin
> 
> Dear Pavel,
> 
> Thanks for testing. It was very kind from you.I'll add this to the Reviewed-tag
> that you had already given to my patch.
> 
> However, I intend to rebase and resend this 1/2 and the 2/2 of this series, because
> (as we already found) they logically follow another patch of mine that is still in the
> queue ("staging: r8188eu: Remove _enter/_exit_critical_mutex()").
> 
> The patch above has already been reviewed by Greg and he found that it looks
> good, but he cannot apply it because it is not tested (for the reasons I've already
> explained with a couple of messages)
> 
> Unfortunately, until "Remove _enter/_exit_critical_mutex()" is not tested, Greg
> won't apply it and the 2/2 of this series cannot be applied too.
> 
> Please, if you have time, do you mind to test also that? It would allow me to resend
> it with your "Tested-by" tag and Greg will surely apply it. No worries if you have no
> time for doing this test, otherwise you may find it at:
> 
> https://lore.kernel.org/lkml/20210819221241.31987-1-fmdefrancesco@gmail.com/
> 
> Please, if you are interested, read the whole thread. You'll see that Greg would apply
> it, only if tested.
> 
> Thanks very much for your help and kindness,
> 


Hi, Fabio!


Ok, I will test it until yesterday evening. I want to enable some debug 
options and sanitizers and recompile the kernel :)

Today I will try to automate testing by writing scripts for connect, 
disconnect and other scenarios. I guess, it will help to test various 
corner cases


Simple test actually passed: I've connected to wifi + pinged google, but 
mutexes can cause deadlock and other not cool bugs, so I will try to 
enable as many sanitizers as possible and retest it :)




With regards,
Pavel Skripkin
