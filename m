Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD3B3F535B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 00:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhHWW1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 18:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbhHWW1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:27:06 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC895C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:26:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id e1so4095353plt.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZNGdMlG+N2F/IFNczPVZ4FDm0Rsfwtl+ur4Eoayiuw=;
        b=Xv6FCGkkowBVANvt56d+uvTNVcdQhDVlnio7+/Ibl3pc0kRCPs+kN9gzVgcEJswYs/
         nI3uJOZshij44VgS2lSW6WyVL9zP9s4E2E8nuRV3BCsb2+pbpFmIk151uwoxMhJz3eid
         n2dz9bZVML2CyFdu4lKWS1fiS+J/c9Q4t7SDRsQOLNKqnTuZl2siH3jfWmtZlU5TMNl5
         P85tUDqRTNxq9wS9QJXAevOmj//FTh2L2KzARLPzwpfi1loFsDFfCWcA9V3LdObA0RT6
         H7OwbiXaSvurIxf/RmQZvSzIFa9shPeGeC2KxBhOjkOOynaAuze/lOlAdv3n3Hr/9a+T
         HqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZNGdMlG+N2F/IFNczPVZ4FDm0Rsfwtl+ur4Eoayiuw=;
        b=IWqGvXD0voMyZBBQNLvc8K5bV/kc82xXzSD5W+7SJorRM7lWHzfJhsjGkdL+uzRt1M
         zQ+FEm3wZlN5pTln6ZJ6gPXdv0T7muHWuxW3kx6m7L+zlzMbJrrFU4seXRMaM3dpTEPc
         s/7+suhNHMiaSlW08/+h6C8bG7UFdqoduhzoqAmqBj4PiTFT37QHDZBxFzgpTPI74dak
         o9foJanNbUvq8JSDYJx8ggA7KvGW2O552nUtn/8vQKS0EMRMYVttPYqXKG+hV04UlIhU
         TFYl6R8H2T4E/l+4BmOwuItN/kEapLOrHephbbM1NCxiS7MFIBG0PP9FpkImbnhA+JXo
         ALrA==
X-Gm-Message-State: AOAM531drVAMPdAORmNdDV5lx+GeM/uIG3qvFgDT6eyxPZZhjFfxvdyf
        jlifiLoHz8rxE2yr73mEV2Kn70Qge5FjJ71/0dvhbA==
X-Google-Smtp-Source: ABdhPJxFLxUqiUkg839eVAbTxEMd4XC+Uh2NRtHSkFsIt/cX3EZyjx2J5BrEy94Qu3jrjQBmADWbEqvXk+huv3ji7kQ=
X-Received: by 2002:a17:902:f704:b029:11a:cdee:490 with SMTP id
 h4-20020a170902f704b029011acdee0490mr30538437plo.37.1629757582266; Mon, 23
 Aug 2021 15:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210823184059.19742-1-paskripkin@gmail.com> <CAA=Fs0mW_4aVNYuLkZMS9ov0CPNKfPB7C=FS2z67Ui+hEvtaRA@mail.gmail.com>
 <262ccda0-0aed-26e9-0585-e5376db86596@gmail.com>
In-Reply-To: <262ccda0-0aed-26e9-0585-e5376db86596@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 23 Aug 2021 23:26:11 +0100
Message-ID: <CAA=Fs0=wWdTXgxg9dOm-UBG7VEtmiTOZXfboK5bt0pZvTVVG5w@mail.gmail.com>
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

Sorry, it also occurred to me after sending it would be better to have
mentioned this as a reply to that patch series rather than to this
e-mail. Apologies if I've confused anyone. Anyhow, I shall report my
findings on that e-mail thread.

Regards,
Phil
