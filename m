Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14348342F91
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 21:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCTUnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 16:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhCTUnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 16:43:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51217C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 13:43:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u5so15086090ejn.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 13:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9lbfn8RjecBl7XS/SHCSRbhQxIUAJWbOM7gWoOXHnr4=;
        b=qcmGUuogEiKnWj6ZAeH1gyWrMEYHHIOymreLlbBif8A6x97q3xGOyQrhyamXPT2yOS
         6URgb33nBKC0rMATs3+gRyB5Psr7NS/wKEXbE5mLvIK+dI53Y2tNc7Rfr89cMoIaLKWg
         3xrqWV98uDhMeb/8mAxamxv6Ar9C4q/bENoZvbdgk9OuSxeAk/idn0etlSpQ28xkInV9
         jSWy3VoBh2gqJ2cKpAsX8LtLAX84rULgmO1Y2dKEEiig7SxhmIns/nEyL0p6QKJuoD1D
         Hor5lf+mTDnCvVC1plpzzabMzWH6CplzkdBuKHBw5DbKn2N89YUl2JW0MrGlq6JY7vAO
         ylGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lbfn8RjecBl7XS/SHCSRbhQxIUAJWbOM7gWoOXHnr4=;
        b=Aot44jzgSP2SzGZ7F5H4um+6Njou4g+K7/5FfuCM0pOXNo0NTArjDl1hjCKHxReb0S
         beYdRkpT6ufDAksmQPuAnyzYVIi4Z+yPqreKd782+JXlY74RqYMSSNi3CxcqSEKokIXl
         th4LA+rANVSC2sGyHV0JMJSBeUk3+75ZHbZmZJUB8prE/uE2lHmAI+XyHudKEYJxd1ge
         hc6Dxmuhx3ZMbQetaS6VqlpUHWal0pKSk9FD48YZz3X3nKdpmjIYI5qKdMuoxSC7wiKN
         k+Jt5y8vgIE4BRIS+I4bMN4I4sla5IUnBTHu10otAYwjwlhetmIh8K/b/yKOFhmOyl+p
         At2w==
X-Gm-Message-State: AOAM532rjesUJJmBXOYyGoXguwOJUMVTLI/DYeAYbQ3k0Njqt3RJ4o3q
        5A/r9mzrRImzMeJ8dn8pFou69sIXoWzETDMbvL8tYQ==
X-Google-Smtp-Source: ABdhPJxWc3LoFWsjVKlONqKZAvVGvzN0WMGPObN/ZNOjfXrwDX0FjsgePqnPaDi0gbzedRpKY6xXrINOvyMiXlTXmRI=
X-Received: by 2002:a17:906:c301:: with SMTP id s1mr11110091ejz.382.1616273032097;
 Sat, 20 Mar 2021 13:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
 <CACT4Y+YeeEkF65O40DMLB=cggiowZUxXDs++BNTrDMO94j=NvA@mail.gmail.com>
 <CAK8P3a0HVu+x0T6+K3d0v1bvU-Pes0F0CSjqm5x=bxFgv5Y3mA@mail.gmail.com>
 <CACT4Y+aWMD283vYMfoGM1fir_fPF7MPqe+vLjaoQD2iZUV4c-A@mail.gmail.com> <CAK8P3a2NEcHG+nOUCc6-DPeFKkc-GF-LEOkynhNdgxiXBHdQaw@mail.gmail.com>
In-Reply-To: <CAK8P3a2NEcHG+nOUCc6-DPeFKkc-GF-LEOkynhNdgxiXBHdQaw@mail.gmail.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Sat, 20 Mar 2021 20:43:25 +0000
Message-ID: <CAFEAcA-s79=4VDSA3TO8tpLUMwJE=HcFT4eZO8L8CCkAAfj8PA@mail.gmail.com>
Subject: Re: arm64 syzbot instances
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021 at 09:16, Arnd Bergmann <arnd@arndb.de> wrote:
> So it's probably qemu that triggers the 'synchronous external
> abort' when accessing the PCI I/O space, which in turn hints
> towards a bug in qemu. Presumably it only returns data from
> I/O ports that are actually mapped to a device when real hardware
> is supposed to return 0xffffffff when reading from unused I/O ports.

Do you have a reference to the bit of the PCI spec that mandates
this -1/discard behaviour for attempted access to places where
there isn't actually a PCI device mapped ? The spec is pretty
long and hard to read...

(Knowing to what extent this behaviour is mandatory for all
PCI systems/host controllers vs just "it would be nice if the
gpex host controller worked this way" would help in figuring
out where in QEMU to change.)

thanks
-- PMM
