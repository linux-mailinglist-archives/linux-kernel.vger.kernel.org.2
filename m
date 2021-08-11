Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13413E8805
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 04:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhHKCb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 22:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhHKCb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:31:26 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28793C061765;
        Tue, 10 Aug 2021 19:31:03 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id x10so1664419iop.13;
        Tue, 10 Aug 2021 19:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/VW95x+7EdLKFOzbBR7pnvL0AfgEb+HfZES5j7zp3VY=;
        b=nIEa34fChNzJ7VtY3gLOG6+C3YfhVgHjkpgksW/5AOF2jGV5vT+Xtb5PCo46w7zM3Z
         w7pykX+sEG6UzH52fR+T7LnlG1bz+rsmClscu741HJlegA+sL8OXhUskJqUo3nWHtWnr
         7mX1jhg8q4tmv1HenAUsdOCfrRZH/IFy77WiZGj25E8Z2XLtD7gEdv4NoPQvwyTqa3C4
         QHggs0hQnXAG2Yk4hmaIP4KAkYsnaOZbY81Z07FPrMNWD1Dx9DvLusAtbTv0LCZoVtMw
         KT4MwxyA4PD8BE/lfZ1ECAorezLfeZkxjFGa4T1XpUJ2nFeEmF5f8speeqseUvfIia19
         m1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/VW95x+7EdLKFOzbBR7pnvL0AfgEb+HfZES5j7zp3VY=;
        b=XheNaV1IpLeBNgJb54T6PvhGDJ2G6namrlGOi2RWlvKcxRIf1VpefKY8VzqrG1pCoq
         ipKhaS8H2DUdLO9zBBxicRRVBgtfoTDwy42RMo2zEZKLzwxite8IY2avyF7hf5ImkI8R
         DbU/JZm1h6r/BWPaWQ4NxQUW4USHMPZg8rmc1F1sbmD3UdEVQMhmC1ILnF9xWyc5nwlu
         478Ig3w+J9ZoSXLSw36XruS05Wq+5Z+3O5kHvoK9REPO75DqSNcMZIloN5g4Sx9eiHYl
         usRoNABnUqiyEuBpPLSpGHwplImLlhMB/Q5Tq9/aMggb9Bm5Ni6USCj/dx1RWpSiLnhl
         N01Q==
X-Gm-Message-State: AOAM531F4xMDuvmSW9KKm6L+Z9PAmSLNBMGj5Y8dkWZ9N54jvsocDCcu
        AwmAs1FbNjY3C1SM4zUfbZg24JzVgaEDBDypndwjg1bv6BPJGw==
X-Google-Smtp-Source: ABdhPJx4MGWX6OfrMQ+W9oud+2SjTAU47kqdJ3YSlERK59yrJesyU+9eEyjzDChvlh0HkMZX8aqI6DuUOitBZWwzWos=
X-Received: by 2002:a5e:d508:: with SMTP id e8mr80175iom.101.1628649062509;
 Tue, 10 Aug 2021 19:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210721235526.10588-1-msbroadf@gmail.com> <7b02cb66-d672-ae95-01ea-c6015725e1ac@linuxfoundation.org>
 <CALdjXpA4_eXen6RjhsEBYt8CQs-2gzwYs9h9q0Z2LKZ=rXVp+Q@mail.gmail.com>
 <ad07410b-05d6-6a12-13df-14e31cbf50ff@linuxfoundation.org>
 <CALdjXpBPRraC8xxORgE3SXw4xFnTW-Y6rLbcS+Cx0xYq3+aBeQ@mail.gmail.com>
 <976d34c0-d603-1f16-edbd-ad6c8881ad4e@linuxfoundation.org>
 <CALdjXpAzE3o7Bwdvj1TvsBRpDWDe1FZ8LsmL5q0suxYnRJCOaA@mail.gmail.com>
 <5165bd84-11af-35dd-8a9b-11c7f219fb88@linuxfoundation.org>
 <CALdjXpCmx_nfYEguv9UvOrBMYFxB4sqwmNiV99ggHRZnZjiM-A@mail.gmail.com> <4f345afe-61d5-66b3-3252-562988c8926f@linuxfoundation.org>
In-Reply-To: <4f345afe-61d5-66b3-3252-562988c8926f@linuxfoundation.org>
From:   Michael <msbroadf@gmail.com>
Date:   Wed, 11 Aug 2021 12:30:51 +1000
Message-ID: <CALdjXpB+-RHMrjt10f1ZksR9VZMuT3gj7HyvrXYtdJ_jq0J93g@mail.gmail.com>
Subject: Re: [PATCH v2] vhci_hcd: USB port can get stuck in the disabled state
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 at 03:46, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 8/2/21 7:00 PM, Michael wrote:
> > On Tue, 3 Aug 2021 at 09:14, Shuah Khan <skhan@linuxfoundation.org> wrote:
> >>
> >> On 7/30/21 5:52 PM, Michael wrote:
> >>> Yes i think just adding the VDEV_ST_USED check in addition to the
> >>> VDEV_ST_NOT_ASSIGNED state is fine and would fix the issue.
> >>>
> >>
> >> Can you please confirm if this works?
> >>
> >>> After many years of writing virtualhere (a similar system to usb/ip
> >>> but cross-platform and different non-kernel way of doing it server
> >>> side) I've seen many drivers that issue reset at any time. Loading
> >>> firmware is usually the reason.  Also sometimes switching
> >>> configurations requires a reset also, for example some gaming wheels
> >>> do this. I don't think you should make this VDEV_ST_USED check
> >>> specific to Wifi devices, as a lot of devices don't follow too closely
> >>> to the USB protocol to begin with from my experience. They primarily
> >>> base their USB interactions assuming the windows platform and its
> >>> quirks.
> >>>
> >>
> >> When sending responses to Linux kernel mailing lists, please use bottom post.
> >> This check will be used for all drivers. We don't add checks for specific cases
> >> in the code.
> >>
> >> thanks,
> >> -- Shuah
> >>
> >
> > Yes it works with that change.
> >
>
> Would you like to send me a patch for this?
>
> thanks,
> -- Shuah

usbip: Allow port reset to occur when the port is also in the ST_USED state

 Signed-off-by: Michael <mail@virtualhere.com>
---
 drivers/usb/usbip/vhci_hcd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 4ba6bcdaa8e9..300131ae5897 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -456,7 +456,9 @@ static int vhci_hub_control(struct usb_hcd *hcd,
u16 typeReq, u16 wValue,
                        vhci_hcd->re_timeout = 0;

                        if (vhci_hcd->vdev[rhport].ud.status ==
-                           VDEV_ST_NOTASSIGNED) {
+                           VDEV_ST_NOTASSIGNED ||
+                               vhci_hcd->vdev[rhport].ud.status ==
+                               VDEV_ST_USED) {
                                usbip_dbg_vhci_rh(
                                        " enable rhport %d (status %u)\n",
                                        rhport,
--
2.30.2
