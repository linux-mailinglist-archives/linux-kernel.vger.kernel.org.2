Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEA434C3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 08:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhC2GYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 02:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhC2GYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 02:24:04 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE035C061574
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 23:24:03 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s21so5517603pjq.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 23:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tc2Kknjut/IrmaznDTOGIf9yHSgf/06kpGrK3dp0fQI=;
        b=B4tS7pmj/YlxOPQ7QsMTNS1YBIShzXiBS5QgIvnrsTRLYj5lv9mTMnWc1jEklHP4wP
         0Ch2/9Asptf4VFDwbDLrlbq1tMOnxWFvfwNUnMCTSKGneR//RhL3efFEGKQ9D7DkD5mD
         KnBBsRxfbITYoYfHVnHHP6txI0dVix3KYD0cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tc2Kknjut/IrmaznDTOGIf9yHSgf/06kpGrK3dp0fQI=;
        b=ugPaXU2OgepUTxEdzM4Tz2uIS/IkHPfWxuHUNZyiniIalND86JIuQROYKf90qKpxLr
         k0br4XpKiQd9xTXy+rQrbZl/ZMSS+ycgYgFzzcmMoWFvAVSmmX9eTLKp9ZJ4O2sWzdBl
         8JPgFejllpHwOeHx8xfnw6EFob328x0msZ1xQ2dGw4tEa0npD5nn3v96AFOEJz3uQw9K
         uFLyrf+82LfhmwnbWXzceLgHvKNl8ZH/UM95fqWxL90VmbVt2Wvi9xg4ZbfAp09b0CIC
         iydsKUlE4q1z7qdRemRBWK2xZiM6p+oNKrVlwV+zw7LVh8sQpJFvFX7dRfy70QsdIb4h
         ilBg==
X-Gm-Message-State: AOAM532a8sORF014FaPianB4vlmRuCK5hJSK2bspfSEnoF7xwo5dUOJi
        OKgPcRWK65mHnay6WAH3LEf2t8fOoKA+4c+N5aYt+w==
X-Google-Smtp-Source: ABdhPJyrd5rM9LIBXCvfPpgsOB+tu/vSbVNplYf6y7i+M/ACB9YVhR28yyfh4uQipaZEu19YUF1rXqjXGbsjire+lVc=
X-Received: by 2002:a17:902:ea0d:b029:e6:f01d:9db5 with SMTP id
 s13-20020a170902ea0db02900e6f01d9db5mr26881495plg.60.1616999043358; Sun, 28
 Mar 2021 23:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210324105153.2322881-1-ikjn@chromium.org> <c21de867cf4ccbfcc8cf555c78dc70dd3a47dfe8.camel@infinera.com>
 <CAATdQgDrri-tMtu3AOFRcbGHfL6hONDfdMdZh45BusbdAoWfdw@mail.gmail.com> <s5ho8f8ogx8.wl-tiwai@suse.de>
In-Reply-To: <s5ho8f8ogx8.wl-tiwai@suse.de>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Mon, 29 Mar 2021 14:23:52 +0800
Message-ID: <CAATdQgAYrq7sHJQN=_5ipH0N_kbixjac=BLFCYv5jTScH_c+Lw@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Apply sample rate quirk to Logitech Connect
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>,
        Gregor Pintar <grpintar@gmail.com>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dylan Robinson <dylan_robinson@motu.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Olivia Mackintosh <livvy@base.nu>,
        Alexander Tsoy <alexander@tsoy.me>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 8:49 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 24 Mar 2021 13:03:14 +0100,
> Ikjoon Jang wrote:
> >
> > On Wed, Mar 24, 2021, 7:16 PM Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> > wrote:
> >
> >     On Wed, 2021-03-24 at 18:51 +0800, Ikjoon Jang wrote:
> >     > Logitech ConferenceCam Connect is a compound USB device with UVC and
> >     > UAC. Not 100% reproducible but sometimes it keeps responding STALL to
> >     > every control transfer once it receives get_freq request.
> >     >
> >     > This patch adds 046d:0x084c to a snd_usb_get_sample_rate_quirk list.
> >     >
> >     > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203419
> >     > Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> >
> >     Most Logitech USB headset I got needs a delay in snd_usb_ctl_msg_quirk()
> >     Have you tried to add say 20 ms delay in there?
> >
> > I didn't try that. But it sounds reasonable to me.
> >
> > let me try that quirk here. If that is the case, HID might need that delay
> > also. Logitech Group webcam had a similar problem on control xfer of
> > get_report from an another interface for HID.
>
> The Logitech devices with 046d:* should be covered generally in
> snd_usb_ctl_msg_quirk(), so I guess it's a different problem.
> But please check it first.
>
> > And 20ms can be too long if it's applied to every control transfer. I will
> > test the device with shorter delay if you didn't try it before.
>
> Actually the delay applied to Logitech devices is from 1 to 2ms, not
> 20ms.  The 20ms delay is applied for some other devices.  But if
> extending the delay fixes the problem, we need to reconsider the delay
> length.

I tested this Logitech device with various delays 2..20ms
in snd_usb_ctl_msg_quirk() but it didn't help.

Disregarding the delay between control transfers,
This device is always stuck at get_cur, responding STALL to all
control transfers.

[   24.045618] usb 1-1.2.1.1: 1:1: cannot get freq at ep 0x82
[   24.167475] usb 1-1.2.1.1: 2:0: cannot get min/max values for
control 2 (id 2)
[   24.287393] usb 1-1.2.1.1: 6:0: cannot get min/max values for
control 2 (id 6)
[   24.289854] usbcore: registered new interface driver snd-usb-audio
[   24.877073] usb 1-1.2.1.1: 2:1: usb_set_interface failed (-32)

And I've also found that in some other platforms (with the same kernel),
this device fails at get_freq - timeout with NYETs or NAKs (instead of STALL),
and succeeded in following set_interface even without any delays
I've tried but couldn't find any differences between the two. ;-(

So until now, I think this approach of skipping get_rate is the only
one possible
workaround for Logitech Connect.

>
>
> Takashi
