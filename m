Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2823F5884
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 08:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhHXGy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 02:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbhHXGyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 02:54:24 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8554C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 23:53:40 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f10so28451950lfv.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 23:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uSYmQad0KIz3lhdbLMiYxSPPWZAwa1aOgDUep2rDmQo=;
        b=tfz/fUaMlzguKO8c64aHNO1shEVpmAv654uob8Vxg0tFfagu32mjSOS7mBWn4RZlCq
         M1vwGnOQeWe1CPwm2O4Mob/qAZKPWayikD+mcChtgmYnN5WdDqlwROhGCwZUP6UdIHfA
         r+uN99nPgU6F6BsC5oxePpx0rPA1jzOV87Rz9fEa46u1tlyGry6pmW2M27/khlPFks8l
         R2Cqiuv6RdJVWYtGA+xceFr4/XwZfXoO8/SXffCAmP6uU0QJ6KzF3x09141mT2jUp7cd
         4jhsZJxn4WK/dB6aNU7c7ZFsN6zYtk8Ilws66dDQa7LIgWrTPCyYGSbTH5soqGr+3G9N
         4Dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uSYmQad0KIz3lhdbLMiYxSPPWZAwa1aOgDUep2rDmQo=;
        b=TdLbfSf+iaN/fUmZqwyDFc2oSRxmmhCcMzyX+7F1hldRQsV5imZe8+QwMPImEL/Kwi
         8xssAVmrVDZLqFhYir4XkXTrQZXLrKQf4tBBDmF1V3n6zyGUdl6OjouNJ+Ka7hpnCopj
         THXpsSNaVNMS6TIpbpH05yqSMjiqcS9z3j1L0HrQBBUKERLuHdYhDPbZjNiepta+o2g8
         +oKOTGzruYPMLcxmruprqd7UVzvneBO537C0xef/SDzZ0w1LpUuzwNtJHlDGJEXPhi+f
         m+q9GreZgM63suF/h+nSFBxySEUwbgL1FderOIQPfJ/8mqOeCvdMKor6IkW9uoN2vqiw
         u3Nw==
X-Gm-Message-State: AOAM531YdSGxlkzm/EDE+8/6zwwQz5eEWMJbsSiMzJz2pyeD/YP6nWCc
        +4xTKfsZEJNyy3IIoLpG6gOFfJELjGdq/A==
X-Google-Smtp-Source: ABdhPJwAKzbddw6vtb4DlhYVUPhEWp+JDK0E1hxi94gv6isKsyS5SQ2Iu/6awrfIjhL0yQsccxuwYQ==
X-Received: by 2002:ac2:4c2a:: with SMTP id u10mr28138257lfq.631.1629788018887;
        Mon, 23 Aug 2021 23:53:38 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id y10sm1821430lfh.40.2021.08.23.23.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 23:53:38 -0700 (PDT)
Subject: Re: [PATCH RFC v2 5/6] staging: r8188eu: add error handling of
 rtw_read32
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1629642658.git.paskripkin@gmail.com>
 <9004eb2972780455db4cba9694244a2c572abba8.1629642658.git.paskripkin@gmail.com>
 <CAA=Fs0=gX66TW3qoHYWcoSsvai6YZn=U81a34V45oij7NrMJrQ@mail.gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <ba9e0634-6cc6-161f-f4f9-3538f44448f8@gmail.com>
Date:   Tue, 24 Aug 2021 09:53:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAA=Fs0=gX66TW3qoHYWcoSsvai6YZn=U81a34V45oij7NrMJrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 2:33 AM, Phillip Potter wrote:
> On Sun, 22 Aug 2021 at 15:36, Pavel Skripkin <paskripkin@gmail.com> wrote:
>> -static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
>> +static int usb_read32(struct intf_hdl *pintfhdl, u32 addr, u32 *data)
>>  {
>>         u8 requesttype;
>>         u16 wvalue;
>>         u16 len;
>> -       __le32 data;
>> +       int res;
>> +       __le32 tmp;
>> +
>> +       if (WARN_ON(unlikely(!data)))
>> +               return -EINVAL;
>>
>>         requesttype = 0x01;/* read_in */
>>
>>         wvalue = (u16)(addr & 0x0000ffff);
>>         len = 4;
>>
>> -       usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
>> +       res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
>> +       if (res < 0) {
>> +               dev_err(dvobj_to_dev(pintfhdl->pintf_dev), "Failed to read 32 bytes: %d\n", res);
>> +       } else {
>> +               /* Noone cares about positive return value */
>> +               *data = le32_to_cpu(tmp);
>> +               res = 0;
>> +       }
>>
>> -       return le32_to_cpu(data);
>> +       return res;
>>  }
> 
> Dear Pavel,
> 
> OK, found the issue with decoded stack trace after reviewing this
> usb_read32 function. Your line:
> res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> 
> should read:
> res = usbctrl_vendorreq(pintfhdl, wvalue, &tmp, len, requesttype);
> 
> With this change, the driver runs fine with no crashes/oopses. I will
> explain the issue but you can probably see already, so I hope I'm not
> coming across as patronising, just trying to be helpful :-)
> 
> Essentially, you are taking the address of the data function parameter
> on this line with &data, a pointer to u32, which is giving you a
> pointer to a pointer to u32 (u32 **) for this function parameter
> variable. When passed to usbctrl_vendorreq, it is being passed to
> memcpy inside this function as a void *, meaning that memcpy
> subsequently overwrites the value of the memory address inside data to
> point to a different location, which is problem when it is later
> deferenced at:
> *data = le32_to_cpu(tmp);
> causing the OOPS
> 

The most strange thing is why gcc didn't complain about different 
pointer types... I think, that gcc must complain about this type of not 
explicit casts, because 99% it's a bug.


Again big thanks for analysis :)



With regards,
Pavel Skripkin
