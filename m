Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90853F8485
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 11:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240987AbhHZJ25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 05:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbhHZJ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 05:28:46 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B6FC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 02:27:59 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id j12so3884077ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 02:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=apPabyFebLBZ6Y4h4FLD74wAviXGA6FanlT1NMAG/UQ=;
        b=EFtvrylaEy+EvAfC6iYMhbuOGOAokbnq2aTwK9FXZM2fGNmuNcAgO+fF2RFTJ/7ejO
         QeMN/dUzePOuMVrmobwhFjPfqBqPxzEM8ZKrtkff1qncqxfTXnLJSAimFnRWQkjusEB1
         3cMGpj9+An27WpLLsdjDqWZ0wwm3jpL4Fkf8a3AQRSFY8gSkL8dKZhrRP2eh9KbFTIFp
         DkYHMRpS8EWuYd3Kby8666ZEyheNpRHR9wZnVNyuKQ7ya9EsoO3hFnap0W4uJHF9WfFi
         rjbWPmMpzRxjiTrOUzn16sS5BIiIs8c+1+VDAI5DSu1A9V66WiCa4PqZgU16YUB9V0jS
         GwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=apPabyFebLBZ6Y4h4FLD74wAviXGA6FanlT1NMAG/UQ=;
        b=XvLfYm4/+d5xk71Hcze7X8eNY5/3vqYOtsaeGyw8FaSoIcdElVKhboWBUrujGYGLKZ
         n8WHSnpHSHoC9FU4fzA/4oeezR6zuqIttYaY1k8Cap6ckkidMigEzHv682+NhwphFyt+
         MpKSnqEs0UWYBl1TzVy3VcKKC3Ww9M2zbbhqhDv4Axxf7n7ZLW5gZe+yF4sB+ToJ1ngV
         AFkxTPR8IE+sVQ0YXwzmaDh0Z766YhDnhzTz0WFkb7LE4aUUZLjnNMMYtm7cfLuJmQJx
         6ruJezPPIWvUMhIOwJ6qtgZUm1fHJfuxDtLV63kBTnyxivwVtpYX8USrkpBan2DjEqNZ
         667w==
X-Gm-Message-State: AOAM532Y4CpKXXw7vh028De1LDdCTVRKSM9Px6mACMnQNrf3CMcbQ0Zi
        JBqCgYJZ8yqlc50905fTtomn7LLUIQ4sNw==
X-Google-Smtp-Source: ABdhPJywMS7VAG3c2EoTLO6fKMoUX4D9GqZ+5UwXT+AqYMRywKNR2yiZKrfKfvpwpDxP+loRF10Qgg==
X-Received: by 2002:a2e:a726:: with SMTP id s38mr2173904lje.386.1629970077317;
        Thu, 26 Aug 2021 02:27:57 -0700 (PDT)
Received: from localhost.localdomain ([46.61.204.60])
        by smtp.gmail.com with ESMTPSA id b2sm262001lfi.283.2021.08.26.02.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 02:27:56 -0700 (PDT)
Subject: Re: [PATCH v3 5/6] staging: r8188eu: add error handling of rtw_read32
From:   Pavel Skripkin <paskripkin@gmail.com>
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
Message-ID: <685618ac-8de1-4eb1-57dd-9d43b96e872e@gmail.com>
Date:   Thu, 26 Aug 2021 12:27:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210826122221.5d2b0f37@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/21 12:22 PM, Pavel Skripkin wrote:
> On Thu, 26 Aug 2021 08:51:23 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
>> From: Pavel Skripkin <paskripkin@gmail.com>
>> > Sent: 24 August 2021 08:28
>> > 
>> > _rtw_read32 function can fail in case of usb transfer failure. But
>> > previous function prototype wasn't designed to return an error to
>> > caller. It can cause a lot uninit value bugs all across the driver
>> > code, since rtw_read32() returns local stack variable to caller.
>> > 
>> > Fix it by changing the prototype of this function. Now it returns an
>> > int: 0 on success, negative error value on failure and callers
>> > should pass the pointer to storage location for register value.
>> 
>> Pretty horrid API interface.
>> Functions like readl() - which can fail just return ~0u and let
>> the caller worry about whether that causes serious grief.
>> 
>> You could make all the read functions return __u64 and return ~0ull
>> on error.
>> Testing for (value & 1ull << 63) will be reasonable even on 32bit.
>> 
> 
> I am not the best at API related questions, so can you, please,
> explain why your approach is better?
> 
> As I can see, most of the drivers in usb/ directory use smth like this
> interface for private reading funcions. We anyway creating tmp variable
> (but 64 bit _always_) and checking for mistery error, which we cannot
> pass up to callers.
> 
> Sorry, if it's _too_ dumb question, but I really can't get your
> point....
> 
> 
> 
>   
> 
>> ...
>> > -static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
>> > +static int usb_read32(struct intf_hdl *pintfhdl, u32 addr, u32
>> > *data) {
>> >  	u8 requesttype;
>> >  	u16 wvalue;
>> >  	u16 len;
>> > -	__le32 data;
>> > +	int res;
>> > +	__le32 tmp;
>> > +
>> > +	if (WARN_ON(unlikely(!data)))
>> > +		return -EINVAL;
>> > 
>> 
>> Kill the NULL check - it is a silly coding error.
>> An OOPS is just as easy to debug.
>> 
> 
> 
> I don't think that one single driver should kill the whole system. It's
> 100% an error, but kernel can recover from it (for example disconnect
> the driver, since it's broken).
> 
> 
> AFIAK, Greg and Linus do not like BUG_ONs in recoverable state...
> Correct me, if I am wrong
> 
Oops, I thought about BUG_ON() instead of WARN_ON(), sorry for 
confusion. My point is "we should not let the box boom".





With regards,
Pavel Skripkin
