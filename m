Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D435A403177
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 01:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347715AbhIGXVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 19:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbhIGXV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 19:21:27 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758B5C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 16:20:20 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id n2so1097119lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 16:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilpefoP4ZGYF65XRGnxXF+J6+mUlKVP7x+yM1zsD60M=;
        b=KHeBNDWg5BifX1XlBzRu8T9/KHG1UksYQ9gM68OWpAA3ZRzmqA4DuxnsSIp+g6eVVd
         X4rxgyvjrDvYM0MtrZBmL7zbN+oqH5JhhFqV6oqMFvG8JpnrSj6wRZUYr2Ik0AbeTEVA
         AeajG8NNX/7IJ98BESxOt4JXZDGERYhZbYSE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilpefoP4ZGYF65XRGnxXF+J6+mUlKVP7x+yM1zsD60M=;
        b=Bdfyeyn5ciVlnnxClS68UyEDIecTFtkASCkIxfNuhCVAgZvzHG6OugSRonTRPTS2ct
         kT8u3Wvb0p7oeVG1Yz3ds0R+iD0ViY2UQRqq0u3wH4kn5A8z+UZ47mbexrvazydj6Zes
         qXCjxv/U+DcpyV0BIXcMEiYQVEswtUp2QAaiSvSNr9tyl1cilX9dgorvaTLwZeS4xpv3
         0pHj6zexlMUvemuLk/t69nujKYx3dSUzmsIw5nO7ISdFENmJtW5VqUsKsPket0qntHRj
         xiOnMAv/2ipob54HJTH3fhWCYSco2oMVy2F6ijGJ26VCKKMO6K3xRuUZAegzAp1/ZGca
         sUMw==
X-Gm-Message-State: AOAM533MrxRCi6dVH6NOPof1HwfwmDKW1hvYzQujDCyiGH5J70fCIJjf
        6jhcRbSZvjQ2j/0suTjxqdH4MpON8UVHQMo1LCo=
X-Google-Smtp-Source: ABdhPJxH0fkMx7YILBhGSv1wllZGSysA+kOQfea/IJMUF9m9HWaPCAGThxmu8lWIQT8VsYPn9j6Q6g==
X-Received: by 2002:ac2:4e62:: with SMTP id y2mr581559lfs.9.1631056818528;
        Tue, 07 Sep 2021 16:20:18 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id v14sm27850lfd.225.2021.09.07.16.20.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 16:20:18 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id y34so995319lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 16:20:17 -0700 (PDT)
X-Received: by 2002:a05:6512:2611:: with SMTP id bt17mr591863lfb.141.1631056817695;
 Tue, 07 Sep 2021 16:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210907195612.321345EED@xen13.tec.linutronix.de>
 <874kaw9mpo.ffs@tglx> <e190b62e3f954cc1804a41149a842641@intel.com>
 <871r609m2i.ffs@tglx> <a883fe85b6b941b9bff44bc4b268bba1@intel.com>
 <87v93c82zn.ffs@tglx> <87sfyg8118.ffs@tglx>
In-Reply-To: <87sfyg8118.ffs@tglx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 16:20:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgDBJY4NGRCbEfjRMW9NRa_8vATkVk0muFFvpgixG=Keg@mail.gmail.com>
Message-ID: <CAHk-=wgDBJY4NGRCbEfjRMW9NRa_8vATkVk0muFFvpgixG=Keg@mail.gmail.com>
Subject: Re: [patch V2 00/20] x86/fpu: Clean up exception fixups and error
 handling in sigframe related code
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 3:37 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> /me mumbles unprintable curses about living in a developing country...

Germany has more ISDN connections than anywhere else in the world! How
can you possibly complain?

             Linus
