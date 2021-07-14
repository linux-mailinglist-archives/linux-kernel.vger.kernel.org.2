Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988EF3C8420
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 13:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbhGNL6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 07:58:08 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:41429 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhGNL6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 07:58:07 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 16EBssxl030572
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 20:54:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 16EBssxl030572
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1626263694;
        bh=Sz3iImpUukCR0yg6rBq7bSklYInDXr9aiKQBe2KLL18=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PoB47dgfFXBipUpE6p8yx4kxGqgP/GmHua16XAIDvNxnBsng3UaSUytsANILwwxrC
         z5KFUq7zxx/aQF1My/orx7fXqXunfOpJi8MglOQRpMP88eZFt+apLX6eq9RWzNhCeg
         k1x7mnGrE0tpm2Sov75wmMFcB8ZUHQTJ69HefKRVkFs0PXXmjV+/2ooJgujySRyc7Z
         ypSGlKfOirfcG1IFx67TJXcvXoYHcIw7K51mA8h5DwdXXdSO5NJUD8VoZ0gwd/jimp
         H/PHRP5ghAL/+y5hdjbuNueMpk/9ivoip0ONomY3Q6FJZx4WjQ6EE5HEpF1MH8/TKu
         TQHTFSy9N38gw==
X-Nifty-SrcIP: [209.85.214.180]
Received: by mail-pl1-f180.google.com with SMTP id j3so1358116plx.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 04:54:54 -0700 (PDT)
X-Gm-Message-State: AOAM530LPei2Sj+TM6h81gW8/7r77bZ2kbToOFCIBejv08H7PaV7Ig59
        avB8CJtPjEjozrCT6ZcswCj25na2FkFWVipEqUU=
X-Google-Smtp-Source: ABdhPJwpMgJglG84BMVFWhZVSqSUEqeGd8/M3jl2S4pghaId232z7ANvIWEyOwMkTphljP88pw4eAX0TnO1zgke/bP0=
X-Received: by 2002:a17:90a:c506:: with SMTP id k6mr3454897pjt.198.1626263693958;
 Wed, 14 Jul 2021 04:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2107120957300.14207@file01.intranet.prod.int.rdu2.redhat.com>
 <YOyGrUvA4LjydcP3@kroah.com> <alpine.LRH.2.02.2107121502380.8445@file01.intranet.prod.int.rdu2.redhat.com>
 <YOyVH3qD9O3qsNUL@kroah.com> <alpine.LRH.2.02.2107121528270.11724@file01.intranet.prod.int.rdu2.redhat.com>
 <87tukzgrkg.fsf@ungleich.ch> <alpine.LRH.2.02.2107130454430.3795@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2107130454430.3795@file01.intranet.prod.int.rdu2.redhat.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 14 Jul 2021 20:54:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQkZSyNjoxVfrKr2goP7rNB0OAPXS6B-p24=8QjDcYWFA@mail.gmail.com>
Message-ID: <CAK7LNAQkZSyNjoxVfrKr2goP7rNB0OAPXS6B-p24=8QjDcYWFA@mail.gmail.com>
Subject: Re: [PATCH v3] scripts/setlocalversion: fix a bug when LOCALVERSION
 is empty
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Nico Schottelius <nico-linuxsetlocalversion@schottelius.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 5:59 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Mon, 12 Jul 2021, Nico Schottelius wrote:
>
> >
> > Sorry to say, but I am not convinced by the patch.
> >
> > While yes, we might have changed the behaviour slightly, reading
> > something on the line of
> >
> > if [ -z ... ]
> >
> > is significantly more simple, elegant and easier to maintain, than
> > a rather atypical special case for setting a variable to empty,
> > using
> >
> > if [ "${LOCALVERSION+set}" != "set" ] ..
> >
> > *and* because it is so atypical, adding a long comment for it, too.
> >
> > Additonally, -z should be correct if the variable *is* truly empty. I
> > assume it actually isn't and contains whitespace, which is not the same
> > as being set and empty.
> >
> > Instead of re-adding complexity, could you consider changing the build
> > flow so that LOCALVERSION is either unset or empty?
> >
> > Nico
>
> I set LOCALVERSION to an empty string (with "export LOCALVERSION="). This
> prevented the kernel from adding a "+" sign to the kernel version. Since
> the commit 042da426f8eb, it no longer works and the kernel adds a "+" sign
> if LOCALVERSION is set and empty.
>
> If you don't like "if [ "${LOCALVERSION+set}" != "set" ]", then please
> provide some other way how to test if the variable is set.

if [ -z "${LOCALVERSION+set}" ]

is the alternative way I came up with, but
I am OK with your v3.


I will pick it up for -rc2.




-- 
Best Regards
Masahiro Yamada
