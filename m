Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE9239F93C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbhFHOeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:34:19 -0400
Received: from mail-qv1-f53.google.com ([209.85.219.53]:38632 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhFHOdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:33:54 -0400
Received: by mail-qv1-f53.google.com with SMTP id t6so4988192qvp.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 07:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=85gfhyhaPICE6JruxReW5bLHIP9PAbtsoqQJ5UZBDsk=;
        b=sp7O2Zt681hV3TBbSN6U5r0xwrEt8LVni6I6bimoBocl22397YlDqjWWL6QkcTnhl1
         Dp2ihHVAROAhoZWqnfxUYkf9jtNVbFkMYhi61RFrUZh2T6W4e2ne7d0roVa2fLrEAsmX
         NBE6MiVW+q2lUCQkbaqYdKeY6SCjE9y+cvegAmFSunVl8aD2G80BueXbwSozW0s3+XYG
         A4lJxnqwn7cLO2z2leDODvv0r4JU3nxpA3l1QE3S/Aw+X2LWEYB7LW1YtK+o/f8d+y1l
         zRS2MptD4bYS5DF1Zqk0FUefR8T9D60GVlelQ5da9juJuOSBMO5KrabFzL94qDX5Qjck
         94tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=85gfhyhaPICE6JruxReW5bLHIP9PAbtsoqQJ5UZBDsk=;
        b=XKQDs7/TdUJYGBdh/0IUnguu1p09nkOP0uO6WCSBA/VDgMzbwlMjJAP68EfgULNEMB
         KmKQUgrnhQK9ZxgTv041Ih5UW40MByYXCOdXZcFcEJmylkDBuTmYk2TYiODwJmLoSshd
         0fgAI93GDweBlq+9XEL9eHoHKAQR9pXa7hEFbt5kTKTy6G0QjqbCA/tgIwyO6ZXBR0to
         ArG13x7F0d68t41N5OzupzHUihDq8H5oRMil1Z3PrEql0ziATslS7IvkPdWx8UstB/Mc
         /f1w7Bajb/33VSuzztgbMj74l8nsjtVzTGQS339M1M7HQt1Lp4hc0ZVRFfKsRPMUvl+i
         cdgw==
X-Gm-Message-State: AOAM532x4OHOjoBykXFMjJpF9qpWHJoas0RhVqhZ36wThcAtG4R0KFvs
        ltm7Ny+cafwEahu93FdThx0=
X-Google-Smtp-Source: ABdhPJxRpZPubwyW7rrT5AEj1tVUNjnoYVPeyzSbfy1Bu2s7ppZeKSpz1/V6W1F95q2zhxL6vl8i5w==
X-Received: by 2002:a0c:cd87:: with SMTP id v7mr5514851qvm.42.1623162661548;
        Tue, 08 Jun 2021 07:31:01 -0700 (PDT)
Received: from ?IPv6:2804:14c:125:811b:fbbc:3360:40c4:fb64? ([2804:14c:125:811b:fbbc:3360:40c4:fb64])
        by smtp.gmail.com with ESMTPSA id o10sm12219837qki.72.2021.06.08.07.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 07:31:01 -0700 (PDT)
Subject: Re: [PATCH RFC] tty: Fix out-of-bound vmalloc access in imageblit
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com
References: <20210531124713.9048-1-igormtorrente@gmail.com>
 <YLoob2rm3isTp+ln@kroah.com>
From:   Igor Torrente <igormtorrente@gmail.com>
Message-ID: <fb93d5aa-d678-9de1-a7e0-dfa5594ff68a@gmail.com>
Date:   Tue, 8 Jun 2021 11:30:58 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YLoob2rm3isTp+ln@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/21 10:19 AM, Greg KH wrote:
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
>>
>> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
>> index fa1548d4f94b..1b90758d8893 100644
>> --- a/drivers/tty/vt/vt.c
>> +++ b/drivers/tty/vt/vt.c
>> @@ -1219,6 +1219,10 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
>>   	new_row_size = new_cols << 1;
>>   	new_screen_size = new_row_size * new_rows;
>>   
>> +	err = resize_screen(vc, new_cols, new_rows, user);
>> +	if (err)
>> +		return err;
>> +
>>   	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
>>   		return 0;
>>   
> 
> But now if any of the checks below this call fail, the screen will be
> resized and not "put back" to the original size, right?  That could
> cause a mis-match of what is expected here.

Right, this will probably cause problems. :/
Thanks to point out, I'll work to find another solution.

> 
> thanks,
> 
> greg k-h
> 

---
Igor M. A. Torrente
