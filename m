Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A17309F31
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 23:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhAaWOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 17:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhAaWKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 17:10:45 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A11C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 14:08:52 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id b9so1726833ejy.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 14:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YwEC/DBzUTfXN/fTV7gO061uOPecLJTSPSEJCwubp8w=;
        b=d+Nuk0VidlVKOwjW/SPpzvmMZZfgvPFc1Gd+CPhzZOKEhtptkTlbaIbsgjOFPBXmTz
         WeCxupNSPmHZgtZ2ge4te6o8lubEivvaVVxqLUbZhCkoqy9O+82TfBr6Qs/jnHdGPhz7
         R/cvgH1mGo5kdgHxK06/vbHeOk3nDLs5L/LDD/gNU9lW/LvhtetlZ5lcjU4249rMxhk9
         pWRDOpGgTHf0OXV3WquO9GXVJGirokrrQaSte7nLNe7b97EZb3obRFNz7mvrKa94K7+S
         16Hd9WHH303NX37tStIiJzBbwk8epQSEZYZ/hh0TCpl3dUvqPay/KAXBkekr5wHN9tTl
         IM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YwEC/DBzUTfXN/fTV7gO061uOPecLJTSPSEJCwubp8w=;
        b=QksOmB/MFvnhNeRdpLPPVzoY9O2SSna9aUpo1tVXd2Tcckgzm1Lx/O6QW3FKggFSe0
         8n9GgtuMuHXLxAYXn/ZAk2oSITNlYUfSH0gxo2SwGjxk22T8nQhaWRbJkESw406NI6Aa
         1Js0EsALB6AcgIrFOWd0W3fxqlexu4l5Xv07ADc3HPy6mhFtPf4kZNIUi8rs57M0RM5E
         FcKYJ+IXs6peSaAtTeLpIBBNxp+SVDr/hfW42W1CS4RTqLdZkan+ykthSXW/VwUUWYZv
         POvDFhPJ/9AEInhhEUG00hGEumbMsoxdbWJyAstlt1faO9z+0VTqpZBYHwqnqDCuBD6z
         LT7w==
X-Gm-Message-State: AOAM532u/jEKZaxN1JMmw00Z0ZXNUhQHqpEfV5F4PGu53/iA2jDNo6Ps
        zVgGzzGZwcI9Ck2OmpZcKITV1I/CI8T0rjoCwUZTEg==
X-Google-Smtp-Source: ABdhPJzXeHptZY3z2nKUcL5NPy86/4Kam5MhABmCe9YTlUIBrBBwvzznJJXIk5U04McpmJVommaUca8ffgen20T/kI8=
X-Received: by 2002:a17:906:e09:: with SMTP id l9mr15007025eji.196.1612130931184;
 Sun, 31 Jan 2021 14:08:51 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgeG7WP_vxho_bfENK3rYP9zUF0_ZjA1X3OftERrs_j2w@mail.gmail.com>
 <0456DEB3-2EA6-4CA6-AA59-E5E1D8F1A77A@amacapital.net>
In-Reply-To: <0456DEB3-2EA6-4CA6-AA59-E5E1D8F1A77A@amacapital.net>
From:   Kyle Huey <me@kylehuey.com>
Date:   Sun, 31 Jan 2021 14:08:40 -0800
Message-ID: <CAP045Ao_Zb0HGg0=bvUeV6GjX=-3fz0ScsvM_jE7VsZcVk_-tg@mail.gmail.com>
Subject: Re: [REGRESSION] x86/entry: TIF_SINGLESTEP handling is still broken
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 2:04 PM Andy Lutomirski <luto@amacapital.net> wrote:
> Indeed, and I have tests for this.

Do you mean you already have a test case or that you would like a
minimized test case?

- Kyle
