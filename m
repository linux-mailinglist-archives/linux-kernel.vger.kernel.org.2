Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F1A3F81F7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 07:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238470AbhHZFOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 01:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbhHZFOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 01:14:20 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44506C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 22:13:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id m28so4037296lfj.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 22:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hkopqt0feIIS5JxkU+fHJyYMDvajUo970zD2BdvBfg0=;
        b=EfcxD7f/97/Bdau5hZbMRGsFrjNDNORSy+HkjbaJdyh7InP/nUFTfws39IlBskKiSp
         +mBUA8nlYV23maf/60P8OEGNi9vzp3lXZySpLXbfeqEk7l1GYodD7iv2837GBkt7z4jt
         O0q6c8dYE9WxPWAQiIVgj34G6X4KYhESb1GsMsqRJ5NffsbRwitTA68tC2JuBAOucDJK
         UNK5V6BpjPaPQ/dtV7j4y3NfdqEmAYoIYmVtxO0TJQ4IECWjkxNuKp8Kb/l0b7xHqXSC
         u2kzm4vREzh6lktO7fgOl0ALaUt5ahiiNoh/MShsODt5Kd+LaJe5aiRpj/0O0krF8rQi
         +juA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hkopqt0feIIS5JxkU+fHJyYMDvajUo970zD2BdvBfg0=;
        b=CHRqkM5Bhw6dOX8LkyUYpmVsyYpxQGUrgazRTBD6DDzJ3ni56PL2K59gV7AIR39fUS
         NvKxg02Mk7oDEwLLmotOfjGOZ9CVvQQYHlq+MHy8+ujoIfW6Fe6AuZYYNElhR4/YEElF
         rb80m+P+d4pjOWide8fqIUYv0qo8ZUpK0/I7D3LPIg7EbMNPrsQ3nxtFJoDVkcYm+R3M
         FRooxNfE9Jx1zPshNIv/pAtNFswsNWSqtf8eMcvb9gAqHMHJcsZoWQs3KdihXDG26QLQ
         SVk6YOWBj0gv3qcS9povs7TBFeXFhGT0zl/hKjzHqAZ6NZV/FfquwT1RV6Miu5TzSAJt
         9Nxg==
X-Gm-Message-State: AOAM5317zcQnTNSSII5+DJbGdKuvHs9/5mnHVkl+ylsvVvbbljdDn1y5
        HJ/27ISsE6V/NRea43ySSaTBs8Z5Py64JA==
X-Google-Smtp-Source: ABdhPJz0yJDvcJEKF+w0SF6jLoiz2PztOaQBUgQZSiE59hAymPRneGMofqA07OxhM4zJKwQI0d+TJg==
X-Received: by 2002:a19:ad46:: with SMTP id s6mr1360414lfd.25.1629954811184;
        Wed, 25 Aug 2021 22:13:31 -0700 (PDT)
Received: from localhost.localdomain ([46.61.204.60])
        by smtp.gmail.com with ESMTPSA id z8sm204034lfs.177.2021.08.25.22.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 22:13:30 -0700 (PDT)
Subject: Re: [PATCH v3 3/6] staging: r8188eu: add error handling of rtw_read8
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1629789580.git.paskripkin@gmail.com>
 <c59d5d850bf9aab208704182c83086609289cb9c.1629789580.git.paskripkin@gmail.com>
 <3591772.nrefL38gfN@localhost.localdomain>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <1f9ef1b3-8581-3261-0cfe-d5e9a8cf8483@gmail.com>
Date:   Thu, 26 Aug 2021 08:13:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <3591772.nrefL38gfN@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/21 2:45 AM, Fabio M. De Francesco wrote:
> On Tuesday, August 24, 2021 9:27:27 AM CEST Pavel Skripkin wrote:
>> _rtw_read8 function can fail in case of usb transfer failure. But
>> previous function prototype wasn't designed to return an error to
>> caller. It can cause a lot uninit value bugs all across the driver code,
>> since rtw_read8() returns local stack variable to caller.
>> 
>> Fix it by changing the prototype of this function. Now it returns an
>> int: 0 on success, negative error value on failure and callers should pass
>> the pointer to storage location for register value.
>> 
>> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> 
> Dear Pavel,
> 
> I have to inform you that building patch v3 3/6 with gcc (version 11.1.1 20210721
> [revision 076930b9690ac3564638636f6b13bbb6bc608aea] (SUSE Linux)), gives
> the following warning:
> 
> drivers/staging/r8188eu/os_dep/ioctl_linux.c:2258:13: warning: variable ‘error’ set but not used [-Wunused-but-set-variable]
>   2258 |         int error;
>        |             ^~~~~
> 
> I'm sorry, but I guess that for some reason previously I had only built v2 of your patch
> which had no warnings at all.
> 
> Unfortunately, introducing warnings is not allowed.
> 
> While we are at this, I can also confirm that GCC 11.1.1 _does_ _not_ emit the warning
> that has been reported by the kernel test robot.
> 

Yep, I see, thank you. v4 is on the way... I had a plan to send v4 
yesterday, but I've finally received r8188eu device.

I tried to connect it and test and.... driver didn't work :) So, I will 
try to figure out the problem with driver (or device) and will send v4.

Again, thank you for report :) My default gcc is too polite...




With regards,
Pavel Skripkin
