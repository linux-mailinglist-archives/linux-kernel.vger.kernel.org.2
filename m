Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F229413831
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhIURSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhIURRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:17:44 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FA1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:16:15 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t4so13893442plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eUN2nnZeqtF9V4R2FiAyrA03lEbiwBDRrmR/8zObR7M=;
        b=U4wQ6cOVPKfZdxAMFAmoymsbOG8L9a8yN6qeAHwwKMBW4PkJsSLJveeZVLfHe+YGWy
         ot7F54svu4ip2vq94EQNZRqCQ+AF8qo48Jkn6+Cq4fYGIvpKzPl3GLwYiOx2LLjbyniF
         wu/fSGWk6l+i6CWAGS6vpseU0D+FA97N3bprGhZVTI44xmDbpOs6NrySHRAlJHpA1FG0
         ejxqYLQRKgTqI7XNr7XPp92QCbAE+jISv4vCTvPwOgSwrEQa/htMVomov331N28Z1aNF
         7G+Pg9vcOfY/LtbBDBVLHYrkCN+pFBS8DaLZ9qZtV+TaHZIMMZ0Qk1K9pBg+wSHxl5gx
         30PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eUN2nnZeqtF9V4R2FiAyrA03lEbiwBDRrmR/8zObR7M=;
        b=LK+PZTodnMHlvN8rbQNzKEz+RWtUUPh6BLDlSn7jA0px4u2aZW2j2NvpYZ8sVSgT3h
         LKpysW6q2272bd7IeQ9h7cbyONmjLLZTORDYUw5O0hVoQVFogOA+LJRXt9E3ggp8FWCO
         uxSiteuIt7+ugSn24fqMIuDjU+CsT/nmV4X2vr5T8WPvmtoye5T1fI9P8R7jvdBCtRbi
         /Uafmn50aHqDyiY4u6tIwCaq1rdiXrU73Ypicm91EIPrZ3oAIzha6RMY0nnduGAQksYE
         lwl4veFs9HAEEyAUfQuw0kHeMYu9+zLBbzid+M2lpMHm3gs067KU+ptaQ1VmIe7CdUvh
         hlmA==
X-Gm-Message-State: AOAM532jKa5yPOG/5Fl6GRAJdDsN/L/X6DFdD8/OJAgG8osyv3ew7OO1
        UomE7rZsmgd90Vt7ZKZ6SkORyh/7xaVSGHKDQaA=
X-Google-Smtp-Source: ABdhPJyfCLZRS/cA/qIX+cu2GOvpUCvUmw/JxxSiq7XFWMsar5eLynsqdU4dnEyymkkSIK21o1Fy4MJib0eFC0t8Cco=
X-Received: by 2002:a17:90b:3805:: with SMTP id mq5mr6401185pjb.143.1632244574967;
 Tue, 21 Sep 2021 10:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
 <CACT4Y+bh1yaGLs5H3YTM6YLLtyWELvjWR7HcEk0pd9Nod9u4ZQ@mail.gmail.com>
 <20210207141104.ikxbdxhoisgqaoio@box> <CACT4Y+YwUgksZBj4YpChqL8iac2us7mOkbVDLsib3Y+MVb31cw@mail.gmail.com>
In-Reply-To: <CACT4Y+YwUgksZBj4YpChqL8iac2us7mOkbVDLsib3Y+MVb31cw@mail.gmail.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Tue, 21 Sep 2021 10:15:39 -0700
Message-ID: <CAMe9rOog08O8xmhhXuJ6aTO+ctv8D2yw1_vu8XjQWwsfw707Mg@mail.gmail.com>
Subject: Re: [RFC 0/9] Linear Address Masking enabling
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Marco Elver <elver@google.com>,
        Taras Madan <tarasmadan@google.com>,
        "xiang1...@intel.com" <xiang1.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 9:52 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sun, 7 Feb 2021 at 15:11, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Sun, Feb 07, 2021 at 09:24:23AM +0100, Dmitry Vyukov wrote:
> > > On Fri, Feb 5, 2021 at 4:16 PM Kirill A. Shutemov
> > > <kirill.shutemov@linux.intel.com> wrote:
> > > >
> > > > Linear Address Masking[1] (LAM) modifies the checking that is applied to
> > > > 64-bit linear addresses, allowing software to use of the untranslated
> > > > address bits for metadata.
> > > >
> > > > The patchset brings support for LAM for userspace addresses.
> > > >
> > > > The most sensitive part of enabling is change in tlb.c, where CR3 flags
> > > > get set. Please take a look that what I'm doing makes sense.
> > > >
> > > > The patchset is RFC quality and the code requires more testing before it
> > > > can be applied.
> > > >
> > > > The userspace API is not finalized yet. The patchset extends API used by
> > > > ARM64: PR_GET/SET_TAGGED_ADDR_CTRL. The API is adjusted to not imply ARM
> > > > TBI: it now allows to request a number of bits of metadata needed and
> > > > report where these bits are located in the address.
> > > >
> > > > There's an alternative proposal[2] for the API based on Intel CET
> > > > interface. Please let us know if you prefer one over another.
> > > >
> > > > The feature competes for bits with 5-level paging: LAM_U48 makes it
> > > > impossible to map anything about 47-bits. The patchset made these
> > > > capability mutually exclusive: whatever used first wins. LAM_U57 can be
> > > > combined with mappings above 47-bits.
> > > >
> > > > I include QEMU patch in case if somebody wants to play with the feature.
> > >
> > > Exciting! Do you plan to send the QEMU patch to QEMU?
> >
> > Sure. After more testing, once I'm sure it's conforming to the hardware.
>
> A follow up after H.J.'s LPC talk:
> https://linuxplumbersconf.org/event/11/contributions/1010/
> (also +Carlos)
>
> As far as I understood, this kernel series depends on the Intel CET patches.
>
> Where are these compiler-rt patches that block gcc support?

Hi Xiang,

Please share your compiler-rt changes for LAM.

-- 
H.J.
