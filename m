Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B773E91CD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhHKMq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:46:56 -0400
Received: from mail1.perex.cz ([77.48.224.245]:59286 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229794AbhHKMqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:46:54 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 0C0D7A003F;
        Wed, 11 Aug 2021 14:46:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 0C0D7A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1628685987; bh=QXZXgljJCtdu7MBw+Qb9Nfz9/Rx2MXlzqn/ktvGvLiQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=wjTLgYX6bmNoLoLnZf78Uz9yjiBaMYm7mn4usY8QEGYxtqfHZNaWk5xXcyX5XRgo0
         dQTTdVOrsLxxg60JGtUjYKMUphIZfLCafF7id8r++9NC00OclJAFndtgkPj8AhsW61
         Jz2D8EvntPO9Q/2upjFAufkBxFb31YCUi+mf3CDA=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Wed, 11 Aug 2021 14:46:20 +0200 (CEST)
Subject: Re: USB-Audio: Device or resource busy (strace log)
To:     Muni Sekhar <munisekharrms@gmail.com>,
        alsa-devel <alsa-devel@alsa-project.org>,
        linux-usb@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
References: <CAHhAz+hQBnUVWBnoQO6y44C-G5CnZdFLJ7v738_Y5Rt6AZSkrA@mail.gmail.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <41bebccc-7940-8379-0108-047bd1cc92f9@perex.cz>
Date:   Wed, 11 Aug 2021 14:46:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHhAz+hQBnUVWBnoQO6y44C-G5CnZdFLJ7v738_Y5Rt6AZSkrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 08. 21 14:36, Muni Sekhar wrote:
> Hi All,
> 
> $ cat /proc/asound/cards
>  0 [USB            ]: USB-Audio - Plantronics .Audio 628 USB
>                       Plantronics Plantronics .Audio 628 USB at
> usb-0000:00:14.0-2, full speed
> 
> I am using a Plantronics USB Audio headset.
> 
> $ arecord --device hw:0,0 --channels 2 --format S16_LE --rate 44100Hz x.wav
> arecord: main:722: audio open error: Device or resource busy
> 
> 
> 'arecord' command always fails the first time after system boot in my
> system. But subsequent execution of the 'arecord' command runs fine.
> 
> 
> I've attached the strace log for the "audio open error: Device or
> resource busy" failure. Is there any fix available for this issue?

You may check which other task blocks the PCM device:

  lsof /dev/snd/pcmC0D0c

I guess that it will be pulseaudio (device enumeration).

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
