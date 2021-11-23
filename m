Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F8E45A70F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbhKWQEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhKWQEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:04:02 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E199C061574;
        Tue, 23 Nov 2021 08:00:54 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so34387661otk.13;
        Tue, 23 Nov 2021 08:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xZcXBlStyz9PWRZ1eN6d8yrum2GVCvr/q9iwNWwmnm0=;
        b=PW4GgGzU7mkPTuIMp8drPN9VQsuMJfAjADlYOAXhQCTfuh5Res4H/tRrb5nCOX3Zem
         x6MwX8+wt5zntRKnhII8Hhs0m//NHVAwKjlanSIACmBYZSsPqjpaI3ukClz3eFMOqlgm
         jzMV8r84KYWeOi6vqWuV0Bj61rpH+VNKrmyYDn8TJoEGEOT+qK+qo46uAXnaF4kyrwYA
         7eBtLyEiyjT4hxq7lFCCJ94yEAvvu+5qjYHGU07wlIjguISeg34PhpiGSnB9mTTgne4C
         MIVKc1NljNXEtHcGKrdNguntYvh2Xl4gnj+WqpKkRcO1qaR90gp/x6bRmZj2FNEQ4IIX
         IziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=xZcXBlStyz9PWRZ1eN6d8yrum2GVCvr/q9iwNWwmnm0=;
        b=WXE58xzaajt4BQnJeqeI498vr9cZTAXeVb/U4C2XlCFToe05RPGfPAUnPBz2UraP3K
         h1022hYiMWMnIa2bjlDNIaYRM1un7/fReLNvAhh50euqK/UnbVQ6sVDxgmzkewXaH8rW
         nqtRLfvN4QODJ5IVwJMS1MOUopv0mhQWgLI7OqXJM5n4UUv/h9cWzGdttrQfbvqt85dx
         5nB4tgo9xbX2CSkEnQmW41Di+oYp444DjVZmLQqGoZiaXnxiMNELp6F7NfTiEL2FuhMh
         EEp23Y8CCYsB0MXd26IcfPcwDIFD/KwjDy1zXSwsx+n6WmhlCVhq1JJXB6wioi9K2aeT
         1grg==
X-Gm-Message-State: AOAM531rL9mmVXYv6xTv00uraqwLyrpIGq4krBmRn907vO3oZSZGVei/
        3MutUFv2mKb4ztdBHHQYznY=
X-Google-Smtp-Source: ABdhPJz/AfOxSIHlu6eT1Ese44DpBJMyWd4LXPiDLUDo+oGvnykDG7rFfM+DOHuHcIZzNllRZfS3fw==
X-Received: by 2002:a05:6830:236b:: with SMTP id r11mr5416530oth.145.1637683253723;
        Tue, 23 Nov 2021 08:00:53 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y1sm2257007otu.58.2021.11.23.08.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:00:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 23 Nov 2021 08:00:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Armin Wolf <W_Armin@gmx.de>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (dell-smm) Unify i8k_ioctl() and
 i8k_ioctl_unlocked()
Message-ID: <20211123160051.GA2326185@roeck-us.net>
References: <20211120170319.72369-1-W_Armin@gmx.de>
 <20211120170319.72369-3-W_Armin@gmx.de>
 <20211122160122.gf6i3qj6dnwi6wla@pali>
 <c23caeab-dd27-4c95-2e25-9eb0ff7b33f6@roeck-us.net>
 <e336f501-fe07-7b49-bc65-d6ca443491ca@gmx.de>
 <20211122191008.uw2tk4orb7p2elb7@pali>
 <b73d5a00-ecce-0517-4fb5-4af451e1facb@roeck-us.net>
 <20211122194310.viaddbblls2wxmbm@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211122194310.viaddbblls2wxmbm@pali>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 08:43:10PM +0100, Pali Rohár wrote:
> On Monday 22 November 2021 11:28:30 Guenter Roeck wrote:
> > On 11/22/21 11:10 AM, Pali Rohár wrote:
> > > On Monday 22 November 2021 19:50:14 Armin Wolf wrote:
> > > > Am 22.11.21 um 18:55 schrieb Guenter Roeck:
> > > > > On 11/22/21 8:01 AM, Pali Rohár wrote:
> > > > > > On Saturday 20 November 2021 18:03:19 Armin Wolf wrote:
> > > > > > > The only purpose of i8k_ioctl() is to call i8k_ioctl_unlocked()
> > > > > > > with i8k_mutex held. Judging from the hwmon code, this mutex
> > > > > > > only needs to be held when setting the fan speed/mode.
> > > > > > 
> > > > > > Really? I think that there is no difference between setting and getting
> > > > > > fan speed/mode. At least I do not see why 'set' needs mutex and 'get' do
> > > > > > not need it. Some more explanation is needed...
> > > > > > 
> > > > > I8K_SET_FAN sets the fan speed and returns the current status. Without
> > > > > locking, the returned status may not match or be associated with the
> > > > > previous
> > > > > set operation.
> > > > > 
> > > > > Maybe that doesn't matter, and the synchronization is not needed. If so,
> > > > > you can probably remove the locking entirely.
> > > > > 
> > > > > Guenter
> > > > 
> > > > That is the reason i kept the locking code. Since i do not want to break
> > > > the ioctl interfacein any way, removing the locking code seems too risky
> > > > to me.
> > > 
> > > I see. That is a good point.
> > > 
> > > But there is same race condition also when at the same time going to
> > > change speed via ioctl and also via hwmon sysfs.
> > > 
> > 
> > I thought the sysfs code does not change the fan speed and report the
> > fan status in the same request. Did I miss something ?
> 
> No. I mean something different. Let me to write trace call:
> 
> CPU 0:                          CPU 1:
>                                 1. dell_smm_write()
> 1. ioctl(I8K_SET_FAN)
> 2. i8k_set_fan()
>                                 2. i8k_set_fan()
> 3. i8k_get_fan_status()
> 
> So to ensure that i8k_get_fan_status() on CPU 0 returns value which
> belongs to i8k_set_fan() from CPU 0 it is needed to still use mutex.
> 
> Armin is right here and I think that patch is correct.

Quoting your earlier reply:

> Really? I think that there is no difference between setting and getting
> fan speed/mode. At least I do not see why 'set' needs mutex and 'get' do
> not need it. Some more explanation is needed...

This was the reason for my comment. Your latest reply is leaving me a bit
puzzled. If you are ok with the patch as-is, please provide a Reviewed-by:
or Acked-by: tag.

Thanks,
Guenter

