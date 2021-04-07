Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1637B357556
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 21:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355840AbhDGT7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 15:59:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355810AbhDGT7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:59:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DC206105A;
        Wed,  7 Apr 2021 19:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617825544;
        bh=k6+WEJUU1OZWMiE9a2UexjzaTvG2oDVuhVsZiW3o6Io=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YR5Q8XvUn6JVjPjj1BNXaM7FVf4Br7ASmk3pta0uakqmw/dDkxpszknJ8UmJ+wudk
         jtnQron+y3IvEv16sN69Mw5kfPI4AXsQxbLEhpVIJ6VbHzqWg73POVIX0llWl/7km5
         C5FlmXQ8rbN0i9Vxa05RsKNzt1lJWE8dA81jJSsw16lZHdla3+ss/EqA9w0Ov7mUiT
         SZ0MwgFHNkbJDQu8pDeuh77/V9ufcutwVYnuuQr0bHtLNkPC2i6qmFBiokoLyQfl0K
         k42/vc95fEetqcc8H3yFXpNT13wDn+r1F/QiBRtpvqLPYIPxc013iptHec/3Sea2F4
         6YswdagWPNA+Q==
Received: by mail-ed1-f47.google.com with SMTP id e7so22300535edu.10;
        Wed, 07 Apr 2021 12:59:04 -0700 (PDT)
X-Gm-Message-State: AOAM532dzROo84Vt7QaBgXoHVphk3NhjTSjIAl7mAF9U60XWHxNSS2Y1
        Y2KbqM6nf7dbS2FkNPYgEm1I2KyysDsNtPVQIg==
X-Google-Smtp-Source: ABdhPJwY9GthufRHILDLTfwGTZSKr9CrrPh9cGzDOgcphaTRdGgVabGLGr25oYBpzfJepxjo3FsXe2sqmNbljCw070k=
X-Received: by 2002:a05:6402:1b1c:: with SMTP id by28mr6528263edb.62.1617825542888;
 Wed, 07 Apr 2021 12:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210403020423.85278-1-syl.loop@gmail.com> <87y2due3mt.fsf@mpe.ellerman.id.au>
In-Reply-To: <87y2due3mt.fsf@mpe.ellerman.id.au>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 7 Apr 2021 14:58:50 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+CKi6+FKO=-VHC538mFMsvpa785sp2Qv86iCTv=1PC1w@mail.gmail.com>
Message-ID: <CAL_Jsq+CKi6+FKO=-VHC538mFMsvpa785sp2Qv86iCTv=1PC1w@mail.gmail.com>
Subject: Re: [PATCH] powerpc/dts: fix not include DTC_FLAGS
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Youlin Song <syl.loop@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, devicetree@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 7, 2021 at 6:27 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Youlin Song <syl.loop@gmail.com> writes:
> > I wanted to build the fsl dts in my machine and found that
> > the dtb have not extra space,so uboot will cause about
> > FDT_ERR_NOSPACE issue.

How do we not have issues with arm and arm64 boards which don't have
padding? Or what took so long to notice on powerpc?

> >
> > Signed-off-by: Youlin Song <syl.loop@gmail.com>
> > ---
> >  arch/powerpc/boot/dts/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
> > index fb335d05aae8..c21165c0cd76 100644
> > --- a/arch/powerpc/boot/dts/Makefile
> > +++ b/arch/powerpc/boot/dts/Makefile
> > @@ -2,5 +2,6 @@
> >
> >  subdir-y += fsl
> >
> > +DTC_FLAGS   ?= -p 1024
> >  dtstree              := $(srctree)/$(src)
> >  dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
>
> I guess that was missed in 1acf1cf8638a ("powerpc: build .dtb files in dts directory").
>
> Which I think means the assignment to DTC_FLAGS in
> arch/powerpc/boot/Makefile is not needed anymore.
>
> Can you send a v2 removing that assignment and explaining that's what
> happened?

I've wanted to make this common, but I guess that's a separate change.

Rob
