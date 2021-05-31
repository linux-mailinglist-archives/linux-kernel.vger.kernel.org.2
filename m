Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BB5396666
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbhEaRFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbhEaQKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 12:10:04 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FC9C08EB15
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 07:44:46 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id h21so8059020qtu.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V/5vPtNm0RB3xPpr+tn4QjogsQf4e8BCs6cxoXBVgL0=;
        b=cr6KhV21Mc7XCbYYfYZTzbYuqrBEPta6rdmJ/NratIdl3E4KpseO3TvMMj9CZYCkBp
         tKHWkFIcqpTaR+idIGySuNmP985stpadnIaVkqXui+1CgjhNSeIyfk0ULr2aa5OX9mpS
         m7bruorzKhfDjYLSrBZAt1pP7a+JwosWG4RTtLa8ynyo6/dxg7hX9L16BxIOFzccGaJM
         Hn82WqmIzty4lpUAryw8UVRihzDLnPBRcc7sDh2Iw2oqaTKn/Fc79stJ8AXz0e1/pTFT
         UERZrxlZl0OYlBSn7pR/9Qro4UNvXO0td+YCi3oDjL7KCSYCjk7MonQ+oKxnEksaQS/W
         PZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V/5vPtNm0RB3xPpr+tn4QjogsQf4e8BCs6cxoXBVgL0=;
        b=N4KP3TWw+pj5+64qGAWuHXcFNevZzoJemg3IpPon4L6J/DMMB5osnyM8XHw9uolBUD
         4nPgiAGHZiVZErPmphw18JnNJfzkAggX7wbo9YrNTMHScgM0gxy2ESOPyd9sFVrmgEbC
         uBzF1CbIZSPDuhj/edUy39L+vtbIOb2USNC0NnRgvx383esxKIyfCA2TtmqM3orK1X7g
         zYOH+MDj0LPJ2OD8Gv8amHlnHMOZgT6WoalvbeY8GG1XT7YHOU3Hd4xFWHv9zqpiq3sO
         Hy7vqVhLSvQwrsnwNPsWLDpKEv+STFDPhAanQxS2SxBdGnzT+78iWpcYHv/Lom/80sAp
         CpYA==
X-Gm-Message-State: AOAM532LabyWwZAU6paLz5dUR32wPxqWf0vqUuPU5lxctw5Y2k4pj/vg
        R4fyWIyjgihVmbRRI3HujPI=
X-Google-Smtp-Source: ABdhPJygG7lmkCR7+jcZa56nzwHY+O4UPuolK7WQn5plyEZFBouMFTWb5sqIsOLNdYFqhXR8Ud2rgg==
X-Received: by 2002:ac8:4256:: with SMTP id r22mr15598167qtm.207.1622472285625;
        Mon, 31 May 2021 07:44:45 -0700 (PDT)
Received: from ?IPv6:2804:14c:125:811b:fbbc:3360:40c4:fb64? ([2804:14c:125:811b:fbbc:3360:40c4:fb64])
        by smtp.gmail.com with ESMTPSA id u11sm3164595qkk.12.2021.05.31.07.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 07:44:45 -0700 (PDT)
Subject: Re: [PATCH RFC] tty: Fix out-of-bound vmalloc access in imageblit
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com
References: <20210531124713.9048-1-igormtorrente@gmail.com>
 <YLTiD489JoUiYt8J@kroah.com>
From:   Igor Torrente <igormtorrente@gmail.com>
Message-ID: <29a21488-3d2e-e07b-f9e9-6d5dc1754c1c@gmail.com>
Date:   Mon, 31 May 2021 11:44:43 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YLTiD489JoUiYt8J@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 5/31/21 10:18 AM, Greg KH wrote:
> On Mon, May 31, 2021 at 09:47:13AM -0300, Igor Matheus Andrade Torrente wrote:
>> This issue happens when a userspace program does an ioctl
>> FBIOPUT_VSCREENINFO passing the fb_var_screeninfo struct
>> containing only the fields xres, yres, and bits_per_pixel
>> with values.
>>
>> If this struct is the same as the previous ioctl, the
>> vc_resize() detects it and doesn't call the resize_screen(),
>> leaving the fb_var_screeninfo incomplete. And this leads to
>> the updatescrollmode() calculates a wrong value to
>> fbcon_display->vrows, which makes the real_y() return a
>> wrong value of y, and that value, eventually, causes
>> the imageblit to access an out-of-bound address value.
>>
>> To solve this issue I brougth the resize_screen() the
>> beginning of vc_do_resize(), so it will "fix and fill"
>> the fb_var_screeninfo even if the screen does not need any
>> resizing.
>>
>> Reported-and-tested-by: syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com
>> Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
>> ---
>>   drivers/tty/vt/vt.c | 12 ++++--------
>>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> Why is this "RFC"?
> 

Maybe I'm using it wrongly, but I usually use RFC to indicate that patch 
is probably not ready and needs comments/suggestions to improve it. In 
case, I don't have much experience with vt driver and I'm a little bit 
afraid to break something.
