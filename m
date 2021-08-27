Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9BD3F94EF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 09:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244307AbhH0HRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 03:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbhH0HRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 03:17:51 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB39FC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 00:17:02 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s12so9889168ljg.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 00:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nsfTnZeRT042LbD6vZ5TbEoeI++bi2xeLyIL6BeGEEc=;
        b=lifqIgLXIGjaD6dYmYO1cCnauEyIsHrHmGgjhqbLV+2Njy5zjS8JMR62cY3rOwb7fH
         yyxPLNm13vHDr8TEDdLoSm4vSoV5H51MHu4PY4mDBPyfgk2K7Y15iz07fohlYq+FUSHv
         6QISkkplfRCRpEYAJNFqLM5PHwyeRTRehC4eYEnp/UUjZUM10SuvfPhLCJDEBMvxfjvJ
         JlRdoBAhTKhfpdfHqxX/07n5agRzpz9UC/IP/GMZR6zPpvXjPE9qU1Kh1tubRc1K4ojX
         rI31fm5sQ2WMposUUxZTowIiJ6mpMgtJLi3uT0cAj4TDnj8Dq5zpnlslnFksjeJMzOKW
         SlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nsfTnZeRT042LbD6vZ5TbEoeI++bi2xeLyIL6BeGEEc=;
        b=oQUxwRWFSA0oP5YKD/OfDTd5ckpFlJMwi0QJesIfUyyDbRy1Gew1fdb0ZWnyShO+Ip
         creDOHSjoNgrVf+8uQ2HHaA3lD3sCii4QfXDjibQK+kJYNhmdK+wEDK8+byVMunOFKAx
         QbCwEal2CLrWbn+XooUON4n+qllyhJt3LFBHXdKnbieqcOedwzKX/Ot/OuGTAa+ZjKFv
         ihZz7Y04je6qfNUpYwrsmes8xuqKC0vDpkH2jRqFoGtmiEzIV0de66o28i8K6PgiEMzw
         BiWdg7Ubffoy0+9xVf+zKIku0JEkuYdaHQun3DffnSQ9b6zpivaMqqu6olovM0iyiWoV
         btxw==
X-Gm-Message-State: AOAM532pb8Oi4eoWJyu03PZflXxyAHHBDPKCSAIFaYpkIbOBoTnkrBOW
        Yz4awSw1XAawVIsDo9ZVl1T4jcjau4U=
X-Google-Smtp-Source: ABdhPJzAnlhBDftiPfGxc8SVk+moS9LcKuO4pMQItSfs2ORHL0nrTBqEFtnN4CwizXPTLBLPxF1ccA==
X-Received: by 2002:a05:651c:894:: with SMTP id d20mr6295547ljq.483.1630048619964;
        Fri, 27 Aug 2021 00:16:59 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id q9sm558596lfn.170.2021.08.27.00.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 00:16:59 -0700 (PDT)
Subject: Re: [PATCH v3 5/6] staging: r8188eu: add error handling of rtw_read32
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "phil@philpotter.co.uk" <phil@philpotter.co.uk>,
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
 <fb29e9f2-3662-c365-7427-a91a298ef10f@gmail.com> <YSiQXpzswaRhvD4P@kroah.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <014d213d-b038-f40f-80b0-f1d5adbdf947@gmail.com>
Date:   Fri, 27 Aug 2021 10:16:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSiQXpzswaRhvD4P@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/21 10:12 AM, gregkh@linuxfoundation.org wrote:
> On Thu, Aug 26, 2021 at 11:03:04PM +0300, Pavel Skripkin wrote:
>> On 8/26/21 1:59 PM, David Laight wrote:
>> > From: Pavel Skripkin
>> > > Sent: 26 August 2021 11:55
>> > > 
>> > > On 8/26/21 1:22 PM, David Laight wrote:
>> > > > From: Pavel Skripkin
>> > > >> Sent: 26 August 2021 10:28
>> > > >>
>> > > >> On 8/26/21 12:22 PM, Pavel Skripkin wrote:
>> > > >> > On Thu, 26 Aug 2021 08:51:23 +0000
>> > > >> > David Laight <David.Laight@ACULAB.COM> wrote:
>> > > > ...
>> > > >> >> ...
>> > > >> >> > -static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
>> > > >> >> > +static int usb_read32(struct intf_hdl *pintfhdl, u32 addr, u32
>> > > >> >> > *data) {
>> > > >> >> >  	u8 requesttype;
>> > > >> >> >  	u16 wvalue;
>> > > >> >> >  	u16 len;
>> > > >> >> > -	__le32 data;
>> > > >> >> > +	int res;
>> > > >> >> > +	__le32 tmp;
>> > > >> >> > +
>> > > >> >> > +	if (WARN_ON(unlikely(!data)))
>> > > >> >> > +		return -EINVAL;
>> > > >> >> >
>> > > >> >>
>> > > >> >> Kill the NULL check - it is a silly coding error.
>> > > >> >> An OOPS is just as easy to debug.
>> > > >> >>
>> > > >> >
>> > > >> >
>> > > >> > I don't think that one single driver should kill the whole system. It's
>> > > >> > 100% an error, but kernel can recover from it (for example disconnect
>> > > >> > the driver, since it's broken).
>> > > >> >
>> > > >> >
>> > > >> > AFIAK, Greg and Linus do not like BUG_ONs in recoverable state...
>> > > >> > Correct me, if I am wrong
>> > > >> >
>> > > >> Oops, I thought about BUG_ON() instead of WARN_ON(), sorry for
>> > > >> confusion. My point is "we should not let the box boom".
>> > > >
>> > > >
>> > > > There is no point checking for NULL that just can't happen.
>> > > > In this case all the callers will pass the address of a local.
>> > > > There really is no point checking.
>> > > >
>> > > 
>> > > We not always read in local variable, there are few places, where we
>> > > read into passed buffer.
>> > 
>> > It is still a very local coding bug.
>> > 
>> > 	David
>> > 
>> 
>> Sure, but is defensive programming so bad?
> 
> Yes it is, for when it is not needed.
> 
>> Greg, what your opinion about this NULL check?
> 
> Never check for things that you know are not going to happen.  Otherwise
> the kernel would just be full of pointless checks everywhere.
> 
> And why are you waiting for me to tell you this?  Why do you not believe
> David?
> 


Just wanted to hear more opinions on this check. I believe David, but 
opinions of other people are important too, IMO




With regards,
Pavel Skripkin
