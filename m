Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02B144EFEA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 00:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhKLXGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 18:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhKLXGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 18:06:17 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF28C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 15:03:25 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id o15-20020a9d410f000000b0055c942cc7a0so16072572ote.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 15:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RwqQ7uJnnuH8oQfmXy4+/qc3GRMuRkeI5EuUmtqWloY=;
        b=AfRfNGfzobvrsH8PJyu8iRlDxBCAbu3NUiJx1yGqDDqQL4miKCwLPeMuo7lv/WYxsV
         zKEdMzpDf3afDWY8SLr4IfwGJW0rORQUqjnL/Npx6D0763FWe0S/JyH3XPciMD3+39tR
         V43X5NxhXMMA+HGy39SADeq+1Qh4Jc3xYVx+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwqQ7uJnnuH8oQfmXy4+/qc3GRMuRkeI5EuUmtqWloY=;
        b=tbz6nsdNNOFKoL79lSmO7nH+fcoPfmxy330yKBrONQhd7Ig2ZXQLRQrKdtFYkB5wO2
         2Ch148JpSoXi2AKCjOla7z6qclTRRBfej312Clu6yTcr49WaXGoCACl5ta4fTGP0JNAV
         ADtTjU+cGoBgCPN17/+w52kDF7D5h/BKoemQypMqkyBtIGT37EvIpltAS608V4UN/i7f
         f/APCSChNQnyh1cFqCjiKp2Y+sJwNpO5H7jL4Pw3xrYiJQf+8FUr5UMTeKnMSeqftFgS
         doIAqZWQIOeVCvuYsy5XTuNQSWW5vw5UXhpLk77RadjKRrSdHasKqAxcaNinAjpTtoY1
         37fQ==
X-Gm-Message-State: AOAM533070UEKHsSYTOVt50bnl1mgmoHEbbJlJWi70AVcahUVmU2T5hc
        99sphToAv7MintFgnVev/uQ4s/oB++WaHw==
X-Google-Smtp-Source: ABdhPJyp1xB26oopC7t9nOAN+3xK5nswTLlkhebEk8R7TLg4UIp1Y3vFV73NQqB7B6BtrkxqmImU2Q==
X-Received: by 2002:a05:6830:1358:: with SMTP id r24mr16164455otq.8.1636758204104;
        Fri, 12 Nov 2021 15:03:24 -0800 (PST)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id k4sm1588131oic.48.2021.11.12.15.03.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 15:03:23 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id r26so20674862oiw.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 15:03:22 -0800 (PST)
X-Received: by 2002:aca:1708:: with SMTP id j8mr15596758oii.62.1636758201979;
 Fri, 12 Nov 2021 15:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20211108200058.v2.1.Ide934b992a0b54085a6be469d3687963a245dba9@changeid>
 <17BDA821-9D4A-46C9-8C0E-F7DB35D50033@holtmann.org> <CACGnfjTBtZ+1ey6+wF7hAVX23ty7yS9qEH0b6p+vzCLBWWPW0Q@mail.gmail.com>
In-Reply-To: <CACGnfjTBtZ+1ey6+wF7hAVX23ty7yS9qEH0b6p+vzCLBWWPW0Q@mail.gmail.com>
From:   Jesse Melhuish <melhuishj@chromium.org>
Date:   Fri, 12 Nov 2021 17:03:10 -0600
X-Gmail-Original-Message-ID: <CACGnfjSdxUGj=6Wk-oUcH-jwe3PYMm9gbPdi_atmaozN8A-mWg@mail.gmail.com>
Message-ID: <CACGnfjSdxUGj=6Wk-oUcH-jwe3PYMm9gbPdi_atmaozN8A-mWg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Don't initialize msft/aosp when using user channel
To:     Jesse Melhuish <melhuishj@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Forgot to include: patch v3 incorporating your feedback will follow
very shortly.

On Fri, Nov 12, 2021 at 4:50 PM Jesse Melhuish <melhuishj@chromium.org> wrote:
>
> Hi Marcel,
>
> No problem, thanks. Happy to extend userchan-tester; do you mind if we
> continue reviewing this patch for approval in the meantime so we can
> mitigate the issue on our end?
>
> On Thu, Nov 11, 2021 at 12:43 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Jesse,
> >
> > > A race condition is triggered when usermode control is given to
> > > userspace before the kernel's MSFT query responds, resulting in an
> > > unexpected response to userspace's reset command.
> > >
> > > Issue can be observed in btmon:
> > > < HCI Command: Vendor (0x3f|0x001e) plen 2                    #3 [hci0]
> > >        05 01                                            ..
> > > @ USER Open: bt_stack_manage (privileged) version 2.22  {0x0002} [hci0]
> > > < HCI Command: Reset (0x03|0x0003) plen 0                     #4 [hci0]
> > >> HCI Event: Command Complete (0x0e) plen 5                   #5 [hci0]
> > >      Vendor (0x3f|0x001e) ncmd 1
> > >       Status: Command Disallowed (0x0c)
> > >       05                                               .
> > >> HCI Event: Command Complete (0x0e) plen 4                   #6 [hci0]
> > >      Reset (0x03|0x0003) ncmd 2
> > >       Status: Success (0x00)
> > >
> > > Signed-off-by: Jesse Melhuish <melhuishj@chromium.org>
> > > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - Moved guard to the new home for this code.
> > >
> > > net/bluetooth/hci_sync.c | 6 ++++--
> > > 1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > > index b794605dc882..5f1f59ac1813 100644
> > > --- a/net/bluetooth/hci_sync.c
> > > +++ b/net/bluetooth/hci_sync.c
> > > @@ -3887,8 +3887,10 @@ int hci_dev_open_sync(struct hci_dev *hdev)
> > >           hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) && hdev->set_diag)
> > >               ret = hdev->set_diag(hdev, true);
> > >
> > > -     msft_do_open(hdev);
> > > -     aosp_do_open(hdev);
> > > +     if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
> > > +             msft_do_open(hdev);
> > > +             aosp_do_open(hdev);
> > > +     }
> >
> > but then you need to do the same on hci_dev_close. Also it would be good to extend userchan-tester with test cases for this.
> >
> > Regards
> >
> > Marcel
> >
