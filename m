Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322C23E926B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhHKNTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhHKNTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:19:06 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0272EC061765;
        Wed, 11 Aug 2021 06:18:43 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d4so5613827lfk.9;
        Wed, 11 Aug 2021 06:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6kHCOipcjZXWmpo3HZhEMRyqVY8BxVQo5dObADAmxsY=;
        b=mlZycOyDjS0LQHewOGJq54kzmcwWqvlJVNq11HE5HgNAzxkBrMYxLhx+4ouRpKp8fX
         dCBUxUPha/98WxKo2m/kZHIp0jFUo+b8T+HNc5N7gOlbpPyj779HMso9ZAb4ykmsLc+B
         LF8ee8YH8QRD3wLC2E5gOr9txV/ixiMN4SwE4+3XIn5mHcA/Umw5LaK3UE1G6zOfNKO8
         UAPKRyydUzFdxdtdN8ClwtCOFlwn7pR/axz9eLSTXTIBMUZbwLHwcwXnNq6+1LBVcNkP
         71vzTwzM4rGYnJc5DA0cqZ1sw5XSxXFqd1OKzfk4hhswjQBur8iQLXwv9ArNoZppjHEZ
         PRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6kHCOipcjZXWmpo3HZhEMRyqVY8BxVQo5dObADAmxsY=;
        b=PB+Afdm3xiCoBjuZvTQypqE/TWjP11RjOhv4LHo/q/eX104UMoQjSBu+mbx+zBL8C1
         iJ/6K/Ut7MU0dh6GNBJCBUJPZQOmhygcvOeJK7DH8JOsjK15gw3kjdCr4FycgHtQC80q
         MhkBMnJYBp86pSCbm9sS6BmdqcuOGv8gLfFTrxeQQh/oLDz9nxu4Fmo2yZ0xNEu9BcTG
         x9UPnR0GPTADlySfZ4gQYfspz9p2TEXfVotHyYVo+gmOxttYnMzqq16Z7yWXVlxg1eNp
         uRgEXs7GWFKYREYfPX/LGftLlkjuI8QctnfLrBMa7WQlSCbdCdB5mIx2E+j4kbHRgZ6N
         5bdA==
X-Gm-Message-State: AOAM532jbTxSnu4eV2ThkLB5UCGe3IEQt5Or5r27pWZVejMpFvpsnd6s
        rLDwZrhVSylOgPuh8iSmHt829t9VycsdvIqWMKE=
X-Google-Smtp-Source: ABdhPJziB6KFxpa67eSH3zBrs9TUw30rTGO3+bApDge1fl9VbSihlN0yFZCa8fXe2RjD+T3fyNYskaBLbsPaaX3JXw8=
X-Received: by 2002:ac2:4205:: with SMTP id y5mr6953636lfh.512.1628687921400;
 Wed, 11 Aug 2021 06:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhAz+hQBnUVWBnoQO6y44C-G5CnZdFLJ7v738_Y5Rt6AZSkrA@mail.gmail.com>
 <41bebccc-7940-8379-0108-047bd1cc92f9@perex.cz> <CACk2A5ZcrVTv4AVHdmRDh-xWkx=1BHi6SV8yYqX1Z2DzcDR8hA@mail.gmail.com>
In-Reply-To: <CACk2A5ZcrVTv4AVHdmRDh-xWkx=1BHi6SV8yYqX1Z2DzcDR8hA@mail.gmail.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Wed, 11 Aug 2021 18:48:29 +0530
Message-ID: <CAHhAz+gD-UtvXgsWnWx8yPwMbpY4R-ZJqPg9TNNF+iZrmKxQSA@mail.gmail.com>
Subject: Re: USB-Audio: Device or resource busy (strace log)
To:     vishnu <vardhanraj4143@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        alsa-devel <alsa-devel@alsa-project.org>,
        linux-usb@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 6:19 PM vishnu <vardhanraj4143@gmail.com> wrote:
>
> can you paste output of
> arecord -l (list of capture devices).
$ arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: USB [Plantronics .Audio 628 USB], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


> Which device you are using and os.
> Does this instance is already open by default? like any video playing or something like that?
lsof does not catch it.

>
> Yes you can stop pulse audio and try..
>
> On Wed, Aug 11, 2021 at 6:17 PM Jaroslav Kysela <perex@perex.cz> wrote:
>>
>> On 11. 08. 21 14:36, Muni Sekhar wrote:
>> > Hi All,
>> >
>> > $ cat /proc/asound/cards
>> >  0 [USB            ]: USB-Audio - Plantronics .Audio 628 USB
>> >                       Plantronics Plantronics .Audio 628 USB at
>> > usb-0000:00:14.0-2, full speed
>> >
>> > I am using a Plantronics USB Audio headset.
>> >
>> > $ arecord --device hw:0,0 --channels 2 --format S16_LE --rate 44100Hz x.wav
>> > arecord: main:722: audio open error: Device or resource busy
>> >
>> >
>> > 'arecord' command always fails the first time after system boot in my
>> > system. But subsequent execution of the 'arecord' command runs fine.
>> >
>> >
>> > I've attached the strace log for the "audio open error: Device or
>> > resource busy" failure. Is there any fix available for this issue?
>>
>> You may check which other task blocks the PCM device:
>>
>>   lsof /dev/snd/pcmC0D0c
It does not output any process.
$ lsof /dev/snd/pcmC0D0c

1st run:
----------
$ arecord --device hw:0,0 --channels 2 --format S16_LE --rate 44100Hz x.wav
arecord: main:722: audio open error: Device or resource busy

2nd run:
----------
$ arecord --device hw:0,0 --channels 2 --format S16_LE --rate 44100Hz x.wav
Recording WAVE 'x.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
^CAborted by signal Interrupt...


>>
>> I guess that it will be pulseaudio (device enumeration).
>>
>>                                         Jaroslav
>>
>> --
>> Jaroslav Kysela <perex@perex.cz>
>> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.



-- 
Thanks,
Sekhar
