Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF343F5358
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 00:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhHWWYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 18:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbhHWWYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:24:23 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0CFC061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:23:40 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x16so16617989pfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u1W+36Qe3I+Zp/NI9r7n+8Xm3W8eBvWeztJ9wzJAYno=;
        b=lqQy/nFYAWJ2nHw5eYylGrErEh9yrufxrnuHFFH6+4+4OZKQra0rpfT20g56/cR5RL
         ieqT4T3VPU6XEKOIJr1PmossE0Il5B7XfNpBqK3NMQ9Ikd74FcQbdHKJVX4tgR7QUKQH
         lEZGTjy/ZbqwNVhjfE8FxNeKxExePa0/iHQFR8MHKGArfmRxhvu9ZbqaFFp537TL5G9E
         vpcgcwAdpbQafEzogw+x3xtQt8ixebdhLKE6EkfeWdrzphRLL9e4Ym3/iko0ywB4sq+H
         UEQlzKPIQ9qvEAibHW351wjj18LAv+uoLi1p23jb4PLw84W/Ach9qCK+kODMxfOa1wB2
         y/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u1W+36Qe3I+Zp/NI9r7n+8Xm3W8eBvWeztJ9wzJAYno=;
        b=qOyiWksAgnbYSCnnx052ugbs3jZgpJfzARJ+SwsUWYr7TmpZMGKxa276K7oVSJeD8f
         1gfPqezecwjiLn4omfjfgpaMRbuHBBEN7OVbeyuh6mWtfqoDAdrrxuKW4lD+D3s12xYQ
         eZVhpf/4w4H+8SF5REq0NWAIq2fBQSgFRPBEs3aapVjCPns4oyx6ro4eMpopuUOV77uv
         3kPysytwiEJS+Z6OIgWRcjWPYdwiL0lYccuLZbhtGJsWcqyHvcGzEv2Z+v5+hs9qHgZY
         ygdD/Js2w3eFMWyUd/AsGp/cpfFO8tLVRo8js49eMWPlCouFVw1ETPDWQSPbofnTWFJD
         LiIQ==
X-Gm-Message-State: AOAM5332FOKFt3LM/Rfd8YOrDHIBkz0kfNTrNQn1i3deiyAaTB1CodHc
        5bsJVZA9x4ROayVVF+i+IJTNCU+Pgrb+5Zh+SM9nQg==
X-Google-Smtp-Source: ABdhPJwto+nl0syuCMr0fAKFQeJ6rtX2kAqUHL1ydhcfdfJ982CiP7Q1+5MdAMUn63g8W+8YcBEAiS0lWqCKb8HcjbA=
X-Received: by 2002:a65:6a0a:: with SMTP id m10mr34151460pgu.82.1629757419847;
 Mon, 23 Aug 2021 15:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210823184059.19742-1-paskripkin@gmail.com> <CAA=Fs0mW_4aVNYuLkZMS9ov0CPNKfPB7C=FS2z67Ui+hEvtaRA@mail.gmail.com>
 <262ccda0-0aed-26e9-0585-e5376db86596@gmail.com>
In-Reply-To: <262ccda0-0aed-26e9-0585-e5376db86596@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 23 Aug 2021 23:23:29 +0100
Message-ID: <CAA=Fs0nVOfqX3+++wvsajUUy0qdfFKT4XZvOZPvdoaa2FAsNQg@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: make rtw_deinit_intf_priv return void
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 at 22:29, Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> On 8/24/21 12:20 AM, Phillip Potter wrote:
> > On Mon, 23 Aug 2021 at 19:41, Pavel Skripkin <paskripkin@gmail.com> wrote:
> >>
> >> rtw_deinit_intf_priv() always return success, so there is no need in
> >> return value
> >>
> >> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> >> ---
> >>  drivers/staging/r8188eu/os_dep/usb_intf.c | 5 +----
> >>  1 file changed, 1 insertion(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> >> index e002070f7fba..37694aa96d13 100644
> >> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> >> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> >> @@ -129,13 +129,10 @@ static u8 rtw_init_intf_priv(struct dvobj_priv *dvobj)
> >>         return rst;
> >>  }
> >>
> >> -static u8 rtw_deinit_intf_priv(struct dvobj_priv *dvobj)
> >> +static void rtw_deinit_intf_priv(struct dvobj_priv *dvobj)
> >>  {
> >> -       u8 rst = _SUCCESS;
> >> -
> >>         kfree(dvobj->usb_alloc_vendor_req_buf);
> >>         _rtw_mutex_free(&dvobj->usb_vendor_req_mutex);
> >> -       return rst;
> >>  }
> >>
> >>  static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
> >> --
> >> 2.32.0
> >>
> >
> > Dear Pavel,
> >
> > Looks good - going to test your RFC series now btw.
> >
>
> Thank you, Phillip!
>
>
> Testing this RFC is very important. If it's all ok with it, I am going
> to add proper error handling all across the driver code, based on read()
> errors :)
>
> Btw, we also can add error handling for write() operations, but I think
> it's not _very_ important, since driver won't misbehave in case of write
> failures
>
>
>
> With regards,
> Pavel Skripkin

Dear Pavel,

Happy to help :-)

Sorry to report, but your RFC series generates an OOPS on boot for me,
in usb_read32. Just doing a stack trace decode to figure out where
failure is and I will report back.

Regards,
Phil
