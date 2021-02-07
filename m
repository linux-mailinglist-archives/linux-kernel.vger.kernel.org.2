Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E605312497
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhBGOK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhBGOJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:09:58 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F26C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 06:09:09 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f23so1017565lfk.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 06:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3WGdnPvISs64NeCdwfew7cl4A+lVQsglEqZAL7qKKck=;
        b=N/K1mbr7vtBj7ZjjCa7b5P7eXXnKKs+HjGZDu4xkzSHwBTzUxYIArRUoIfj+qxNdnS
         w6UmMXkFIKBjjMXa+5VXwOUC/34D20hKZ5bU3LJ/LEjPvNb5u2xHSEDIpn4JMM18xMlj
         0BIrrEHC5Z7wABsWF+dA38XofrThWLr1vNnRIt8hkMUBBblLJczgMhill0T9OkJP5O7v
         d3e1XrIB7QPCTUEQ+P701I818w8qgbH2g4m/7NTOdmUURU62qnYfoDi9UU+LXtyZjR2I
         e+H38//N/BO2Qnfq6Bh7u/cQFT10O2UtA87NHF2z98qQmainwT9MHa+7pt0RwNIsZJgc
         Dgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3WGdnPvISs64NeCdwfew7cl4A+lVQsglEqZAL7qKKck=;
        b=dd7iTci33BVpzgICJ8JD3fQH6v2gfbEr6P12yrwfpITtjtEiZFyIm5u2sbvxLG4Ui3
         9rUMs+orWQpS5A7XmadBSuw3G2sfkNYNAZoFVas1NpZfjKpTISMyftcEpE/mIW/JwwjL
         S6sUVddMDgN7Syh4VHdxTGeX/fz35m2hiNd7KgDhZALRA6DRREdIDBD6M2Jalhjx/I4N
         eMJRXPhe2lFrFAwB18NGyWti9qmLLwn0irNDfZphjvKmdHR0qbdCP05GkuyDVnLgnsWE
         Wx4Su8OYTPcXfHNci5x9IiGpLeqW4mRvJ8EWGcxd0qm7Fx4V28cGCDR8sDMSVC4SOAow
         MNEw==
X-Gm-Message-State: AOAM533Mub5ibliyzC9Nhu6Qzp4dm1Qib0l43GECUIRWVtFI2ddZQVwi
        Z5aIM7fHfEF6650YPlASCx/dqg==
X-Google-Smtp-Source: ABdhPJwXp/oy+V9Wswzmu/s94NDp417EvomnDa9nyhb8+7f+CoIzFtqIvBCuwa0s2sOkvmdAbytoaA==
X-Received: by 2002:a19:ac08:: with SMTP id g8mr319535lfc.428.1612706947859;
        Sun, 07 Feb 2021 06:09:07 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d15sm1705266lfm.183.2021.02.07.06.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 06:09:07 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id A6568102656; Sun,  7 Feb 2021 17:09:06 +0300 (+03)
Date:   Sun, 7 Feb 2021 17:09:06 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        GCC Development <gcc@gcc.gnu.org>
Subject: Re: [RFC 9/9] x86/mm: Implement PR_SET/GET_TAGGED_ADDR_CTRL with LAM
Message-ID: <20210207140906.hdfzorevpmiqtryd@box>
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
 <20210205151631.43511-11-kirill.shutemov@linux.intel.com>
 <CAMe9rOrhPNs7WZa7DquEQf_YN4XyeDZC5u3XC7MBDija3ic3+Q@mail.gmail.com>
 <CACT4Y+b3jpjnWeDeUmn8TZ6KvQCu3riip0R07JjNwiOjsRYy6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b3jpjnWeDeUmn8TZ6KvQCu3riip0R07JjNwiOjsRYy6w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 09:07:02AM +0100, Dmitry Vyukov wrote:
> On Fri, Feb 5, 2021 at 4:43 PM H.J. Lu <hjl.tools@gmail.com> wrote:
> >
> > On Fri, Feb 5, 2021 at 7:16 AM Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > Provide prctl() interface to enabled LAM for user addresses. Depending
> > > how many tag bits requested it may result in enabling LAM_U57 or
> > > LAM_U48.
> >
> > I prefer the alternate kernel interface based on CET arch_prctl interface which
> > is implemented in glibc on users/intel/lam/master branch:
> >
> > https://gitlab.com/x86-glibc/glibc/-/tree/users/intel/lam/master
> >
> > and in GCC on users/intel/lam/master branch:
> >
> > https://gitlab.com/x86-gcc/gcc/-/tree/users/intel/lam/master
> 
> Hi Kirill, H.J.,
> 
> I don't have strong preference for PR_SET/GET_TAGGED_ADDR_CTRL vs
> ARCH_X86_FEATURE_1_ENABLE itself, but tying LAM to ELF and
> GNU_PROPERTY in the second option looks strange. LAM can be used
> outside of ELF/GNU, right?

Sure. In both cases it's still a syscall.

-- 
 Kirill A. Shutemov
