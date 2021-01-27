Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1817130645C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344508AbhA0Tkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344539AbhA0Tfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:35:48 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760EBC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:35:07 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id u14so2464880wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jEwuMp7A3WWSP0TnGIOE+Ahd5LOZUBmATUawOOig7sk=;
        b=JK2IbSZqz64q13wnxXmAH1Vmz22VHQQmRhPdVmljoGkYCqBcKtE/B32QsY+KDm2Km9
         jYjS7R1FnduEXDThiIM7t+g78LUbqrlcJIZZ84CqXuzL8Rbzlt2qrjvUj0vih0HhiZdQ
         bHbSYMEy0/SJxPWmStMn6OG9C+gdVXlsoUUsCbpCng7iBjuPquOTwRwQt6HFkYJWpI3R
         tm7Nhb1eVqtZtOd6vcO/eHe6MDWmwYmidrCwy4wMUid3ybk+np8qenVq5NPmSSEdExEN
         H3Iv+k2qe3hc05A4/7lmhQ5iV0C8HEI4atIg2/TCjtH/g/g1je/iLqhabq6o5Z+pCtke
         Vi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jEwuMp7A3WWSP0TnGIOE+Ahd5LOZUBmATUawOOig7sk=;
        b=WKZovEkQUqhMlxPF0FXW6p23edLtbncr51W17dX5+1Y4egSVzGVzu4bE8RGiAXKnDk
         uAD8n4mDfW01oC0keYKi3v24qIFib9+bwp0n6tMPb8RHskJblWckm3prCicnfaHeVBVP
         AWq2YCw01Ekrw4Wt2nAVGZ62NnKhl+OWuXFYQck4y5UUyLc9BWcKfjXx5bG84CS9O0/u
         KjZjmJLVOWBmpTssEKAsvaSfG/x2HJVOtCtSbiWsFAo3Hz/z1LUH/Kg3vSFI5HJyo5kc
         cPKaDcpQycnb/vXUZCQ+GY4bCeWaUfOKEVmTIuK1VS963so/u8GuRUrjfJ83HWSVICbt
         tn7g==
X-Gm-Message-State: AOAM533+06BGQaw+z8TFy2n9kijusY3NWF5DSLUHAp22WHQDSOjFWpiQ
        /zv0VU/zA/86FSvOsIwIe00=
X-Google-Smtp-Source: ABdhPJzlyHF/1STEzyL61ZWCYbfEDyDDr3rSB3vhrqgH6oMFMlflTawSkO671nU70AqKAwkTeolEPA==
X-Received: by 2002:a1c:f70c:: with SMTP id v12mr5438768wmh.77.1611776106132;
        Wed, 27 Jan 2021 11:35:06 -0800 (PST)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id q9sm3940047wme.18.2021.01.27.11.35.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 11:35:05 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [PATCH] drm/lima: add governor data with pre-defined thresholds
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <88ae6467-07fc-2c4e-9db9-a02a00d01347@arm.com>
Date:   Wed, 27 Jan 2021 23:35:01 +0400
Cc:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Steven Price <steven.price@arm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <08B992A3-6A8C-4585-8B0D-EE0DA6C5F4E2@gmail.com>
References: <20210125081804.13016-1-christianshewitt@gmail.com>
 <9e30a8e1-ef69-5929-17f1-cdb603686495@arm.com>
 <88ae6467-07fc-2c4e-9db9-a02a00d01347@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
X-Mailer: Apple Mail (2.3445.104.17)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 27 Jan 2021, at 3:11 pm, Lukasz Luba <lukasz.luba@arm.com> wrote:
>=20
> On 1/27/21 10:24 AM, Lukasz Luba wrote:
>> Hi Christian,
>> On 1/25/21 8:18 AM, Christian Hewitt wrote:
>>> This patch adapts the panfrost pre-defined thresholds change [0] to =
the
>>> lima driver to improve real-world performance. The upthreshold value =
has
>>> been set to ramp GPU frequency to max freq faster (compared to =
panfrost)
>>> to compensate for the lower overall performance of utgard devices.
>>>=20
>>> [0] =
https://patchwork.kernel.org/project/dri-devel/patch/20210121170445.19761-=
1-lukasz.luba@arm.com/=20
>>>=20
>>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>>> ---
>>> I have been using Kodi as my test application. If you scroll in =
library
>>> views with hundreds of list items and the panfrost values the slow =
GPU
>>> ramp up is quite noticeable and the GUI feels sluggish. As =
everything
>>> lima runs on is inherently slower than panfrost using devices I =
believe
>>> it's better to ramp up to max freq quicker.
>> It's quite low value for the upthreshold, but I believe you have
>> experimented and observed that a bit higher (30, 40?) don't work =
well.
>> I don't know the Kodi system, though.
>> You can check if the other frequencies are also used in statistics =
for
>> devfreq device:
>> cat /sys/class/devfreq/<your_gpu>/trans_stats
>> If they are also used, then it OK (better than stuck at min freq).
>=20
> I've just realized that your board might suffer a another issue.
> Please apply this patch [1] and run your experiments with =
upthresholds.
>=20
> [1] =
https://lore.kernel.org/lkml/20210127105121.20345-1-lukasz.luba@arm.com/

I=E2=80=99ve included the patch and with unscientific testing it feels =
snappier with a larger value than
before. I did revert back to 45 first, but again this feels sluggish =
when navigating around the
Kodi GUI. My main test is to enter =E2=80=98Movies=E2=80=99 in Kodi then =
start scrolling in a long list. When
the GPU ramps up quickly the experience is snappy, but when it ramps =
more conservatively
scrolling feels like it stutters, then (once you hit max freq) it =
becomes fluid.

WP2:~ # cat /sys/class/devfreq/d00c0000.gpu/trans_stat=20
     =46rom  :   To
           : 125000000 250000000 285714285 400000000 500000000 666666666 =
744000000   time(ms)
* 125000000:         0         0         0         0         0         0 =
      264     52720
  250000000:         9         0         0         0         0         0 =
       36      3404
  285714285:         9         3         0         0         0         0 =
       32      2628
  400000000:        18        20        13         0         0         0 =
      191     21140
  500000000:        12        12         8        63         0         0 =
       31     10068
  666666666:       179         5        16       133        66         0 =
       24     29360
  744000000:        37         5         7        46        60       423 =
        0     46016

I=E2=80=99ll send v2 with the value set to 30.

Christian=
