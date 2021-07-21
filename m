Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686613D15E7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237986AbhGUR1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhGUR1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:27:45 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB7BC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 11:08:21 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h4so4111420ljo.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 11:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gtIf04Z37gx9XqNiwrsxPZO7oSThLTlbi0RPsWdfaFM=;
        b=UGfV3dnRrxXZDPaaemsemZl5AWjKR+fUL80TbIDXhqu2qF770NP1zJ4FWA7smAOsBj
         +DTEb1bn7VR5OD7KSSObN2is3t9s51LebBvBA+eV0QEDRC3TZZ8M8m6U9xGxVum9ljJ0
         VKQq2uVXNUptfjfbw4frYhB44+zw9VvSmYkCPQGMZj9wTazF9LCaeBKzLdJzbAMgrRcc
         U+rxvhfNeaG/uUuf3s2bB2juZWWx0x7MCbEkOJyH8F118hqDbt9KovoLgVgQmfj+IWMm
         Ete3RO0RWdpj0xJ9uIZznY5JzOl7+iZwcoqmKIQ+mwrfoBjKRKt/qN9eaC9PHxWIzGDi
         fVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gtIf04Z37gx9XqNiwrsxPZO7oSThLTlbi0RPsWdfaFM=;
        b=pCgMkCIZMM188WZ7M3PxlgIFqlZsUlauGbim9o9hA+TPcfwM4QpPVmi2WX+jnnkHcV
         Vl+E2ZouSqeC9kOFeLRUNdK4z2Ae7Gpw62s4ob501s7cgYntNW8iU2cwlZtKslup/jTe
         CPDOgHLKvcxUqwQ6YDNWfSZCPD7MFcQX5Oqs2f99CwwmVwM7uWuSA3OfSkrp2SxMlxyo
         DRigZAKmdI64VGGekMFGQLOCvq7Tfmcc/jctS7zCD1Wtpqy2sN7nEA3tmfor0rFYaLks
         lHvQodrBSOhm5xB/jAEmtRvlksCFvufkFzGi5NqZNIA03ixNpxGDD+mEOQCKlj0wZeeo
         NysA==
X-Gm-Message-State: AOAM532zHwRuzFZPZsqM9ifEVc/bca8xuvNlns/hEHtl0Me9ubtMqkA9
        6oMl0/0yyEAFmzLqk6XXd1eTQC6+Y740AY1J4Y//Bg==
X-Google-Smtp-Source: ABdhPJxrq4futLBsxaQ59VtkjdmJQuQy/S66dDex7M2vFe5dYW/PA5zDw9jXVCNnWGkgJlk7EVVXeHwG+WpaJFd4aok=
X-Received: by 2002:a2e:720f:: with SMTP id n15mr28248753ljc.333.1626890899442;
 Wed, 21 Jul 2021 11:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-30-Sergey.Semin@baikalelectronics.ru>
 <CALAqxLX_FNvFndEDWtGbFPjSzuAbfqxQE07diBJFZtftwEJX5A@mail.gmail.com>
 <20210714124807.o22mottsrg3tv6nt@mobilestation> <YPfPDqJhfzbvDLvB@kroah.com>
 <20210721100220.ddfxwugivsndsedv@mobilestation> <YPf29+ewbrYgHxRP@kroah.com>
 <0064cb2c-5ca6-e693-2e89-8f045c8f7502@kernel.org> <YPf+shNM6cXb3mfe@kroah.com>
 <d853df77-8d36-30b0-dd26-da1bfcb068e0@kernel.org> <20210721112531.xvu6ni5ksaehsrjh@mobilestation>
In-Reply-To: <20210721112531.xvu6ni5ksaehsrjh@mobilestation>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 21 Jul 2021 11:08:08 -0700
Message-ID: <CALAqxLViEqSO17P3JGRGYJh-wDoHaJiQQV48zeoRgnar4Xd5Bg@mail.gmail.com>
Subject: Re: [PATCH 29/29] arm64: dts: qcom: Harmonize DWC USB3 DT nodes name
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 4:25 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> On Wed, Jul 21, 2021 at 01:10:19PM +0200, Krzysztof Kozlowski wrote:
> > It's not good example. The configfs entries (file names) are
> > user-visible however the USB gadget exposes specific value for specific
> > one device. It encodes device specific DT node name and HW address and
> > gives it to user-space. It is valid only on this one HW, all other
> > devices will have different values.
> >
> > User-space has hard-coded this value (DT node name and hardware
> > address). This value was never part of configfs ABI, maybe except of its
> > format "[a-z]+\.[0-9a-f]+". Format is not broken. Just the value changes
> > for a specific device/hardware.
> >
> > It's like you depend that lsusb will always report:
> >   Bus 003 Device 008: ID 046d:c52b Logitech, Inc. Unifying Receiver
> > and then probing order changed and this Logitech ends as Device 009.
> > Then AOSP guys come, wait, we hard-coded that Logitech on our device
> > will be always Device 008, not 009. Please revert it, we depend on
> > specific value of Device number. It must be always 009...
> >
> > For the record - the change discussed here it's nothing like USB VID/PID. :)
>
> Right I was wrong referring to the configfs names in this context.
> That must have mislead Greg.
>
> Getting back to the topic AFAICS from what John said in here
> https://lore.kernel.org/lkml/CALAqxLWGujgR7p8Vb5S_RimRVYxwm5XF-c4NkKgMH-43wEBaWg@mail.gmail.com/
>
> AOSP developers somehow hardcoded a USB-controller UDC name in the
> internal property called "sys.usb.controller" with a value
> "ff100000.dwc3". That value is generated by the kernel based on the
> corresponding DT-node name. The property is then used to
> pre-initialize the system like it's done here:
> https://android.googlesource.com/platform/system/core/+/master/rootdir/init.usb.configfs.rc
>
> Since we changed the DT-node name in the recent kernel, we thus changed the
> UDC controller name so AOSP init procedure now fails to bring up the Linux
> USB-gadget using on the older UDC name. UDC is supposed to be ff100000.usb now
> (after this patch has been merged in).
>
> What problems I see here:
> 1) the AOSP developers shouldn't have hard-coded the value but read
> from the /sys/class/udc/* directory and then decided which controller
> to use. As it's described for instance here:
> https://www.kernel.org/doc/Documentation/usb/gadget_configfs.txt

The problem with this is there may be multiple USB controllers on a
system (not all exposed outside the case - and also the dummy
controller is often present). How can we configure the system to know
which controller is which?

The only name we have for distinguishing the controllers is the DTS
node. So it seems inherent that changes to that name will break the
config.

That said, this issue reminded me of the /dev/hda -> /dev/sda device
name or the eth0 -> enp3s0 switch which both also had the potential to
break configurations or scripts.  I get that having a standard naming
scheme is important (I'm very sympathetic to this point)! I can
imagine UI trying to show possible controllers for a user to select
needs a simple way to determine if a device is a usb controller - but
again this just shows that the node names are an ABI.

So I'm not the one to judge if this change is useful enough to push
through the pain, but it did seem to be done a bit casually.

> 2) even if they hard-coded the value, then they should have used an
> older dts file for their platform, since DTS is more
> platform-specific, but not the kernel one. Even if a dts-file is
> supplied in the kernel it isn't supposed to have the node names
> unchanged from release to release.

DTS changes are a constant source of regressions in my experience. We
mostly just have to roll with it, but it feels never ending. :)  I'd
personally rather folks in general be more thoughtful about what DTS
changes they make and accept, understanding that they do have impact
on userland.  And I'd imagine If updates to linux-firmware broke the
most recent LTS kernel, that would be seen as a regression too, and
folks wouldn't be told to just keep the old firmware.  But all the
same, I'd also be happy for suggestions to remove any such
dependencies userland has on specific dts naming, where possible, to
make the constant pain go away. :)

thanks
-john
