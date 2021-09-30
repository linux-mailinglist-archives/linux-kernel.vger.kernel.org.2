Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EBB41D21B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 06:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbhI3EOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 00:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhI3EOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 00:14:49 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34223C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 21:13:07 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u18so19662361lfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 21:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybfITpBm22sJ0qTITfKzloHH9OFhLMtm0iBbulL70uA=;
        b=nohrJOKCNseu7b2ywiwiPYsNcAU3IVfpwDH/QVFad5KG+wSXmD46gE18mecw3bgkcL
         hK7cgWBfzzfceFD/1gzeYPliWuhsY54PK5eMYEFi3XTyFR3Ejcbk0QZTkBZqSXsEhpnT
         M+lF4KKFDYUqLlFGHw1+cpfqKDMRFPHE5b4S72w/mu5T1QtvKOoLZsJl2nNuERQrA2HE
         iRFL1QkHR+/a9+IuAvTW1TTKC8vIY96QIjMPkz4aAsF2YWED01PU4XIJOai+VQvRuFRf
         x+U84hnWPEMEd27/V4FYhnaA3hqM6fwg2uOwUcM2pj31MpMW7Qaib+0isSRvu0ivPwSP
         vLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybfITpBm22sJ0qTITfKzloHH9OFhLMtm0iBbulL70uA=;
        b=S+Ld0/BPFjkG0avdYfN/EteI1gmpY2HC+tvQ8AzwKe0WF6kTBZoLvZRimAqwKToNjB
         ngHaRsjqtuJcacXQzXVDvzg3s5Xggb3KyjMzFNtXr6bc3r69VwboBc7C+Pzuy7y+wBfb
         p8GAfz2XJ84aI1G3EBqebUR0sew+nRGYC938yCsg8ONb98tAO20d2wmERXrAkgHlkw5M
         Blw+fZ/rtwQ6vsHzNoM0sUOXYmtSUwcl+c4dQdsHpECnH6XEyWVzxnMbg3OicVbHunmB
         ob3GEmIJ997a9kxHx3LOVWTjXGVSBRQ7b7jMbasHc2sXBsTKEvxkjrkFVzOjP5Vsc9Hx
         I6dA==
X-Gm-Message-State: AOAM530NGbDPz3tUyy3rS/gYqVecQH3orOP5iJq3oEEPQT8/+jsDIldA
        NMe9Qr0DeWk4i2Ual8jO4pRwsis4G6gkCHncZIDS6g==
X-Google-Smtp-Source: ABdhPJyJqyVL2VZxEOD1okwY27OOhQswijMTr1C9c6QL4wIM651T3RQ3aw3G8KN7j3/jJ+NhdT+QyVWJu/SB9+HVAsE=
X-Received: by 2002:ac2:4d10:: with SMTP id r16mr3455494lfi.309.1632975185478;
 Wed, 29 Sep 2021 21:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
 <20210916231325.125533-16-pasha.tatashin@soleen.com> <YVSXtswhm6iTC3yz@arm.com>
In-Reply-To: <YVSXtswhm6iTC3yz@arm.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 30 Sep 2021 00:12:28 -0400
Message-ID: <CA+CK2bA4LXSqRNDhen0GVVTz=gYwLmr8FgKCJeyG3iRpy=ULSA@mail.gmail.com>
Subject: Re: [PATCH v17 15/15] arm64: trans_pgd: remove trans_pgd_map_page()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        madvenka@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 12:43 PM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Thu, Sep 16, 2021 at 07:13:25PM -0400, Pasha Tatashin wrote:
> > The intend of trans_pgd_map_page() was to map contiguous range of VA
> > memory to the memory that is getting relocated during kexec. However,
> > since we are now using linear map instead of contiguous range this
> > function is not needed
> >
> > Suggested-by: Pingfan Liu <kernelfans@gmail.com>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  arch/arm64/include/asm/trans_pgd.h |  5 +--
> >  arch/arm64/mm/trans_pgd.c          | 57 ------------------------------
> >  2 files changed, 1 insertion(+), 61 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
> > index 7b04d32b102c..033d400a4ea4 100644
> > --- a/arch/arm64/include/asm/trans_pgd.h
> > +++ b/arch/arm64/include/asm/trans_pgd.h
> > @@ -15,7 +15,7 @@
> >  /*
> >   * trans_alloc_page
> >   *   - Allocator that should return exactly one zeroed page, if this
> > - *     allocator fails, trans_pgd_create_copy() and trans_pgd_map_page()
> > + *     allocator fails, trans_pgd_create_copy() and trans_pgd_idmap_page()
> >   *     return -ENOMEM error.
> >   *
> >   * trans_alloc_arg
> > @@ -30,9 +30,6 @@ struct trans_pgd_info {
> >  int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **trans_pgd,
> >                         unsigned long start, unsigned long end);
> >
> > -int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
> > -                    void *page, unsigned long dst_addr, pgprot_t pgprot);
>
> So this function never got used in mainline after commit 7018d467ff2d
> ("arm64: trans_pgd: hibernate: idmap the single page that holds the copy
> page routines"). I guess it's because we merged part of v10 of this
> series and in v12 you dropped the contiguous VA range in favour of a
> copy of the linear map.

This is exactly right. This function was meant for the contiguous-va
relocation version of this series.

Pasha
