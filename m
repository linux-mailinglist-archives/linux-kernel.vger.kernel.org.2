Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DDC3F8F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 22:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhHZUD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 16:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhHZUD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 16:03:56 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E351DC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 13:03:08 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x27so9385340lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 13:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3zAr+cyoXevrt8A+DyLi9G7nlDrM3xPW3HSqFrbuWPs=;
        b=Icip//QmnD0NfBJVT3jKI5SpPllcAFbvQJPqcqAi/lHASsMeGAYEwhsLQR1iq41S45
         jOzXGIyTUMc62f3JOHJTfpjSW5XWDpkfcUfBeITDpzkUaTuU/1q9ATb8uk3E5i8CN5T3
         0AzphqxcD6CPlGJHUvhLW9FDkqc46Omn/SmjptA5Qxix8Nm7rgrf0L4sWvYVA+l5Tp0i
         g8bmd5FMM7T4LTuKvUSwuM32w7/mA0jDmWIxmcwUsXaOwnk1fTLA2XK15KaBdJgArb2H
         A5vS22SK2seRm8qqMYfJL3pU6v3Ci4+zwOypaTIvI1o/RIMOTYZ7RkJv8xG1H3WfB7uh
         BYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3zAr+cyoXevrt8A+DyLi9G7nlDrM3xPW3HSqFrbuWPs=;
        b=r8AaH1//cHNawDTVmUSPSzbkQkewQHnpNi76qnH0eBOiEmtnm8FwZY+48tMjk9OO7B
         VbVS3NXDo6mksnhFHcoed2m/QRYtgG6J1bEZQ5PDUjFHJR3r2bpRl48TBHmBR9xKYQ/W
         XRuYBqZ+4Cm3Zv3RTEMQQYIR/8/1Tbdqk/Zd67hsH6BLVxI/XLVhTVbgCEVwOQSi0EiN
         JXDsoWICMZnwu364jVnsDdhk1u1L3JwDKHXHp9UrBwPYm8R7MHsAcqXisft+IJHEWJv3
         oD+evTSRnteg4bTW0VrdzKpr+6T21pTa+kN7XbTRE06TFFDJqiFSrQxgRWGsNTAs5Eqy
         WHTQ==
X-Gm-Message-State: AOAM532fShqggoDSuavhC3Pwe2ZU0csCPxQu+cH0V5afH+hg5g5tRfvL
        ME+Z+JJPG4BptJJARLLzlhEiYvVUPBI=
X-Google-Smtp-Source: ABdhPJzFUVFuXxfr49qDXFQHyBkAbZDK+s8QKVlAGiVJEju4KP3Zu+mi5R4agrFlZpcWYZPZOxqXCA==
X-Received: by 2002:ac2:41d9:: with SMTP id d25mr3921380lfi.386.1630008186989;
        Thu, 26 Aug 2021 13:03:06 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id b4sm397722lfo.94.2021.08.26.13.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 13:03:06 -0700 (PDT)
Subject: Re: [PATCH v3 5/6] staging: r8188eu: add error handling of rtw_read32
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "phil@philpotter.co.uk" <phil@philpotter.co.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "straube.linux@gmail.com" <straube.linux@gmail.com>,
        "fmdefrancesco@gmail.com" <fmdefrancesco@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1629789580.git.paskripkin@gmail.com>
 <93bf46ce2d0ce12e94672acf28b64dc341fde038.1629789580.git.paskripkin@gmail.com>
 <27f5e52d520b453cbcabb3d72f0f5d15@AcuMS.aculab.com>
 <20210826122221.5d2b0f37@gmail.com>
 <685618ac-8de1-4eb1-57dd-9d43b96e872e@gmail.com>
 <64112dfd8e8b472ab78ca8b4837dc9e9@AcuMS.aculab.com>
 <0eb2bbc6-9d35-9ff3-acde-fd89bbe0ca27@gmail.com>
 <6e864f9d133d4db3923190f5acacc32a@AcuMS.aculab.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <fb29e9f2-3662-c365-7427-a91a298ef10f@gmail.com>
Date:   Thu, 26 Aug 2021 23:03:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6e864f9d133d4db3923190f5acacc32a@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/21 1:59 PM, David Laight wrote:
> From: Pavel Skripkin
>> Sent: 26 August 2021 11:55
>> 
>> On 8/26/21 1:22 PM, David Laight wrote:
>> > From: Pavel Skripkin
>> >> Sent: 26 August 2021 10:28
>> >>
>> >> On 8/26/21 12:22 PM, Pavel Skripkin wrote:
>> >> > On Thu, 26 Aug 2021 08:51:23 +0000
>> >> > David Laight <David.Laight@ACULAB.COM> wrote:
>> > ...
>> >> >> ...
>> >> >> > -static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
>> >> >> > +static int usb_read32(struct intf_hdl *pintfhdl, u32 addr, u32
>> >> >> > *data) {
>> >> >> >  	u8 requesttype;
>> >> >> >  	u16 wvalue;
>> >> >> >  	u16 len;
>> >> >> > -	__le32 data;
>> >> >> > +	int res;
>> >> >> > +	__le32 tmp;
>> >> >> > +
>> >> >> > +	if (WARN_ON(unlikely(!data)))
>> >> >> > +		return -EINVAL;
>> >> >> >
>> >> >>
>> >> >> Kill the NULL check - it is a silly coding error.
>> >> >> An OOPS is just as easy to debug.
>> >> >>
>> >> >
>> >> >
>> >> > I don't think that one single driver should kill the whole system. It's
>> >> > 100% an error, but kernel can recover from it (for example disconnect
>> >> > the driver, since it's broken).
>> >> >
>> >> >
>> >> > AFIAK, Greg and Linus do not like BUG_ONs in recoverable state...
>> >> > Correct me, if I am wrong
>> >> >
>> >> Oops, I thought about BUG_ON() instead of WARN_ON(), sorry for
>> >> confusion. My point is "we should not let the box boom".
>> >
>> >
>> > There is no point checking for NULL that just can't happen.
>> > In this case all the callers will pass the address of a local.
>> > There really is no point checking.
>> >
>> 
>> We not always read in local variable, there are few places, where we
>> read into passed buffer.
> 
> It is still a very local coding bug.
> 
> 	David
> 

Sure, but is defensive programming so bad?


Greg, what your opinion about this NULL check?




With regards,
Pavel Skripkin
