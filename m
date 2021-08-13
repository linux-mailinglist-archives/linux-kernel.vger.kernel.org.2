Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA4A3EBA0A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 18:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbhHMQaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 12:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhHMQaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 12:30:10 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EF8C061756;
        Fri, 13 Aug 2021 09:29:43 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id n7so16506940ljq.0;
        Fri, 13 Aug 2021 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lSjANMOkeDV/0UvMiD3d/wgPXF81D4gziwyjM+awd5c=;
        b=Oquwslrv0iZO0iE4+rg2oqrPU9W7lCXWmZo8U1byMsIeJqu7KOK/WmqadDlVomPZ3Z
         NUvTbj8Mlso65qDPO523wiGbXwH/sTgFXJuqIb5kplbAz3s69wJ+TaHPXpZIjy9OiSvF
         8lcu89HaYJwEEO75RNV4jgueP7YS/2YdnToXR2fgEUuVQKWBgAqS8E7vYjsgRXXi0lla
         Bj5frT1giO08YsBWMmdsCsdRHBZgSvZeoMmKFckysmdWn6nIySXuIGQo7/RN/Kt++rFJ
         BG8GLADvjfgqW0wrFovbCeq4if/pFdveRNZYNlMnOYhaLvKnad1eSvf91x87zaweD6Gn
         RLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lSjANMOkeDV/0UvMiD3d/wgPXF81D4gziwyjM+awd5c=;
        b=pjgFUuLH2vwcqKfIXPZrsqulEX2FuhkUQoIR4IRcYsem8ISInBDzTP9QkJ0CEnO/dw
         KPQ2Itj93i7G5pUWRLEnnjY01F9j1BHsO6rtspGqTbXyc56NAXjwhwcXfAXTP9aRw67s
         qbZfXjs9wJP2zN6W1arjQOPenqDtXe8DZ/iy4qv231ufQfnLyJjumsq8Kl7BXnQFFzdk
         g7EW45jI3W7Mtl29NEnoy1iVH8zx7yLyEKbHH1KM/QHlddkHURL4gYGGF2zsgio/9YHl
         JuACD3bLvKg/XE7WZa4ib1uj6ssR8k5N+eEvklsAzOFvjdnJBLgOC38Z36WDXyau7HhC
         5NMA==
X-Gm-Message-State: AOAM5336oHowoR0mAsBx/3kdMChYMBkQRtE3KokHK3CxiEPbvWjk02Z3
        4ao/mMwq3Zx/oulbka9+WQkH02ubV8i5s/ZU/jc=
X-Google-Smtp-Source: ABdhPJw7IU0i3kJszwAd/r6LZDHpmqyuenklMvUuyjDAEcVXEQ5w6NynYbqNk6S0sprJyfm2fRUjHi3oxxQANr8xgoc=
X-Received: by 2002:a2e:3607:: with SMTP id d7mr2452450lja.481.1628872181924;
 Fri, 13 Aug 2021 09:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhAz+hQBnUVWBnoQO6y44C-G5CnZdFLJ7v738_Y5Rt6AZSkrA@mail.gmail.com>
 <41bebccc-7940-8379-0108-047bd1cc92f9@perex.cz> <CACk2A5ZcrVTv4AVHdmRDh-xWkx=1BHi6SV8yYqX1Z2DzcDR8hA@mail.gmail.com>
 <CAHhAz+gD-UtvXgsWnWx8yPwMbpY4R-ZJqPg9TNNF+iZrmKxQSA@mail.gmail.com>
In-Reply-To: <CAHhAz+gD-UtvXgsWnWx8yPwMbpY4R-ZJqPg9TNNF+iZrmKxQSA@mail.gmail.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Fri, 13 Aug 2021 21:59:30 +0530
Message-ID: <CAHhAz+jVm6_B8Fje5TafKFFXk9x801z07afivsfHw7tWp4eB=w@mail.gmail.com>
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

On Wed, Aug 11, 2021 at 6:48 PM Muni Sekhar <munisekharrms@gmail.com> wrote:
>
> On Wed, Aug 11, 2021 at 6:19 PM vishnu <vardhanraj4143@gmail.com> wrote:
> >
> > can you paste output of
> > arecord -l (list of capture devices).
> $ arecord -l
> **** List of CAPTURE Hardware Devices ****
> card 0: USB [Plantronics .Audio 628 USB], device 0: USB Audio [USB Audio]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
>
>
> > Which device you are using and os.
> > Does this instance is already open by default? like any video playing or something like that?
> lsof does not catch it.
>
> >
> > Yes you can stop pulse audio and try..
> >
> > On Wed, Aug 11, 2021 at 6:17 PM Jaroslav Kysela <perex@perex.cz> wrote:
> >>
> >> On 11. 08. 21 14:36, Muni Sekhar wrote:
> >> > Hi All,
> >> >
> >> > $ cat /proc/asound/cards
> >> >  0 [USB            ]: USB-Audio - Plantronics .Audio 628 USB
> >> >                       Plantronics Plantronics .Audio 628 USB at
> >> > usb-0000:00:14.0-2, full speed
> >> >
> >> > I am using a Plantronics USB Audio headset.
> >> >
> >> > $ arecord --device hw:0,0 --channels 2 --format S16_LE --rate 44100Hz x.wav
> >> > arecord: main:722: audio open error: Device or resource busy
> >> >
> >> >
> >> > 'arecord' command always fails the first time after system boot in my
> >> > system. But subsequent execution of the 'arecord' command runs fine.
> >> >
> >> >
> >> > I've attached the strace log for the "audio open error: Device or
> >> > resource busy" failure. Is there any fix available for this issue?
> >>
> >> You may check which other task blocks the PCM device:
> >>
> >>   lsof /dev/snd/pcmC0D0c
> It does not output any process.
> $ lsof /dev/snd/pcmC0D0c
>
> 1st run:
> ----------
> $ arecord --device hw:0,0 --channels 2 --format S16_LE --rate 44100Hz x.wav
> arecord: main:722: audio open error: Device or resource busy
>
> 2nd run:
> ----------
> $ arecord --device hw:0,0 --channels 2 --format S16_LE --rate 44100Hz x.wav
> Recording WAVE 'x.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> ^CAborted by signal Interrupt...
>
>
> >>
> >> I guess that it will be pulseaudio (device enumeration).
I see that pulseaudio is getting loaded on invoking the 1st run of
'arecord' command. Here is the log:

After system boot I verified that pulseaudio is not in the memory.

test@test594:~$ uptime
 21:39:27 up 0 min,  1 user,  load average: 0.70, 0.25, 0.09
test@test594:~$ ls -ltr /dev/snd/controlC1
crw-rw---- 1 root audio 116, 2 Aug 13 21:38 /dev/snd/controlC1
test@test594:~$ ls -ltr /dev/snd/
total 0
crw-rw---- 1 root audio 116, 33 Aug 13 21:38 timer
crw-rw---- 1 root audio 116,  1 Aug 13 21:38 seq
crw-rw---- 1 root audio 116,  3 Aug 13 21:38 pcmC1D0p
crw-rw---- 1 root audio 116,  4 Aug 13 21:38 pcmC1D0c
crw-rw---- 1 root audio 116,  2 Aug 13 21:38 controlC1
drwxr-xr-x 2 root root       60 Aug 13 21:38 by-path
drwxr-xr-x 2 root root       60 Aug 13 21:38 by-id
test@test594:~$ lsof /dev/snd/controlC1
test@test594:~$ lsof /dev/snd/pcmC1D0c
test@test594:~$


1st run of 'arecord':
-------------------------
I triggered 'arecord' after 2 mins of the system boot. In the 1st run,
it failed with "Device or resource busy" and I see that pulseaudio
loaded in the memory.
Why does pulseaudio get triggered on running the alsa-utils command?
How is the failure message "Device or resource busy" from the kernel code?


test@test594:~$ arecord --device hw:1,0 --channels 2 --format S16_LE
--rate 44100Hz x.wav
arecord: main:722: audio open error: Device or resource busy
test@test594:~$
test@test594:~$ lsof /dev/snd/pcmC1D0c
COMMAND    PID   USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
pulseaudi 1550 test  mem    CHR  116,4           463 /dev/snd/pcmC1D0c
pulseaudi 1550 test   27u   CHR  116,4      0t0  463 /dev/snd/pcmC1D0c
test@test594:~$ lsof /dev/snd/controlC1
COMMAND    PID   USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
pulseaudi 1550 test   20u   CHR  116,2      0t0  461 /dev/snd/controlC1
pulseaudi 1550 test   26u   CHR  116,2      0t0  461 /dev/snd/controlC1
test@test594:~$ lsof /dev/snd/pcmC1D0p
test@test594:~$
test@test594:~$ uptime
 21:41:06 up 2 min,  1 user,  load average: 0.20, 0.19, 0.08


2nd run of 'arecord':
-------------------------
The subsequent run of arecord runs fine without any issues even though
pulseaudio is still in memory.

test@test594:~$ arecord --device hw:1,0 --channels 2 --format S16_LE
--rate 44100Hz x.wav
Recording WAVE 'x.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
^CAborted by signal Interrupt...
test@test594:~$ uptime
 21:41:22 up 2 min,  1 user,  load average: 0.14, 0.18, 0.08
test@test594:~$

What is the role of pulseaudio? Is there a way to disable it from running it?
Disabling pulseaudio causes any issues while testing audio drivers?


> >>
> >>                                         Jaroslav
> >>
> >> --
> >> Jaroslav Kysela <perex@perex.cz>
> >> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
>
>
>
> --
> Thanks,
> Sekhar



-- 
Thanks,
Sekhar
