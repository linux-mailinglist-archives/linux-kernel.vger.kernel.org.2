Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4383B49FD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 23:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFYVMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 17:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYVMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 17:12:08 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB78BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:09:45 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g3so4250715qth.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GHJEjaQr0KmEeIyROSH4ZXM2rKTKH4pwJGeBqIbXJ6o=;
        b=f3kFHqIiYcQI0wbq8uSmoaDYjt0SQKkom9h5Z34Fqon3fVl+H5e3G6eMV77z+rCo9+
         3z0AQKYxHzj3aEuV0NeMxfwwml0rRT9mVelUD8IvQWkK5IXYd6CFqNtEScTgqj1h7jRd
         qgklPjp9tCbt9kJUFmCJoP8ZV0EopQ10WVxsFTB4fbJpyAlchBVOUynr6L4fFmMbhFgv
         MEPAaM7DwOVzqX546Alikb+om87HqRqBWcPLdlh9jAB9SRms9sOZqShn225WELlJP5OV
         YM6y8Sd6owshXzAMMarxTTqu0nvABO7YpWmCpUCCtvIJIldlMeEyx3FolUN9+2FIvHke
         QyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GHJEjaQr0KmEeIyROSH4ZXM2rKTKH4pwJGeBqIbXJ6o=;
        b=dD8x/NlGF2+wxsu3LEI4BB+HmS1RA8UwkXx9r1V9CnvI/OkrgFW+85L8Lnzm3dA5Zi
         MQ+BZgjAusizO+IoLCQYs20HsvQAwHIz3PQurexl+VAid88VBJxj3mjUXw/RA+ByBfqK
         orTJUfk5cK01MUdDZ7hBsrAGdkUR0kWv+PkEJiW7WnkVRsIGaG50u/VtuISXJNZsEO2C
         heHUtiGrsk26Y04JscZNcikjA+uFJfYtneRZ0VxQgIog4VZ9ksTp5SnwpUSa3v3cVAJo
         ni6/CFyKLNcy485yp6/kkeKV+4eni2k2wPMzx+B1E9uX4iajlLorKmgJnxEu0aFreIJb
         zKdQ==
X-Gm-Message-State: AOAM531BR4aO139Y9d4q4Et2sazKAbVNCSjGJYRwHeeYdBPwbvxXsY4h
        eUuYvEmM5a8fuAlTkTHflI8=
X-Google-Smtp-Source: ABdhPJw/nVxq84mJXzE3U7dG/6tJwjdCKWKX9IzOoxy6b1SSNPzudF6TwVGB/ajQ2V7E/Fs25s+mrA==
X-Received: by 2002:ac8:7b53:: with SMTP id m19mr11304797qtu.349.1624655385151;
        Fri, 25 Jun 2021 14:09:45 -0700 (PDT)
Received: from ?IPv6:2804:14c:125:811b:fbbc:3360:40c4:fb64? ([2804:14c:125:811b:fbbc:3360:40c4:fb64])
        by smtp.gmail.com with ESMTPSA id w22sm4396929qta.55.2021.06.25.14.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 14:09:44 -0700 (PDT)
From:   Igor Torrente <igormtorrente@gmail.com>
Subject: Re: [PATCH v4] tty: Fix out-of-bound vmalloc access in imageblit
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        syzbot <syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com>
References: <20210624202725.20415-1-igormtorrente@gmail.com>
 <6d3d27d2-36e2-d95b-98e4-df08dedc34e2@kernel.org>
Message-ID: <b184dbfc-ef92-5c1e-924d-481946e92ad7@gmail.com>
Date:   Fri, 25 Jun 2021 18:09:41 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6d3d27d2-36e2-d95b-98e4-df08dedc34e2@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/25/21 3:09 AM, Jiri Slaby wrote:
> On 24. 06. 21, 22:27, Igor Matheus Andrade Torrente wrote:
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
>> To solve this issue I made the resize_screen() be called
>> even if the screen does not need any resizing, so it will
>> "fix and fill" the fb_var_screeninfo independently.
>>
>> Reported-and-tested-by:
>> syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com
>> Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
>> ---
>>   drivers/tty/vt/vt.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
>> index fa1548d4f94b..e342f5c905bc 100644
>> --- a/drivers/tty/vt/vt.c
>> +++ b/drivers/tty/vt/vt.c
>> @@ -1220,7 +1220,22 @@ static int vc_do_resize(struct tty_struct *tty,
>> struct vc_data *vc,
>>       new_screen_size = new_row_size * new_rows;
>>       if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
>> -        return 0;
>> +        /* This function is being called here to cover the case
>
> This was already commented on v3:
> <quote>
>   Please do not use networking style comments, use normal ones:
>                  /*
>                   * This function...
> </quote>

I don't know how, but I didn't see this comment in the original email. I
will change it.

>
>> +         * where the userspace calls the FBIOPUT_VSCREENINFO twice,
>> +         * passing the same fb_var_screeninfo containing the fields:
>> +         * yres/xres equal to a number non-multiple of vc_font.height
>> +         * and yres_virtual/xres_virtual equal to number lesser than the
>> +         * vc_font.height and yres/xres.
>> +         * In the second call, the struct fb_var_screeninfo isn't
>> +         * being modified by the underlying driver because of the
>> +         * if above, and this causes the fbcon_display->vrows to become
>> +         * negative and it eventually leads to out-of-bound
>> +         * access by the imageblit function.
>> +         * To give the correct values to the struct and to not have
>> +         * to deal with possible errors from the code below, we call
>> +         * the resize_screen here as well.
>> +         */
>> +        return resize_screen(vc, new_cols, new_rows, user);
>
> I suppose you need to add { } after the if given how its body grew.
>
> With what all console drivers have you tested this with?

fbcon

>
>>       if (new_screen_size > KMALLOC_MAX_SIZE || !new_screen_size)
>>           return -EINVAL;
>>
>
>

Thanks,
Igor M. A. Torrente
