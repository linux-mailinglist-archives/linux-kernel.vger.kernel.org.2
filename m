Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32535434600
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhJTHmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52486 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229544AbhJTHmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634715636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xzO4Q3aQAxDd/CXjxVc/PBLDgKS0VWU0zhTheAx1U8U=;
        b=ZtW9hUnuX16e/Y0/5YEa84EbHhEgH7wremWSF4sdlpjBIsIKYxvql0p/KlVb/UTU8TNkwI
        QXEkwF/fhfla2gSNMnHk3Zs+vAzZg0G956ORY0csyoSzMzNzmsVNikZExhSRmO8o1kId7K
        UemByyJBrdiWkMk+nyhqWcV0r1dKUOk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-51rDcPftOOOO3Z5KDk4DqA-1; Wed, 20 Oct 2021 03:40:35 -0400
X-MC-Unique: 51rDcPftOOOO3Z5KDk4DqA-1
Received: by mail-pl1-f200.google.com with SMTP id n15-20020a170902e54f00b0013ed08c1bacso9140260plf.20
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 00:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xzO4Q3aQAxDd/CXjxVc/PBLDgKS0VWU0zhTheAx1U8U=;
        b=KIYcCF/ZMGhqXC6hrdlKDhm9tWxa0aUn68Rpt+OSAlRO0pnOiJIAOyoFYxga1jYhk7
         BAyWMcGdC22Nw3Kxu1dujgnS2hqtBuAH+hZ1GYrJsRTyPRTEsUq7xGR7WpCFAP+VNMnI
         RJs+x+WPcIAgnazLUTJ6acsCxzVEntE1esLBIu1BgdpZ0TRXRIOsRITypyr0dQYNNy16
         EX1lua7+FZTCa7mzrIw50h0zDlMYkD66e9B2mQUKlgKbgwgVjIKySn+cynljNpQtuN/7
         3iENfE0EiaqG0PJQ7Sr5ri0bD21WRUVrbtKhMQk8ogiP8VlcX6Y18PIZP+RNP4qfQOVZ
         5bbg==
X-Gm-Message-State: AOAM533h9CyCuKlN9PnpqN89RUbvzcc+GmVm+Ih2rk51M65Snblnfqmf
        B8SWUcuBqZ2b+XO0V2h512Tdad8YRN8BjCdRPgJ84HAFV5BSSuH6oiPJONVQ+dYgi9nwCiuTKfs
        1CL6ghP/iFlaFN/F6A1+hoJsPVK6RY5rTnrHyOs6t
X-Received: by 2002:a17:903:1c2:b0:13f:2893:de99 with SMTP id e2-20020a17090301c200b0013f2893de99mr37622303plh.80.1634715634012;
        Wed, 20 Oct 2021 00:40:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfSAVC+6desZq5CXC1hcJfxb6eLGYqapPpaxCnEKqY9rPZ4gaXaycO0TCrv2Qga1iqLwsz6Z60kaM4RT3oIec=
X-Received: by 2002:a17:903:1c2:b0:13f:2893:de99 with SMTP id
 e2-20020a17090301c200b0013f2893de99mr37622288plh.80.1634715633756; Wed, 20
 Oct 2021 00:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211009114313.17967-1-alistair@alistair23.me>
 <CAF8JNh+OUzvAHA9tBrH2d_WxWPXRgiunhGO5KV4-fqVG+tUOyQ@mail.gmail.com>
 <YW4kgnI0DQHj4sw4@google.com> <CAKmqyKMrb=Uz0+-ycj0HkAKJYdRU11Dc+24+KJw_j3MHT=2+yw@mail.gmail.com>
 <YW9rRUsxPHTjeOGT@google.com> <CAKmqyKMpMCb4gLyp94rCgVBU3eccjafD8nF7y6o+oU6D-OHvTQ@mail.gmail.com>
 <YW97lwsMrLHetJGy@google.com>
In-Reply-To: <YW97lwsMrLHetJGy@google.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 20 Oct 2021 09:40:22 +0200
Message-ID: <CAO-hwJKSxVFAiAriWU0No7sFxzo9XB1-T9LFeF5Zn27B8erFPA@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] HID: wacom_sys: Add support for flipping the data values
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Alistair Francis <alistair23@gmail.com>,
        Ping Cheng <pinglinux@gmail.com>,
        Alistair Francis <alistair@alistair23.me>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Jiri Kosina <jikos@kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 4:14 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Wed, Oct 20, 2021 at 11:44:50AM +1000, Alistair Francis wrote:
> > On Wed, Oct 20, 2021 at 11:05 AM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > On Wed, Oct 20, 2021 at 09:33:13AM +1000, Alistair Francis wrote:
> > > > On Tue, Oct 19, 2021 at 11:51 AM Dmitry Torokhov
> > > > <dmitry.torokhov@gmail.com> wrote:
> > > > >
> > > > > We already have touchscreen-inverted-x/y defined in
> > > > > Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml,
> > > > > why are they not sufficient?
> > > >
> > > > The touchscreen-* properties aren't applied to HID devices though, at
> > > > least not that I can tell.
> > >
> > > No, they are not currently, but that does not mean we need to establish
> > > a new set of properties (property names) for HID case.
> >
> > I can update the names to use the existing touchscreen ones.
> >
> > Do you have a hint of where this should be implemented though?
> >
> > Right now (without "HID: wacom: Add support for the AG14 Wacom
> > device") the wacom touchscreen is just registered as a generic HID
> > device. I don't see any good place in hid-core, hid-input or
> > hid-generic to invert the input values for this.
>
> I think the transformation should happen in
> hid-multitouch.c::mt_process_slot() using helpers from
> include/linux/input/touchscreen.h
>
> I think the more challenging question is to how pass/attach struct
> touchscreen_properties * to the hid device (i expect the properties will
> be attached to i2c-hid device, but maybe we could create a sub-node of
> it and attach properties there.
>

Sorry but I don't like that very much. This would mean that we have an
out of band information that needs to be carried over to
HID-generic/multitouch and having tests for it is going to be harder.
I would rather have userspace deal with the rotation if we do not have
the information from the device itself.

Foreword: I have been given a hammer, so I see nails everywhere.

The past 3 weeks I have been working on implementing some eBPF hooks
in the HID subsystem. This would IMO be the best solution here: a udev
hwdb rule sees that there is the not-wacom PID/VID (and maybe the
platform or parses the OF properties if they are available in the
sysfs) and adds a couple of functions in the HID stack to rotate the
screen. The advantage is that we do not need to add a new kernel API
anymore, the disadvantage is that we need userspace to "fix" the
kernel behaviour (so at boot, this might be an issue).

I am not at the point where I can share the code as there is a lot of
rewriting and my last attempt is resulting in a page fault, but I'd be
happy to share it more once that hiccup is solved.

Cheers,
Benjamin

