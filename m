Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB3C39268D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhE0Etq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhE0Etp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:49:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A06FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:48:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id h20so4526214ejg.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QZgTnd18oJjSktIe4nzePe2qIf/HOj3XsBocSVEg3Fo=;
        b=dHD1aNy6c2NzhkZzviRTn/QfMunKNbqR+F9idMa7Es6Jy1oZ3Nb+UBd7V+hztW+7/M
         dFV5CyWvUp5V+WVJ7neNG04Y0J1lmdNdjGMlIwKsGmMQWzE1d6f6CnamtZtmJSZii3wG
         t+6Pz1pULW7Vm3kagcgZxqukkmcixIS4fi0nUd5qL9pQ880/xjopcAIfvH/4kJhNwgM6
         9FGG4m9+oXFPVR1lr4xejC6MG1ImDegs5Nk+N0UjhovsUrcQtPbshZXx3VGrtRzgZ3D6
         fe2qhtuYiVSfgGw5wmUGGRzIrK2PYsveS/2wxiY83TBnS2uSxzEDZxpZG6OfiI7TR3QC
         EGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QZgTnd18oJjSktIe4nzePe2qIf/HOj3XsBocSVEg3Fo=;
        b=RfnagJ2zrXRXOaURbZ2qxo85UKwwu5/Z1PF6h58gPZMnf6iN3VN9Aptlspkp31hfFt
         /Iv+fQNVcSVX+te1oX4K6czv181A3cB+cOruru4ECmWoqKtfrvEGKg3vNNwPIeVOO0EA
         LVQUN0bTeBpjMyRW5MbWjOLCUALFADtonKk8JV1STn6jJVmDhQUXgeajuLsQ9vLKbZuL
         Z4bppRQvu/yHLBivsQbLe+E1Jgg3un03S3T6nPECfKZ9bJ7Pj0jLFZ1N/fok5REqXydN
         sqPDz9bIpHZ3oBHc0B6JXW6qHuHGV6EX5CxcUvzSxjc3sywgp9ubo+1IW/ahwHK+yv1a
         lcQQ==
X-Gm-Message-State: AOAM531X3/Y+vlDoakqu4b4Bb+zpv109gH4EEtEkwRfmaeLC1iyMtMap
        Cfv87n4muwpPJ9jeNlahxjdcB0dFdQKajFWT0ls=
X-Google-Smtp-Source: ABdhPJxXHycM2Qz2uuIZXXm7fHnTcDsXPn2JZNwjxW2M0dg5hD5AXukMBtdzGjwfpiqsC/BnI7Jbh93FnWAEEdk/ZGs=
X-Received: by 2002:a17:906:73d7:: with SMTP id n23mr1820503ejl.135.1622090891770;
 Wed, 26 May 2021 21:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAD-N9QWYOE5vW=Q4wP74vV-TkrZUDFZxLn5OACX4jUC2ysEACQ@mail.gmail.com>
 <YK8dUDlYrq/RRzo7@kroah.com> <CAD-N9QXxX2Zgg9t7m5GfTq6-qFU1PeVfrwd-AQ90eFRRSpVmOA@mail.gmail.com>
In-Reply-To: <CAD-N9QXxX2Zgg9t7m5GfTq6-qFU1PeVfrwd-AQ90eFRRSpVmOA@mail.gmail.com>
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Thu, 27 May 2021 12:47:45 +0800
Message-ID: <CAD-N9QWqPLd6Y0EUxAsjfE5t0HxZkJWAk3myudUwAtC_EU-Mew@mail.gmail.com>
Subject: Re: Suggestion on how to fix "memory leak in snd_ctl_led_register"
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 12:20 PM =E6=85=95=E5=86=AC=E4=BA=AE <mudongliangab=
cd@gmail.com> wrote:
>
> On Thu, May 27, 2021 at 12:17 PM Greg KH <gregkh@linuxfoundation.org> wro=
te:
> >
> > On Thu, May 27, 2021 at 10:49:22AM +0800, =E6=85=95=E5=86=AC=E4=BA=AE w=
rote:
> > > Hi kernel developers,
> > >
> > > The root cause of "memory leak in snd_ctl_led_register" [1] is
> > > unbalanced refcount operations in the device_add function [2]. This
> > > refcount issue causes struct device_private allocated in
> > > device_private_init unable to be deallocated, leading to memory leak.
> > > The details are as follows:
> >
> > <snip>
> >
> > Great, can you just send a patch to us to resolve the issue?  That's th=
e
> > easiest way to resolve all of this.

Let me think more about the fix. I will send a patch if I can test it
successfully in my local workspace.

>
> As I said in the last, I think up some fixes, but they are not working
> in my local testing. So I have no idea how to fix this bug. Then I ask
> for help.
>
> >
> > thanks,
> >
> > greg k-h
