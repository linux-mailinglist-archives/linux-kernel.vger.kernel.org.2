Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC6332E2D8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 08:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhCEHRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 02:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCEHRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 02:17:50 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550DEC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 23:17:50 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id l12so1186317edt.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 23:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QLJ12ANC/PP7G33YJ0w0xUrmaXTmSNmRKBIydpJYLC4=;
        b=rPB8B2QY3c/gbtUBH3Px9N+1U3JGDARPA9G1v28xS5xrkqVxm94N4iCUUE22PA6azW
         HjNjBFGwXe7JhURhaiGlBEC5IJxcX43ldg76S+KNlPOCMiZszLjo+r4VprmkqZvRFJVS
         wNKnB37CGMZL5jTECpPslQDaK9uFKiBlBAoyhAyd5mzh4QTOEmJQl8THPuC8wFEkDOMI
         nfYXmbVI6CmShKupl0a8QID2HY81Ia3ElcQbTzMZD0xpuxSrRLu+lRCoAc5Ky7fAMYdx
         pKFTCQORfPwsq4OdrynIUSX8M8Qw/9yHhhiixARWjepWJck2V/9xRiHVazZ3CsUAVlZh
         80Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QLJ12ANC/PP7G33YJ0w0xUrmaXTmSNmRKBIydpJYLC4=;
        b=rFZ/fJQgIhQ7+k209JrvugtWYdxy0kDmmipUjUwHR9kPdqxVY8j/oCNGheNaotZrZR
         9Z3ycJ2U2UC4hSw59CZlVD6ogupe39J7w/00psLctl0zj3paAiAeT2LT8g/CB0ijn9al
         C8b+7gWorVo/qpQBvkafFW6RhYqqHjmAXDaKJQ67EFgZDcMnWlARDMM6foZxOmapWy52
         xyPawxRhZP5JSbezSwPaLL9xfnwRi1oMkQXVs/aN+e+oWAjavJevvnD63tEb9DmqciMW
         7BHyFHX8+C8zXB4gU7X9CmjsPbMGvGZ2DL7il7QqecX+oBxbXH7ymwiIKVJklbrhiTDy
         NDsw==
X-Gm-Message-State: AOAM5321UlY8BsxiXBDD3oWJFNAwbEQ5IgTEld9G5uNO6/kdCa4SpYE1
        sVxOujfYVmorF1VFtGrMJbcHkX+uZ5f9ggGigUPNGA==
X-Google-Smtp-Source: ABdhPJzxJTRIoEpkX5faeWURqXqG0yeZXi3wHPUCvf14krGAcSWmk1f3Skge8emQM8fpv47b9OVzyM4VkfvYAsAt2zU=
X-Received: by 2002:a05:6402:3552:: with SMTP id f18mr6482783edd.240.1614928668820;
 Thu, 04 Mar 2021 23:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20210226091612.508639-1-rickyniu@google.com> <YDi/+TN6AYXropf7@kroah.com>
 <CADRPvQubTEjKeJc=+LQ2jb0L=N4mxY8n21Bf8U-tS1stpB_eGw@mail.gmail.com> <YD9SYklmQq5amDA7@kroah.com>
In-Reply-To: <YD9SYklmQq5amDA7@kroah.com>
From:   Chien Kun Niu <rickyniu@google.com>
Date:   Fri, 5 Mar 2021 15:17:37 +0800
Message-ID: <CADRPvQtbbxKhvmE1OZ=GRSmfejk5tXYADo=jw52EQdkj1nN78w@mail.gmail.com>
Subject: Re: [PATCH] ANDROID: usb: core: Send uevent when USB TOPO layer over 6
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stern@rowland.harvard.edu, erosca@de.adit-jv.com,
        gustavoars@kernel.org, a.darwish@linutronix.de, oneukum@suse.com,
        Kyle Tso <kyletso@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Wei <jameswei@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2021=E5=B9=B43=E6=9C=883=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:10=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Mar 03, 2021 at 05:03:25PM +0800, Chien Kun Niu wrote:
> > Hi , Greg
> >
> > What tool will "catch" this?  Where is that code located at?
> > =3D> I prepare merge the code to Android phone , so I used Android HLOS
> > to catch this uevent.
>
> Very odd quoting style, perhaps you might want to read up on how to do
> this properly at:
>         https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
>
> > uevents are not for stuff like this, you are trying to send "error
> > conditions" to userspace, please use the "proper" interfaces like this
> > and not abuse existing ones.
> > =3D> Sorry , I am not sure what is the "proper" interfaces your mean.
> >      Could you please give me more description?
>
> How does the kernel normally send error conditions that it detects in
> hardware to userspace?
>

I will create a sysfs attribute to record the hub status.
If there is a new hub with over 6 USB TOPO layer connected, I will use
the sysfs_notify to send the "error conditions" to userspace.
Is it a proper interfaces to delivery "error conditions"?

> > You just created a whole new sysfs class with no Documentation/ABI/
> > update?
> > =3D> Yes, I will add it.
> >
> > Wait, how did you even test this code?  This will not work if you have
> > more than one hub in the system at a single time, right?
> > =3D> I build the test build which flash in Android phone and connect
> > several hubs to try it.
> >      When the new hub which met MAX_TOPO_LEVEL connected , it sent
> > notify to user space.
> >
> > Phone ------=E2=86=93
> >                  hub ------=E2=86=93
> >                              hub ------=E2=86=93
> >                                            ...------=E2=86=93
> >                                                     hub
> >
> >      if (hdev->level =3D=3D MAX_TOPO_LEVEL) {
> >                 dev_err(&intf->dev,
> >                         "Unsupported bus topology: hub nested too deep\=
n");
> >                 hub_over_tier();
> >                 return -E2BIG;
> >      }
> >
>
> But you only have a single hub variable, and a huge memory leak, did you
> not detect that in your testing?
>
> > So, proof that this works?  How did you test this?
> > =3D> I use the Pixel phone to verify the code , the framework received
> > the uevent when the last connected hub over "MAX_TOPO_LEVEL".
>
> Try it on a desktop as well, with many hubs and see what happens :(
>
> > Also, you have a memory leak in this submission :(
> > =3D> Do you mean I should add device_destroy here ?
>
> What do you think should be done?
>
> >
> > hub_device =3D
> > device_create(hub_class, NULL, MKDEV(0, 0), NULL, "usb_hub");
> > +if (IS_ERR(hub_device))
> > +               return PTR_ERR(hub_device);
> >
> > void usb_hub_cleanup(void)
> > {
> > +if (!IS_ERR(hub_device))
> > +device_destroy(hub_class, hub_device->devt);
> >
> > if (!IS_ERR(hub_class))
> > class_destroy(hub_class);
>
> I don't think you are understanding that you can have multiple hubs in
> the system at the same time :(
>
> thanks,
>
> greg k-h

Thanks,

Chien Kun Niu
