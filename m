Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5010311707
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhBEXWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbhBEOZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:25:16 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5451AC061A2B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 07:50:52 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id h192so7920698oib.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXaDfNcUv+WdAxJMcKk3vOMMC2UEVA2HeEFd3d5xH68=;
        b=QEpRBNE5E1CgI4//GqSAN6QmRzxv+u84cAcrQo3xpHZxWICl2LU1+Gw7kvZq24L1wQ
         RvqnsxhSe/427ydgOfUZ1gjIe/5qEelN5CIj1lw2L/8nRTntKn/twGMp4JPUbF3Ubtkg
         F7AXKcpR/kZb85nSfkNCOdcT5SOYLIQiaoLyHz+GVsOGDJyyyQBB/RqcXkEppLd9OfZ8
         ITbnMJKOEB4fE7R4OFjpdItHofu6U+cyfcUPHvN0Xfx/E1+r7MIyENUHg3bH1lcZ1g4q
         fi6+PsMjCZ2ct/+d+H3r5m1cLpUe1SPwhj2Ih+udCQXYYPZbam3u33bdxYE03QecCt9Z
         iTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXaDfNcUv+WdAxJMcKk3vOMMC2UEVA2HeEFd3d5xH68=;
        b=CBXy0iPO+fjSee6c3HURPjYW7+vqjkzhjlZ62eIYUY/IKw6fIZPjr2KI1wbiNLk9yE
         Fb/Og2g1F31/WuGh4ryhHoo8eIW3awlVMXSvLHmEMqo1qwr86kQ7OCJ0bzSBrvJxa93X
         EQpYRTJ6yN0gmyFfUKHcGgCE2QS1eS5Jt8B+7OVoNLWiJE8NjmO9qMP/io5PzuclMYQF
         GHmrIYsq+0qwBLvGep0DZhUHxUUeRbsEwV+UN7d8xgVsvofR8XTR4AM5YI/0cejoQcEK
         Bo1nMFrkUR3aDt4WmTfFKStFf9aeqNQ3pfXvUYS9UKvbn28Lglf3uIK8wlYxPH2yzjEr
         8b2g==
X-Gm-Message-State: AOAM532GpYVtAKbOegE09HCMrMSpZi6ZPCwgQ4sAueyxfEHuw+ExGVLT
        xcQtwnbzUeLGX10+paGeB/DuPNSNNI69naq+P9YjsAzjwaU=
X-Google-Smtp-Source: ABdhPJwHTnPAUM85HdMxOyVKYR58qW1z0dM2qVU5dOnBXWP29Z6+qCP6jMhGC6R7R9dw7IYl0+73dKZvG/k1a7nVFxU=
X-Received: by 2002:aca:c693:: with SMTP id w141mr3370936oif.58.1612539792227;
 Fri, 05 Feb 2021 07:43:12 -0800 (PST)
MIME-Version: 1.0
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com> <20210205151631.43511-11-kirill.shutemov@linux.intel.com>
In-Reply-To: <20210205151631.43511-11-kirill.shutemov@linux.intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 5 Feb 2021 07:42:36 -0800
Message-ID: <CAMe9rOrhPNs7WZa7DquEQf_YN4XyeDZC5u3XC7MBDija3ic3+Q@mail.gmail.com>
Subject: Re: [RFC 9/9] x86/mm: Implement PR_SET/GET_TAGGED_ADDR_CTRL with LAM
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        GCC Development <gcc@gcc.gnu.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 7:16 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Provide prctl() interface to enabled LAM for user addresses. Depending
> how many tag bits requested it may result in enabling LAM_U57 or
> LAM_U48.

I prefer the alternate kernel interface based on CET arch_prctl interface which
is implemented in glibc on users/intel/lam/master branch:

https://gitlab.com/x86-glibc/glibc/-/tree/users/intel/lam/master

and in GCC on users/intel/lam/master branch:

https://gitlab.com/x86-gcc/gcc/-/tree/users/intel/lam/master

-- 
H.J.
