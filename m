Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80DD41A937
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 09:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239146AbhI1HCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 03:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbhI1HCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:02:02 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE027C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 00:00:23 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id dk4so3611195qvb.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 00:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V0EGJN/P+LEExA8lxyMUxikBR1Id3NZT+DE5wAoythM=;
        b=hryktab/XlTDjnX/RTsksGopECHlU5gDiEZD481ZLXdYdRS70v2d/wnQP4Zn7kQiDe
         Ume9S3tWTnLJpGTxkUIMhUz/JBeTxurjJ/yyFswgE1Yp7w8RsfmbOT3CzgqoRakwTVpm
         u3hLZObKr+OmaYw8OqAvWsKe9VG0pBXx8uC3HET+/j5g3TaTnXk1V0b1fydku6uVSN08
         LRBrZyNU9Yeo2bse6NqgSCpmnetl+cwLVWv3huyJ/AojEvE75TyobMDYTadGMzG0QcZO
         0UeZx1sfWr+l1laXPoXy5VBMZVHl+dhLJEtatg5wMpifMHIdpZf7mJWGNRenyOgo9Kd/
         xaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V0EGJN/P+LEExA8lxyMUxikBR1Id3NZT+DE5wAoythM=;
        b=2rgUgSfE6oKfYgdjbrKzr57M4yZ3kOpTsAMhpfWtFCaiku2Ad9BRmO24RKbJYGwrHi
         NzHN2qSFf/vPMREw6pBrbkYU9ZfZXO69gau/4/UaH8kDixIDzYuVK++ATHhx50JZZQ/x
         98Mw8wjxcoBMNy/hpAKA7czXhwf1TAB9iz3iF9s2MW8h/eKsBozBJztGzKuukUc5jK9a
         gERCTwDJJiLH6AcxIic1BZVvTqtr5qcmWw3xMWcddNMtLiiSn9yhhv2N9i1eqDmgapLG
         Dw0P8/p6arbj7Ceqn72stGZ3dP2cRkUQ8BPy0xbC6scsRjXYYeids34fg3rgy4+jMuDb
         PVkg==
X-Gm-Message-State: AOAM530Ew0//MvX1/72AKayExSReMZXsFutxzPehkRHxTiNmXekERCQq
        cCUgby+fMw1cMZpW40i879YG92R9e5LVXKnF5WHunMH9jfinxA==
X-Google-Smtp-Source: ABdhPJxZhSy+lG5/Tv6o946/6YeaHkiCTMHaj6JpGttJV5xrX9Eu2pOL5tpLcLIkNFGlo1wM4UoPSfGw3mH7Z7BKxqI=
X-Received: by 2002:a05:6214:13a6:: with SMTP id h6mr3959597qvz.50.1632812423030;
 Tue, 28 Sep 2021 00:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631121222.git.greentime.hu@sifive.com> <33c485ee595aff1e19a0e43074da59779f58d105.1631121222.git.greentime.hu@sifive.com>
 <YTmlwTlSX94tltyV@infradead.org>
In-Reply-To: <YTmlwTlSX94tltyV@infradead.org>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Tue, 28 Sep 2021 15:00:11 +0800
Message-ID: <CAHCEehK_zE9PqnxBJpupZ0P+Bx=8L6ydrMDjxfCD5FBbSi=sOw@mail.gmail.com>
Subject: Re: [RFC PATCH v8 15/21] riscv: Add vector extension XOR implementation
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> =E6=96=BC 2021=E5=B9=B49=E6=9C=889=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:12=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Sep 09, 2021 at 01:45:27AM +0800, Greentime Hu wrote:
> > +extern void xor_regs_2_(unsigned long bytes, unsigned long *p1,
> > +                     unsigned long *p2);
> > +extern void xor_regs_3_(unsigned long bytes, unsigned long *p1,
> > +                     unsigned long *p2, unsigned long *p3);
> > +extern void xor_regs_4_(unsigned long bytes, unsigned long *p1,
> > +                     unsigned long *p2, unsigned long *p3,
> > +                     unsigned long *p4);
> > +extern void xor_regs_5_(unsigned long bytes, unsigned long *p1,
> > +                     unsigned long *p2, unsigned long *p3, unsigned lo=
ng *p4,
> > +                     unsigned long *p5);
>
> There is no need for externs on function declarations ever.
>
Ok, I'll remove it.

> > +static void xor_rvv_2(unsigned long bytes, unsigned long *p1, unsigned=
 long *p2)
> > +{
> > +     kernel_rvv_begin();
> > +     xor_regs_2_(bytes, p1, p2);
> > +     kernel_rvv_end();
> > +}
>
> This looks strange.  Why these wrappers?

We don't use rvv in kernel space generally. If we want to use it, we
need to save all vector registers first.
Just like arm64/x86 implementation in
arch/arm64/include/asm/xor.h
arch/x86/include/asm/xor.h
