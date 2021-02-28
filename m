Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0A6326FFB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 02:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhB1Be7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 20:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhB1Bey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 20:34:54 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C432C061788
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 17:34:14 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id a13so14250780oid.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 17:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9boI14QwAlu2PcXuymg1QkXuG474SaB7CiYYGhNgj2c=;
        b=tvh7xqhUgz5mQDAogLiBbjs+YzStEV/wbzTtZIzF5ik5+ippftlk4dFoOs1Zf764Yy
         tXn7BCCbBSALRyuy2zHQ8vb6/JDtfreeCriGkqtQmlsozAOPVm8u39ZFHGzAGqhJhl4e
         TW4JDddwssvUIwQunCvbuydCuKaY8+iBg2QHcI5SQ0J/Oiz2cmtnhqEO7pas/G3DfRqQ
         rKFuhSI8xsKTJjF/R47iXnCNXLg2T6MaZG9DO+HCnBlhqCvRvDiAfUa7wpVyfpBmS37I
         7spV80R6g/oVeMeVMVs1YJGH0ikfXw0CQvstuJIfEFdttXNDQZXOczDiuDQpM6b2Bz9S
         +3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9boI14QwAlu2PcXuymg1QkXuG474SaB7CiYYGhNgj2c=;
        b=sMybaduaEM5K43ZZRjLuckNCuiI0ny7gXdRttQxv+10VpwX3sllTmLxgvX6YVGZkZR
         z75SuvVF+jk3QGjBxn+32cMA/u56SZ39n3p8O4ZxnmayZreatn4uxWR2xTNCLKgLqQNq
         gVFpOmheAsPQ5yiWM+QNUvgQ6Z1CcBfZ2xnvBcSOLbszt84Dzgx1CCWPoET0NTkCSq0I
         V6gIMYqbNX8rASn35xODUuc20HLCg1EsshYgG0Kf5/b+Cz40qMfggvID1q4Qz8mScllB
         B7hrdxdGPDmDs2ndwJ8i0hS/VdO7gtjVUPjJDHiZKLub+UDYTMbubM0BIFV/fECdzZuW
         wTsw==
X-Gm-Message-State: AOAM533cXFrD7NfVjRWsiv/v2JR2oMTutq1yvTrDkp8+rKzwmSZbuZDb
        4hIrsUwxRX3BPSiKr+mQttI=
X-Google-Smtp-Source: ABdhPJx/BXgyuYJLEHx+k84HgcbxKogu1POk7ibcSCIf0vWQ7tjH6vjDmGlzN0u9r8SXX2sQT1bB+g==
X-Received: by 2002:a05:6808:bd2:: with SMTP id o18mr6764307oik.7.1614476053955;
        Sat, 27 Feb 2021 17:34:13 -0800 (PST)
Received: from [192.168.35.124] ([69.149.214.238])
        by smtp.gmail.com with ESMTPSA id h11sm2639233ooj.36.2021.02.27.17.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Feb 2021 17:34:12 -0800 (PST)
Subject: Re: [PATCH] Input: Add "Share" button to Microsoft Xbox One
 controller.
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Ye <lzye@google.com>
Cc:     Chris Ye <linzhao.ye@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org,
        kernel-team@android.com
References: <20210225040032.684590-1-lzye@google.com>
 <YDcoduCkBjC8EM3F@google.com>
 <CAFFuddKYhOV8NY9vqrmzRNe0P_n0H+zzAMarV9iGc_qt=+40xg@mail.gmail.com>
 <YDdDFfMFFbuqvL43@google.com>
From:   Cameron Gutman <aicommander@gmail.com>
Message-ID: <7f35325d-efa4-4546-bfc7-7d2532cc25e1@gmail.com>
Date:   Sat, 27 Feb 2021 19:34:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDdDFfMFFbuqvL43@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/21 12:26 AM, Dmitry Torokhov wrote:
> On Wed, Feb 24, 2021 at 08:44:37PM -0800, Chris Ye wrote:
>> Hi Dmitry,
>> The latest Xbox One X series has this button, I can add a new
>> XTYPE_XBOXONE_X and only apply the change to the new type.
> 
> Sounds good to me. Cameron, what do you think?
> 

I'm not sure if some wires got crossed, but I see v2 uses MAP_SHARE_BUTTON
rather than a new XTYPE. I'm fine with either.

>> The controller supports bluetooth and the HID usage for this button is
>> consumer 0xB2:
>> 0x05, 0x0C,        //   Usage Page (Consumer)
>> 0x0A, 0xB2, 0x00,  //   Usage (Record)
> 
> I see, thank you.
> 

Regards,
Cameron

>>
>> Thanks!
>> Chris
>>
>> On Wed, Feb 24, 2021 at 8:33 PM Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>>>
>>> Hi Chris,
>>>
>>> On Thu, Feb 25, 2021 at 04:00:32AM +0000, Chris Ye wrote:
>>>> Add "Share" button input capability and input event mapping for
>>>> Microsoft Xbox One controller.
>>>> Fixed Microsoft Xbox One controller share button not working under USB
>>>> connection.
>>>>
>>>> Signed-off-by: Chris Ye <lzye@google.com>
>>>> ---
>>>>  drivers/input/joystick/xpad.c | 16 ++++++++++++++--
>>>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
>>>> index 9f0d07dcbf06..08c3e93ccb2f 100644
>>>> --- a/drivers/input/joystick/xpad.c
>>>> +++ b/drivers/input/joystick/xpad.c
>>>> @@ -368,6 +368,14 @@ static const signed short xpad360_btn[] = {  /* buttons for x360 controller */
>>>>       -1
>>>>  };
>>>>
>>>> +static const signed short xpad_xboxone_btn[] = {
>>>> +     /* buttons for xbox one controller */
>>>> +     BTN_TL, BTN_TR,         /* Button LB/RB */
>>>> +     BTN_MODE,               /* The big X button */
>>>> +     KEY_RECORD,             /* The share button */
>>>
>>> If I understand this correctly, not all Xbox One controllers have this
>>> new key. Is it possible to determine if it is present and only set
>>> capability for controllers that actually have it?
>>>
>>> Also, I am unsure if KEY_RECORD is the best keycode for this. It might,
>>> but does your controller supports bluetooth? What HID usage code does it
>>> send for this key?
>>>
>>> Thanks.
>>>
>>> --
>>> Dmitry
> 

