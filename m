Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEA5435ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhJUGPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:15:38 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:57727 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJUGPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:15:36 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MScHp-1mF4rR0O4H-00SsUW for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021
 08:13:20 +0200
Received: by mail-wm1-f52.google.com with SMTP id 186-20020a1c01c3000000b0030d8315b593so5370261wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 23:13:20 -0700 (PDT)
X-Gm-Message-State: AOAM530Ugth2LFFeP4StCe7LbDRIjGe8pxThaBwKziu9QS6iOxx9IwjK
        gV8ps5UW/rFRgPQogeV1NUBwxtNI1netLoqBeU0=
X-Google-Smtp-Source: ABdhPJwONMgKrcX5KWAhlOd2bscXE1lCvooPNYjIk7FVfmfCe4YtpnGyeGd0P6MSZGh5GtKP469F0tBp/wqKWh1zzS4=
X-Received: by 2002:a05:600c:208:: with SMTP id 8mr18203487wmi.173.1634796799792;
 Wed, 20 Oct 2021 23:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211015005923.2659140-1-alistair.francis@opensource.wdc.com>
 <CAK8P3a3GVcjPp+ANKQvgMaDLqN4xAhNv+3jSO5gUMRszsARtFA@mail.gmail.com> <CAKmqyKNZm+w=WhUXPRLs-UWCwgBpZzt=4DMne-FbfBe=UjSrKw@mail.gmail.com>
In-Reply-To: <CAKmqyKNZm+w=WhUXPRLs-UWCwgBpZzt=4DMne-FbfBe=UjSrKw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Oct 2021 08:13:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1CxFfHze6id1sQbQXV-x8DXkEdfqh51MwabzwhKAoTdQ@mail.gmail.com>
Message-ID: <CAK8P3a1CxFfHze6id1sQbQXV-x8DXkEdfqh51MwabzwhKAoTdQ@mail.gmail.com>
Subject: Re: [PATCH] uapi: futex: Add a futex syscall
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair.francis@opensource.wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fNPolSmmpWkGIMUoskRXA+08mxE677vIFtO+wJt/wKWnDLoj7u6
 wDMCGBqnXNB8slijKu2bpT0l4UagMazu+4uck7YSJrBffERHEsKMKhMHg/R5dUh/wl8KhUV
 EinqK8e3Vm63syNzXyTe78PzCJhKoB7KEKeCuzaQ7B6XHYymBtV3mDxguUnx+mk06KUUooe
 6MJfprI/Xg0wEIppJhVVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XU0ZPF1Vp9k=:nalqZrCtKFbjBNGqJtCXOI
 g85gUIhKYi3gDVq1QP8obhy4s2MIj4RVhZU9pO9sFfi6gvbvm5ChxRAAvoA5P51FmNS8KEg4Z
 Kjg0Et52LqlJGE4bb14TUStzk9emyEGYoee3iRqaSDZgLfcUyd/5xNp7e6a+2w+1humBE1zQR
 5/gxaq/lUufQWw8xf65NftahlNq6D8lZuADOX1lrnV0bbFjyrccGc8GN183VrR8bX5B/bg5Jq
 PuriBlhWz/bN0x94jEDWShnE1DTECUCwp8ZgEYcH57RIb9zUXuvFRj8t/ueYdAwoaRmvVu8BG
 HAvbxCm4iBDInMrE+vAC9ydhedmNWdKBCKhVVE+zGGRlDjxSZIvJqp/Sntxetb0pwAq3YmU/B
 gADILkS10/4MvrZae6V949UMQKlYUNbGZzQi39H0T+QeYNnWLdPCn8ddqRANtMsjBRb2LFbmT
 sdHFtQ3+JyOUpMmaoanDm1YHeQcWVZcJoFr1qHFeSc/MKJO4l6+yTnWnfArrppm2AZ3V4T8Jm
 L1U4diDWJl3+JU9sd9JpUi9CSb7uicVrdOwo1IETtTpVLMcYhCmG81KS06PXBUDkHKL8Xg+ll
 yFMxUd1/ihQncn6Lzz8pguel+2xTYn8siblLO5pM7lqPsptULvIGU7Njw1CoTPUjOw98lb8nU
 ihdFn2JeXiWITtiKWqcjC1FiU0aqLr6cYCkNIE/U0AFqMahr74JiOpzBdR0qchEGopbo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 5:41 AM Alistair Francis <alistair23@gmail.com> wrote:

(sorry I missed this part of your reply earlier, just saw the new version of the
patch and wondered what had happened to my feedback)

> On Fri, Oct 15, 2021 at 6:24 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Oct 15, 2021 at 2:59 AM Alistair Francis
> >
> > I think it would be nicer to use a transparent union like
> >
> > typedef union __attribute__((__transparent_inion__)) {
> >         struct timespec *timeout;
> >         u_int32_t nr_requeue;
> > } __futex_arg4;
> >
> > which would let us provide a single function for both variants.
> > The main downside is that this relies on a GCC extension, but I
> > don't expect that to be a problem since any code using this is
> > already nonportable.
>
> I don't love this. Relying on a GCC extension doesn't seem like a great idea.

I see that even glibc uses __transparent_union__, though they have
a fallback for incompatible compilers in there, which we could
duplicate if necessary. I would expect that the kernel headers already
have a number of gcc extensions in them elsewhere.

> As well as that we need to split the types out to check the timeout
> value, and I'm not sure of how we could do that. We could have a
> switch case on the futex op, but that seems likely to get out of sync.

This is a good point. It would be ok if we could guarantee that
no new futex operations are added in the future and all new work
is on futex2(), but we probably don't want to make that a hard
requirement.

Another option would be to add the new wrappers into the
existing uapi/linux/futex.h header instead of a new header.
This is also not great, but it would have the advantage of
having the full list of operations in the same file.

        Arnd
