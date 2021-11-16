Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87C545384D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 18:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbhKPRKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 12:10:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51625 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237632AbhKPRKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 12:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637082441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H3riuHE7sVj3zMfG7eEcQnR+YQaScrJuhgpIheDS+2g=;
        b=iEIz6ecM3W8z53EMOUn+yNWCSfKQyQogiHMqkKFu1c7cpMb+WpbhvT8sSivT7buUJEmT9n
        F1aYlDtMstMrlZxrzort6zPMY5Yg8xFwCIHgNapSF5Ci32IlugGi56XmZ/5iilJ1+Ydca/
        VGuBl+Ay133WgSBuIjH0zaQKfudcKAA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-AWfu1PFsP0-b14rM9sESkA-1; Tue, 16 Nov 2021 12:07:19 -0500
X-MC-Unique: AWfu1PFsP0-b14rM9sESkA-1
Received: by mail-pg1-f199.google.com with SMTP id i25-20020a631319000000b002cce0a43e94so11008350pgl.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 09:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H3riuHE7sVj3zMfG7eEcQnR+YQaScrJuhgpIheDS+2g=;
        b=X6VcRUPOSSqO1vnoHXNHVWJmqYiK7s1w2DjfmxHRYJWVDGLBHfIQB15rCn5TajRMfo
         SPHMPAB+VF+y0R2MBiD8vPWrpnH+YTfgklbKRwn0eQtjSoKZ2W3fJYogfTmVocWCe3yP
         gkoAaVdKvhmXPItgjluxewp5rtQvDK1ps6+jI/7L7sWO3SnjyDtnDSJKUccbmfZqhJAg
         rVou9OjyvdNqM0OLUmg22rHOFSETUjtsP2qqnRJ/6QoLDwNV0rtOpJY/L+eRSRe838Lk
         OdfIlV9ihnRutoHlw92EAyTe4sQ1JkbMsEDcqVGzjqXhDvDBLno9oG5GPQ2BIBW1syS8
         b3Mw==
X-Gm-Message-State: AOAM531+H+7SL5txmqCyGMAklL46p7EJYP3Dm+w2NER7k8xbar+7cdEK
        IWPkXcOZ5p82guHWCfG75m95RFJD38VjkLFcKI16fZXyHlPPQRcwwUgUpETL/xw2GkwS6+aE7Z4
        /yIZEP3nbjpWfPhPj1QIMr3DCfkWdJ8APBQ8GIKuk
X-Received: by 2002:a17:90b:224f:: with SMTP id hk15mr750394pjb.173.1637082438488;
        Tue, 16 Nov 2021 09:07:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwk89cfC9XFH1oRKbd8sYP0mMZgGUyP5mUE39CW2RS/+u1DuJlvqPYj1cMvfgsA79PmpRBextz60FKxVI/4wPc=
X-Received: by 2002:a17:90b:224f:: with SMTP id hk15mr750331pjb.173.1637082438062;
 Tue, 16 Nov 2021 09:07:18 -0800 (PST)
MIME-Version: 1.0
References: <CAO-hwJ+huX5wFQjwzZ+o9zOonCuifiyQ2rZosTWW7or09_SfiA@mail.gmail.com>
 <20211116131502.24603-1-linux@zary.sk>
In-Reply-To: <20211116131502.24603-1-linux@zary.sk>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 16 Nov 2021 18:07:07 +0100
Message-ID: <CAO-hwJ+n2-WO7O9zM9UABMhzCqANC=BHCyw5hObm7-B0vMqCSg@mail.gmail.com>
Subject: Re: [PATCH v2] hid-multitouch: Fix Iiyama ProLite T1931SAW (0eef:0001 again!)
To:     Ondrej Zary <linux@zary.sk>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 2:15 PM Ondrej Zary <linux@zary.sk> wrote:
>
> Iiyama ProLite T1931SAW does not work with Linux - input devices are
> created but cursor does not move.
>
> It has the infamous 0eef:0001 ID which has been reused for various
> devices before.
>
> It seems to require export_all_inputs = true.
>
> Hopefully there are no HID devices using this ID that will break.
> It should not break non-HID devices (handled by usbtouchscreen).
>
> Signed-off-by: Ondrej Zary <linux@zary.sk>

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks!

Cheers,
Benjamin

> ---
>  drivers/hid/hid-multitouch.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 3ea7cb1cda84..ac114b76057b 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1880,6 +1880,11 @@ static const struct hid_device_id mt_devices[] = {
>                 MT_USB_DEVICE(USB_VENDOR_ID_CVTOUCH,
>                         USB_DEVICE_ID_CVTOUCH_SCREEN) },
>
> +       /* eGalax devices (SAW) */
> +       { .driver_data = MT_CLS_EXPORT_ALL_INPUTS,
> +               MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
> +                       USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER) },
> +
>         /* eGalax devices (resistive) */
>         { .driver_data = MT_CLS_EGALAX,
>                 MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
> --
> Ondrej Zary
>

