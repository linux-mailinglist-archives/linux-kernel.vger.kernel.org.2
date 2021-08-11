Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7113E918E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhHKMfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhHKMez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:34:55 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7483C0617A2;
        Wed, 11 Aug 2021 05:34:31 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id x7so4281655ljn.10;
        Wed, 11 Aug 2021 05:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=K9DpAgAnqxctyg4iaJo9mqnhzEJ5oKvSm6u/94Ov1yA=;
        b=ZRIuqf+6LM6KdfsSSjraUybCR6jhHjLqDQpSn7xIO9yjwZr2fubJupLvo4GZYVSC+P
         PHSVc7LGUeLAJvq305BQxnx0zVjVvnYMSqI9ioC7MPS16pq0DY+9YnXPrNoA5AG12pzJ
         LgbT+FBN7NNVQJb7ICIjZXIw35q3Mszfy/JbqKPjYAxZiInGJE8ESV3Aj0F3boGHZWpx
         Bwo1j4Bzu+nTzH5VPW7/VfV8nanVJEL8fLvihnA4tvPJHJcaSaiZhDXEBVhv5n236w4+
         RhHfhvouBvUNs6624gP7m6pBII4lXaKO/xcthf1lxd5ehJfP5M8ltvjxQuJazhqh7qNv
         E50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=K9DpAgAnqxctyg4iaJo9mqnhzEJ5oKvSm6u/94Ov1yA=;
        b=cJK9W37OC39iEgvQvvUadfGrnkE3BTG4Sf7kv6dP7h4T03/loWc1uYDoNZGot55ePv
         hPumrZKVNM3piHsnBpoL7Husk7pGWJX0pcoH1wmGv5VdNmbdheTRBuqOxGrWkkB8HKmO
         NR9NdOT/klCGudHDbtWfGcyScPDn372DXi5GecOLWGhzJ47njaQu250Y9et1yDsVe0F2
         okxUR2/yr5NXdlNC7OzxsBbfbEFX2X/TpHUa/LMXwV3s2fqfnFBoKvFAKWChEUTBAYeW
         lg8P/2maDARSL1i1JDK2Ngc97RivXivVLk3afdnNubq3XBAwp8u+ZFwBknRtPezeTpGF
         5qlA==
X-Gm-Message-State: AOAM531IhkxcJHBuS7/n3djyp7S5F27e9zWaChxqUoSm8I0uFQ4GtF0H
        zo5H+9ZH/fgN+QQohzsGFgZWZYelFTBbwPyZnQA9PtKOdRw=
X-Google-Smtp-Source: ABdhPJwc11vu//JpjbWm8gdvehISxVfavnwrQtgO73mGuFN5KpY+qWgqnTROg/oCvj6P3+R46Ai50erZcXzcEmXsmvQ=
X-Received: by 2002:a2e:3206:: with SMTP id y6mr8086833ljy.187.1628685270124;
 Wed, 11 Aug 2021 05:34:30 -0700 (PDT)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Wed, 11 Aug 2021 18:04:18 +0530
Message-ID: <CAHhAz+iRiLjG+=xMDoZiqZzqn9fO1ZHk4ZtawCkWZ-TyH8forA@mail.gmail.com>
Subject: USB-Audio: Device or resource busy
To:     alsa-devel <alsa-devel@alsa-project.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-usb@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

$ cat /proc/asound/cards
 0 [USB            ]: USB-Audio - Plantronics .Audio 628 USB
                      Plantronics Plantronics .Audio 628 USB at
usb-0000:00:14.0-2, full speed

I am using a Plantronics USB Audio headset.

$ arecord --device hw:0,0 --channels 2 --format S16_LE --rate 44100Hz x.wav
arecord: main:722: audio open error: Device or resource busy


'arecord' command always fails the first time after system boot in my
system. But subsequent execution of the 'arecord' command runs fine.


I've attached the strace log for the "audio open error: Device or
resource busy" failure. Is there any fix available for this issue?


-- 
Thanks,
Sekhar
