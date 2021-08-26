Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD5B3F85EB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241843AbhHZKzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241764AbhHZKzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:55:52 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00430C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 03:55:04 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s12so4408623ljg.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 03:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gyaOi6RN2420GeghFUJpRrLyGOmM8GbJSeqKZfO6HQY=;
        b=U4lLeUiWuganwWyXzSGOE9L32MEooa5dMIEAhQNKDUUXz3CNTEwp2b9yarYNs2C89e
         XX3Zhbh1P9ZuZeWZutDWJHkhRRkSInbx+xGJ2P8EGLoTydM39Ufh5hlDyfBiNE23ABvq
         /ei0Ge0MFM0cnWFMVPzOhTe+eePu4kCtcQJ5xzRjz2MxqJG82sVD6PmmC5zbFm4UWUg1
         rpS0FuLwU9hplnFCCpcHweC4gTyZV/AOqclppc4PMRLaWMGsekNiR5c2H23hRkby89pU
         LGUNJtobzaRUVJoRyl15N9SJ64IITob28AyGNfxvup/MiCqEkfPeA/sqBxUGmGtl5RbX
         Ln7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gyaOi6RN2420GeghFUJpRrLyGOmM8GbJSeqKZfO6HQY=;
        b=KD7z7NVzyhoOTxk4Eonm8mJfdqTNR3F2nL7eaR/mL3Vr1wlUYvm7GQH1Xwm7ceKtvw
         tkJLxZIZKBRd54nOFKPuuBRradaQ222PC48aFggft7ZJ3cJcT0LSg41y7J9j096J6936
         JNvVfyEcV7/l++kyEKK0W5+0WqnO9eYY6IlXYeXB/Z0Vkvjs/9DZSXa3btNBMgEYgGfQ
         vey+buXHBi5S/V4lg1oB9OpyRUNNMubHeInE/MiuHBnbLfokZk8Stnv8d0JvlpDXmF8N
         9kLxy9jsf/VIATLz+3tGSkaAeVcxgB6E4vgob2wf5b7BAt8QR/hXPaXaEmUfqt78Uq5S
         bXCQ==
X-Gm-Message-State: AOAM532Alww6zhA9nv7fYbpVTLU9pJlxFYCVaecd+PmMmJKn3TNRPn0s
        MDeIIaS0rhYbIcR7XTnWH1sIX6fs86Zk/A==
X-Google-Smtp-Source: ABdhPJxIhrcvQ/+ceOKRvRh6zz3SeummF+ZdhzyNUFnZAbelD7GcZgJRrYxb883fW0GZ8561oPoEog==
X-Received: by 2002:a2e:97cf:: with SMTP id m15mr2459361ljj.243.1629975302866;
        Thu, 26 Aug 2021 03:55:02 -0700 (PDT)
Received: from localhost.localdomain ([46.61.204.60])
        by smtp.gmail.com with ESMTPSA id v1sm288528lfg.106.2021.08.26.03.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 03:55:02 -0700 (PDT)
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
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <0eb2bbc6-9d35-9ff3-acde-fd89bbe0ca27@gmail.com>
Date:   Thu, 26 Aug 2021 13:55:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <64112dfd8e8b472ab78ca8b4837dc9e9@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/21 1:22 PM, David Laight wrote:
> From: Pavel Skripkin
>> Sent: 26 August 2021 10:28
>> 
>> On 8/26/21 12:22 PM, Pavel Skripkin wrote:
>> > On Thu, 26 Aug 2021 08:51:23 +0000
>> > David Laight <David.Laight@ACULAB.COM> wrote:
> ...
>> >> ...
>> >> > -static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
>> >> > +static int usb_read32(struct intf_hdl *pintfhdl, u32 addr, u32
>> >> > *data) {
>> >> >  	u8 requesttype;
>> >> >  	u16 wvalue;
>> >> >  	u16 len;
>> >> > -	__le32 data;
>> >> > +	int res;
>> >> > +	__le32 tmp;
>> >> > +
>> >> > +	if (WARN_ON(unlikely(!data)))
>> >> > +		return -EINVAL;
>> >> >
>> >>
>> >> Kill the NULL check - it is a silly coding error.
>> >> An OOPS is just as easy to debug.
>> >>
>> >
>> >
>> > I don't think that one single driver should kill the whole system. It's
>> > 100% an error, but kernel can recover from it (for example disconnect
>> > the driver, since it's broken).
>> >
>> >
>> > AFIAK, Greg and Linus do not like BUG_ONs in recoverable state...
>> > Correct me, if I am wrong
>> >
>> Oops, I thought about BUG_ON() instead of WARN_ON(), sorry for
>> confusion. My point is "we should not let the box boom".
> 
> 
> There is no point checking for NULL that just can't happen.
> In this case all the callers will pass the address of a local.
> There really is no point checking.
> 

We not always read in local variable, there are few places, where we 
read into passed buffer.



With regards,
Pavel Skripkin
