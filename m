Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB8A43F88F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 10:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhJ2ILE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 04:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbhJ2ILD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 04:11:03 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30232C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 01:08:35 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id q74so16339431ybq.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 01:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+Le6B97XTarP+zpQalZY09j7ckTrgrQqCOfMYv/ZEc=;
        b=DjKZY9D+OQRTBixFRj8IBTQc8b6gxJFd7rLgtm4WKbLiDaFCoiUfEbSALVPMEMKUPu
         NSe8gzWxHV+Aie2MukOGYwtX0WeN2x8MpTZV++WsYxjzbdTwC6+HRTYWIBcsd5R2S+pC
         Xq5nkVd+ic+9t0MQ0HWLryGQG8dWTWTNFAb7G02PAKGnLOoVG46Z3T531ns3DJr1axS9
         T7dmloJ6pygkJjidHXGnp2IB4i9Jm24EoyBEzXLN2Qov0YG+FVmMg96MY7kxUaVh97Wj
         LrALToH1vebbjm6EM5fBaLX+R0reOQb/qNg0PQ/PGTqN2jSJDB5ME8ahwDuQitV8BfY8
         bmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+Le6B97XTarP+zpQalZY09j7ckTrgrQqCOfMYv/ZEc=;
        b=KQQokLyinVAw9SOP9NmXbhJt0M9vR4VVbaxI+wQUZhNSvlwqx9N8jQodVonikJzUO1
         zj1AAacMlbABX/5KLatxj6r6BBa6jy3vY6ovcTev0TfsODbk/HphXcnidqCH9zDUlwGE
         BTPUKZxRNZ3vmKdxDL7uU/8m3sj64TE/veF9Yos2kXMlJs3Ev+8jKdnjar6TYneX5Zo+
         ja7SQ6Hvx9hGEGDVFzMQz0mbGOUZWnP5y1vWPJgzFWEeTT3/DkngLNL5LNLk74f7rR6J
         jXANiU+bkcGY29K0Ig1c0wUWKV/yvpjtgEKkw8OEcbN73o6YWr9dXYY/yNz9DppZB1Yd
         5KOw==
X-Gm-Message-State: AOAM532Z0ydtfNPb9aOxJLLNnUZkp+ed2PwC9cXxg7QHLacKQ9N3sfhQ
        Ie2jKsXsZB0ya/695gfJgkZ0V3VKIOSvOmALq8G2MA==
X-Google-Smtp-Source: ABdhPJwFrM6PBPue6H1nJLQA2Et1dk4Al61AI6BdQ9f7QepIWKlUxAqSmdG3cD7H8DwNC6aPk3YoJmBjCwZw0Dd+k/U=
X-Received: by 2002:a25:3817:: with SMTP id f23mr9775126yba.436.1635494914148;
 Fri, 29 Oct 2021 01:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211021230356.v6.1.I139e71adfd3f00b88fe9edb63d013f9cd3e24506@changeid>
 <20211021230356.v6.3.I257ac5cfaf955d15670479efc311bbab702397f4@changeid> <AB7796C2-6543-43CD-8FA3-DAF57AB68767@holtmann.org>
In-Reply-To: <AB7796C2-6543-43CD-8FA3-DAF57AB68767@holtmann.org>
From:   Joseph Hwang <josephsih@google.com>
Date:   Fri, 29 Oct 2021 16:08:23 +0800
Message-ID: <CAHFy41_y8LS81gTHNidMdrD9tpeXf0YyvHaTKZJU+jmjuFgYXQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] Bluetooth: btusb: enable Mediatek to support AOSP extension
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        pali@kernel.org, chromeos-bluetooth-upstreaming@chromium.org,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWFyay1ZVyBDaGVuICjpmbPmj5rmlocp?= 
        <Mark-YW.Chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Mark-YW.Chen@mediatek.com

Some of Mediatek's controllers/firmwares do NOT support AOSP extensions.

Please refer to this Gerrit patch review link for chrome os
(https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3054233/8/drivers/bluetooth/btusb.c)
which was reviewed by Mark-YW Chen, Mediatek's engineer.

As an example, MediaTek MT7615E does not support the AOSP extensions.

That was why I used a new BTUSB_QUALITY_REPORT flag in the changes v4
and earlier ones.

Please let me know how you would like to proceed with this patch.

Thanks!
Joseph


On Mon, Oct 25, 2021 at 9:26 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Joseph,
>
> > This patch enables Mediatek to support the AOSP extension.
> >
> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> >
> > ---
> >
> > (no changes since v5)
> >
> > Changes in v5:
> > - Let the vendor command in aosp_do_open() to determine what
> >  capabilities are supported.
> >
> > Changes in v4:
> > - Call hci_set_aosp_capable in the driver.
> > - This patch is added in this Series-changes 4.
> >
> > drivers/bluetooth/btusb.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 87b71740fad8..00311ebd7823 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -3876,6 +3876,8 @@ static int btusb_probe(struct usb_interface *intf,
> >               hdev->set_bdaddr = btusb_set_bdaddr_mtk;
> >               set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> >               data->recv_acl = btusb_recv_acl_mtk;
> > +
> > +             hci_set_aosp_capable(hdev);
>
> can we get an ACK from Mediatek people that all their firmwares support the AOSP extensions.
>
> Regards
>
> Marcel
>


-- 

Joseph Shyh-In Hwang
Email: josephsih@google.com
