Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F6E316842
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhBJNrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhBJNrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:47:07 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2D7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 05:46:26 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id f20so1879995ioo.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 05:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=exnHZw86HNGLSwoeO44L0ExyjinyWwZMRU9SyneUwkY=;
        b=iY25WJzyjaYqfaN4yHM634yOYaMGgqRL36Ga0ajElPHMsw4ykOzFelLZq+DHQUvVR5
         Lfj9a5ESQGHm75otpPacbsEaWe3T1wxmG58tFgCLRbBIuon9TLnzCpn2bP9gkN+9meY2
         beI+n54NEubCbPrkrQmOTbD5E6NQzztAbhxO85+TmfVrFQ44xvty01oKg1QWACO7060o
         K3KeUulcmbXFjgvp2GxnG8hj+DLDsjECtF8Txkl0v8bMXD923MQstfd13Q1y+ihDmBuJ
         XefloT08QX3p+LSDOEByLOyv3tcLgQKuuWxR6tRyn2a6L0IUWnLPsPBYFaj7NndtcIR/
         drhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=exnHZw86HNGLSwoeO44L0ExyjinyWwZMRU9SyneUwkY=;
        b=pIXD+lv1s+9NjMzYtSgpFE/xhZIrU3YE61CuSZ9bSLN7DlzRdl4n3juxlz+uZggxih
         p4nk2cJ3LHe2Elxxs14qmNIf8UhHbDvkPM7JXkUOMW5XyjMJwPFI79SunU5oYhagXK1o
         zMiNYv3JEYTCSoFfZJ15VTUu9DtSIvUBCwWmOmwmO3JBSHOg1FuHDoG8gfK8a7vb0vfK
         qXHyvwhlYt5uSghjF/6lVmfi9HpvP2CjTa113T1N1jstm2r8ZsgawPoUL2scCmH5SBgx
         UUUiaowfD01ev07nM19VpSDb97Qpwlf4bUW9t/SZ+87sK4SXBpOt8KyOptUd/tWPcC4t
         MNcA==
X-Gm-Message-State: AOAM531WaUl4rfzFZ7UckaVZSSQiICFfqAc/PFco6H5yoQEwDUIzUH3q
        mjZaon7B5vdJW2v2kDpmoDrkSVtQbEIwnu+NYrs=
X-Google-Smtp-Source: ABdhPJw0nq8ugg+Fu5cAulHMlNtyBHT/cIiUlD8iiqSuxcNDKbvVxJnu4r4uje8c85FSO4SjCFw//pxuCsguKKVarZI=
X-Received: by 2002:a5e:8d11:: with SMTP id m17mr956746ioj.144.1612964785631;
 Wed, 10 Feb 2021 05:46:25 -0800 (PST)
MIME-Version: 1.0
References: <20210210000749.3952313-1-ztong0001@gmail.com> <20210210093611.GA14650@zn.tnic>
In-Reply-To: <20210210093611.GA14650@zn.tnic>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Wed, 10 Feb 2021 08:46:14 -0500
Message-ID: <CAA5qM4ARMQycR0_7gY=nuCxGcdK3Zc9eW7vyg0XbTrNHi7MHGQ@mail.gmail.com>
Subject: Re: [PATCH v1] x86/vdso: fix CE on non-compatible cflags
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,
I am using ubuntu gcc, the x86-urgent branch works
Thanks,
- Tong

On Wed, Feb 10, 2021 at 4:36 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Feb 09, 2021 at 07:07:49PM -0500, Tong Zhang wrote:
> > I am getting some compilation error on when using CONFIG_X86_32 kernel
> > configuration
>
> With an ubuntu gcc?
> Does this branch work:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/urgent
>
> ?
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
